import '../../domain/entities/order_trip_route_entity.dart';
import '../models/order_trip_route_model.dart';

extension OrderTripLegModelMapper on OrderTripLegModel {
  OrderTripLegEntity get toEntity {
    return OrderTripLegEntity(
      distanceMeters: distanceMeters,
      durationSeconds: durationSeconds,
      encodedPolyline: encodedPolyline,
      startLabel: startLabel,
      endLabel: endLabel,
      startLatitude: startLatitude,
      startLongitude: startLongitude,
      endLatitude: endLatitude,
      endLongitude: endLongitude,
      startAddress: startAddress,
      endAddress: endAddress,
      points: points
          .map(
            (p) => OrderTripRoutePointEntity(
              latitude: p.latitude,
              longitude: p.longitude,
            ),
          )
          .toList(),
    );
  }
}

extension OrderTripRouteModelMapper on OrderTripRouteModel {
  OrderTripRouteEntity get toEntity {
    return OrderTripRouteEntity(
      points: points
          .map(
            (point) => OrderTripRoutePointEntity(
              latitude: point.latitude,
              longitude: point.longitude,
            ),
          )
          .toList(),
      durationText: durationText,
      distanceText: distanceText,
      distanceMeters: distanceMeters,
      legs: legs.map((leg) => leg.toEntity).toList(),
    );
  }
}
