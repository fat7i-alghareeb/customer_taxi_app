import 'package:customertaxi/features/order/domain/entities/order_location_entity.dart';
import 'package:customertaxi/features/order/domain/entities/order_saved_location_entity.dart';
import 'package:customertaxi/utils/helpers/app_strings.dart';

class SavedLocationsHelper {
  SavedLocationsHelper._();

  static const int maxCount = 10;

  static String identityKey(OrderLocationEntity location) {
    return '${location.latitude.toStringAsFixed(6)},${location.longitude.toStringAsFixed(6)}';
  }

  static String identityPreview(List<OrderSavedLocationEntity> saved) {
    if (saved.isEmpty) return '[]';
    return '[${saved.map((item) => item.identityKey).join('|')}]';
  }

  static List<OrderSavedLocationEntity> sorted(
    List<OrderSavedLocationEntity> locations,
  ) {
    final sorted = List<OrderSavedLocationEntity>.from(locations);
    sorted.sort((first, second) {
      if (first.isPinned != second.isPinned) {
        return first.isPinned ? -1 : 1;
      }
      return second.touchedAtMillis.compareTo(first.touchedAtMillis);
    });
    return sorted;
  }

  static List<OrderSavedLocationEntity> normalizeForUi(
    List<OrderSavedLocationEntity> locations,
  ) {
    final normalized = sorted(locations);
    while (normalized.length > maxCount) {
      final unpinnedIndex = normalized.lastIndexWhere((item) => !item.isPinned);
      final removeIndex = unpinnedIndex != -1
          ? unpinnedIndex
          : normalized.length - 1;
      normalized.removeAt(removeIndex);
    }
    return normalized;
  }

  static List<OrderSavedLocationEntity> filterByQuery({
    required String query,
    required List<OrderSavedLocationEntity> saved,
  }) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) return sorted(saved);
    final filtered = saved
        .where(
          (item) =>
              item.location.label.toLowerCase().contains(normalizedQuery),
        )
        .toList();
    return sorted(filtered);
  }

  static List<OrderSavedLocationEntity> fromSearchResults(
    List<OrderLocationEntity> locations,
  ) {
    final now = DateTime.now().millisecondsSinceEpoch;
    return locations
        .map(
          (location) => OrderSavedLocationEntity(
            identityKey: identityKey(location),
            location: location,
            isPinned: false,
            touchedAtMillis: now,
          ),
        )
        .toList();
  }

  static bool isSameCoordinates(
    OrderLocationEntity first,
    OrderLocationEntity second,
  ) {
    const epsilon = 0.0001;
    return (first.latitude - second.latitude).abs() <= epsilon &&
        (first.longitude - second.longitude).abs() <= epsilon;
  }

  static OrderLocationEntity buildFallbackLocation({
    required double latitude,
    required double longitude,
  }) {
    final coords =
        '${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}';
    return OrderLocationEntity(
      latitude: latitude,
      longitude: longitude,
      label: coords,
      primaryName: AppStrings.droppedPin,
      secondaryAddress: coords,
    );
  }
}
