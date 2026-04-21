import 'package:customertaxi/common/imports/imports.dart';

class OrderCarOptionCardWidget extends StatelessWidget {
  const OrderCarOptionCardWidget({
    super.key,
    required this.title,
    required this.iconData,
    required this.isSelected,
    required this.isPriceLoading,
    required this.onTap,
    this.priceText,
  });

  final String title;
  final IconData iconData;
  final bool isSelected;
  final bool isPriceLoading;
  final VoidCallback onTap;
  final String? priceText;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppDurations.normal,
          curve: Curves.easeOutCubic,
          padding: REdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: isSelected
                ? context.primary.withValues(alpha: 0.05)
                : context.surface,
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            border: Border.all(
              color: isSelected ? context.primary : Colors.transparent,
              width: 2.r,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: context.primary.withValues(alpha: 0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: AppDurations.normal,
                width: 48.r,
                height: 48.r,
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            context.primary,
                            context.primary.withValues(alpha: 0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : LinearGradient(
                          colors: [
                            context.onSurface.withValues(alpha: 0.05),
                            context.onSurface.withValues(alpha: 0.08),
                          ],
                        ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: FaIcon(
                    iconData,
                    size: 18.r,
                    color: isSelected ? context.onPrimary : context.primary,
                  ),
                ),
              ),
              AppSpacing.md.horizontalSpace,
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    style: AppTextStyles.s14w600.copyWith(
                      color: isSelected ? context.primary : context.onSurface,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  AppSpacing.xs.verticalSpace,
                  if (isPriceLoading)
                    LoadingDots(color: context.primary, dotSize: 3, spacing: 2)
                  else
                    Text(
                      priceText ?? '--',
                      style: AppTextStyles.s14w600.copyWith(
                        color: isSelected
                            ? context.primary
                            : context.onSurface.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w900,
                      ),
                    ).animate().fadeIn(duration: 200.ms),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
