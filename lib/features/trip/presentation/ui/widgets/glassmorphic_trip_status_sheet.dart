import 'dart:ui' as ui;
import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_status.dart';
import 'package:customertaxi/features/trip/domain/entities/driver_location_entity.dart';
import 'package:customertaxi/features/trip/presentation/coordinators/trip_completion_coordinator.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/live_arrival_overlay.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/live_arrival_progress_header.dart';
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
    required this.onCompensationPressed,
    this.driverLocation,
    super.key,
  });

  final TripEntity trip;
  final BlocStatus<void> cancelStatus;
  final VoidCallback onCancelPressed;
  final VoidCallback onCompensationPressed;
  final DriverLocationEntity? driverLocation;

  @override
  State<GlassmorphicTripStatusSheet> createState() =>
      _GlassmorphicTripStatusSheetState();
}

class _GlassmorphicTripStatusSheetState
    extends State<GlassmorphicTripStatusSheet> {
  // Ensures the post-trip rating sheet is only auto-shown once.
  bool _ratingPrompted = false;
  // Drives the 1-second rebuilds for the live waiting countdown once the arrived
  // sheet is showing (phase B).
  Timer? _waitingTicker;
  // Arrived shows the completed stepper for a couple of seconds (the "handoff")
  // before swapping to the dedicated arrived sheet. This flag flips when that
  // brief replay is over.
  bool _arrivedHandoffDone = false;
  Timer? _arrivedHandoffTimer;
  // Farthest driver→target distance seen for the current tracking leg, used as
  // the baseline so the arrival header's car reflects real journey progress.
  int? _arrivalBaselineMeters;
  // The status the current baseline belongs to. Lets us reset the baseline when
  // the target switches (en-route → in-progress) so progress restarts cleanly.
  TripStatus? _baselineStatus;

  TripEntity get trip => widget.trip;
  BlocStatus<void> get cancelStatus => widget.cancelStatus;
  VoidCallback get onCancelPressed => widget.onCancelPressed;
  VoidCallback get onCompensationPressed => widget.onCompensationPressed;
  DriverLocationEntity? get driverLocation => widget.driverLocation;

  @override
  void initState() {
    super.initState();
    _syncArrivedHandoff();
    _syncWaitingTicker();
    _syncArrivalBaseline();
    _maybePromptRating();
  }

  @override
  void didUpdateWidget(covariant GlassmorphicTripStatusSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncArrivedHandoff();
    _syncWaitingTicker();
    _syncArrivalBaseline();
    _maybePromptRating();
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
    _arrivedHandoffTimer = Timer(const Duration(seconds: 3), () {
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

  /// Tracks the farthest driver→target distance observed for the current leg so
  /// the arrival header can show progress as `(baseline - remaining) / baseline`.
  /// The target is the pickup while en-route and the destination while in-progress;
  /// the baseline resets when leaving those states or when the target switches
  /// (en-route → in-progress) so progress restarts from the new, farther target.
  void _syncArrivalBaseline() {
    final tracksTarget =
        trip.status == TripStatus.enRoute ||
        trip.status == TripStatus.inProgress;
    if (!tracksTarget) {
      _arrivalBaselineMeters = null;
      _baselineStatus = null;
      return;
    }
    if (_baselineStatus != trip.status) {
      _baselineStatus = trip.status;
      _arrivalBaselineMeters = null;
    }
    final remaining = driverLocation?.distanceToPickupMeters;
    if (remaining == null) return;
    final baseline = _arrivalBaselineMeters;
    if (baseline == null || remaining > baseline) {
      _arrivalBaselineMeters = remaining;
    }
  }

  void _maybePromptRating() {
    if (_ratingPrompted || trip.status != TripStatus.completed) return;
    _ratingPrompted = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(
        getIt<TripCompletionCoordinator>().promptRatingForCompletedTrip(
          trip.id,
        ),
      );
    });
  }

  /// The real-time arrival header — "Arrival in / N min / dashed line with a
  /// live-progress car / distance • arrival clock" — shared by the en-route sheet
  /// (driver → pickup) and the in-progress sheet (car → destination). The live
  /// fields carry pickup- or destination-relative values depending on status.
  Widget _buildArrivalProgressHeader() {
    // Prefer the live ETA streamed from the moving position; fall back to the
    // trip's static pickup ETA when unavailable.
    final int? liveEtaSeconds = driverLocation?.etaToPickupSeconds;
    final int minutes = liveEtaSeconds != null
        ? LiveArrival.minutes(liveEtaSeconds)
        : (trip.etaToPickup != null
              ? (trip.etaToPickup!.difference(DateTime.now()).inMinutes > 0
                    ? trip.etaToPickup!.difference(DateTime.now()).inMinutes
                    : 1)
              : 5);

    // Distance-based journey progress: the share of the farthest-seen distance
    // already covered. Positions the car on the dashed line.
    final int? remainingMeters = driverLocation?.distanceToPickupMeters;
    final int? baseline = _arrivalBaselineMeters;
    final double progress =
        (baseline != null && baseline > 0 && remainingMeters != null)
        ? ((baseline - remainingMeters) / baseline).clamp(0.0, 1.0)
        : 0.0;

    return LiveArrivalProgressHeader(
      minutes: minutes,
      progress: progress,
      distanceMeters: remainingMeters,
      etaSeconds: liveEtaSeconds,
    );
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
            AppSpacing.xl,
            AppSpacing.xl,
            AppSpacing.xl,
            AppSpacing.xl + bottomPadding,
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
              AppSpacing.md.verticalSpace,

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
                  arrivalProgressHeader: _buildArrivalProgressHeader(),
                ),
              ] else if (trip.status == TripStatus.arrived) ...[
                if (_arrivedHandoffDone)
                  TripArrivedStatusSheet(
                    trip: trip,
                    cancelStatus: cancelStatus,
                    onCancelPressed: onCancelPressed,
                    onCompensationPressed: onCompensationPressed,
                  )
                else
                  TripEnRouteStatusSheet(
                    trip: trip,
                    cancelStatus: cancelStatus,
                    onCancelPressed: onCancelPressed,
                  ),
              ] else if (trip.status == TripStatus.inProgress) ...[
                TripInProgressStatusSheet(
                  trip: trip,
                  arrivalProgressHeader: _buildArrivalProgressHeader(),
                ),
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
