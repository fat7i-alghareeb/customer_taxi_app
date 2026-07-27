import 'package:customertaxi/common/imports/imports.dart';

import '../../../domain/entities/refund_issue_request_type.dart';

class RefundIssueReasonOption {
  const RefundIssueReasonOption({required this.type, required this.label});

  final RefundIssueRequestType type;
  final String label;
}

/// A borderless radio row meant to sit inside a shared grouped card
/// (see [RefundIssueBody]). Label on the leading edge, radio glyph trailing.
class RefundIssueReasonOptionTile extends StatelessWidget {
  const RefundIssueReasonOptionTile({
    super.key,
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final RefundIssueReasonOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.md.r),
      child: Padding(
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                option.label,
                style: AppTextStyles.s14w600.copyWith(
                  color: selected
                      ? AppColors.tripOrange
                      : context.onSurface,
                ),
              ),
            ),
            AppSpacing.md.horizontalSpace,
            FaIcon(
              selected
                  ? FontAwesomeIcons.solidCircleCheck
                  : FontAwesomeIcons.circle,
              size: 16.r,
              color: selected
                  ? AppColors.tripOrange
                  : context.onSurface.withValues(alpha: 0.42),
            ),
          ],
        ),
      ),
    );
  }
}
