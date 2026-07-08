import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_cancel_button.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_chat_button.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_waiting_card.dart';

/// Dedicated arrived sheet (shown after the brief stepper handoff in
/// `GlassmorphicTripStatusSheet`): green arrival banner + live waiting-time
/// counter + chat + cancel + compensation.
class TripArrivedStatusSheet extends StatelessWidget {
  const TripArrivedStatusSheet({
    required this.trip,
    required this.cancelStatus,
    required this.onCancelPressed,
    required this.onCompensationPressed,
    super.key,
  });

  final TripEntity trip;
  final BlocStatus<void> cancelStatus;
  final VoidCallback onCancelPressed;
  final VoidCallback onCompensationPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Arrived banner: green check + title + "Aangekomen" badge.
        Container(
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
        AppSpacing.md.verticalSpace,

        // Live waiting-time counter.
        TripWaitingCard(trip: trip),

        const TripChatButton(),
        AppSpacing.md.verticalSpace,

        TripCancelButton(
          isLoading: cancelStatus.isLoading,
          onTap: onCancelPressed,
        ),

        // Late-driver compensation claim (policy: >20 min late => compensation).
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
}
