import 'package:customertaxi/common/imports/imports.dart';

class SafetyAction extends StatelessWidget {
  const SafetyAction({
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.md.r),
        child: Container(
          margin: REdgeInsets.symmetric(horizontal: AppSpacing.xs / 2),
          padding: REdgeInsets.symmetric(
            vertical: AppSpacing.md,
            horizontal: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: colors.onSurface.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(AppRadii.md.r),
            border: Border.all(color: colors.onSurface.withValues(alpha: 0.12)),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 22.r, color: context.primary),
                AppSpacing.sm.verticalSpace,
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.s11w500.copyWith(
                    color: colors.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
