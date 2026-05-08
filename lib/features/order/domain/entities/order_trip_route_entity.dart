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

class OrderTripLegEntity {
  const OrderTripLegEntity({
    required this.distanceMeters,
    required this.durationSeconds,
    required this.encodedPolyline,
    required this.startLabel,
    required this.endLabel,
    required this.startLatitude,
    required this.startLongitude,
    required this.endLatitude,
    required this.endLongitude,
    required this.startAddress,
    required this.endAddress,
    required this.points,
  });

  final int distanceMeters;
  final int durationSeconds;
  final String encodedPolyline;
  final String startLabel;
  final String endLabel;
  final double startLatitude;
  final double startLongitude;
  final double endLatitude;
  final double endLongitude;
  final String startAddress;
  final String endAddress;
  final List<OrderTripRoutePointEntity> points;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OrderTripLegEntity &&
        other.distanceMeters == distanceMeters &&
        other.durationSeconds == durationSeconds &&
        other.encodedPolyline == encodedPolyline &&
        other.startLabel == startLabel &&
        other.endLabel == endLabel &&
        _listEquals(other.points, points);
  }

  @override
  int get hashCode => Object.hash(
        distanceMeters,
        durationSeconds,
        encodedPolyline,
        startLabel,
        endLabel,
        Object.hashAll(points),
      );

  bool _listEquals(
    List<OrderTripRoutePointEntity> first,
    List<OrderTripRoutePointEntity> second,
  ) {
    if (first.length != second.length) return false;
    for (var i = 0; i < first.length; i++) {
      if (first[i] != second[i]) return false;
    }
    return true;
  }
}

class OrderTripRouteEntity {
  const OrderTripRouteEntity({
    required this.points,
    required this.durationText,
    required this.distanceText,
    required this.distanceMeters,
    required this.legs,
  });

  final List<OrderTripRoutePointEntity> points;
  final String durationText;
  final String distanceText;
  final int distanceMeters;
  final List<OrderTripLegEntity> legs;

  OrderTripRouteEntity copyWith({
    List<OrderTripRoutePointEntity>? points,
    String? durationText,
    String? distanceText,
    int? distanceMeters,
    List<OrderTripLegEntity>? legs,
  }) {
    return OrderTripRouteEntity(
      points: points ?? this.points,
      durationText: durationText ?? this.durationText,
      distanceText: distanceText ?? this.distanceText,
      distanceMeters: distanceMeters ?? this.distanceMeters,
      legs: legs ?? this.legs,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OrderTripRouteEntity &&
        _listEquals(other.points, points) &&
        other.durationText == durationText &&
        other.distanceText == distanceText &&
        other.distanceMeters == distanceMeters &&
        _listEqualsLegs(other.legs, legs);
  }

  @override
  int get hashCode => Object.hash(
        Object.hashAll(points),
        durationText,
        distanceText,
        distanceMeters,
        Object.hashAll(legs),
      );

  bool _listEquals<T>(List<T> first, List<T> second) {
    if (first.length != second.length) return false;
    for (var i = 0; i < first.length; i++) {
      if (first[i] != second[i]) return false;
    }
    return true;
  }

  bool _listEqualsLegs(List<OrderTripLegEntity> first, List<OrderTripLegEntity> second) {
    return _listEquals(first, second);
  }
}
