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
