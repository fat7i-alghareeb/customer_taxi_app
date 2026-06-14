import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/injection/injectable.dart';
import '../../../../core/services/realtime/realtime_event.dart';
import '../../../../core/services/realtime/realtime_service.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../domain/entities/trip_entity.dart';
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

  bool get hasActiveTrip => trip != null && !trip!.status.isTerminal;

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
  ActiveTripCubit(this._facade, this._realtime)
    : super(const ActiveTripState());

  final TripFacade _facade;
  final RealtimeService _realtime;

  StreamSubscription<RealtimeEvent>? _eventsSub;
  Timer? _debounce;
  bool _started = false;

  /// Idempotent. Subscribes to realtime trip events and does a first resolve.
  void start() {
    if (_started) return;
    _started = true;
    printC('[ActiveTripCubit] start');
    _eventsSub = _realtime.events
        .where(_shouldRefreshForRealtimeEvent)
        .listen((_) => _scheduleRefresh());
    unawaited(refresh());
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
    result.when(
      success: (trip) {
        final previousId = state.trip?.id;
        if (trip != null && !trip.status.isTerminal) {
          printG(
            '[ActiveTripCubit] active trip=${trip.id} status=${trip.status}',
          );
          emit(ActiveTripState(trip: trip, loaded: true));
        } else {
          printM('[ActiveTripCubit] no active trip');
          emit(const ActiveTripState(loaded: true));
          // The active trip just ended. If it completed and is still unrated,
          // make sure the rating sheet appears even if the SignalR completion
          // event was missed (the coordinator re-checks status, so cancelled
          // trips are ignored).
          if (previousId != null) {
            unawaited(
              getIt<TripCompletionCoordinator>().promptRatingForCompletedTrip(
                previousId,
              ),
            );
          }
        }
      },
      failure: (message) {
        printY('[ActiveTripCubit] refresh failed: $message');
        emit(state.copyWith(loading: false, loaded: true));
      },
    );
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
    return super.close();
  }
}
