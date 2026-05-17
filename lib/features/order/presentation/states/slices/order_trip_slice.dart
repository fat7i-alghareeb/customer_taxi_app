import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:customertaxi/core/utils/bloc_status.dart';
import 'package:customertaxi/features/order/domain/entities/order_location_entity.dart';
import 'package:customertaxi/features/order/domain/entities/order_trip_car_option_entity.dart';
import 'package:customertaxi/features/order/domain/entities/order_trip_route_entity.dart';

part 'order_trip_slice.freezed.dart';

@freezed
abstract class OrderTripSlice with _$OrderTripSlice {
  const factory OrderTripSlice({
    @Default(BlocStatus<OrderTripRouteEntity>.initial())
    BlocStatus<OrderTripRouteEntity> routeState,
    @Default(BlocStatus<List<OrderTripCarOptionEntity>>.initial())
    BlocStatus<List<OrderTripCarOptionEntity>> carOptionsState,
    @Default(BlocStatus<OrderTripRouteEntity>.initial())
    BlocStatus<OrderTripRouteEntity> prefetchedRouteState,
    @Default(BlocStatus<List<OrderTripCarOptionEntity>>.initial())
    BlocStatus<List<OrderTripCarOptionEntity>> prefetchedCarOptionsState,
    @Default([]) List<OrderLocationEntity> prefetchedStops,
    String? selectedCarTypeId,
    String? selectedQuoteId,
  }) = _OrderTripSlice;
}
