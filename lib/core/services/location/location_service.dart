import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/constants/app_flow_constants.dart';
import '../../../utils/helpers/colored_print.dart';

/// Wraps geolocator APIs behind a small service surface.
@lazySingleton
class LocationService {
  const LocationService();

  Future<bool> isLocationServiceEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  Future<Position?> getLastKnownPosition() {
    return Geolocator.getLastKnownPosition();
  }

  /// Coordinates a place search must be biased towards.
  ///
  /// The backend rejects a coordinate-less search (400, "Search location
  /// (coordinates) is required."), so this never returns null: device position
  /// first, then the caller's own hint (map camera, saved address), then the
  /// app default.
  Future<({double lat, double lng})> resolveSearchBias({
    double? fallbackLat,
    double? fallbackLng,
  }) async {
    try {
      final lastKnown = await getLastKnownPosition();
      if (lastKnown != null) {
        return (lat: lastKnown.latitude, lng: lastKnown.longitude);
      }
    } catch (error) {
      printY('[Location] resolveSearchBias failed: $error');
    }

    if (fallbackLat != null && fallbackLng != null) {
      return (lat: fallbackLat, lng: fallbackLng);
    }

    return (lat: MapConfig.defaultLat, lng: MapConfig.defaultLng);
  }

  Future<Position> getCurrentPosition({
    LocationAccuracy accuracy = LocationAccuracy.high,
  }) async {
    try {
      return await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: accuracy),
      );
    } catch (e) {
      printY('[Location] getCurrentPosition failed: $e');
      rethrow;
    }
  }

  Stream<Position> getPositionStream({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 0,
  }) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
      ),
    );
  }
}
