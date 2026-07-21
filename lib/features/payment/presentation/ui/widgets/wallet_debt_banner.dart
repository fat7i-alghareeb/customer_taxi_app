import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/payment/presentation/states/wallet_cubit.dart';
import 'package:customertaxi/features/payment/presentation/ui/screens/betaling_screen.dart';
import 'package:customertaxi/features/payment/presentation/ui/widgets/payment_format.dart';

/// Persistent notice that the customer owes money and cannot book until it is paid.
///
/// The server already refuses the booking, but that arrives as a transient error banner after
/// the customer has picked a destination and chosen a car — far too late and too easy to miss.
/// This states it up front, and taps through to the wallet where it can be settled.
///
/// Self-hiding, like [AppDiscountBanner]: renders nothing when there is no blocking debt.
class WalletDebtBanner extends StatelessWidget {
  const WalletDebtBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      bloc: getIt<WalletCubit>(),
      buildWhen: (a, b) =>
          a.isBookingBlocked != b.isBookingBlocked ||
          a.amountOwed != b.amountOwed,
      builder: (context, state) {
        if (!state.isBookingBlocked) return const SizedBox.shrink();

        final colors = context.colorScheme;
        final amount = formatMoney(state.amountOwed, state.currencyCode);

        return Padding(
          padding: REdgeInsets.only(bottom: AppSpacing.md),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadii.md.r),
            onTap: () => context.pushNamed(BetalingScreen.pageName),
            child: Container(
              padding: REdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadii.md.r),
                border: Border.all(
                  color: AppColors.error.withValues(alpha: 0.35),
                  width: 1.r,
                ),
              ),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleExclamation,
                    size: 16.r,
                    color: AppColors.error,
                  ),
                  AppSpacing.md.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.bookingBlockedByDebtTitle,
                          style: AppTextStyles.s14w600.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                        AppSpacing.xs.verticalSpace,
                        Text(
                          AppStrings.bookingBlockedByDebtMessage.replaceAll(
                            '{amount}',
                            amount,
                          ),
                          style: AppTextStyles.s12w400.copyWith(
                            color: colors.onSurface.withValues(alpha: 0.75),
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 12.r,
                    color: AppColors.error.withValues(alpha: 0.7),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
