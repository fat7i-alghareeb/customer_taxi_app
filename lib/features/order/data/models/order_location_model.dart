class OrderLocationModel {
  const OrderLocationModel({
    required this.latitude,
    required this.longitude,
    required this.label,
  });

  final double latitude;
  final double longitude;
  final String label;

  static final RegExp _plusCodeTokenRegex = RegExp(
    r'^[A-Z0-9]{4,}\+[A-Z0-9]{2,}$',
    caseSensitive: false,
  );

  static final RegExp _plusCodePrefixRegex = RegExp(
    r'^[A-Z0-9]{4,}\+[A-Z0-9]{2,}\s*',
    caseSensitive: false,
  );

  factory OrderLocationModel.fromGoogleResult(Map<String, dynamic> json) {
    final geometry = json['geometry'] as Map<String, dynamic>?;
    final location = geometry?['location'] as Map<String, dynamic>?;

    final lat = (location?['lat'] as num?)?.toDouble() ?? 0;
    final lng = (location?['lng'] as num?)?.toDouble() ?? 0;

    final formattedAddress = json['formatted_address']?.toString();
    final cleanedAddress = _sanitizeDisplayText(formattedAddress ?? '');
    final fallbackLabel =
        '${lat.toStringAsFixed(6)}, ${lng.toStringAsFixed(6)}';

    return OrderLocationModel(
      latitude: lat,
      longitude: lng,
      label: cleanedAddress.isNotEmpty ? cleanedAddress : fallbackLabel,
    );
  }

  factory OrderLocationModel.fromPlacesTextResult(Map<String, dynamic> json) {
    final geometry = json['geometry'] as Map<String, dynamic>?;
    final location = geometry?['location'] as Map<String, dynamic>?;

    final lat = (location?['lat'] as num?)?.toDouble() ?? 0;
    final lng = (location?['lng'] as num?)?.toDouble() ?? 0;

    final name = _sanitizeDisplayText(json['name']?.toString() ?? '');
    final formattedAddress = _sanitizeDisplayText(
      json['formatted_address']?.toString() ?? '',
    );

    final label = _composePlacesLabel(name: name, address: formattedAddress);

    final fallbackLabel =
        '${lat.toStringAsFixed(6)}, ${lng.toStringAsFixed(6)}';

    return OrderLocationModel(
      latitude: lat,
      longitude: lng,
      label: label.isNotEmpty ? label : fallbackLabel,
    );
  }

  static String _sanitizeDisplayText(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return '';
    }

    final withoutPrefix = trimmed.replaceFirst(_plusCodePrefixRegex, '').trim();
    final segments = withoutPrefix
        .split(',')
        .map((segment) => segment.trim())
        .where((segment) => segment.isNotEmpty)
        .where((segment) => !_plusCodeTokenRegex.hasMatch(segment))
        .toList();

    return segments.join(', ').trim();
  }

  static String _composePlacesLabel({
    required String name,
    required String address,
  }) {
    if (name.isEmpty && address.isEmpty) {
      return '';
    }

    if (name.isEmpty) {
      return address;
    }

    if (address.isEmpty) {
      return name;
    }

    if (_isSameIgnoringCase(name, address) || _isGenericAreaAddress(address)) {
      return name;
    }

    return '$name - $address';
  }

  static bool _isSameIgnoringCase(String first, String second) {
    return first.toLowerCase() == second.toLowerCase();
  }

  static bool _isGenericAreaAddress(String address) {
    final segments = address
        .split(',')
        .map((segment) => segment.trim())
        .where((segment) => segment.isNotEmpty)
        .toList();

    // Generic outputs like "Aleppo, Syria" add little value beside place name.
    return segments.length <= 2;
  }
}
