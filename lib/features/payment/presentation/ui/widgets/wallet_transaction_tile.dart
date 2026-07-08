import 'package:customertaxi/common/imports/imports.dart';

import '../../../domain/entities/wallet_entities.dart';
import 'payment_format.dart';

class WalletTransactionTile extends StatelessWidget {
  const WalletTransactionTile({super.key, required this.transaction});

  final WalletTransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    final isCredit = transaction.isCredit;
    final accent = transaction.isPending
        ? AppColors.warning
        : (isCredit ? AppColors.success : context.onSurface);
    final sign = isCredit ? '+' : '−';

    return Padding(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: (isCredit ? AppColors.success : context.onSurface)
                  .withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: FaIcon(
              isCredit
                  ? FontAwesomeIcons.arrowDown
                  : FontAwesomeIcons.arrowUp,
              size: 14.r,
              color: isCredit ? AppColors.success : context.onSurface,
            ),
          ),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _typeLabel(transaction.type),
                  style: AppTextStyles.s14w600.copyWith(
                    color: context.onSurface,
                  ),
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  _subtitle(context),
                  style: AppTextStyles.s11w500.copyWith(
                    color: context.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '$sign ${formatMoney(transaction.amount, transaction.currencyCode)}',
            style: AppTextStyles.s14w700.copyWith(color: accent),
          ),
        ],
      ),
    );
  }

  String _subtitle(BuildContext context) {
    final d = transaction.createdAtUtc.toLocal();
    final date =
        '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
    if (transaction.isPending) {
      return '$date · ${AppStrings.walletTxnPending}';
    }
    return date;
  }

  String _typeLabel(String type) {
    switch (type) {
      case 'TopUp':
        return AppStrings.walletTxnTopUp;
      case 'TripPayment':
        return AppStrings.walletTxnTripPayment;
      case 'FeeCharge':
        return AppStrings.walletTxnFee;
      case 'RefundReversal':
        return AppStrings.walletTxnRefund;
      case 'AdminAdjustment':
        return AppStrings.walletTxnAdjustment;
      default:
        return AppStrings.walletTxnOther;
    }
  }
}
