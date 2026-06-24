import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_location_entity.freezed.dart';

@freezed
abstract class DriverLocationEntity with _$DriverLocationEntity {
  const factory DriverLocationEntity({
    required double latitude,
    required double longitude,
    double? bearing,
    // Live driver-arrival estimate to the pickup (only while heading there).
    int? etaToPickupSeconds,
    int? distanceToPickupMeters,
    // Encoded road-following route from the driver to the pickup.
    String? routeToPickupPolyline,
  }) = _DriverLocationEntity;
}
