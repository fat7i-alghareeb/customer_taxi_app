import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../utils/helpers/colored_print.dart';
import 'active_trip_cubit.dart';

/// What the latest active-trip state means for a visible reservation overlay.
enum ReservationOverlayVerdict {
  /// Nothing conclusive yet — leave the overlay alone.
  keep,

  /// The trip is still a future reservation. Leave the overlay up, and record
  /// that we have now seen it as one.
  keepAndMarkSeen,

  /// The overlay must get out of the way.
  dismiss,
}

/// Decides whether the reservation overlay for [tripId] should stay.
///
/// A pure function so the rule can be tested without standing up
/// [ActiveTripCubit] and its dependencies.
///
/// The overlay closes as soon as the trip stops being a quiet reservation:
/// the driver is en route, the trip has started, or the dispatch window opened
/// at `pickup - 15 min`. In every one of those cases `ActiveTripGate` has
/// already mounted the live trip view underneath, and the overlay would
/// otherwise paint straight over a ride that is actually happening.
///
/// An admin merely *accepting* a ride scheduled for next week is not a reason
/// to close it — nothing has started, and the three notification promises are
/// still the right thing on screen.
ReservationOverlayVerdict resolveReservationOverlay({
  required String tripId,
  required ActiveTripState state,
  required bool seenAsReserved,
}) {
  for (final trip in state.trips) {
    if (trip.id != tripId) continue;
    return trip.isReservedFuture
        ? ReservationOverlayVerdict.keepAndMarkSeen
        : ReservationOverlayVerdict.dismiss;
  }

  // The trip is gone. Only treat that as "cancelled" once we have actually seen
  // it as a reservation: right after booking, a refresh triggered by an earlier
  // realtime event can resolve without the new trip in it, and dismissing on
  // mere absence would make the overlay flash away the instant it appeared.
  if (seenAsReserved && state.loaded && !state.loading) {
    return ReservationOverlayVerdict.dismiss;
  }

  return ReservationOverlayVerdict.keep;
}

/// One-shot flag for the full-screen "thank you for your reservation" overlay.
///
/// Lives outside `OrderBloc` because the overlay must survive the booking sheet
/// collapsing right after a successful booking, and outside [ActiveTripCubit]
/// because a reservation is deliberately *not* an active-trip state change —
/// the passenger stays free to book again the moment the overlay is dismissed.
///
/// It does watch [ActiveTripCubit] though, so the overlay steps aside on its
/// own once the reservation turns into a live trip. Watching from here rather
/// than from a widget means it also works while the passenger is sitting on
/// another tab, so coming back to Home never shows a stale confirmation.
@lazySingleton
class ReservationConfirmationCubit extends Cubit<String?> {
  ReservationConfirmationCubit(this._activeTrips) : super(null);

  final ActiveTripCubit _activeTrips;

  StreamSubscription<ActiveTripState>? _activeTripsSub;

  /// Whether the announced trip has been observed as a live reservation. Guards
  /// the "it disappeared, so it was cancelled" branch — see
  /// [resolveReservationOverlay].
  bool _seenAsReserved = false;

  /// Shows the overlay for a freshly booked scheduled trip.
  void show(String tripId) {
    printC('[ReservationConfirmationCubit] show $tripId');
    _seenAsReserved = false;
    emit(tripId);

    _activeTripsSub?.cancel();
    _activeTripsSub = _activeTrips.stream.listen(_onActiveTrips);
    // Evaluate what we already hold. On the Stripe path `show()` runs up to 15s
    // after the booking, by which time the relevant emissions have gone by.
    _onActiveTrips(_activeTrips.state);
  }

  void _onActiveTrips(ActiveTripState activeState) {
    final tripId = state;
    if (tripId == null) return;

    switch (resolveReservationOverlay(
      tripId: tripId,
      state: activeState,
      seenAsReserved: _seenAsReserved,
    )) {
      case ReservationOverlayVerdict.keep:
        break;
      case ReservationOverlayVerdict.keepAndMarkSeen:
        _seenAsReserved = true;
      case ReservationOverlayVerdict.dismiss:
        printC(
          '[ReservationConfirmationCubit] trip $tripId is no longer a '
          'reservation — closing the overlay',
        );
        dismiss();
    }
  }

  /// Dismissed via the "Go to Home" button, or automatically once the trip is
  /// no longer a future reservation.
  void dismiss() {
    if (state == null) return;
    printC('[ReservationConfirmationCubit] dismiss');
    _activeTripsSub?.cancel();
    _activeTripsSub = null;
    _seenAsReserved = false;
    emit(null);
  }

  @override
  Future<void> close() {
    _activeTripsSub?.cancel();
    return super.close();
  }
}
