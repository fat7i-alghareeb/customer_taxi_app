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
