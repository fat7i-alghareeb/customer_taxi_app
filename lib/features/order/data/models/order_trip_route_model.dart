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

class OrderTripLegModel {
  const OrderTripLegModel({
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
    this.points = const [],
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
  final List<OrderTripRoutePointModel> points;

  factory OrderTripLegModel.fromJson(Map<String, dynamic> json) {
    final pointsJson = json['points'] as List<dynamic>? ?? const [];
    return OrderTripLegModel(
      distanceMeters: (json['distanceMeters'] as num?)?.toInt() ?? 0,
      durationSeconds: (json['durationSeconds'] as num?)?.toInt() ?? 0,
      encodedPolyline: json['encodedPolyline'] as String? ?? '',
      startLabel: json['startLabel'] as String? ?? '',
      endLabel: json['endLabel'] as String? ?? '',
      startLatitude: (json['startLatitude'] as num?)?.toDouble() ?? 0.0,
      startLongitude: (json['startLongitude'] as num?)?.toDouble() ?? 0.0,
      endLatitude: (json['endLatitude'] as num?)?.toDouble() ?? 0.0,
      endLongitude: (json['endLongitude'] as num?)?.toDouble() ?? 0.0,
      startAddress: json['startAddress'] as String? ?? '',
      endAddress: json['endAddress'] as String? ?? '',
      points: pointsJson
          .whereType<Map<String, dynamic>>()
          .map(OrderTripRoutePointModel.fromJson)
          .toList(),
    );
  }

  OrderTripLegModel copyWith({List<OrderTripRoutePointModel>? points}) {
    return OrderTripLegModel(
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
      points: points ?? this.points,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distanceMeters': distanceMeters,
      'durationSeconds': durationSeconds,
      'encodedPolyline': encodedPolyline,
      'startLabel': startLabel,
      'endLabel': endLabel,
      'startLatitude': startLatitude,
      'startLongitude': startLongitude,
      'endLatitude': endLatitude,
      'endLongitude': endLongitude,
      'startAddress': startAddress,
      'endAddress': endAddress,
      'points': points.map((e) => e.toJson()).toList(),
    };
  }
}

class OrderTripRouteModel {
  const OrderTripRouteModel({
    required this.points,
    required this.durationText,
    required this.distanceText,
    required this.distanceMeters,
    required this.legs,
    this.encodedPolyline,
  });

  final List<OrderTripRoutePointModel> points;
  final String durationText;
  final String distanceText;
  final int distanceMeters;
  final List<OrderTripLegModel> legs;
  final String? encodedPolyline;

  factory OrderTripRouteModel.fromJson(Map<String, dynamic> json) {
    final pointsJson = json['points'] as List<dynamic>? ?? const [];
    final legsJson = json['legs'] as List<dynamic>? ?? const [];

    return OrderTripRouteModel(
      points: pointsJson
          .whereType<Map<String, dynamic>>()
          .map(OrderTripRoutePointModel.fromJson)
          .toList(),
      durationText: json['durationText']?.toString() ?? '',
      distanceText: json['distanceText']?.toString() ?? '',
      distanceMeters: (json['distanceMeters'] as num?)?.toInt() ?? 0,
      legs: legsJson
          .whereType<Map<String, dynamic>>()
          .map(OrderTripLegModel.fromJson)
          .toList(),
    );
  }

  // Backend proxy: { totalDistanceMeters, totalDurationSeconds, encodedPolyline, legs:[...] }
  factory OrderTripRouteModel.fromBackend(
    Map<String, dynamic> json,
    List<OrderTripRoutePointModel> decodedPoints,
    List<List<OrderTripRoutePointModel>> legPoints,
  ) {
    final meters = (json['totalDistanceMeters'] as num?)?.toInt() ?? 0;
    final seconds = (json['totalDurationSeconds'] as num?)?.toInt() ?? 0;
    final legsJson = json['legs'] as List<dynamic>? ?? const [];

    final List<OrderTripLegModel> legs = [];
    for (int i = 0; i < legsJson.length; i++) {
      final legModel = OrderTripLegModel.fromJson(
        legsJson[i] as Map<String, dynamic>,
      );
      final pointsForLeg = i < legPoints.length
          ? legPoints[i]
          : const <OrderTripRoutePointModel>[];
      legs.add(legModel.copyWith(points: pointsForLeg));
    }

    return OrderTripRouteModel(
      points: decodedPoints,
      durationText: _formatDuration(seconds),
      distanceText: _formatDistance(meters),
      distanceMeters: meters,
      encodedPolyline: json['encodedPolyline'] as String?,
      legs: legs,
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
      'legs': legs.map((leg) => leg.toJson()).toList(),
    };
  }
}
