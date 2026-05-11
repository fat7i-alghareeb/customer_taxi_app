import 'package:customertaxi/common/imports/imports.dart';

import '../../../states/order_bloc.dart';

class OrderMapContextTriggerWidget extends StatelessWidget {
  const OrderMapContextTriggerWidget({
    super.key,
    required this.target,
    required this.onTap,
  });

  final OrderLocationTarget target;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final targetLabel = switch (target) {
      OrderLocationTarget.stop => AppStrings.from,
    };

    return Material(
          color: context.surface,
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            onTap: onTap,
            child: Container(
              height: 52.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadii.lg.r),
                border: Border.all(
                  color: context.colorScheme.outline.withValues(alpha: 0.15),
                  width: 1.5,
                ),
              ),
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Row(
                  children: [
                    Container(
                      padding: REdgeInsets.all(AppSpacing.xs),
                      decoration: BoxDecoration(
                        color: context.primary.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.mapLocationDot,
                        size: 14.r,
                        color: context.primary,
                      ),
                    ),
                    AppSpacing.sm.horizontalSpace,
                    Expanded(
                      child: Text(
                        '${AppStrings.setOnMap} $targetLabel',
                        style: AppTextStyles.s14w600.copyWith(
                          color: context.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: 12.r,
                      color: context.onSurface.withValues(alpha: 0.4),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
  }
}
