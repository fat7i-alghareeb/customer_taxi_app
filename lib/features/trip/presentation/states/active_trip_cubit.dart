import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio_refresh_bot/dio_refresh_bot.dart' show AuthStatus, Status;
import 'package:injectable/injectable.dart';

import '../../../../core/injection/injectable.dart';
import '../../../../core/services/realtime/realtime_event.dart';
import '../../../../core/services/realtime/realtime_service.dart';
import '../../../../core/services/session/auth_manager.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../domain/entities/trip_entity.dart';
import '../../domain/entities/trip_status.dart';
import '../../domain/facade/trip_facade.dart';
import '../coordinators/trip_completion_coordinator.dart';

/// State for the Home-tab active-trip gate.
///
/// A passenger can hold several open trips at once: at most one *live* trip
/// (which owns the map) plus any number of *reserved* future scheduled trips
/// (which do not block booking). See [TripEntity.isReservedFuture].
class ActiveTripState {
  const ActiveTripState({
    this.trips = const [],
    this.loading = false,
    this.loaded = false,
  });

  /// Every non-terminal trip the passenger holds, soonest pickup first.
  final List<TripEntity> trips;
  final bool loading;

  /// True once the first resolve has completed (so the gate can avoid flashing
  /// the booking sheet before we know whether a trip is active).
  final bool loaded;

  // `completed` stays "live" for gate purposes: the active-trip screen owns
  // showing the one-shot completed overlay + receipt sheet, and only drops out
  // via the explicit Done button (`ActiveTripCubit.clearTrip()`), not
  // automatically the moment the status flips terminal.
  static bool _ownsTheMap(TripEntity trip) =>
      trip.status == TripStatus.completed || trip.isLiveNow;

  /// The trip currently occupying the Home tab, or null when the passenger is
  /// free to book. Only future reservations may coexist with booking.
  TripEntity? get liveTrip {
    for (final trip in trips) {
      if (_ownsTheMap(trip)) return trip;
    }
    return null;
  }

  /// Scheduled trips whose dispatch window has not opened yet.
  List<TripEntity> get reservedTrips =>
      trips.where((t) => t.isReservedFuture).toList();

  bool get hasLiveTrip => liveTrip != null;

  ActiveTripState copyWith({
    List<TripEntity>? trips,
    bool? loading,
    bool? loaded,
  }) {
    return ActiveTripState(
      trips: trips ?? this.trips,
      loading: loading ?? this.loading,
      loaded: loaded ?? this.loaded,
    );
  }
}

/// Resolves and tracks every active trip the passenger holds so the Home tab can
/// show the live trip view (which opens the SignalR channel) or the booking
/// sheet, and so future reservations stay visible without blocking a new
/// booking. Refreshes on realtime trip events and on demand.
@lazySingleton
class ActiveTripCubit extends Cubit<ActiveTripState> {
  ActiveTripCubit(this._facade, this._realtime, this._authManager)
    : super(const ActiveTripState());

  final TripFacade _facade;
  final RealtimeService _realtime;
  final AuthManager _authManager;

  /// How often the live/reserved split is recomputed. A reservation becomes
  /// live purely by the clock reaching `pickup - 15 min`, and nothing else in
  /// the app rebuilds on time alone — without this tick the map would keep
  /// showing the booking sheet until the next realtime event or tab switch.
  static const _partitionTick = Duration(seconds: 30);

  StreamSubscription<RealtimeEvent>? _eventsSub;
  StreamSubscription<AuthStatus>? _authSub;
  Timer? _debounce;
  Timer? _partitionTimer;
  bool _started = false;

  /// Trip groups this cubit has joined on the hub, so membership can be diffed
  /// against the active set instead of being owned by whichever `TripBloc`
  /// happens to be mounted.
  final Set<String> _joinedGroups = {};

  /// Idempotent. Subscribes to realtime trip events and auth state, and
  /// resolves the active trips only while authenticated (guests/logged-out
  /// users must never trigger the protected `getActiveTrips` call).
  void start() {
    if (_started) return;
    _started = true;
    printC('[ActiveTripCubit] start');
    _authSub = _authManager.authStatusStream.listen(_onAuthStatus);
    _eventsSub = _realtime.events
        .where(_shouldRefreshForRealtimeEvent)
        .listen((_) => _scheduleRefresh());
    if (_authManager.isAuthenticated) {
      unawaited(refresh());
    }
  }

  void _onAuthStatus(AuthStatus status) {
    switch (status.status) {
      case Status.authenticated:
        unawaited(refresh());
        break;
      case Status.unauthenticated:
        printC('[ActiveTripCubit] auth -> unauthenticated, resetting');
        _debounce?.cancel();
        _debounce = null;
        _stopPartitionTimer();
        unawaited(_syncTripGroups(const []));
        if (!isClosed) emit(const ActiveTripState(loaded: true));
        break;
      case Status.initial:
        break;
    }
  }

  /// Cancels subscriptions and resets state. Call on logout / teardown.
  Future<void> stop() async {
    if (!_started) return;
    _started = false;
    await _eventsSub?.cancel();
    _eventsSub = null;
    await _authSub?.cancel();
    _authSub = null;
    _debounce?.cancel();
    _debounce = null;
    _stopPartitionTimer();
    await _syncTripGroups(const []);
    if (!isClosed) emit(const ActiveTripState());
  }

  bool _shouldRefreshForRealtimeEvent(RealtimeEvent event) {
    return event is! RealtimeDriverLocationUpdated;
  }

  void _scheduleRefresh() {
    _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 600),
      () => unawaited(refresh()),
    );
  }

  /// Fetches every active trip and updates the gate.
  Future<void> refresh() async {
    if (isClosed) return;
    emit(state.copyWith(loading: true));
    final result = await _facade.getActiveTrips();
    if (isClosed) return;

    List<TripEntity>? activeTrips;
    bool failed = false;
    String? failMessage;
    result.when(
      success: (trips) => activeTrips = trips,
      failure: (message) {
        failed = true;
        failMessage = message;
      },
    );

    if (failed) {
      printY('[ActiveTripCubit] refresh failed: $failMessage');
      emit(state.copyWith(loading: false, loaded: true));
      return;
    }

    final previousLive = state.liveTrip;
    final resolved = List<TripEntity>.from(
      activeTrips!.where((t) => !t.status.isTerminal),
    );

    // The server's active statuses exclude Completed, so a just-completed trip
    // disappears from the list. Before dropping it, if its completed overlay has
    // NOT been closed yet, keep it mounted so the full-screen overlay stays
    // until the user taps Close (see `ActiveTripBody`).
    final retained = await _retainCompletedTrip(previousLive, resolved);
    if (isClosed) return;
    if (retained != null) {
      resolved.insert(0, retained);
    }

    printG(
      '[ActiveTripCubit] active trips=${resolved.length} '
      'live=${resolved.where(ActiveTripState._ownsTheMap).map((t) => t.id).join(',')}',
    );

    await _syncTripGroups(resolved);
    if (isClosed) return;
    emit(ActiveTripState(trips: resolved, loaded: true));
    _syncPartitionTimer();

    // The live trip just ended. If it completed and is still unrated, make sure
    // the rating sheet appears even if the SignalR completion event was missed
    // (the coordinator re-checks status, so cancelled trips are ignored).
    // Skipped when we already observed `completed` locally — that case is owned
    // by the completed overlay's close button (see `ActiveTripBody`).
    if (previousLive != null &&
        previousLive.status != TripStatus.completed &&
        retained == null &&
        !resolved.any((t) => t.id == previousLive.id)) {
      unawaited(
        getIt<TripCompletionCoordinator>().promptRatingForCompletedTrip(
          previousLive.id,
        ),
      );
    }
  }

  /// Returns the previously live trip when it has just completed and its
  /// overlay is still owed to the user, otherwise null.
  Future<TripEntity?> _retainCompletedTrip(
    TripEntity? previousLive,
    List<TripEntity> resolved,
  ) async {
    if (previousLive == null) return null;
    if (resolved.any((t) => t.id == previousLive.id)) return null;
    if (getIt<TripCompletionCoordinator>().isCompletedOverlayClosed(
      previousLive.id,
    )) {
      return null;
    }

    // Fast path: we already hold the completed trip — re-emit it without a
    // network round-trip on each realtime tick.
    if (previousLive.status == TripStatus.completed) return previousLive;

    final byId = await _facade.getTripById(previousLive.id);
    if (isClosed) return null;
    return byId.when(
      success: (trip) {
        if (trip.status == TripStatus.completed && trip.passengerRating == null) {
          printG(
            '[ActiveTripCubit] keep completed trip=${trip.id} until overlay closed',
          );
          return trip;
        }
        return null;
      },
      failure: (_) => null,
    );
  }

  /// Joins the hub group of every active trip and leaves the ones that are gone.
  /// Owned here rather than in `TripBloc` because several blocs are alive at
  /// once and a passenger holds several trips.
  Future<void> _syncTripGroups(List<TripEntity> trips) async {
    final wanted = trips.map((t) => t.id).toSet();
    final toJoin = wanted.difference(_joinedGroups);
    final toLeave = _joinedGroups.difference(wanted);

    for (final id in toJoin) {
      _joinedGroups.add(id);
      await _realtime.joinTripGroup(id);
    }
    for (final id in toLeave) {
      _joinedGroups.remove(id);
      await _realtime.leaveTripGroup(id);
    }
  }

  /// Runs the partition tick only while a reservation is still waiting to go
  /// live — there is nothing to recompute otherwise.
  void _syncPartitionTimer() {
    final needsTick = state.reservedTrips.isNotEmpty;
    if (!needsTick) {
      _stopPartitionTimer();
      return;
    }
    if (_partitionTimer != null) return;
    _partitionTimer = Timer.periodic(_partitionTick, (_) {
      if (isClosed) return;
      final wasLive = state.liveTrip?.id;
      // Re-emitting the same list re-evaluates the time-based getters.
      emit(state.copyWith(trips: List<TripEntity>.from(state.trips)));
      if (state.liveTrip?.id != wasLive) {
        printG('[ActiveTripCubit] reservation went live -> refreshing');
        unawaited(refresh());
      }
      _syncPartitionTimer();
    });
  }

  void _stopPartitionTimer() {
    _partitionTimer?.cancel();
    _partitionTimer = null;
  }

  /// Marks a booking as in-flight right after it succeeds, before the async
  /// [refresh] resolves. Lets `ActiveTripGate` hide the bookable Home pill
  /// immediately instead of waiting for the next realtime-triggered refresh
  /// (up to ~600ms later), which would otherwise let the passenger book a
  /// second trip in that window.
  void markBookingPending() {
    printC('[ActiveTripCubit] markBookingPending');
    emit(state.copyWith(loading: true));
  }

  /// Drops one trip so the Home tab returns to the booking flow. Used by the
  /// cancelled sheet and the no-driver Done button, which resolve a specific
  /// trip rather than "the" trip.
  void clearTrip(String tripId) {
    printC('[ActiveTripCubit] clearTrip $tripId');
    emit(
      state.copyWith(
        trips: state.trips.where((t) => t.id != tripId).toList(),
        loaded: true,
        loading: false,
      ),
    );
    _syncPartitionTimer();
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    _partitionTimer?.cancel();
    _eventsSub?.cancel();
    _authSub?.cancel();
    return super.close();
  }
}
