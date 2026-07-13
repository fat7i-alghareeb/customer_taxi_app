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
class ActiveTripState {
  const ActiveTripState({this.trip, this.loading = false, this.loaded = false});

  /// The passenger's current non-terminal trip, or null when there is none.
  final TripEntity? trip;
  final bool loading;

  /// True once the first resolve has completed (so the gate can avoid flashing
  /// the booking sheet before we know whether a trip is active).
  final bool loaded;

  // `completed` stays "active" for gate purposes: the active-trip screen
  // owns showing the one-shot completed overlay + receipt sheet, and only
  // drops out via the explicit Done button (`ActiveTripCubit.clear()`), not
  // automatically the moment the status flips terminal.
  bool get hasActiveTrip =>
      trip != null &&
      (!trip!.status.isTerminal || trip!.status == TripStatus.completed);

  ActiveTripState copyWith({
    TripEntity? trip,
    bool clearTrip = false,
    bool? loading,
    bool? loaded,
  }) {
    return ActiveTripState(
      trip: clearTrip ? null : (trip ?? this.trip),
      loading: loading ?? this.loading,
      loaded: loaded ?? this.loaded,
    );
  }
}

/// Resolves and tracks the passenger's current active trip so the Home tab can
/// show the live trip view (which opens the SignalR channel) instead of the
/// booking sheet. Refreshes on realtime trip events and on demand.
@lazySingleton
class ActiveTripCubit extends Cubit<ActiveTripState> {
  ActiveTripCubit(this._facade, this._realtime, this._authManager)
    : super(const ActiveTripState());

  final TripFacade _facade;
  final RealtimeService _realtime;
  final AuthManager _authManager;

  StreamSubscription<RealtimeEvent>? _eventsSub;
  StreamSubscription<AuthStatus>? _authSub;
  Timer? _debounce;
  bool _started = false;

  /// Idempotent. Subscribes to realtime trip events and auth state, and
  /// resolves the active trip only while authenticated (guests/logged-out
  /// users must never trigger the protected `getActiveTrip` call).
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

  /// Fetches the current active trip and updates the gate.
  Future<void> refresh() async {
    if (isClosed) return;
    emit(state.copyWith(loading: true));
    final result = await _facade.getActiveTrip();
    if (isClosed) return;

    TripEntity? activeTrip;
    bool failed = false;
    String? failMessage;
    result.when(
      success: (trip) => activeTrip = trip,
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

    final previousId = state.trip?.id;
    final previousStatus = state.trip?.status;

    if (activeTrip != null &&
        (!activeTrip!.status.isTerminal ||
            activeTrip!.status == TripStatus.completed)) {
      printG(
        '[ActiveTripCubit] active trip=${activeTrip!.id} status=${activeTrip!.status}',
      );
      emit(ActiveTripState(trip: activeTrip, loaded: true));
      return;
    }

    // getActiveTrip() returns no trip for a Completed one (the backend's
    // ActiveStatuses excludes Completed), so a just-completed trip shows up here
    // as "no active trip". Before dropping it, if we had a trip whose completed
    // overlay has NOT been closed yet, keep it mounted so the full-screen
    // completed overlay stays until the user taps Close (see `ActiveTripBody`).
    if (previousId != null &&
        !getIt<TripCompletionCoordinator>().isCompletedOverlayClosed(
          previousId,
        )) {
      // Fast path: we already hold the completed trip — re-emit it without a
      // network round-trip on each realtime tick.
      if (previousStatus == TripStatus.completed && state.trip != null) {
        emit(ActiveTripState(trip: state.trip, loaded: true));
        return;
      }
      // Re-fetch by id to learn whether it just completed (and is still unrated).
      final byId = await _facade.getTripById(previousId);
      if (isClosed) return;
      final kept = byId.when(
        success: (trip) {
          if (trip.status == TripStatus.completed &&
              trip.passengerRating == null) {
            printG(
              '[ActiveTripCubit] keep completed trip=${trip.id} until overlay closed',
            );
            emit(ActiveTripState(trip: trip, loaded: true));
            return true;
          }
          return false;
        },
        failure: (_) => false,
      );
      if (kept) return;
    }

    printM('[ActiveTripCubit] no active trip');
    emit(const ActiveTripState(loaded: true));
    // The active trip just ended. If it completed and is still unrated, make
    // sure the rating sheet appears even if the SignalR completion event was
    // missed (the coordinator re-checks status, so cancelled trips are ignored).
    // Skipped when we already observed `completed` locally — that case is owned
    // by the completed overlay's close button (see `ActiveTripBody`), and firing
    // it here too would race that flow and navigate home before Close.
    if (previousId != null && previousStatus != TripStatus.completed) {
      unawaited(
        getIt<TripCompletionCoordinator>().promptRatingForCompletedTrip(
          previousId,
        ),
      );
    }
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

  /// Drops the current trip so the Home tab returns to the booking flow.
  void clear() {
    printC('[ActiveTripCubit] clear');
    emit(const ActiveTripState(loaded: true));
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    _eventsSub?.cancel();
    _authSub?.cancel();
    return super.close();
  }
}
