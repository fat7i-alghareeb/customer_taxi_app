import 'package:customertaxi/common/imports/imports.dart';

import '../../../domain/entities/refund_issue_request_type.dart';

class RefundIssueReasonOption {
  const RefundIssueReasonOption({
    required this.type,
    required this.icon,
    required this.label,
  });

  final RefundIssueRequestType type;
  final FaIconData icon;
  final String label;
}

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
    return AppButton.outline(
      variant: selected ? AppButtonVariant.warning : AppButtonVariant.grey,
      onTap: onTap,
      child: AppButtonChild.custom(
        Row(
          children: [
            FaIcon(
              option.icon,
              size: 16.r,
              color: selected ? AppColors.warning : context.onSurface,
            ),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Text(
                option.label,
                style: AppTextStyles.s14w600.copyWith(color: context.onSurface),
              ),
            ),
            FaIcon(
              selected
                  ? FontAwesomeIcons.solidCircleCheck
                  : FontAwesomeIcons.circle,
              size: 16.r,
              color: selected
                  ? AppColors.warning
                  : context.onSurface.withValues(alpha: 0.42),
            ),
          ],
        ),
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
      ),
    );
  }
}
