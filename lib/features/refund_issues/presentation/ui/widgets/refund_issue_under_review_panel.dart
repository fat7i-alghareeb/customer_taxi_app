import 'package:customertaxi/common/imports/imports.dart';

/// Shown in place of the submit form when the rider already has an open refund
/// review for this trip.
///
/// The server accepts one open request per trip, so re-opening this screen used
/// to offer a form that would simply be rejected. Instead it now reports what is
/// already happening, and when the money is due — which is the question the
/// rider came back to ask.
class RefundIssueUnderReviewPanel extends StatelessWidget {
  const RefundIssueUnderReviewPanel({
    required this.submittedAtUtc,
    required this.onOpenWhatsApp,
    super.key,
  });

  final DateTime submittedAtUtc;
  final VoidCallback onOpenWhatsApp;

  @override
  Widget build(BuildContext context) {
    final submittedAtLocal = submittedAtUtc.toLocal();

    return Center(
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.xl),
        child:
            Container(
              padding: REdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: context.surface,
                borderRadius: BorderRadius.circular(AppRadii.lg.r),
                border: Border.all(
                  color: AppColors.tripOrange.withValues(alpha: 0.22),
                ),
                boxShadow: context.shadows.primary,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FaIcon(
                    FontAwesomeIcons.clockRotateLeft,
                    size: 42.r,
                    color: AppColors.tripOrange,
                  ),
                  AppSpacing.lg.verticalSpace,
                  Text(
                    AppStrings.refundIssueUnderReviewTitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.s18w600.copyWith(
                      color: context.onSurface,
                    ),
                  ),
                  AppSpacing.sm.verticalSpace,
                  Text(
                    AppStrings.refundIssueUnderReviewBody,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.s14w400.copyWith(
                      color: context.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  AppSpacing.md.verticalSpace,
                  Text(
                    AppStrings.refundIssueUnderReviewSubmittedAt.replaceAll(
                      '{date}',
                      '${submittedAtLocal.toYmd()} '
                          '${submittedAtLocal.toTime12Compact()}',
                    ),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.s12w400.copyWith(
                      color: context.onSurface.withValues(alpha: 0.45),
                    ),
                  ),
                  AppSpacing.xl.verticalSpace,
                  // Same escape hatch as the success panel: nothing left to
                  // submit, but the rider can still reach a human.
                  AppButton.outline(
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
