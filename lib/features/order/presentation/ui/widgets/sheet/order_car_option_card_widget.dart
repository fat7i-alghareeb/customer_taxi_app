import 'package:customertaxi/common/imports/imports.dart';

class OrderCarOptionCardWidget extends StatelessWidget {
  const OrderCarOptionCardWidget({
    super.key,
    required this.title,
    required this.imagePath,
    required this.isSelected,
    required this.isPriceLoading,
    required this.onTap,
    this.priceText,
  });

  final String title;
  final String imagePath;
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
          padding: REdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? context.primary.withValues(alpha: 0.08)
                : context.surface,
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            border: Border.all(
              color: isSelected
                  ? context.primary
                  : context.onSurface.withValues(alpha: 0.05),
              width: isSelected ? 2.5.r : 1.5.r,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: context.primary.withValues(alpha: 0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: context.onSurface.withValues(alpha: 0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: AppDurations.normal,
                width: 60.r,
                height: 60.r,
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            context.primary,
                            context.primary.withValues(alpha: 0.85),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : LinearGradient(
                          colors: [
                            context.onSurface.withValues(alpha: 0.04),
                            context.onSurface.withValues(alpha: 0.07),
                          ],
                        ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: AppImageViewer.asset(
                    imagePath,
                    width: 44.r,
                    height: 44.r,
                    fit: BoxFit.contain,
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
                    style: AppTextStyles.s16w600.copyWith(
                      color: isSelected ? context.primary : context.onSurface,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  AppSpacing.xs.verticalSpace,
                  if (isPriceLoading)
                    LoadingDots(
                      color: context.primary,
                      dotSize: 4.r,
                      spacing: 3.r,
                    )
                  else
                    Text(
                      priceText ?? '--',
                      style: AppTextStyles.s14w600.copyWith(
                        color: isSelected
                            ? context.primary
                            : context.onSurface.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w800,
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
