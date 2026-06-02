import 'package:customertaxi/common/imports/imports.dart';

import '../../../../constants/order_constants.dart';
import '../../../../domain/entities/order_trip_car_option_entity.dart';
import '../../../states/order_bloc.dart';
import 'order_car_option_card_widget.dart';
import 'order_passenger_note_field_widget.dart';
import 'order_route_summary_timeline_widget.dart';
import '../../../../domain/entities/order_location_entity.dart';

class OrderVehicleSelectionStepWidget extends StatelessWidget {
  const OrderVehicleSelectionStepWidget({
    super.key,
    required this.state,
    required this.onCarTypeTapped,
  });

  final OrderState state;
  final ValueChanged<String> onCarTypeTapped;

  String _resolveLabel(OrderTripCarOptionEntity? option, String fallbackId) {
    if (option != null) return option.name;

    return state.trip.carOptionsState.maybeWhen(
      loading: () => '...',
      failure: (msg) => '!',
      orElse: () => '...',
    );
  }

  String _resolveImagePath(
    OrderTripCarOptionEntity? option,
    String fallbackId,
  ) {
    final code = option?.typeCode?.toLowerCase() ?? '';
    final name = option?.name.toLowerCase() ?? fallbackId.toLowerCase();

    // Standard / عادي / ستاندرد
    if (code.contains('standard') ||
        name.contains('standard') ||
        name.contains('عادي') ||
        name.contains('ستاندرد')) {
      return Assets.images.standered.path;
    }

    // Comfort / مريح / فخم / كومفورت
    if (code.contains('comfort') ||
        name.contains('comfort') ||
        name.contains('مريح') ||
        name.contains('فخم') ||
        name.contains('كومفورت')) {
      return Assets.images.comfort.path;
    }

    // Large Vehicles (XL, Van, Bus, Wheelchair) / كبير / فان / حافلة / ذوي الاحتياجات
    if (code.contains('xl') ||
        code.contains('van') ||
        code.contains('bus') ||
        code.contains('wheelchair') ||
        code.contains('8') ||
        name.contains('xl') ||
        name.contains('van') ||
        name.contains('bus') ||
        name.contains('كبير') ||
        name.contains('فان') ||
        name.contains('حافلة') ||
        name.contains('ذوي الاحتياجات') ||
        name.contains('كراسي')) {
      return Assets.images.a8Passengeres.path;
    }

    return Assets.images.standered.path;
  }

  List<String> get _fallbackTypeIds => const <String>[
    OrderConstants.carTypeStandard,
    OrderConstants.carTypeComfort,
    OrderConstants.carTypeBus8,
  ];

  @override
  Widget build(BuildContext context) {
    printM('[OrderVehicleSelectionStepWidget] build');

    final isPriceLoading = state.trip.carOptionsState.isLoading;

    final stops = state.stops.list.whereType<OrderLocationEntity>().toList();
    if (stops.length < 2) {
      return const SizedBox.shrink();
    }

    final durationText = state.trip.routeState.maybeWhen(
      success: (route) => route.durationText,
      orElse: () => '',
    );

    final discountPercent = state.trip.carOptionsState.maybeWhen(
      success: (opts) => opts.isNotEmpty ? opts.first.discountPercent : 0.0,
      orElse: () => 0.0,
    );

    final totalDistanceKm = state.trip.carOptionsState.maybeWhen(
      success: (opts) => opts.isNotEmpty ? opts.first.totalDistanceKm : 0.0,
      orElse: () => 0.0,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OrderRouteSummaryTimelineWidget(
          stops: stops,
          durationText: durationText,
          distanceKm: totalDistanceKm,
          onEditStop: (index) {
            context.read<OrderBloc>().add(
              OrderEvent.setOnMapPressed(index: index),
            );
          },
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
        if (discountPercent > 0) ...[
          AppSpacing.md.verticalSpace,
          AppDiscountBanner(
            discountPercent: discountPercent,
          ).animate().fadeIn(delay: 300.ms),
        ],
        AppSpacing.md.verticalSpace,
        ...state.trip.carOptionsState.maybeWhen(
          success: (options) => [
            for (var i = 0; i < options.length; i++) ...[
              if (i > 0) SizedBox(height: AppSpacing.sm.h),
              OrderCarOptionCardWidget(
                title: _resolveLabel(options[i], options[i].typeId),
                imagePath: _resolveImagePath(options[i], options[i].typeId),
                isSelected: state.trip.selectedCarTypeId == options[i].typeId,
                isPriceLoading: false,
                passengerCapacity: options[i].passengerCapacity,
                priceText:
                    '${options[i].currency} ${options[i].price.toStringAsFixed(2)}',
                originalPriceText: options[i].discountPercent > 0
                    ? '${options[i].currency} ${options[i].originalPrice.toStringAsFixed(2)}'
                    : null,
                onTap: () => onCarTypeTapped(options[i].typeId),
              ),
            ],
          ],
          orElse: () => [
            for (var i = 0; i < _fallbackTypeIds.length; i++) ...[
              if (i > 0) SizedBox(height: AppSpacing.sm.h),
              OrderCarOptionCardWidget(
                title: _resolveLabel(null, _fallbackTypeIds[i]),
                imagePath: _resolveImagePath(null, _fallbackTypeIds[i]),
                isSelected: state.trip.selectedCarTypeId == _fallbackTypeIds[i],
                isPriceLoading: isPriceLoading,
                passengerCapacity: 0,
                priceText: null,
                onTap: () => onCarTypeTapped(_fallbackTypeIds[i]),
              ),
            ],
          ],
        ),
        AppSpacing.xl.verticalSpace,
        OrderPassengerNoteFieldWidget(
          note: state.booking.passengerNote,
        ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.08),
      ],
    );
  }
}
