class OrderTripCarOptionEntity {
  const OrderTripCarOptionEntity({
    required this.quoteId,
    required this.typeId,
    this.typeCode,
    required this.name,
    required this.passengerCapacity,
    required this.originalPrice,
    required this.price,
    required this.discountPercent,
    required this.currency,
    required this.validUntil,
  });

  final String quoteId;
  final String typeId;
  final String? typeCode;
  final String name;
  final int passengerCapacity;
  final double originalPrice;
  final double price;
  final double discountPercent;
  final String currency;
  final DateTime validUntil;

  OrderTripCarOptionEntity copyWith({
    String? quoteId,
    String? typeId,
    String? typeCode,
    String? name,
    int? passengerCapacity,
    double? originalPrice,
    double? price,
    double? discountPercent,
    String? currency,
    DateTime? validUntil,
  }) {
    return OrderTripCarOptionEntity(
      quoteId: quoteId ?? this.quoteId,
      typeId: typeId ?? this.typeId,
      typeCode: typeCode ?? this.typeCode,
      name: name ?? this.name,
      passengerCapacity: passengerCapacity ?? this.passengerCapacity,
      originalPrice: originalPrice ?? this.originalPrice,
      price: price ?? this.price,
      discountPercent: discountPercent ?? this.discountPercent,
      currency: currency ?? this.currency,
      validUntil: validUntil ?? this.validUntil,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OrderTripCarOptionEntity && other.quoteId == quoteId;
  }

  @override
  int get hashCode => quoteId.hashCode;
}
