import 'dart:ui' as ui;
import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_status.dart';
import 'package:customertaxi/features/trip/domain/entities/driver_location_entity.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_arrived_status_sheet.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_completed_status_sheet.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_confirmation_status_sheet.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_en_route_status_sheet.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_general_status_sheet.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_in_progress_status_sheet.dart';

/// Glassmorphic bottom sheet shown over the active-trip map. Owns the
/// real-time bookkeeping shared across statuses (arrival distance baseline,
/// the arrived-sheet handoff timer, the waiting-time ticker, and the one-shot
/// rating prompt) and dispatches to the per-status sheet widget.
class GlassmorphicTripStatusSheet extends StatefulWidget {
  const GlassmorphicTripStatusSheet({
    required this.trip,
    required this.cancelStatus,
    required this.onCancelPressed,
    this.driverLocation,
    super.key,
  });

  final TripEntity trip;
  final BlocStatus<void> cancelStatus;
  final VoidCallback onCancelPressed;
  final DriverLocationEntity? driverLocation;

  @override
  State<GlassmorphicTripStatusSheet> createState() =>
      _GlassmorphicTripStatusSheetState();
}

class _GlassmorphicTripStatusSheetState
    extends State<GlassmorphicTripStatusSheet> {
  // Drives the 1-second rebuilds for the live waiting countdown once the arrived
  // sheet is showing (phase B).
  Timer? _waitingTicker;
  // Arrived shows the completed stepper for a couple of seconds (the "handoff")
  // before swapping to the dedicated arrived sheet. This flag flips when that
  // brief replay is over.
  bool _arrivedHandoffDone = false;
  Timer? _arrivedHandoffTimer;

  TripEntity get trip => widget.trip;
  BlocStatus<void> get cancelStatus => widget.cancelStatus;
  VoidCallback get onCancelPressed => widget.onCancelPressed;
  DriverLocationEntity? get driverLocation => widget.driverLocation;

  @override
  void initState() {
    super.initState();
    _syncArrivedHandoff();
    _syncWaitingTicker();
  }

  @override
  void didUpdateWidget(covariant GlassmorphicTripStatusSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncArrivedHandoff();
    _syncWaitingTicker();
  }

  @override
  void dispose() {
    _waitingTicker?.cancel();
    _arrivedHandoffTimer?.cancel();
    super.dispose();
  }

  /// Holds the completed stepper on screen for a beat when the driver arrives,
  /// then flips to the dedicated arrived sheet. A trip re-opened while already
  /// arrived (stale `arrivedAtUtc`) skips the replay and lands on the sheet.
  void _syncArrivedHandoff() {
    if (trip.status != TripStatus.arrived) {
      _arrivedHandoffTimer?.cancel();
      _arrivedHandoffTimer = null;
      _arrivedHandoffDone = false;
      return;
    }
    if (_arrivedHandoffDone || _arrivedHandoffTimer != null) return;

    final arrivedAt = trip.arrivedAtUtc;
    final isFresh =
        arrivedAt == null ||
        DateTime.now().toUtc().difference(arrivedAt) <
            const Duration(seconds: 6);
    if (!isFresh) {
      _arrivedHandoffDone = true;
      return;
    }
    _arrivedHandoffTimer = Timer(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() => _arrivedHandoffDone = true);
      // didUpdateWidget won't fire for this internal setState, so kick the
      // waiting-counter ticker on directly.
      _syncWaitingTicker();
    });
  }

  /// 1-second rebuilds that keep the waiting-time counter live — only once the
  /// arrived sheet (phase B) is actually showing.
  void _syncWaitingTicker() {
    final needsTicker =
        trip.status == TripStatus.arrived && _arrivedHandoffDone;
    if (needsTicker && _waitingTicker == null) {
      _waitingTicker = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() {});
      });
    } else if (!needsTicker && _waitingTicker != null) {
      _waitingTicker?.cancel();
      _waitingTicker = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadii.xl.r)),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: colors.surface.withValues(alpha: 0.85),
            border: Border(
              top: BorderSide(
                color: colors.onSurface.withValues(alpha: 0.08),
                width: 1.5.r,
              ),
            ),
          ),
          padding: REdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.sm + bottomPadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Tiny top drag handle visual styling
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: colors.onSurface.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppRadii.sm.r),
                  ),
                ),
              ),
              AppSpacing.xs.verticalSpace,

              // Status-specific sheet content.
              if (trip.status == TripStatus.awaitingAdminAcceptance ||
                  trip.status == TripStatus.accepted) ...[
                // Same widget for both statuses so the element is reused and the
                // headline can animate from "pending" to "confirmed" in place.
                TripConfirmationStatusSheet(
                  trip: trip,
                  cancelStatus: cancelStatus,
                  onCancelPressed: onCancelPressed,
                ),
              ] else if (trip.status == TripStatus.enRoute) ...[
                TripEnRouteStatusSheet(
                  trip: trip,
                  cancelStatus: cancelStatus,
                  onCancelPressed: onCancelPressed,
                ),
              ] else if (trip.status == TripStatus.arrived) ...[
                if (_arrivedHandoffDone)
                  TripArrivedStatusSheet(
                    trip: trip,
                    cancelStatus: cancelStatus,
                    onCancelPressed: onCancelPressed,
                  )
                else
                  TripEnRouteStatusSheet(
                    trip: trip,
                    cancelStatus: cancelStatus,
                    onCancelPressed: onCancelPressed,
                  ),
              ] else if (trip.status == TripStatus.inProgress) ...[
                TripInProgressStatusSheet(trip: trip),
              ] else if (trip.status == TripStatus.completed) ...[
                TripCompletedStatusSheet(trip: trip),
              ] else ...[
                // Default fallback
                TripGeneralStatusSheet(
                  trip: trip,
                  cancelStatus: cancelStatus,
                  onCancelPressed: onCancelPressed,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
