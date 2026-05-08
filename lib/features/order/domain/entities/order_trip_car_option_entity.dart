class OrderTripCarOptionEntity {
  const OrderTripCarOptionEntity({
    required this.quoteId,
    required this.typeId,
    this.typeCode,
    required this.name,
    required this.price,
    required this.currency,
    required this.validUntil,
  });

  final String quoteId;
  final String typeId;
  final String? typeCode;
  final String name;
  final double price;
  final String currency;
  final DateTime validUntil;

  OrderTripCarOptionEntity copyWith({
    String? quoteId,
    String? typeId,
    String? typeCode,
    String? name,
    double? price,
    String? currency,
    DateTime? validUntil,
  }) {
    return OrderTripCarOptionEntity(
      quoteId: quoteId ?? this.quoteId,
      typeId: typeId ?? this.typeId,
      typeCode: typeCode ?? this.typeCode,
      name: name ?? this.name,
      price: price ?? this.price,
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
