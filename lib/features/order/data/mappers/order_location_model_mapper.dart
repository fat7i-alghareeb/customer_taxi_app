import '../../domain/entities/order_location_entity.dart';
import '../models/order_location_model.dart';

extension OrderLocationModelMapper on OrderLocationModel {
  OrderLocationEntity get toEntity {
    return OrderLocationEntity(
      latitude: latitude,
      longitude: longitude,
      label: label,
      primaryName: primaryName,
      secondaryAddress: secondaryAddress,
    );

  }
}
