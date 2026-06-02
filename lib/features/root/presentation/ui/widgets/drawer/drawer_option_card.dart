import 'package:customertaxi/common/imports/imports.dart';

class DrawerOptionCard extends StatelessWidget {
  const DrawerOptionCard({
    super.key,
    required this.icon,
    required this.label,
    this.value,
    required this.onTap,
    this.iconColor,
  });

  final IconData icon;
  final String label;
  final String? value;
  final VoidCallback onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        boxShadow: [
          BoxShadow(
            color: context.grey.withValues(alpha: 0.1),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: context.theme.dividerColor.withValues(alpha: 0.05),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        child: Padding(
          padding: REdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                padding: REdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: (iconColor ?? context.primary).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: FaIcon(
                  icon,
                  size: 18.r,
                  color: iconColor ?? context.primary,
                ),
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTextStyles.s14w400.copyWith(
                        color: context.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    if (value != null && value!.isNotEmpty)
                      Text(
                        value!,
                        style: AppTextStyles.s16w700.copyWith(
                          color: context.onSurface,
                        ),
                      ),
                  ],
                ),
              ),
              FaIcon(
                context.chevronEnd,
                size: 14.r,
                color: context.onSurface.withValues(alpha: 0.3),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn().slideX(
      begin: 0.1,
      duration: AppDurations.normal,
      curve: Curves.easeOutQuad,
    );
  }
}
