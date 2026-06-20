import '../../domain/entities/order_location_entity.dart';
import '../../domain/entities/order_saved_location_entity.dart';
import '../models/order_saved_location_cache_model.dart';

extension OrderSavedLocationCacheModelMapper on OrderSavedLocationCacheModel {
  OrderSavedLocationEntity get toEntity {
    return OrderSavedLocationEntity(
      identityKey: identityKey,
      location: OrderLocationEntity(
        latitude: latitude,
        longitude: longitude,
        label: label,
        primaryName: primaryName,
        secondaryAddress: secondaryAddress,
        isAirport: isAirport,
      ),
      isPinned: isPinned,
      touchedAtMillis: touchedAtMillis,
    );
  }
}

extension OrderSavedLocationEntityMapper on OrderSavedLocationEntity {
  OrderSavedLocationCacheModel get toCacheModel {
    return OrderSavedLocationCacheModel(
      identityKey: identityKey,
      latitude: location.latitude,
      longitude: location.longitude,
      label: location.label,
      primaryName: location.primaryName,
      secondaryAddress: location.secondaryAddress,
      isAirport: location.isAirport,
      isPinned: isPinned,
      touchedAtMillis: touchedAtMillis,
    );
  }
}
