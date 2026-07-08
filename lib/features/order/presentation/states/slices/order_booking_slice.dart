import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:customertaxi/core/utils/bloc_status.dart';
import 'package:customertaxi/features/order/domain/entities/order_trip_response_entity.dart';

part 'order_booking_slice.freezed.dart';

enum OrderScheduleMode { now, later }

/// How the passenger chose to pay for this trip. The card portion (card / mixed)
/// always opens the Stripe sheet, which shows whatever methods Stripe has enabled.
enum OrderPaymentMethod {
  card,
  wallet,
  mixed;

  String get apiValue => switch (this) {
    OrderPaymentMethod.card => 'card',
    OrderPaymentMethod.wallet => 'wallet',
    OrderPaymentMethod.mixed => 'mixed',
  };
}

@freezed
abstract class OrderBookingSlice with _$OrderBookingSlice {
  const factory OrderBookingSlice({
    @Default(OrderScheduleMode.now) OrderScheduleMode scheduleMode,
    DateTime? scheduledAt,
    @Default('') String passengerNote,
    @Default('') String flightNumber,
    @Default(OrderPaymentMethod.card) OrderPaymentMethod paymentMethod,
    double? walletBalance,
    @Default('EUR') String walletCurrency,
    @Default(BlocStatus<OrderTripResponseEntity>.initial())
    BlocStatus<OrderTripResponseEntity> tripRequestStatus,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> paymentSheetState,
    // Stores the trip created by requestTrip so the same PaymentIntent can be
    // re-presented if the user dismisses the sheet without paying. Cleared on
    // success, full payment failure, or when the user abandons the booking.
    OrderTripResponseEntity? pendingTripResponse,
  }) = _OrderBookingSlice;
}
