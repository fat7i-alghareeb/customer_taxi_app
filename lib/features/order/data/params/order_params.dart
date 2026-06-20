class OrderParams {
  const OrderParams();
}

class OrderSearchLocationParams {
  const OrderSearchLocationParams({
    required this.query,
    this.biasLat,
    this.biasLng,
  });

  final String query;
  final double? biasLat;
  final double? biasLng;

  Map<String, dynamic> toJson() => {
    'query': query,
    if (biasLat != null) 'latitude': biasLat,
    if (biasLng != null) 'longitude': biasLng,
  };
}

class OrderReverseGeocodeParams {
  const OrderReverseGeocodeParams({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
  };
}

class OrderCoordinateParam {
  const OrderCoordinateParam({
    required this.latitude,
    required this.longitude,
    this.label,
    this.isAirport = false,
  });

  final double latitude;
  final double longitude;
  final String? label;
  final bool isAirport;

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
    if (label != null) 'label': label,
    'isAirport': isAirport,
  };
}

class OrderTripRouteParams {
  const OrderTripRouteParams({required this.stops});

  final List<OrderCoordinateParam> stops;

  Map<String, dynamic> toJson() => {
    'stops': stops.map((s) => s.toJson()).toList(),
  };
}

class OrderPricingQuotesParams {
  const OrderPricingQuotesParams({required this.stops});

  final List<OrderCoordinateParam> stops;

  Map<String, dynamic> toJson() => {
    'stops': stops.map((s) => s.toJson()).toList(),
  };
}

class OrderRequestTripParams {
  const OrderRequestTripParams({
    required this.quoteId,
    required this.stops,
    this.scheduledAt,
    this.passengerNote,
    this.flightNumber,
  });

  final String quoteId;
  final List<OrderCoordinateParam> stops;
  final DateTime? scheduledAt;
  final String? passengerNote;
  final String? flightNumber;

  Map<String, dynamic> toJson() => {
    'quoteId': quoteId,
    'stops': stops.map((s) => s.toJson()).toList(),
    if (scheduledAt != null)
      'scheduledAt': scheduledAt!.toUtc().toIso8601String(),
    if (passengerNote?.trim().isNotEmpty == true)
      'passengerNote': passengerNote!.trim(),
    if (flightNumber?.trim().isNotEmpty == true)
      'flightNumber': flightNumber!.trim(),
  };
}
