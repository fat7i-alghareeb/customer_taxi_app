import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/order/presentation/states/order_bloc.dart';

class OrderBookingDetailsStepWidget extends StatelessWidget {
  const OrderBookingDetailsStepWidget({super.key, required this.state});

  final OrderState state;

  @override
  Widget build(BuildContext context) {
    printM('[OrderBookingDetailsStepWidget] build');
    

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionHeader(title: AppStrings.paymentMethod),
        AppSpacing.md.verticalSpace,
        _PaymentMethodSelector(
          selectedMethodId: state.paymentMethodId,
          onMethodSelected: (id) {
            context.read<OrderBloc>().add(OrderEvent.paymentMethodChanged(id));
          },
        ),
        AppSpacing.xl.verticalSpace,
        AppButton.primary(
          onTap: () {
            context.read<OrderBloc>().add(
                  const OrderEvent.confirmBookingDetailsPressed(),
                );
          },
          isActive: state.paymentMethodId != null &&
              !state.tripRequestStatus.isLoading,
          isLoading: state.tripRequestStatus.isLoading,
          layout: AppButtonLayout(
            width: double.infinity,
            height: 56.h,
            borderRadius: AppRadii.lg,
          ),
          child: AppButtonChild.label(AppStrings.confirmBooking),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    printM('[_SectionHeader] build title=$title');
    return Text(
      title,
      style: AppTextStyles.s16w600.copyWith(
        color: context.onSurface,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class _PaymentMethodSelector extends StatelessWidget {
  const _PaymentMethodSelector({
    this.selectedMethodId,
    required this.onMethodSelected,
  });

  final String? selectedMethodId;
  final ValueChanged<String> onMethodSelected;

  @override
  Widget build(BuildContext context) {
    printM('[_PaymentMethodSelector] build selectedMethodId=$selectedMethodId');
    final methods = [
      _PaymentMethod(
        id: 'visa',
        icon: FontAwesomeIcons.ccVisa,
        label: 'Visa',
        color: const Color(0xFF1A1F71),
      ),
      _PaymentMethod(
        id: 'mastercard',
        icon: FontAwesomeIcons.ccMastercard,
        label: 'Mastercard',
        color: const Color(0xFFEB001B),
      ),
      _PaymentMethod(
        id: 'apple_pay',
        icon: FontAwesomeIcons.applePay,
        label: 'Apple Pay',
        color: Colors.black,
      ),
      _PaymentMethod(
        id: 'google_pay',
        icon: FontAwesomeIcons.googlePay,
        label: 'Google Pay',
        color: const Color(0xFF4285F4),
      ),
      _PaymentMethod(
        id: 'paypal',
        icon: FontAwesomeIcons.paypal,
        label: 'PayPal',
        color: const Color(0xFF003087),
      ),
    ];

    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: REdgeInsets.symmetric(vertical: AppSpacing.xs),
        itemCount: methods.length,
        separatorBuilder: (context, index) => AppSpacing.md.horizontalSpace,
        itemBuilder: (context, index) {
          final method = methods[index];
          final isSelected = selectedMethodId == method.id;

          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onMethodSelected(method.id),
              borderRadius: BorderRadius.circular(AppRadii.lg.r),
              child: AnimatedContainer(
                duration: AppDurations.normal,
                width: 110.w,
                padding: REdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: isSelected
                      ? context.primary.withValues(alpha: 0.08)
                      : context.surface,
                  borderRadius: BorderRadius.circular(AppRadii.lg.r),
                  boxShadow: isSelected ? context.shadows.primary : null,
                  border: Border.all(
                    color: isSelected
                        ? context.primary
                        : context.onSurface.withValues(alpha: 0.1),
                    width: isSelected ? 2.5.r : 1.r,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      method.icon,
                      size: 32.r,
                      color: isSelected ? context.primary : method.color,
                    ),
                    AppSpacing.sm.verticalSpace,
                    Text(
                      method.label,
                      style: AppTextStyles.s12w700.copyWith(
                        color: isSelected ? context.primary : context.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PaymentMethod {
  final String id;
  final IconData icon;
  final String label;
  final Color color;

  _PaymentMethod({
    required this.id,
    required this.icon,
    required this.label,
    required this.color,
  });
}
