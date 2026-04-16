class OrderTripRoutePointEntity {
  const OrderTripRoutePointEntity({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  OrderTripRoutePointEntity copyWith({double? latitude, double? longitude}) {
    return OrderTripRoutePointEntity(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OrderTripRoutePointEntity &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode => Object.hash(latitude, longitude);
}

class OrderTripRouteEntity {
  const OrderTripRouteEntity({
    required this.points,
    required this.durationText,
    required this.distanceText,
    required this.distanceMeters,
  });

  final List<OrderTripRoutePointEntity> points;
  final String durationText;
  final String distanceText;
  final int distanceMeters;

  OrderTripRouteEntity copyWith({
    List<OrderTripRoutePointEntity>? points,
    String? durationText,
    String? distanceText,
    int? distanceMeters,
  }) {
    return OrderTripRouteEntity(
      points: points ?? this.points,
      durationText: durationText ?? this.durationText,
      distanceText: distanceText ?? this.distanceText,
      distanceMeters: distanceMeters ?? this.distanceMeters,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OrderTripRouteEntity &&
        _listEquals(other.points, points) &&
        other.durationText == durationText &&
        other.distanceText == distanceText &&
        other.distanceMeters == distanceMeters;
  }

  @override
  int get hashCode => Object.hash(
    Object.hashAll(points),
    durationText,
    distanceText,
    distanceMeters,
  );

  bool _listEquals(
    List<OrderTripRoutePointEntity> first,
    List<OrderTripRoutePointEntity> second,
  ) {
    if (first.length != second.length) {
      return false;
    }

    for (var i = 0; i < first.length; i++) {
      if (first[i] != second[i]) {
        return false;
      }
    }

    return true;
  }
}
