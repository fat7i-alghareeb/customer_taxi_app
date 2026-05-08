import 'package:customertaxi/common/imports/imports.dart';

import '../../../../constants/order_constants.dart';
import '../../../../domain/entities/order_trip_car_option_entity.dart';
import '../../../states/order_bloc.dart';
import 'order_car_option_card_widget.dart';
import 'order_route_summary_timeline_widget.dart';

class OrderVehicleSelectionStepWidget extends StatelessWidget {
  const OrderVehicleSelectionStepWidget({
    super.key,
    required this.state,
    required this.onCarTypeTapped,
  });

  final OrderState state;
  final ValueChanged<String> onCarTypeTapped;

  String _resolveLabel(String typeId) {
    switch (typeId) {
      case OrderConstants.carTypeStandard:
        return AppStrings.carTypeStandard;
      case OrderConstants.carTypeComfort:
        return AppStrings.carTypeComfort;
      case OrderConstants.carTypeBus8:
        return AppStrings.carTypeBus8;
      default:
        return typeId;
    }
  }

  String _resolveImagePath(String typeId) {
    switch (typeId) {
      case OrderConstants.carTypeStandard:
        return Assets.images.standered.path;
      case OrderConstants.carTypeComfort:
        return Assets.images.comfort.path;
      case OrderConstants.carTypeBus8:
        return Assets.images.a8Passengeres.path;
      default:
        return Assets.images.standered.path;
    }
  }

  List<String> get _orderedTypeIds => const <String>[
    OrderConstants.carTypeStandard,
    OrderConstants.carTypeComfort,
    OrderConstants.carTypeBus8,
  ];

  Map<String, OrderTripCarOptionEntity> _mapByTypeId(
    List<OrderTripCarOptionEntity> options,
  ) {
    final result = <String, OrderTripCarOptionEntity>{};

    for (final option in options) {
      result[option.typeId] = option;
    }

    return result;
  }


  @override
  Widget build(BuildContext context) {
    printM('[OrderVehicleSelectionStepWidget] build');
    final pricingMap = state.tripCarOptionsState.maybeWhen(
      success: _mapByTypeId,
      orElse: () => <String, OrderTripCarOptionEntity>{},
    );

    final isPriceLoading = state.tripCarOptionsState.isLoading;

    final fromLocation = state.stops.isNotEmpty ? state.stops.first : null;
    final toLocation = state.stops.isNotEmpty ? state.stops.last : null;

    if (fromLocation == null || toLocation == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OrderRouteSummaryTimelineWidget(
          fromLocation: fromLocation,
          toLocation: toLocation,
        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),

        AppSpacing.lg.verticalSpace,
        Row(
          children: [
            Container(
              width: 4.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: context.primary,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            AppSpacing.sm.horizontalSpace,
            Text(
              AppStrings.selectCarType,
              style: AppTextStyles.s16w600.copyWith(
                color: context.primary,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ).animate().fadeIn(delay: 300.ms),
        AppSpacing.md.verticalSpace,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: REdgeInsets.only(bottom: AppSpacing.xs),
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              for (var index = 0; index < _orderedTypeIds.length; index++) ...[
                if (index > 0) AppSpacing.md.horizontalSpace,
                Builder(
                  builder: (context) {
                    final typeId = _orderedTypeIds[index];
                    final option = pricingMap[typeId];
                    final priceText = option == null
                        ? null
                        : '${option.currency} ${option.price.toStringAsFixed(2)}';

                    return OrderCarOptionCardWidget(
                      title: _resolveLabel(typeId),
                      imagePath: _resolveImagePath(typeId),
                      isSelected: state.selectedCarTypeId == typeId,
                      isPriceLoading: isPriceLoading,
                      priceText: priceText,
                      onTap: () => onCarTypeTapped(typeId),
                    );
                  },
                ),
              ],
            ],
          ),
        ).animate().fadeIn(delay: 400.ms).moveY(begin: 16, end: 0),
      ],
    );
  }
}
