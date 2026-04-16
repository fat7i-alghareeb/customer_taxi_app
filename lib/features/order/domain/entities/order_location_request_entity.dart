class OrderLocationSearchRequestEntity {
  const OrderLocationSearchRequestEntity({required this.query});

  final String query;
}

class OrderReverseGeocodeRequestEntity {
  const OrderReverseGeocodeRequestEntity({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;
}

class OrderTripRouteRequestEntity {
  const OrderTripRouteRequestEntity({
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

class OrderTripPricingRequestEntity {
  const OrderTripPricingRequestEntity({
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
