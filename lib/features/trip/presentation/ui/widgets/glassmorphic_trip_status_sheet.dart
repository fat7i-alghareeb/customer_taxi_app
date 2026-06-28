import 'dart:ui' as ui;
import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_status.dart';
import 'package:customertaxi/features/trip/domain/entities/driver_location_entity.dart';
import 'package:customertaxi/features/trip/presentation/coordinators/trip_completion_coordinator.dart';
import 'package:customertaxi/features/trip/presentation/states/active_trip_cubit.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/completed_action_chips.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_fare_summary_card.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_stops_timeline.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_rating_sheet.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/in_trip_safety_panel.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/live_arrival_overlay.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/live_arrival_progress_header.dart';

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
  // Drives the 1-second rebuilds for the live waiting countdown while the
  // driver is waiting at pickup.
  Timer? _waitingTicker;
  // Ensures the post-trip rating sheet is only auto-shown once.
  bool _ratingPrompted = false;
  // Farthest driver→pickup distance seen this en-route session, used as the
  // baseline so the arrival header's car reflects real journey progress.
  int? _arrivalBaselineMeters;

  TripEntity get trip => widget.trip;
  BlocStatus<void> get cancelStatus => widget.cancelStatus;
  VoidCallback get onCancelPressed => widget.onCancelPressed;
  VoidCallback get onCompensationPressed => widget.onCompensationPressed;
  DriverLocationEntity? get driverLocation => widget.driverLocation;

  @override
  void initState() {
    super.initState();
    _syncWaitingTicker();
    _syncArrivalBaseline();
    _maybePromptRating();
  }

  @override
  void didUpdateWidget(covariant GlassmorphicTripStatusSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncWaitingTicker();
    _syncArrivalBaseline();
    _maybePromptRating();
  }

  @override
  void dispose() {
    _waitingTicker?.cancel();
    super.dispose();
  }

  void _syncWaitingTicker() {
    final needsTicker = trip.status == TripStatus.arrived;
    if (needsTicker && _waitingTicker == null) {
      _waitingTicker = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() {});
      });
    } else if (!needsTicker && _waitingTicker != null) {
      _waitingTicker?.cancel();
      _waitingTicker = null;
    }
  }

  /// Tracks the farthest driver→pickup distance observed while en-route so the
  /// arrival header can show progress as `(baseline - remaining) / baseline`.
  /// Resets once the driver is no longer heading to the pickup.
  void _syncArrivalBaseline() {
    if (trip.status != TripStatus.enRoute) {
      _arrivalBaselineMeters = null;
      return;
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

  Future<void> _refreshActiveTripGate() async {
    await getIt<ActiveTripCubit>().refresh();
  }

  Future<void> _clearActiveTripGate() async {
    final cubit = getIt<ActiveTripCubit>();
    cubit.clear();
    await cubit.refresh();
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

              // Glassmorphic status specific cards builder
              if (trip.status == TripStatus.enRoute) ...[
                _buildEnRouteSheet(context),
              ] else if (trip.status == TripStatus.arrived) ...[
                _buildArrivedSheet(context),
              ] else if (trip.status == TripStatus.inProgress) ...[
                _buildInProgressSheet(context),
              ] else if (trip.status == TripStatus.completed) ...[
                _buildCompletedSheet(context),
              ] else ...[
                // Default fallback
                _buildGeneralSheet(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnRouteSheet(BuildContext context) {
    // Prefer the live driver-arrival ETA streamed from the driver's moving
    // position; fall back to the trip's static pickup ETA when unavailable.
    final int? liveEtaSeconds = driverLocation?.etaToPickupSeconds;
    final int minutes = liveEtaSeconds != null
        ? LiveArrival.minutes(liveEtaSeconds)
        : (trip.etaToPickup != null
              ? (trip.etaToPickup!.difference(DateTime.now()).inMinutes > 0
                    ? trip.etaToPickup!.difference(DateTime.now()).inMinutes
                    : 1)
              : 5);

    // Distance-based journey progress: the share of the farthest-seen distance
    // the driver has already covered. Positions the car on the dashed line.
    final int? remainingMeters = driverLocation?.distanceToPickupMeters;
    final int? baseline = _arrivalBaselineMeters;
    final double progress =
        (baseline != null && baseline > 0 && remainingMeters != null)
        ? ((baseline - remainingMeters) / baseline).clamp(0.0, 1.0)
        : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Real-time arrival header: "Arrival in / N min / dashed line with a
        // live-progress car / distance • arrival clock". Replaces the old title
        // row, ETA pill, distance row and vehicle card for this status.
        LiveArrivalProgressHeader(
          minutes: minutes,
          progress: progress,
          distanceMeters: remainingMeters,
          etaSeconds: liveEtaSeconds,
        ),
        AppSpacing.xl.verticalSpace,

        // Cancel button
        AppButton.outline(
          variant: AppButtonVariant.error,
          isLoading: cancelStatus.isLoading,
          onTap: onCancelPressed,
          child: AppButtonChild.label(AppStrings.activeTripCancelRide),
        ),
      ],
    );
  }

  Widget _buildArrivedSheet(BuildContext context) {
    final colors = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Prominent glowing green highlight banner
        Container(
          padding: REdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            border: Border.all(
              color: AppColors.success.withValues(alpha: 0.3),
              width: 1.r,
            ),
          ),
          child: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.solidCircleCheck,
                color: AppColors.success,
                size: 28.r,
              ).animate().scale(duration: 400.ms),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.tripStatusDriverArrived,
                      style: AppTextStyles.s14w700.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                    AppSpacing.xs.verticalSpace,
                    Text(
                      AppStrings.activeTripDriverOutside,
                      style: AppTextStyles.s16w700.copyWith(
                        color: colors.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AppSpacing.lg.verticalSpace,

        // Live "board within 10 minutes" countdown + accruing waiting fee.
        _buildWaitingCountdown(context),

        // Vehicle info
        _buildVehicleCard(context),
        AppSpacing.xl.verticalSpace,

        // Cancel button
        AppButton.outline(
          variant: AppButtonVariant.error,
          isLoading: cancelStatus.isLoading,
          onTap: onCancelPressed,
          child: AppButtonChild.label(AppStrings.activeTripCancelRide),
        ),

        // Late-driver compensation claim (policy: >20 min late => 5% back).
        AppSpacing.sm.verticalSpace,
        Center(
          child: TextButton(
            onPressed: onCompensationPressed,
            child: Text(AppStrings.activeTripReportDriverLate),
          ),
        ),
      ],
    );
  }

  /// Shows the 10-minute boarding countdown after the driver arrives. Once the
  /// free grace window elapses, it switches to the accruing per-minute fee.
  Widget _buildWaitingCountdown(BuildContext context) {
    final colors = context.colorScheme;
    final session = trip.activeWaitingSession;
    final startUtc = session?.startedAtUtc ?? trip.arrivedAtUtc;
    if (startUtc == null) return const SizedBox.shrink();

    final graceMinutes = session?.graceMinutes ?? 10;
    final ratePerMinute = session?.ratePerMinute ?? 0;
    final now = DateTime.now();

    final Widget content;
    final Color tint;
    if (now.isBefore(startUtc)) {
      // The driver arrived before the scheduled pickup time. Count down to the
      // trip time rather than showing the boarding window — the free waiting
      // window only begins at the scheduled time (startUtc).
      final untilStart = startUtc.difference(now);
      final mm = untilStart.inMinutes.remainder(60).toString().padLeft(2, '0');
      final ss = untilStart.inSeconds.remainder(60).toString().padLeft(2, '0');
      tint = colors.primary;
      content = Row(
        children: [
          FaIcon(FontAwesomeIcons.solidClock, color: tint, size: 18.r),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Text(
              AppStrings.tripScheduledStartsIn.replaceAll('{time}', '$mm:$ss'),
              style: AppTextStyles.s14w700.copyWith(color: colors.onSurface),
            ),
          ),
        ],
      );
    } else {
      final elapsed = now.difference(startUtc);
      final graceRemaining = Duration(minutes: graceMinutes) - elapsed;
      if (graceRemaining > Duration.zero) {
        final mm = graceRemaining.inMinutes
            .remainder(60)
            .toString()
            .padLeft(2, '0');
        final ss = graceRemaining.inSeconds
            .remainder(60)
            .toString()
            .padLeft(2, '0');
        tint = colors.primary;
        content = Row(
          children: [
            FaIcon(FontAwesomeIcons.solidClock, color: tint, size: 18.r),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Text(
                AppStrings.tripArrivedBoardWithin.replaceAll(
                  '{time}',
                  '$mm:$ss',
                ),
                style: AppTextStyles.s14w700.copyWith(color: colors.onSurface),
              ),
            ),
          ],
        );
      } else {
        final overdueSeconds = elapsed.inSeconds - graceMinutes * 60;
        final billableMinutes = (overdueSeconds / 60).ceil();
        final fee = billableMinutes * ratePerMinute;
        final amount = '${fee.toStringAsFixed(2)} ${trip.currencyCode}';
        tint = AppColors.warning;
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.triangleExclamation,
                  color: tint,
                  size: 18.r,
                ),
                AppSpacing.md.horizontalSpace,
                Expanded(
                  child: Text(
                    AppStrings.tripWaitingGraceOver,
                    style: AppTextStyles.s12w500.copyWith(
                      color: colors.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            AppSpacing.xs.verticalSpace,
            Text(
              AppStrings.waitingLateMinutes.replaceAll(
                '{minutes}',
                billableMinutes.toString(),
              ),
              style: AppTextStyles.s14w700.copyWith(color: tint),
            ),
            AppSpacing.xs.verticalSpace,
            Text(
              AppStrings.tripWaitingFeeAccruing.replaceAll('{amount}', amount),
              style: AppTextStyles.s16w700.copyWith(color: tint),
            ),
            AppSpacing.xs.verticalSpace,
            Text(
              AppStrings.waitingPayDriverNotice,
              style: AppTextStyles.s12w500.copyWith(
                color: colors.onSurface.withValues(alpha: 0.72),
              ),
            ),
          ],
        );
      }
    }

    return Padding(
      padding: REdgeInsets.only(bottom: AppSpacing.lg),
      child: Container(
        width: double.infinity,
        padding: REdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: tint.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          border: Border.all(color: tint.withValues(alpha: 0.30), width: 1.r),
        ),
        child: content,
      ),
    );
  }

  Widget _buildInProgressSheet(BuildContext context) {
    final colors = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            FaIcon(FontAwesomeIcons.route, color: colors.primary, size: 24.r),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Text(
                AppStrings.tripStatusInProgress,
                style: AppTextStyles.s20w700.copyWith(color: colors.onSurface),
              ),
            ),
          ],
        ),
        AppSpacing.lg.verticalSpace,

        // Safety panel — only while the passenger is in the car with the
        // driver. Lives inside the sheet so it reads as a section, not a
        // floating card.
        Divider(
          height: 1.h,
          thickness: 1.r,
          color: colors.onSurface.withValues(alpha: 0.08),
        ),
        AppSpacing.md.verticalSpace,
        InTripSafetyPanel(tripId: trip.id),
      ],
    );
  }

  Widget _buildCompletedSheet(BuildContext context) {
    final colors = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: FaIcon(
            FontAwesomeIcons.circleCheck,
            color: AppColors.success,
            size: 48.r,
          ),
        ),
        AppSpacing.md.verticalSpace,
        Center(
          child: Text(
            AppStrings.tripStatusCompleted,
            style: AppTextStyles.s20w700.copyWith(color: colors.onSurface),
          ),
        ),
        AppSpacing.lg.verticalSpace,

        // Uber-style receipt / invoice chips
        CompletedActionChips(tripId: trip.id),
        AppSpacing.lg.verticalSpace,

        // Fare Summary Card
        TripFareSummaryCard(
          amount: trip.quotedFare,
          currencyCode: trip.currencyCode,
          referenceCode: trip.referenceCode,
        ),
        AppSpacing.xl.verticalSpace,

        // Stops Timeline
        if (trip.stops.isNotEmpty) ...[
          TripStopsTimeline(stops: trip.stops),
          AppSpacing.xl.verticalSpace,
        ],

        // Rate the trip (also auto-shown once on completion).
        AppButton.outline(
          onTap: () => showTripRatingSheet(
            context,
            tripId: trip.id,
            onClosed: _refreshActiveTripGate,
          ),
          child: AppButtonChild.label(AppStrings.ratingTitle),
        ),
        AppSpacing.md.verticalSpace,

        // Done button to route home (explicit dismiss — no auto-redirect)
        AppButton.primaryGradient(
          onTap: () async {
            await _clearActiveTripGate();
            if (context.mounted) context.goNamed('RootScreen');
          },
          child: AppButtonChild.label(AppStrings.done),
        ),
      ],
    );
  }

  Widget _buildGeneralSheet(BuildContext context) {
    final colors = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            FaIcon(
              FontAwesomeIcons.circleInfo,
              color: colors.primary,
              size: 24.r,
            ),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Text(
                trip.status.title,
                style: AppTextStyles.s20w700.copyWith(color: colors.onSurface),
              ),
            ),
          ],
        ),
        AppSpacing.xl.verticalSpace,

        if (trip.status.canCancel)
          AppButton.outline(
            variant: AppButtonVariant.error,
            isLoading: cancelStatus.isLoading,
            onTap: onCancelPressed,
            child: AppButtonChild.label(AppStrings.activeTripCancelRide),
          ),
      ],
    );
  }

  Widget _buildVehicleCard(BuildContext context) {
    final colors = context.colorScheme;
    final vehicleType = trip.vehicleTypeName?.trim().isNotEmpty == true
        ? trip.vehicleTypeName!.trim()
        : AppStrings.carType;
    final vehicleString = AppStrings.activeTripLookForCar.replaceAll(
      '{type}',
      vehicleType,
    );

    return Container(
      padding: REdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.onSurface.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(
          color: colors.onSurface.withValues(alpha: 0.06),
          width: 1.r,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: REdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: FaIcon(
              FontAwesomeIcons.car,
              color: colors.primary,
              size: 24.r,
            ),
          ),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vehicleType,
                  style: AppTextStyles.s16w700.copyWith(
                    color: colors.onSurface,
                  ),
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  vehicleString,
                  style: AppTextStyles.s12w400.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.65),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
