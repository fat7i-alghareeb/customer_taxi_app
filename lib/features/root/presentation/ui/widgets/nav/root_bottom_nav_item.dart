import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/root/constants/root_constants.dart';

class RootBottomNavItem extends StatelessWidget {
  const RootBottomNavItem({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = isSelected
        ? context.primary
        : context.onSurface.withValues(alpha: 0.65);

    final background = isSelected
        ? context.primary.withValues(alpha: 0.12)
        : context.surface.withValues(alpha: 0.0);

    return AppButton.variant(
      variant: AppButtonVariant.grey,
      fill: AppButtonFill.solid,
      onTap: onTap,
      noShadow: true,
      layout: AppButtonLayout(
        height: RootConstants.bottomNavItemHeight.sp,
        borderRadius: AppRadii.lg,
        backgroundColor: background,
        contentPadding: REdgeInsets.symmetric(horizontal: AppSpacing.sm),
      ),
      child: AppButtonChild.custom(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              icon,
              size: RootConstants.bottomNavIconSize.r,
              color: foreground,
            ),
            AppSpacing.xs.verticalSpace,
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.s11w500.copyWith(color: foreground),
            ),
          ],
        ),
      ),
    );
  }
}
