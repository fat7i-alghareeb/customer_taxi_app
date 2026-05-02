import 'package:customertaxi/common/imports/imports.dart';

class DrawerLogoutFooter extends StatelessWidget {
  const DrawerLogoutFooter({
    super.key,
    required this.onLogoutTap,
  });

  final VoidCallback onLogoutTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        context.bottomPadding + AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(
          color: context.onSurface.withValues(alpha: 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onLogoutTap,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        child: Padding(
          padding: REdgeInsets.all(AppSpacing.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.rightFromBracket,
                size: 20.r,
                color: context.primary,
              ),
              AppSpacing.md.horizontalSpace,
              Text(
                AppStrings.logout,
                style: AppTextStyles.s16w600.copyWith(
                  color: context.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.2, duration: AppDurations.normal);
  }
}
