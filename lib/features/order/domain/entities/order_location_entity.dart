class OrderLocationEntity {
  const OrderLocationEntity({
    required this.latitude,
    required this.longitude,
    required this.label,
  });

  final double latitude;
  final double longitude;
  final String label;

  OrderLocationEntity copyWith({
    double? latitude,
    double? longitude,
    String? label,
  }) {
    return OrderLocationEntity(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      label: label ?? this.label,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OrderLocationEntity &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.label == label;
  }

  @override
  int get hashCode => Object.hash(latitude, longitude, label);
}
