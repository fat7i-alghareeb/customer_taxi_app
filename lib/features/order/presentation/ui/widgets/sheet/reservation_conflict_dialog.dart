import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/presentation/states/active_trip_cubit.dart';

/// How close two rides may start before they collide. Mirrors the server's
/// `TripScheduleConflict.Guard`.
const _conflictWindow = Duration(minutes: 60);

/// How far before a scheduled pickup a ride starts occupying the passenger.
/// Mirrors the server's `Trip.ScheduledEnRouteLeadTime`.
const _dispatchLead = Duration(minutes: 15);

/// When a booking would start occupying the passenger. A scheduled ride goes
/// live at `pickup - dispatch lead`; an immediate one goes live at once.
DateTime _activeWindowStart(DateTime? scheduledAt, DateTime now) {
  return scheduledAt?.toUtc().subtract(_dispatchLead) ?? now;
}

/// Blocks a booking that would leave the passenger with two rides underway at
/// the same time, and returns whether the booking may proceed.
///
/// The server enforces the same rule (`TripErrors.ScheduleConflict`); this runs
/// first so the rider is stopped *before* the payment sheet opens rather than
/// after paying.
///
/// Compares active windows rather than pickup times, because an immediate ride
/// booked half an hour before a reservation's dispatch window opens collides
/// just as surely as two reservations twenty minutes apart.
Future<bool> confirmReservationConflict(
  BuildContext context, {
  required DateTime? scheduledAt,
}) async {
  final now = DateTime.now().toUtc();
  final newWindowStart = _activeWindowStart(scheduledAt, now);

  final clash = getIt<ActiveTripCubit>().state.trips.where((trip) {
    final otherStart = _activeWindowStart(trip.scheduledAtUtc, trip.createdAtUtc.toUtc());
    return otherStart.difference(newWindowStart).abs() < _conflictWindow;
  }).firstOrNull;

  if (clash == null) return true;

  await AppDialog.show<void>(
    context,
    dialog: AppDialog.basic(
      icon: IconSource.icon(Icons.event_busy_rounded),
      title: AppStrings.reservationConflictTitle,
      message: AppStrings.reservationConflictMessage.replaceAll(
        '{time}',
        _clashLabel(clash),
      ),
      primaryAction: AppDialogAction.primary(
        label: AppStrings.reservationConflictDismiss,
        // `AppDialog.show` puts the dialog on the root navigator, so pop from
        // there — popping the nearest one could dismiss the booking sheet's
        // route instead of the dialog.
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
      ),
    ),
  );

  return false;
}

/// The clashing ride's pickup time, or its booking time when it is an immediate
/// ride that has no scheduled pickup.
String _clashLabel(TripEntity clash) {
  final at = clash.scheduledAtUtc ?? clash.createdAtUtc;
  return at.toLocal().toSmartDateTime();
}
