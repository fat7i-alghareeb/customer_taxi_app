import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:customertaxi/core/utils/bloc_status.dart';
import 'package:customertaxi/features/order/domain/entities/order_trip_response_entity.dart';

part 'order_booking_slice.freezed.dart';

enum OrderScheduleMode { now, later }

@freezed
abstract class OrderBookingSlice with _$OrderBookingSlice {
  const factory OrderBookingSlice({
    @Default(OrderScheduleMode.now) OrderScheduleMode scheduleMode,
    DateTime? scheduledAt,
    @Default('') String passengerNote,
    @Default(false) bool isAirport,
    @Default(BlocStatus<OrderTripResponseEntity>.initial())
    BlocStatus<OrderTripResponseEntity> tripRequestStatus,
    @Default(BlocStatus<void>.initial())
    BlocStatus<void> paymentSheetState,
    // Stores the trip created by requestTrip so the same PaymentIntent can be
    // re-presented if the user dismisses the sheet without paying. Cleared on
    // success, full payment failure, or when the user abandons the booking.
    OrderTripResponseEntity? pendingTripResponse,
  }) = _OrderBookingSlice;
}
