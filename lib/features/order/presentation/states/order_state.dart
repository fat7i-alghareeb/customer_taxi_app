part of 'order_bloc.dart';

@freezed
abstract class OrderState with _$OrderState {
  const factory OrderState({
    @Default(OrderSheetSlice()) OrderSheetSlice sheet,
    @Default(OrderMapSlice()) OrderMapSlice map,
    @Default(OrderStopsSlice()) OrderStopsSlice stops,
    @Default(OrderTripSlice()) OrderTripSlice trip,
    @Default(OrderBookingSlice()) OrderBookingSlice booking,
  }) = _OrderState;
}
