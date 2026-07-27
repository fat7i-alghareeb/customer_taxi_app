class OrderLocationSearchRequestEntity {
  const OrderLocationSearchRequestEntity({
    required this.query,
    required this.biasLat,
    required this.biasLng,
  });

  final String query;

  /// Required: the backend rejects a search without a bias point (400,
  /// "Search location (coordinates) is required."). Callers resolve these
  /// through `LocationService.resolveSearchBias`, which never returns null.
  final double biasLat;
  final double biasLng;
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
    this.isAirport = false,
  });

  final double latitude;
  final double longitude;
  final String? label;
  final bool isAirport;
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
    this.passengerNote,
    this.flightNumber,
    this.paymentMethod = 'card',
  });

  final String quoteId;
  final List<OrderStopCoordinateEntity> stops;
  final DateTime? scheduledAt;
  final String? passengerNote;
  final String? flightNumber;

  /// "card" (Stripe sheet), "wallet" (balance only), or "mixed" (balance + card).
  final String paymentMethod;
}
