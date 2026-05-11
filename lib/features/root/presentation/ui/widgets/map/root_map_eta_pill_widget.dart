import 'package:customertaxi/common/imports/imports.dart';

class RootMapEtaPillWidget extends StatelessWidget {
  const RootMapEtaPillWidget({super.key, required this.durationText});

  final String durationText;

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: REdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: context.primary.withValues(alpha: .9),
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            boxShadow: context.shadows.grey,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.clock,
                size: 14.r,
                color: AppColors.backGroundLight,
              ),
              AppSpacing.sm.horizontalSpace,
              Text(
                '${AppStrings.estimatedTripTime}: $durationText',
                style: AppTextStyles.s14w600.copyWith(
                  color: AppColors.backGroundLight,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: AppDurations.normal)
        .slideY(begin: -0.2, end: 0, curve: Curves.easeOutBack);
  }
}
