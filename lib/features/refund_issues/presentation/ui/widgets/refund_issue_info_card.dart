import 'package:customertaxi/common/imports/imports.dart';

class RefundIssueInfoCard extends StatelessWidget {
  const RefundIssueInfoCard({super.key, required this.knownFailed});

  final bool knownFailed;

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
            child: Text(
              knownFailed
                  ? AppStrings.refundIssueKnownFailedInfo
                  : AppStrings.refundIssueSafeInfo,
              style: AppTextStyles.s12w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.76),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
