import 'package:customertaxi/common/imports/imports.dart';

class DrawerLogoutFooter extends StatelessWidget {
  const DrawerLogoutFooter({super.key, required this.onLogoutTap});

  final VoidCallback onLogoutTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xl,
        context.bottomPadding + AppSpacing.xl,
      ),
      child: AppButton.variant(
        variant: CustomButtonVariant(
          gradientColor: context.gradients.primary,
          foregroundColor: AppColors.secondary,
        ),
        fill: AppButtonFill.gradient,
        layout: AppButtonLayout(height: 52.sp, borderRadius: AppRadii.lg),
        child: AppButtonChild.labelIcon(
          label: AppStrings.logout,
          icon: IconSource.faIcon(FontAwesomeIcons.rightFromBracket),
          iconSize: 18.r,
          textStyle: AppTextStyles.s16w700,
        ),
        onTap: onLogoutTap,
      ),
    ).animate().fadeIn().slideY(begin: 0.2, duration: AppDurations.normal);
  }
}
