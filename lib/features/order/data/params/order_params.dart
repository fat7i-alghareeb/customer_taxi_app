class OrderParams {
  const OrderParams();
}

class OrderSearchLocationParams {
  const OrderSearchLocationParams({required this.query});

  final String query;
}

class OrderReverseGeocodeParams {
  const OrderReverseGeocodeParams({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;
}

class OrderTripRouteParams {
  const OrderTripRouteParams({
    required this.fromLatitude,
    required this.fromLongitude,
    required this.toLatitude,
    required this.toLongitude,
  });

  final double fromLatitude;
  final double fromLongitude;
  final double toLatitude;
  final double toLongitude;
}

class OrderTripPricingParams {
  const OrderTripPricingParams({
    required this.fromLatitude,
    required this.fromLongitude,
    required this.toLatitude,
    required this.toLongitude,
  });

  final double fromLatitude;
  final double fromLongitude;
  final double toLatitude;
  final double toLongitude;
}
