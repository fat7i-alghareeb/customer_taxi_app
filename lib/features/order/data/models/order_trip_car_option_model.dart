class OrderTripCarOptionModel {
  const OrderTripCarOptionModel({
    required this.typeId,
    required this.name,
    required this.price,
    required this.currency,
  });

  final String typeId;
  final String name;
  final double price;
  final String currency;

  factory OrderTripCarOptionModel.fromJson(Map<String, dynamic> json) {
    return OrderTripCarOptionModel(
      typeId: json['typeId']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      currency: json['currency']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'typeId': typeId,
      'name': name,
      'price': price,
      'currency': currency,
    };
  }
}
