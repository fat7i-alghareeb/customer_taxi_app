import '../../domain/entities/order_trip_response_entity.dart';
import '../mappers/order_stripe_payment_model_mapper.dart';
import '../models/order_trip_response_model.dart';

extension OrderTripResponseModelMapper on OrderTripResponseModel {
  OrderTripResponseEntity get toEntity {
    return OrderTripResponseEntity(
      id: id,
      referenceCode: referenceCode,
      passengerId: passengerId,
      driverId: driverId,
      vehicleTypeId: vehicleTypeId,
      status: status,
      quotedFare: quotedFare,
      currencyCode: currencyCode,
      createdAtUtc: createdAtUtc,
      scheduledAtUtc: scheduledAtUtc,
      stops: stops
          .map(
            (s) => OrderTripStopCoordinate(
              latitude: s.latitude,
              longitude: s.longitude,
            ),
          )
          .toList(),
      stripePayment: stripePayment?.toEntity,
    );
  }
}
