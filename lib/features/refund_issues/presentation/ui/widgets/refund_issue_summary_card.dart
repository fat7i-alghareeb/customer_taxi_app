import 'package:customertaxi/common/imports/imports.dart';

import '../screens/refund_issue_screen.dart';

class RefundIssueSummaryCard extends StatelessWidget {
  const RefundIssueSummaryCard({super.key, required this.args});

  final RefundIssueScreenArgs args;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
        boxShadow: context.shadows.primary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42.w,
                height: 42.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadii.lg.r),
                ),
                child: FaIcon(
                  FontAwesomeIcons.rotateLeft,
                  size: 18.r,
                  color: AppColors.warning,
                ),
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.refundIssueSummaryTitle,
                      style: AppTextStyles.s16w700.copyWith(
                        color: context.onSurface,
                      ),
                    ),
                    AppSpacing.xs.verticalSpace,
                    Text(
                      AppStrings.tripReferenceCode.replaceAll(
                        '#{code}',
                        args.referenceCode,
                      ),
                      style: AppTextStyles.s12w400.copyWith(
                        color: context.onSurface.withValues(alpha: 0.56),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.lg.verticalSpace,
          RefundIssueSummaryRow(
            label: AppStrings.refundIssueRouteFrom,
            value: args.fromLabel,
          ),
          AppSpacing.sm.verticalSpace,
          RefundIssueSummaryRow(
            label: AppStrings.refundIssueRouteTo,
            value: args.toLabel,
          ),
          AppSpacing.sm.verticalSpace,
          RefundIssueSummaryRow(
            label: AppStrings.refundIssueRefundAmount,
            value: _formatAmount(args.refundAmount, args.currencyCode),
            valueColor: AppColors.warning,
          ),
          AppSpacing.sm.verticalSpace,
          RefundIssueSummaryRow(
            label: AppStrings.refundIssueRefundPercent,
            value: '${args.refundPercent.toStringAsFixed(0)}%',
          ),
        ],
      ),
    );
  }

  String _formatAmount(double value, String currencyCode) =>
      '${value.toStringAsFixed(2)} $currencyCode';
}

class RefundIssueSummaryRow extends StatelessWidget {
  const RefundIssueSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 118.w,
          child: Text(
            label,
            style: AppTextStyles.s12w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.58),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value.isEmpty ? AppStrings.notAvailable : value,
            textAlign: TextAlign.end,
            style: AppTextStyles.s12w700.copyWith(
              color: valueColor ?? context.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
