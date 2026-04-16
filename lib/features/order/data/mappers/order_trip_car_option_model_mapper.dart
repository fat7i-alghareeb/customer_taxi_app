import '../../domain/entities/order_trip_car_option_entity.dart';
import '../models/order_trip_car_option_model.dart';

extension OrderTripCarOptionModelMapper on OrderTripCarOptionModel {
  OrderTripCarOptionEntity get toEntity {
    return OrderTripCarOptionEntity(
      typeId: typeId,
      name: name,
      price: price,
      currency: currency,
    );
  }
}
