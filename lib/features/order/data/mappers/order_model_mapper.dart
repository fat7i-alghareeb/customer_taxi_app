import '../../domain/entities/order_entity.dart';
import '../models/order_model.dart';

extension OrderModelMapper on OrderModel {
  OrderEntity get toEntity => OrderEntity(id: id);
}
