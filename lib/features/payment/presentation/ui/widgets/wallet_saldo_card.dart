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
        final isInDebt = balance?.isInDebt ?? false;

        return InkWell(
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          onTap: () => context.pushNamed(WalletTransactionsScreen.pageName),
          child: Container(
            padding: REdgeInsets.all(AppSpacing.lg),
            // A debt is not a balance. Rendering it on the usual brand gradient made
            // "€ -12.50" read as an ordinary saldo with a stray minus sign, which is how
            // customers ended up believing nothing had been charged.
            decoration: BoxDecoration(
              gradient: isInDebt ? null : context.gradients.primary,
              color: isInDebt ? AppColors.error : null,
              borderRadius: BorderRadius.circular(AppRadii.lg.r),
              boxShadow: isInDebt ? null : context.shadows.primary,
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
                            isInDebt
                                ? AppStrings.walletAmountOwedTitle
                                : AppStrings.walletSaldoTitle,
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
                                      // Shown as a positive figure under an "amount owed"
                                      // label — clearer than a negative under "balance".
                                      isInDebt
                                          ? balance.amountOwed
                                          : balance.balance,
                                      balance.currencyCode,
                                    ),
                              style: AppTextStyles.s32w700.copyWith(
                                color: context.onPrimary,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (!isInDebt)
                      _TopUpButton(
                        isLoading: isToppingUp,
                        onTap: () => _startTopUp(context),
                      ),
                  ],
                ),
                AppSpacing.md.verticalSpace,
                Divider(color: context.onPrimary.withValues(alpha: 0.25)),
                AppSpacing.sm.verticalSpace,
                if (isInDebt && balance != null) ...[
                  Text(
                    AppStrings.walletDebtExplainer,
                    style: AppTextStyles.s12w400.copyWith(
                      color: context.onPrimary.withValues(alpha: 0.9),
                      height: 1.35,
                    ),
                  ),
                  AppSpacing.md.verticalSpace,
                  // Pre-filled with the exact debt: the server waives its usual minimum
                  // top-up for this amount, so a small debt is still payable.
                  _PayDebtButton(
                    isLoading: isToppingUp,
                    label: AppStrings.walletPayWhatYouOwe.replaceAll(
                      '{amount}',
                      formatMoney(balance.amountOwed, balance.currencyCode),
                    ),
                    onTap: () => context.read<PaymentBloc>().add(
                      PaymentEvent.topUpSubmitted(balance.amountOwed),
                    ),
                  ),
                ] else
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

/// Full-width settle button shown in place of the top-up affordance while in debt. Deliberately
/// the only action on the card: the customer is blocked until this is paid, so offering a free
/// top-up amount alongside it would just let them pay the wrong figure and stay blocked.
class _PayDebtButton extends StatelessWidget {
  const _PayDebtButton({
    required this.isLoading,
    required this.label,
    required this.onTap,
  });

  final bool isLoading;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(AppRadii.md.r),
        child: Container(
          padding: REdgeInsets.symmetric(vertical: AppSpacing.sm),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.onPrimary,
            borderRadius: BorderRadius.circular(AppRadii.md.r),
          ),
          child: isLoading
              ? SizedBox(
                  width: 18.r,
                  height: 18.r,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(AppColors.error),
                  ),
                )
              : Text(
                  label,
                  style: AppTextStyles.s14w600.copyWith(color: AppColors.error),
                ),
        ),
      ),
    );
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
