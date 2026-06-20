import 'dart:convert';

class OrderSavedLocationCacheModel {
  const OrderSavedLocationCacheModel({
    required this.identityKey,
    required this.latitude,
    required this.longitude,
    required this.label,
    this.primaryName,
    this.secondaryAddress,
    this.isAirport = false,
    required this.isPinned,
    required this.touchedAtMillis,
  });

  final String identityKey;
  final double latitude;
  final double longitude;
  final String label;
  final String? primaryName;
  final String? secondaryAddress;
  final bool isAirport;
  final bool isPinned;
  final int touchedAtMillis;

  OrderSavedLocationCacheModel copyWith({
    String? identityKey,
    double? latitude,
    double? longitude,
    String? label,
    String? primaryName,
    String? secondaryAddress,
    bool? isAirport,
    bool? isPinned,
    int? touchedAtMillis,
  }) {
    return OrderSavedLocationCacheModel(
      identityKey: identityKey ?? this.identityKey,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      label: label ?? this.label,
      primaryName: primaryName ?? this.primaryName,
      secondaryAddress: secondaryAddress ?? this.secondaryAddress,
      isAirport: isAirport ?? this.isAirport,
      isPinned: isPinned ?? this.isPinned,
      touchedAtMillis: touchedAtMillis ?? this.touchedAtMillis,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identityKey': identityKey,
      'latitude': latitude,
      'longitude': longitude,
      'label': label,
      'primaryName': primaryName,
      'secondaryAddress': secondaryAddress,
      'isAirport': isAirport,
      'isPinned': isPinned,
      'touchedAtMillis': touchedAtMillis,
    };
  }

  factory OrderSavedLocationCacheModel.fromJson(Map<String, dynamic> json) {
    return OrderSavedLocationCacheModel(
      identityKey: json['identityKey']?.toString() ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      label: json['label']?.toString() ?? '',
      primaryName: json['primaryName']?.toString(),
      secondaryAddress: json['secondaryAddress']?.toString(),
      isAirport: json['isAirport'] == true,
      isPinned: json['isPinned'] == true,
      touchedAtMillis: (json['touchedAtMillis'] as num?)?.toInt() ?? 0,
    );
  }
}

class OrderSavedLocationsCacheEnvelopeModel {
  const OrderSavedLocationsCacheEnvelopeModel({required this.items});

  final List<OrderSavedLocationCacheModel> items;

  Map<String, dynamic> toJson() {
    return {'items': items.map((item) => item.toJson()).toList()};
  }

  String toRawValue() => jsonEncode(toJson());

  factory OrderSavedLocationsCacheEnvelopeModel.fromRawValue(String raw) {
    try {
      final decoded = jsonDecode(raw);

      if (decoded is Map<String, dynamic>) {
        final rawItems = decoded['items'] as List<dynamic>? ?? const [];

        return OrderSavedLocationsCacheEnvelopeModel(
          items: rawItems
              .whereType<Map<String, dynamic>>()
              .map(OrderSavedLocationCacheModel.fromJson)
              .toList(),
        );
      }

      if (decoded is List<dynamic>) {
        return OrderSavedLocationsCacheEnvelopeModel(
          items: decoded
              .whereType<Map<String, dynamic>>()
              .map(OrderSavedLocationCacheModel.fromJson)
              .toList(),
        );
      }

      return const OrderSavedLocationsCacheEnvelopeModel(items: []);
    } catch (_) {
      return const OrderSavedLocationsCacheEnvelopeModel(items: []);
    }
  }
}
