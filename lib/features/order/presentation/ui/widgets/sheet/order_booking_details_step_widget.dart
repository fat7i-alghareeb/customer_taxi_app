import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/order/presentation/states/order_bloc.dart';

class OrderBookingDetailsStepWidget extends StatefulWidget {
  const OrderBookingDetailsStepWidget({super.key, required this.state});

  final OrderState state;

  @override
  State<OrderBookingDetailsStepWidget> createState() =>
      _OrderBookingDetailsStepWidgetState();
}

class _OrderBookingDetailsStepWidgetState
    extends State<OrderBookingDetailsStepWidget> {
  @override
  void initState() {
    super.initState();
    // Load the wallet balance so we can offer Saldo / Wallet+card options.
    context.read<OrderBloc>().add(const OrderEvent.walletBalanceRequested());
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final isLoading =
        state.booking.tripRequestStatus.isLoading ||
        state.booking.paymentSheetState.isLoading;
    final isAirport = state.stops.list.firstOrNull?.isAirport == true;
    final normalizedFlightNumber = state.booking.flightNumber
        .trim()
        .replaceAll(RegExp(r'\s+'), ' ')
        .toUpperCase();
    final hasValidFlightNumber =
        !isAirport ||
        (normalizedFlightNumber.length >= 2 &&
            normalizedFlightNumber.length <= 15 &&
            RegExp(
              r'^[A-Z0-9](?:[A-Z0-9 -]{0,13}[A-Z0-9])?$',
            ).hasMatch(normalizedFlightNumber));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionHeader(title: AppStrings.paymentMethod),
        AppSpacing.md.verticalSpace,
        _PaymentMethodChooser(state: state, fare: _selectedFare(state)),
        AppSpacing.xl.verticalSpace,
        AppButton.primary(
          onTap: () {
            context.read<OrderBloc>().add(
              const OrderEvent.confirmBookingDetailsPressed(),
            );
          },
          isActive: !isLoading && hasValidFlightNumber,
          isLoading: isLoading,
          layout: AppButtonLayout(
            width: double.infinity,
            height: 56.h,
            borderRadius: AppRadii.lg,
          ),
          child: AppButtonChild.label(AppStrings.confirmAndPay),
        ),
      ],
    );
  }

  double? _selectedFare(OrderState state) {
    final options = state.trip.carOptionsState.getDataWhenSuccess;
    if (options == null) return null;
    return options
        .where((c) => c.quoteId == state.trip.selectedQuoteId)
        .firstOrNull
        ?.price;
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.s16w600.copyWith(
        color: context.onSurface,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

/// High-level payment choice. The card portion (Stripe / Wallet+card) always opens
/// the Stripe sheet, which shows whatever methods are enabled in Stripe — we never
/// hardcode payment-method types here.
class _PaymentMethodChooser extends StatelessWidget {
  const _PaymentMethodChooser({required this.state, required this.fare});

  final OrderState state;
  final double? fare;

  @override
  Widget build(BuildContext context) {
    final balance = state.booking.walletBalance;
    final currency = state.booking.walletCurrency;
    final hasWallet = balance != null && balance > 0;
    final canWalletOnly = hasWallet && fare != null && balance >= fare!;
    final canMixed = hasWallet && fare != null && balance < fare!;
    final selected = state.booking.paymentMethod;

    void select(OrderPaymentMethod method) =>
        context.read<OrderBloc>().add(OrderEvent.paymentMethodSelected(method));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _MethodOption(
          icon: FontAwesomeIcons.stripe,
          label: AppStrings.payViaStripe,
          selected: selected == OrderPaymentMethod.card,
          onTap: () => select(OrderPaymentMethod.card),
        ),
        if (canWalletOnly) ...[
          AppSpacing.sm.verticalSpace,
          _MethodOption(
            icon: FontAwesomeIcons.wallet,
            label: AppStrings.orderPayWithSaldo,
            subtitle: _money(balance, currency),
            selected: selected == OrderPaymentMethod.wallet,
            onTap: () => select(OrderPaymentMethod.wallet),
          ),
        ],
        if (canMixed) ...[
          AppSpacing.sm.verticalSpace,
          _MethodOption(
            icon: FontAwesomeIcons.layerGroup,
            label: AppStrings.orderPayWalletPlusCard,
            subtitle:
                '${_money(balance, currency)} + ${_money(fare! - balance, currency)}',
            selected: selected == OrderPaymentMethod.mixed,
            onTap: () => select(OrderPaymentMethod.mixed),
          ),
        ],
      ],
    );
  }

  String _money(double value, String currency) {
    final symbol = currency.toUpperCase() == 'EUR' ? '€' : currency;
    return '$symbol ${value.toStringAsFixed(2)}';
  }
}

class _MethodOption extends StatelessWidget {
  const _MethodOption({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.subtitle,
  });

  final FaIconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.lg.r),
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          border: Border.all(
            color: selected
                ? context.primary
                : context.onSurface.withValues(alpha: 0.1),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            FaIcon(icon, size: 24.r, color: context.primary),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.s14w500.copyWith(
                      color: context.onSurface,
                    ),
                  ),
                  if (subtitle != null) ...[
                    AppSpacing.xs.verticalSpace,
                    Text(
                      subtitle!,
                      style: AppTextStyles.s12w400.copyWith(
                        color: context.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            _RadioDot(selected: selected),
          ],
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.r,
      height: 20.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected
              ? context.primary
              : context.onSurface.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: selected
          ? Container(
              width: 10.r,
              height: 10.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.primary,
              ),
            )
          : null,
    );
  }
}
