import 'package:customertaxi/common/imports/imports.dart';

/// Actions for the force-update screen.
///
/// When the backend has no store URL for this platform the primary button is
/// omitted entirely rather than shown disabled: a button that cannot do
/// anything is worse than a sentence telling the user what to do. The re-check
/// action always stays, because iOS can return the user to a foregrounded app
/// that never restarted.
class ForceUpdateActionsWidget extends StatelessWidget {
  const ForceUpdateActionsWidget({
    super.key,
    required this.hasStoreUrl,
    required this.isChecking,
    required this.onUpdate,
    required this.onRecheck,
  });

  final bool hasStoreUrl;
  final bool isChecking;
  final VoidCallback onUpdate;
  final VoidCallback onRecheck;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (hasStoreUrl) ...[
          AppButton.primaryGradient(
            layout: const AppButtonLayout(height: 52),
            onTap: onUpdate,
            child: AppButtonChild.label(
              AppStrings.forceUpdateButton,
              textStyle: AppTextStyles.s14w600,
            ),
          ),
          AppSpacing.md.verticalSpace,
        ] else ...[
          Text(
            AppStrings.updateFromStoreHint,
            textAlign: TextAlign.center,
            style: AppTextStyles.s14w600.copyWith(color: context.primary),
          ),
          AppSpacing.lg.verticalSpace,
        ],
        AppButton.outline(
          isLoading: isChecking,
          layout: const AppButtonLayout(height: 52),
          onTap: onRecheck,
          child: AppButtonChild.label(
            AppStrings.forceUpdateAlreadyUpdated,
            textStyle: AppTextStyles.s14w600,
          ),
        ),
      ],
    );
  }
}
