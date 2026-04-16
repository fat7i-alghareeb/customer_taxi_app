import '../../domain/entities/order_trip_route_entity.dart';
import '../models/order_trip_route_model.dart';

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
    );
  }
}
