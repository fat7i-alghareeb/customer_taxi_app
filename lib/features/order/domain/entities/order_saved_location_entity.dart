import 'order_location_entity.dart';

class OrderSavedLocationEntity {
  const OrderSavedLocationEntity({
    required this.identityKey,
    required this.location,
    required this.isPinned,
    required this.touchedAtMillis,
  });

  final String identityKey;
  final OrderLocationEntity location;
  final bool isPinned;
  final int touchedAtMillis;

  OrderSavedLocationEntity copyWith({
    String? identityKey,
    OrderLocationEntity? location,
    bool? isPinned,
    int? touchedAtMillis,
  }) {
    return OrderSavedLocationEntity(
      identityKey: identityKey ?? this.identityKey,
      location: location ?? this.location,
      isPinned: isPinned ?? this.isPinned,
      touchedAtMillis: touchedAtMillis ?? this.touchedAtMillis,
    );
  }
}
