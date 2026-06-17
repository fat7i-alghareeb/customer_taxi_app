import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/order/presentation/states/order_bloc.dart';

/// Lets the rider flag the booking as an airport trip, which applies the
/// airport waiting policy (30 minutes of free waiting after arrival).
class OrderAirportToggleWidget extends StatelessWidget {
  const OrderAirportToggleWidget({super.key, required this.isAirport});

  final bool isAirport;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadii.md.r),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          FaIcon(FontAwesomeIcons.plane, size: 16.r, color: colors.primary),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.orderAirportTitle,
                  style: AppTextStyles.s14w600.copyWith(color: colors.onSurface),
                ),
                Text(
                  AppStrings.orderAirportSubtitle,
                  style: AppTextStyles.s12w400.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isAirport,
            onChanged: (value) => context.read<OrderBloc>().add(
              OrderEvent.airportToggled(value),
            ),
          ),
        ],
      ),
    );
  }
}
