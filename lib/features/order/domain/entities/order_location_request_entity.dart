class OrderLocationSearchRequestEntity {
  const OrderLocationSearchRequestEntity({required this.query, this.biasLat, this.biasLng});

  final String query;
  final double? biasLat;
  final double? biasLng;
}

class OrderReverseGeocodeRequestEntity {
  const OrderReverseGeocodeRequestEntity({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;
}

class OrderStopCoordinateEntity {
  const OrderStopCoordinateEntity({
    required this.latitude,
    required this.longitude,
    this.label,
  });

  final double latitude;
  final double longitude;
  final String? label;
}

class OrderTripRouteRequestEntity {
  const OrderTripRouteRequestEntity({required this.stops});

  final List<OrderStopCoordinateEntity> stops;
}

class OrderPricingQuotesRequestEntity {
  const OrderPricingQuotesRequestEntity({required this.stops});

  final List<OrderStopCoordinateEntity> stops;
}

class OrderRequestTripEntity {
  const OrderRequestTripEntity({
    required this.quoteId,
    required this.stops,
    this.scheduledAt,
    required this.pickupLatitude,
    required this.pickupLongitude,
    this.pickupAddress,
    this.pickupStreetName,
    this.pickupHouseNumber,
  });

  final String quoteId;
  final List<OrderStopCoordinateEntity> stops;
  final DateTime? scheduledAt;
  final double pickupLatitude;
  final double pickupLongitude;
  final String? pickupAddress;
  final String? pickupStreetName;
  final String? pickupHouseNumber;
}
