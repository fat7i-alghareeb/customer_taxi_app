import 'package:customertaxi/common/imports/imports.dart';

/// Warning-tinted info card. Renders an optional bold [title] above [message].
/// Used both for the safe-review notice and the "What happens now?" panel.
class RefundIssueInfoCard extends StatelessWidget {
  const RefundIssueInfoCard({super.key, required this.message, this.title});

  /// Convenience constructor for the safe/known-failed review notice.
  RefundIssueInfoCard.review({super.key, required bool knownFailed})
    : title = null,
      message = knownFailed
          ? AppStrings.refundIssueKnownFailedInfo
          : AppStrings.refundIssueSafeInfo;

  final String? title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadii.md.r),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.28)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FaIcon(
            FontAwesomeIcons.circleInfo,
            size: 16.r,
            color: AppColors.warning,
          ),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: AppTextStyles.s14w600.copyWith(
                      color: context.onSurface,
                    ),
                  ),
                  AppSpacing.xs.verticalSpace,
                ],
                Text(
                  message,
                  style: AppTextStyles.s12w400.copyWith(
                    color: context.onSurface.withValues(alpha: 0.76),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
