import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_location_entity.freezed.dart';

@freezed
abstract class DriverLocationEntity with _$DriverLocationEntity {
  const factory DriverLocationEntity({
    required double latitude,
    required double longitude,
    double? bearing,
  }) = _DriverLocationEntity;
}
