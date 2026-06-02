import 'package:customertaxi/common/imports/imports.dart';

/// Soft surface card showing fare amount + trip reference. Extracted from
/// the original inline completion sheet so multiple screens render it
/// identically.
class TripFareSummaryCard extends StatelessWidget {
  const TripFareSummaryCard({
    super.key,
    required this.amount,
    required this.currencyCode,
    required this.referenceCode,
  });

  final double amount;
  final String currencyCode;
  final String referenceCode;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final fareStr = '${amount.toStringAsFixed(2)} $currencyCode';

    return Container(
      padding: REdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.onSurface.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
      ),
      child: Column(
        children: [
          Text(
            AppStrings.tripFare.replaceAll('{fare} {currency}', fareStr),
            style: AppTextStyles.s24w700.copyWith(color: colors.primary),
          ),
          AppSpacing.xs.verticalSpace,
          Text(
            AppStrings.tripReferenceCode.replaceAll('#{code}', referenceCode),
            style: AppTextStyles.s12w400.copyWith(
              color: colors.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
