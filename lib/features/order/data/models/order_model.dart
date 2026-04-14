class OrderModel {
  const OrderModel({required this.id});

  final String id;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(id: json["id"]);
  }
}
