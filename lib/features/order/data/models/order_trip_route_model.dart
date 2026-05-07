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
    this.encodedPolyline,
  });

  final List<OrderTripRoutePointModel> points;
  final String durationText;
  final String distanceText;
  final int distanceMeters;
  final String? encodedPolyline;

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

  // Backend proxy: { totalDistanceMeters, totalDurationSeconds, encodedPolyline, legs:[...] }
  factory OrderTripRouteModel.fromBackend(
    Map<String, dynamic> json,
    List<OrderTripRoutePointModel> decodedPoints,
  ) {
    final meters = (json['totalDistanceMeters'] as num?)?.toInt() ?? 0;
    final seconds = (json['totalDurationSeconds'] as num?)?.toInt() ?? 0;
    return OrderTripRouteModel(
      points: decodedPoints,
      durationText: _formatDuration(seconds),
      distanceText: _formatDistance(meters),
      distanceMeters: meters,
      encodedPolyline: json['encodedPolyline'] as String?,
    );
  }

  static String _formatDuration(int seconds) {
    if (seconds <= 0) return '';
    final minutes = seconds ~/ 60;
    if (minutes < 60) return '$minutes min';
    final hours = minutes ~/ 60;
    final rem = minutes % 60;
    return rem > 0 ? '$hours h $rem min' : '$hours h';
  }

  static String _formatDistance(int meters) {
    if (meters <= 0) return '';
    if (meters < 1000) return '$meters m';
    final km = (meters / 1000).toStringAsFixed(1);
    return '$km km';
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
