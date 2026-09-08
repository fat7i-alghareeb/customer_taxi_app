import 'package:customertaxi/common/imports/imports.dart';

/// Body of the soft-update sheet.
///
/// Deliberately quieter than the force screen: a rounded badge rather than a
/// glowing circle, and an obvious way out. When the backend has no store URL the
/// primary button is replaced by a manual-update hint rather than shown dead.
class SoftUpdateSheetContentWidget extends StatelessWidget {
  const SoftUpdateSheetContentWidget({
    super.key,
    required this.latestVersion,
    required this.hasStoreUrl,
    required this.onUpdate,
    required this.onDismiss,
  });

  final String latestVersion;
  final bool hasStoreUrl;
  final VoidCallback onUpdate;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            height: 62.r,
            width: 62.r,
            decoration: BoxDecoration(
              gradient: context.gradients.auroraSoft,
              borderRadius: BorderRadius.circular(AppRadii.lg.r),
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.wandMagicSparkles,
                size: 26.r,
                color: context.primary,
              ),
            ),
          ),
        ),
        AppSpacing.lg.verticalSpace,
        Text(
          AppStrings.softUpdateTitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.s20w700.copyWith(color: context.onSurface),
        ),
        AppSpacing.sm.verticalSpace,
        Text(
          AppStrings.softUpdateMessage,
          textAlign: TextAlign.center,
          style: AppTextStyles.s14w400.copyWith(
            color: context.onSurface.withValues(alpha: 0.7),
          ),
        ),
        if (latestVersion.isNotEmpty) ...[
          AppSpacing.md.verticalSpace,
          Center(
            child: Container(
              padding: REdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: context.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadii.xl.r),
              ),
              child: Text(
                latestVersion,
                style: AppTextStyles.s12w700.copyWith(color: context.primary),
              ),
            ),
          ),
        ],
        AppSpacing.xl.verticalSpace,
        if (hasStoreUrl) ...[
          AppButton.primaryGradient(
            layout: const AppButtonLayout(height: 52),
            onTap: onUpdate,
            child: AppButtonChild.label(
              AppStrings.softUpdateButton,
              textStyle: AppTextStyles.s14w600,
            ),
          ),
          AppSpacing.sm.verticalSpace,
        ] else ...[
          Text(
            AppStrings.updateFromStoreHint,
            textAlign: TextAlign.center,
            style: AppTextStyles.s14w600.copyWith(color: context.primary),
          ),
          AppSpacing.lg.verticalSpace,
        ],
        AppButton.grey(
          layout: const AppButtonLayout(height: 52),
          onTap: onDismiss,
          child: AppButtonChild.label(
            AppStrings.softUpdateLater,
            textStyle: AppTextStyles.s14w600,
          ),
        ),
      ],
    ).animate().fadeIn(duration: AppDurations.fast);
  }
}
