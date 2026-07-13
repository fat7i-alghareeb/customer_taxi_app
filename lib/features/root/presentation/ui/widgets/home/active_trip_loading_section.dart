import 'package:customertaxi/common/imports/imports.dart';

/// Shown by [ActiveTripGate] while it's resolving whether the passenger has
/// an active trip — on cold start, and (mainly) right after a booking
/// succeeds while the backend confirms and the live trip view spins up.
/// Replaces a bare spinner with a pulsing car icon + status copy so the wait
/// reads as progress rather than a stall.
class ActiveTripLoadingSection extends StatelessWidget {
  const ActiveTripLoadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
                padding: REdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: FaIcon(
                  FontAwesomeIcons.carSide,
                  color: AppColors.primary,
                  size: 32.r,
                ),
              )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .scaleXY(
                begin: 0.9,
                end: 1.15,
                duration: 700.ms,
                curve: Curves.easeInOut,
              ),
          AppSpacing.lg.verticalSpace,
          Text(
            AppStrings.activeTripBookingLoadingTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.s16w700.copyWith(color: context.onSurface),
          ),
          AppSpacing.xs.verticalSpace,
          Text(
            AppStrings.activeTripBookingLoadingSubtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.s12w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
