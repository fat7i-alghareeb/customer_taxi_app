import 'order_stripe_payment_entity.dart';

class OrderTripStopCoordinate {
  const OrderTripStopCoordinate({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;
}

class OrderTripResponseEntity {
  const OrderTripResponseEntity({
    required this.id,
    required this.referenceCode,
    required this.passengerId,
    this.driverId,
    required this.vehicleTypeId,
    required this.status,
    required this.quotedFare,
    required this.currencyCode,
    required this.createdAtUtc,
    this.scheduledAtUtc,
    required this.stops,
    this.stripePayment,
    this.passengerNote,
  });

  final String id;
  final String referenceCode;
  final String passengerId;
  final String? driverId;
  final String vehicleTypeId;
  final String status;
  final double quotedFare;
  final String currencyCode;
  final DateTime createdAtUtc;
  final DateTime? scheduledAtUtc;
  final List<OrderTripStopCoordinate> stops;
  final OrderStripePaymentEntity? stripePayment;
  final String? passengerNote;
}
