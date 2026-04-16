class OrderTripCarOptionEntity {
  const OrderTripCarOptionEntity({
    required this.typeId,
    required this.name,
    required this.price,
    required this.currency,
  });

  final String typeId;
  final String name;
  final double price;
  final String currency;

  OrderTripCarOptionEntity copyWith({
    String? typeId,
    String? name,
    double? price,
    String? currency,
  }) {
    return OrderTripCarOptionEntity(
      typeId: typeId ?? this.typeId,
      name: name ?? this.name,
      price: price ?? this.price,
      currency: currency ?? this.currency,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OrderTripCarOptionEntity &&
        other.typeId == typeId &&
        other.name == name &&
        other.price == price &&
        other.currency == currency;
  }

  @override
  int get hashCode => Object.hash(typeId, name, price, currency);
}
