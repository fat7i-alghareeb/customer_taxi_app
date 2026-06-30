import 'package:customertaxi/common/imports/imports.dart';

class RefundIssueSuccessPanel extends StatelessWidget {
  const RefundIssueSuccessPanel({
    super.key,
    required this.referenceCode,
    required this.onOpenWhatsApp,
  });

  final String referenceCode;
  final VoidCallback onOpenWhatsApp;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.xl),
        child: Container(
          padding: REdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: context.surface,
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            border: Border.all(
              color: AppColors.success.withValues(alpha: 0.22),
            ),
            boxShadow: context.shadows.primary,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FaIcon(
                FontAwesomeIcons.solidCircleCheck,
                size: 42.r,
                color: AppColors.success,
              ),
              AppSpacing.lg.verticalSpace,
              Text(
                AppStrings.refundIssueSuccessTitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.s18w600.copyWith(color: context.onSurface),
              ),
              AppSpacing.sm.verticalSpace,
              Text(
                AppStrings.refundIssueSuccessBody.replaceAll(
                  '{reference}',
                  referenceCode,
                ),
                textAlign: TextAlign.center,
                style: AppTextStyles.s14w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.7),
                ),
              ),
              AppSpacing.xl.verticalSpace,
              AppButton.outline(
                variant: AppButtonVariant.success,
                onTap: onOpenWhatsApp,
                child: AppButtonChild.labelIcon(
                  label: AppStrings.refundIssueOpenWhatsApp,
                  icon: IconSource.faIcon(FontAwesomeIcons.whatsapp),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: AppDurations.normal).slideY(begin: 0.08),
      ),
    );
  }
}
