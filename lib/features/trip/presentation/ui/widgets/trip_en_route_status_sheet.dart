import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_status.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_arrival_stepper.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_cancel_button.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_chat_button.dart';

/// Sheet for `TripStatus.enRoute`, also reused for the brief "arrived" handoff
/// (see `GlassmorphicTripStatusSheet`) where all three stepper steps render
/// checked just before the dedicated arrived sheet takes over. The layout is
/// identical for both; only the stepper's active step and the live arrival
/// header (en-route only) change.
class TripEnRouteStatusSheet extends StatelessWidget {
  const TripEnRouteStatusSheet({
    required this.trip,
    required this.cancelStatus,
    required this.onCancelPressed,
    this.arrivalProgressHeader,
    super.key,
  });

  final TripEntity trip;
  final BlocStatus<void> cancelStatus;
  final VoidCallback onCancelPressed;

  /// Live ETA + dashed-line-with-car header, built by the parent (it owns the
  /// distance baseline). Only shown while en-route.
  final Widget? arrivalProgressHeader;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (arrivalProgressHeader != null) ...[
          arrivalProgressHeader!,
          AppSpacing.md.verticalSpace,
        ],

        // Header card: car icon + reassuring title/subtitle.
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
              Container(
                padding: REdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: FaIcon(
                  FontAwesomeIcons.carSide,
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
                      AppStrings.activeTripDriverComing,
                      style: AppTextStyles.s16w700.copyWith(
                        color: colors.onSurface,
                      ),
                    ),
                    AppSpacing.xs.verticalSpace,
                    Text(
                      AppStrings.activeTripComfortableTripSoon,
                      style: AppTextStyles.s12w400.copyWith(
                        color: colors.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AppSpacing.md.verticalSpace,

        // Progress stepper card.
        Container(
          padding: REdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: colors.onSurface.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            border: Border.all(
              color: colors.onSurface.withValues(alpha: 0.06),
              width: 1.r,
            ),
          ),
          // En-route: step 2 active. Arrived handoff: all three checked before
          // the dedicated arrived sheet takes over.
          child: TripArrivalStepper(
            activeIndex: trip.status == TripStatus.arrived ? 3 : 1,
          ),
        ),
        AppSpacing.md.verticalSpace,

        const TripChatButton(),
        AppSpacing.md.verticalSpace,

        TripCancelButton(
          isLoading: cancelStatus.isLoading,
          onTap: onCancelPressed,
        ),
      ],
    );
  }
}
