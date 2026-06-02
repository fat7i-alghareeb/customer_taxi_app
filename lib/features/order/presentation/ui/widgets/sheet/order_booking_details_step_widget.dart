import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/order/presentation/states/order_bloc.dart';

class OrderBookingDetailsStepWidget extends StatelessWidget {
  const OrderBookingDetailsStepWidget({super.key, required this.state});

  final OrderState state;

  @override
  Widget build(BuildContext context) {
    printM('[OrderBookingDetailsStepWidget] build');

    final isLoading =
        state.booking.tripRequestStatus.isLoading ||
        state.booking.paymentSheetState.isLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionHeader(title: AppStrings.paymentMethod),
        AppSpacing.md.verticalSpace,
        const _StripePaymentRow(),
        AppSpacing.xl.verticalSpace,
        AppButton.primary(
          onTap: () {
            context.read<OrderBloc>().add(
              const OrderEvent.confirmBookingDetailsPressed(),
            );
          },
          isActive: !isLoading,
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

class _StripePaymentRow extends StatelessWidget {
  const _StripePaymentRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          FaIcon(FontAwesomeIcons.stripe, size: 28.r, color: context.primary),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Text(
              AppStrings.payViaStripe,
              style: AppTextStyles.s14w500.copyWith(color: context.onSurface),
            ),
          ),
          FaIcon(
            FontAwesomeIcons.lock,
            size: 18.r,
            color: context.onSurface.withValues(alpha: 0.4),
          ),
        ],
      ),
    );
  }
}
