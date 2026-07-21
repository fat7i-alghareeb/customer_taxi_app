import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_sheet_actions.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_waiting_card.dart';

/// Dedicated arrived sheet (shown after the brief stepper handoff in
/// `GlassmorphicTripStatusSheet`): green arrival banner + live waiting-time
/// counter + chat + cancel.
class TripArrivedStatusSheet extends StatelessWidget {
  const TripArrivedStatusSheet({
    required this.trip,
    required this.cancelStatus,
    required this.onCancelPressed,
    super.key,
  });

  final TripEntity trip;
  final BlocStatus<void> cancelStatus;
  final VoidCallback onCancelPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Arrived banner: green check + title + "Aangekomen" badge.
        Container(
          padding: REdgeInsets.all(AppSpacing.sm),
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
              FaIcon(
                FontAwesomeIcons.circleCheck,
                color: AppColors.success,
                size: 28.r,
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppStrings.activeTripDriverArrivedTitle,
                      style: AppTextStyles.s16w700.copyWith(
                        color: colors.onSurface,
                      ),
                    ),
                    AppSpacing.xs.verticalSpace,
                    Text(
                      AppStrings.activeTripDriverWaitingAtPickup,
                      style: AppTextStyles.s12w400.copyWith(
                        color: colors.onSurface.withValues(alpha: 0.65),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              AppSpacing.sm.horizontalSpace,
              Container(
                padding: REdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadii.xl.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7.r,
                      height: 7.r,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                    AppSpacing.xs.horizontalSpace,
                    Text(
                      AppStrings.tripStatusDriverArrived,
                      style: AppTextStyles.s12w500.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AppSpacing.sm.verticalSpace,

        // Live waiting-time counter.
        TripWaitingCard(trip: trip),
        AppSpacing.sm.verticalSpace,

        // Address / passengers can no longer be changed once the driver has
        // arrived, so no edit actions are shown here.
        TripSheetActions(
          showCancel: trip.status.canCancel,
          cancelIsLoading: cancelStatus.isLoading,
          onCancelPressed: onCancelPressed,
        ),
      ],
    );
  }
}
