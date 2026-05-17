import 'package:freezed_annotation/freezed_annotation.dart';

import 'order_stripe_payment_model.dart';
import 'order_trip_stop_model.dart';

part 'order_trip_response_model.freezed.dart';
part 'order_trip_response_model.g.dart';

@freezed
abstract class OrderTripResponseModel with _$OrderTripResponseModel {
  const OrderTripResponseModel._();

  const factory OrderTripResponseModel({
    required String id,
    required String referenceCode,
    required String passengerId,
    String? driverId,
    required String vehicleTypeId,
    required String status,
    required double quotedFare,
    required String currencyCode,
    required DateTime createdAtUtc,
    DateTime? scheduledAtUtc,
    required List<OrderTripStopModel> stops,
    OrderStripePaymentModel? stripePayment,
  }) = _OrderTripResponseModel;

  factory OrderTripResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OrderTripResponseModelFromJson(json);
}
