class OrderTripRoutePointModel {
  const OrderTripRoutePointModel({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  factory OrderTripRoutePointModel.fromJson(Map<String, dynamic> json) {
    return OrderTripRoutePointModel(
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude};
  }
}

class OrderTripRouteModel {
  const OrderTripRouteModel({
    required this.points,
    required this.durationText,
    required this.distanceText,
    required this.distanceMeters,
  });

  final List<OrderTripRoutePointModel> points;
  final String durationText;
  final String distanceText;
  final int distanceMeters;

  factory OrderTripRouteModel.fromJson(Map<String, dynamic> json) {
    final pointsJson = json['points'] as List<dynamic>? ?? const [];

    return OrderTripRouteModel(
      points: pointsJson
          .whereType<Map<String, dynamic>>()
          .map(OrderTripRoutePointModel.fromJson)
          .toList(),
      durationText: json['durationText']?.toString() ?? '',
      distanceText: json['distanceText']?.toString() ?? '',
      distanceMeters: (json['distanceMeters'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'points': points.map((point) => point.toJson()).toList(),
      'durationText': durationText,
      'distanceText': distanceText,
      'distanceMeters': distanceMeters,
    };
  }
}
