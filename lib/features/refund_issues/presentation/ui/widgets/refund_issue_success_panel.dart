import 'package:customertaxi/common/imports/imports.dart';

/// Outcome the result panel communicates, derived from the refund status
/// snapshot returned by the submit response. Kept intentionally binary
/// (plus a neutral fallback) — no granular status or failure reason shown.
enum _RefundOutcome { succeeded, failed, submitted }

class RefundIssueSuccessPanel extends StatelessWidget {
  const RefundIssueSuccessPanel({
    super.key,
    required this.referenceCode,
    required this.onOpenWhatsApp,
    this.refundStatusSnapshot,
  });

  final String referenceCode;
  final VoidCallback onOpenWhatsApp;

  /// Live `PaymentRefund` status captured when the request was submitted
  /// (e.g. "Succeeded", "Failed", "Pending"). May be null.
  final String? refundStatusSnapshot;

  _RefundOutcome get _outcome {
    switch (refundStatusSnapshot?.trim().toLowerCase()) {
      case 'succeeded':
        return _RefundOutcome.succeeded;
      case 'failed':
      case 'permanentlyfailed':
        return _RefundOutcome.failed;
      default:
        return _RefundOutcome.submitted;
    }
  }

  @override
  Widget build(BuildContext context) {
    final outcome = _outcome;
    final isFailed = outcome == _RefundOutcome.failed;
    final accent = isFailed ? AppColors.error : AppColors.success;

    final icon = switch (outcome) {
      _RefundOutcome.succeeded => FontAwesomeIcons.solidCircleCheck,
      _RefundOutcome.failed => FontAwesomeIcons.circleXmark,
      _RefundOutcome.submitted => FontAwesomeIcons.solidCircleCheck,
    };

    final title = switch (outcome) {
      _RefundOutcome.succeeded => AppStrings.refundIssueRefundSucceededTitle,
      _RefundOutcome.failed => AppStrings.refundIssueRefundFailedTitle,
      _RefundOutcome.submitted => AppStrings.refundIssueSuccessTitle,
    };

    final body = switch (outcome) {
      _RefundOutcome.succeeded => AppStrings.refundIssueRefundSucceededBody,
      _RefundOutcome.failed => AppStrings.refundIssueRefundFailedBody,
      _RefundOutcome.submitted => AppStrings.refundIssueSuccessBody,
    };

    return Center(
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.xl),
        child: Container(
          padding: REdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: context.surface,
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            border: Border.all(color: accent.withValues(alpha: 0.22)),
            boxShadow: context.shadows.primary,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FaIcon(icon, size: 42.r, color: accent),
              AppSpacing.lg.verticalSpace,
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.s18w600.copyWith(color: context.onSurface),
              ),
              AppSpacing.sm.verticalSpace,
              Text(
                body.replaceAll('{reference}', referenceCode),
                textAlign: TextAlign.center,
                style: AppTextStyles.s14w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.7),
                ),
              ),
              AppSpacing.xl.verticalSpace,
              AppButton.outline(
                variant: isFailed
                    ? AppButtonVariant.warning
                    : AppButtonVariant.success,
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
