import 'package:customertaxi/common/imports/imports.dart';

class OrderCarOptionCardWidget extends StatelessWidget {
  const OrderCarOptionCardWidget({
    super.key,
    required this.title,
    required this.imagePath,
    required this.isSelected,
    required this.isPriceLoading,
    required this.passengerCapacity,
    required this.onTap,
    required this.priceText,
    this.originalPriceText,
  });

  final String title;
  final String imagePath;
  final bool isSelected;
  final bool isPriceLoading;
  final int passengerCapacity;
  final VoidCallback onTap;
  final String? priceText;
  final String? originalPriceText;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppDurations.normal,
      curve: Curves.easeOutCubic,
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
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          onTap: onTap,
          child: Padding(
            padding: REdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: AppDurations.normal,
                  width: 56.r,
                  height: 56.r,
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
                      width: 40.r,
                      height: 40.r,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                AppSpacing.md.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.s16w600.copyWith(
                          color: isSelected
                              ? context.primary
                              : context.onSurface,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      AppSpacing.xs.verticalSpace,
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: 13.r,
                            color: isSelected
                                ? context.primary
                                : context.onSurface.withValues(alpha: 0.55),
                          ),
                          AppSpacing.xs.horizontalSpace,
                          Text(
                            '$passengerCapacity',
                            style: AppTextStyles.s12w500.copyWith(
                              color: isSelected
                                  ? context.primary
                                  : context.onSurface.withValues(alpha: 0.55),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AppSpacing.md.horizontalSpace,
                if (isPriceLoading)
                  LoadingDots(
                    color: context.primary,
                    dotSize: 4.r,
                    spacing: 3.r,
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (originalPriceText != null)
                        Text(
                          originalPriceText!,
                          style: AppTextStyles.s12w400.copyWith(
                            color: context.onSurface.withValues(alpha: 0.45),
                            decoration: TextDecoration.lineThrough,
                            decorationColor:
                                context.onSurface.withValues(alpha: 0.45),
                          ),
                        ),
                      Text(
                        priceText ?? '--',
                        style: AppTextStyles.s14w700.copyWith(
                          color: isSelected
                              ? context.primary
                              : context.onSurface.withValues(alpha: 0.8),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 200.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
