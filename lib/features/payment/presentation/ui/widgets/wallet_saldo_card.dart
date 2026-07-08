import 'package:customertaxi/common/imports/imports.dart';

import '../../states/payment_bloc.dart';
import '../screens/wallet_transactions_screen.dart';
import 'payment_format.dart';
import 'top_up_amount_sheet.dart';

/// Fat7i Saldo card: balance + top-up action. Tapping the card opens the
/// wallet transaction history.
class WalletSaldoCard extends StatelessWidget {
  const WalletSaldoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      buildWhen: (a, b) =>
          a.balanceStatus != b.balanceStatus ||
          a.topUpStatus != b.topUpStatus,
      builder: (context, state) {
        final balance = state.balanceStatus.getDataWhenSuccess;
        final isLoadingBalance = state.balanceStatus.isLoading;
        final isToppingUp = state.topUpStatus.isLoading;

        return InkWell(
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          onTap: () => context.pushNamed(WalletTransactionsScreen.pageName),
          child: Container(
            padding: REdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              gradient: context.gradients.primary,
              borderRadius: BorderRadius.circular(AppRadii.lg.r),
              boxShadow: context.shadows.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.walletSaldoTitle,
                            style: AppTextStyles.s16w600.copyWith(
                              color: context.onPrimary.withValues(alpha: 0.9),
                            ),
                          ),
                          AppSpacing.sm.verticalSpace,
                          if (isLoadingBalance && balance == null)
                            Container(
                              height: 30.h,
                              width: 90.w,
                              decoration: BoxDecoration(
                                color: context.onPrimary.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(AppRadii.sm.r),
                              ),
                            )
                          else
                            Text(
                              balance == null
                                  ? formatMoney(0, 'EUR')
                                  : formatMoney(
                                      balance.balance,
                                      balance.currencyCode,
                                    ),
                              style: AppTextStyles.s32w700.copyWith(
                                color: context.onPrimary,
                              ),
                            ),
                        ],
                      ),
                    ),
                    _TopUpButton(
                      isLoading: isToppingUp,
                      onTap: () => _startTopUp(context),
                    ),
                  ],
                ),
                AppSpacing.md.verticalSpace,
                Divider(color: context.onPrimary.withValues(alpha: 0.25)),
                AppSpacing.sm.verticalSpace,
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.shieldHalved,
                      size: 12.r,
                      color: context.onPrimary.withValues(alpha: 0.9),
                    ),
                    AppSpacing.sm.horizontalSpace,
                    Text(
                      AppStrings.walletTopUpVia,
                      style: AppTextStyles.s12w500.copyWith(
                        color: context.onPrimary.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _startTopUp(BuildContext context) async {
    final bloc = context.read<PaymentBloc>();
    final amount = await showTopUpAmountSheet(context);
    if (amount != null && amount > 0) {
      bloc.add(PaymentEvent.topUpSubmitted(amount));
    }
  }
}

class _TopUpButton extends StatelessWidget {
  const _TopUpButton({required this.isLoading, required this.onTap});

  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(999.r),
      child: Container(
        width: 44.r,
        height: 44.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.onPrimary.withValues(alpha: 0.18),
          shape: BoxShape.circle,
          border: Border.all(color: context.onPrimary.withValues(alpha: 0.5)),
        ),
        child: isLoading
            ? SizedBox(
                width: 18.r,
                height: 18.r,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: context.onPrimary,
                ),
              )
            : FaIcon(
                FontAwesomeIcons.plus,
                size: 18.r,
                color: context.onPrimary,
              ),
      ),
    );
  }
}
