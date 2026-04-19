class OrderLocationEntity {
  const OrderLocationEntity({
    required this.latitude,
    required this.longitude,
    required this.label,
    this.primaryName,
    this.secondaryAddress,
  });

  final double latitude;
  final double longitude;
  final String label;
  final String? primaryName;
  final String? secondaryAddress;


  OrderLocationEntity copyWith({
    double? latitude,
    double? longitude,
    String? label,
    String? primaryName,
    String? secondaryAddress,
  }) {
    return OrderLocationEntity(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      label: label ?? this.label,
      primaryName: primaryName ?? this.primaryName,
      secondaryAddress: secondaryAddress ?? this.secondaryAddress,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OrderLocationEntity &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.label == label &&
        other.primaryName == primaryName &&
        other.secondaryAddress == secondaryAddress;
  }

  @override
  int get hashCode =>
      Object.hash(latitude, longitude, label, primaryName, secondaryAddress);

}
