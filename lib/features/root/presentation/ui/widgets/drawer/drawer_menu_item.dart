import 'package:customertaxi/common/imports/imports.dart';

class DrawerMenuItem extends StatelessWidget {
  const DrawerMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.value,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.md.r),
      child: Padding(
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.lg,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 24.r,
              child: Center(
                child: FaIcon(
                  icon,
                  size: 20.r,
                  color: context.primary,
                ),
              ),
            ),
            AppSpacing.xl.horizontalSpace,
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.s16w600.copyWith(
                  color: context.onSurface,
                ),
              ),
            ),
            if (value != null) ...[
              Text(
                value!,
                style: AppTextStyles.s14w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.6),
                ),
              ),
              AppSpacing.md.horizontalSpace,
            ],
            FaIcon(
              FontAwesomeIcons.chevronRight,
              size: 14.r,
              color: context.onSurface.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideX(begin: 0.05, duration: AppDurations.normal);
  }
}
