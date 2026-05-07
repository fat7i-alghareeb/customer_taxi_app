import '../../../../utils/helpers/app_strings.dart';
import '../../../../utils/helpers/colored_print.dart';


class OrderLocationModel {
  const OrderLocationModel({
    required this.latitude,
    required this.longitude,
    required this.label,
    this.primaryName,
    this.secondaryAddress,
    this.isEstablishment = false,
    this.street,
    this.neighborhood,
  });

  final double latitude;
  final double longitude;
  final String label;
  final String? primaryName;
  final String? secondaryAddress;
  final bool isEstablishment;
  final String? street;
  final String? neighborhood;

  OrderLocationModel copyWith({
    double? latitude,
    double? longitude,
    String? label,
    String? primaryName,
    String? secondaryAddress,
    bool? isEstablishment,
    String? street,
    String? neighborhood,
  }) {
    return OrderLocationModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      label: label ?? this.label,
      primaryName: primaryName ?? this.primaryName,
      secondaryAddress: secondaryAddress ?? this.secondaryAddress,
      isEstablishment: isEstablishment ?? this.isEstablishment,
      street: street ?? this.street,
      neighborhood: neighborhood ?? this.neighborhood,
    );
  }

  // Backend proxy factories — used when maps data comes from the server
  factory OrderLocationModel.fromBackend(Map<String, dynamic> json) {
    final primary = json['primaryName'] as String? ?? '';
    final secondary = json['secondaryAddress'] as String? ?? '';
    final label = secondary.isNotEmpty ? '$primary, $secondary' : primary;
    return OrderLocationModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      label: label,
      primaryName: primary,
      secondaryAddress: secondary,
    );
  }

  factory OrderLocationModel.fromReverseGeocodeBackend(
    Map<String, dynamic> json,
  ) {
    final primary = json['primaryName'] as String? ?? '';
    final secondary = json['secondaryAddress'] as String? ?? '';
    final label = secondary.isNotEmpty ? '$primary, $secondary' : primary;
    return OrderLocationModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      label: label,
      primaryName: primary,
      secondaryAddress: secondary,
    );
  }

  static final RegExp _plusCodeTokenRegex = RegExp(
    r'^[A-Z0-9]{4,}\+[A-Z0-9]{2,}$',
    caseSensitive: false,
  );

  static final RegExp _plusCodePrefixRegex = RegExp(
    r'^[A-Z0-9]{4,}\+[A-Z0-9]{2,}\s*',
    caseSensitive: false,
  );

  static const List<String> _placeDetailTypes = <String>[
    'premise',
    'subpremise',
    'establishment',
    'point_of_interest',
  ];

  static const List<String> _localDetailTypes = <String>[
    'neighborhood',
    'sublocality',
    'sublocality_level_1',
    'sublocality_level_2',
    'sublocality_level_3',
    'sublocality_level_4',
    'sublocality_level_5',
    'colloquial_area',
  ];

  static const List<String> _administrativeTypes = <String>[
    'country',
    'locality',
    'administrative_area_level_1',
    'administrative_area_level_2',
    'administrative_area_level_3',
    'administrative_area_level_4',
    'administrative_area_level_5',
    'postal_town',
  ];

  factory OrderLocationModel.fromGoogleResult(Map<String, dynamic> json) {
    final geometry = json['geometry'] as Map<String, dynamic>?;
    final location = geometry?['location'] as Map<String, dynamic>?;

    final lat = (location?['lat'] as num?)?.toDouble() ?? 0;
    final lng = (location?['lng'] as num?)?.toDouble() ?? 0;

    final components = _extractAddressComponents(json);
    final formattedAddress = _sanitizeDisplayText(
      json['formatted_address']?.toString() ?? '',
    );

    final streetPart = _buildStreetPartFromComponents(components);
    final placePart = _firstComponentValueByTypes(
      components,
      _placeDetailTypes,
    );
    final localPart = _firstComponentValueByTypes(
      components,
      _localDetailTypes,
    );

    final adminNames = _administrativeComponentNames(components);
    final formattedSegments = _extractLocalSegmentsFromFormattedAddress(
      formattedAddress: formattedAddress,
      excludedAdministrativeNames: adminNames,
    );

    final preferredLabel = _buildGoogleLabel(
      components: components,
      formattedAddress: formattedAddress,
    );

    final primaryName = streetPart.isNotEmpty
        ? streetPart
        : (placePart.isNotEmpty
            ? placePart
            : (localPart.isNotEmpty ? localPart : formattedSegments.firstOrNull));

    final secondaryAddress = _buildStructuredSecondary(
      components: components,
      primaryName: primaryName ?? '',
      formattedSegments: formattedSegments,
    );

    printC(
      '[OrderLocationModel:fromGoogleResult] primary="$primaryName" secondary="$secondaryAddress" label="$preferredLabel"',
    );

    // Ensure we don't return an empty label if possible
    final finalLabel = preferredLabel.isNotEmpty
        ? preferredLabel
        : (_sanitizeDisplayText(json['formatted_address']?.toString() ?? '')
            .split(',')
            .firstOrNull ??
        AppStrings.orderLocationUnknownLabel);

    return OrderLocationModel(
      latitude: lat,
      longitude: lng,
      label: finalLabel,
      primaryName: primaryName?.isNotEmpty == true ? primaryName : finalLabel,
      secondaryAddress: secondaryAddress,
      isEstablishment: placePart.isNotEmpty || (streetPart.isNotEmpty && streetPart.contains(RegExp(r'\d'))),
      street: streetPart.isNotEmpty ? streetPart : null,
      neighborhood: localPart.isNotEmpty ? localPart : null,
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

    final label = _buildPlacesLabel(
      name: name,
      formattedAddress: formattedAddress,
    );

    final localAddressSegments =
        _extractPlacesLocalSegmentsFromFormattedAddress(formattedAddress);

    final primaryName = name.isNotEmpty
        ? name
        : (localAddressSegments.isNotEmpty ? localAddressSegments.first : null);

    final secondaryAddress = localAddressSegments.isNotEmpty
        ? (name.isNotEmpty
            ? _joinUniqueSegments(source: localAddressSegments, maxSegments: 2)
            : (localAddressSegments.length > 1
                ? _joinUniqueSegments(
                    source: localAddressSegments.sublist(1),
                    maxSegments: 2,
                  )
                : null))
        : null;

    printC(
      '[OrderLocationModel:fromPlacesTextResult] primary="$primaryName" secondary="$secondaryAddress" label="$label"',
    );

    return OrderLocationModel(
      latitude: lat,
      longitude: lng,
      label: label.isNotEmpty ? label : AppStrings.orderLocationUnknownLabel,
      primaryName:
          primaryName?.isNotEmpty == true ? primaryName : (label.isNotEmpty ? label : AppStrings.orderLocationUnknownLabel),
      secondaryAddress: secondaryAddress,
      isEstablishment: true,
    );
  }



  factory OrderLocationModel.fromNearbyResult(Map<String, dynamic> json) {
    final geometry = json['geometry'] as Map<String, dynamic>?;
    final location = geometry?['location'] as Map<String, dynamic>?;

    final lat = (location?['lat'] as num?)?.toDouble() ?? 0;
    final lng = (location?['lng'] as num?)?.toDouble() ?? 0;

    final name = _sanitizeDisplayText(json['name']?.toString() ?? '');
    final vicinity = _sanitizeDisplayText(json['vicinity']?.toString() ?? '');

    return OrderLocationModel(
      latitude: lat,
      longitude: lng,
      label: name,
      primaryName: name,
      secondaryAddress: vicinity,
      isEstablishment: _isEstablishingType(json['types'] as List<dynamic>? ?? const []),
    );
  }

  static bool _isEstablishingType(List<dynamic> types) {
    final typeSet = types.map((t) => t.toString()).toSet();
    return typeSet.intersection(_placeDetailTypes.toSet()).isNotEmpty;
  }






  static String _sanitizeDisplayText(String value) {
    if (value.isEmpty) {
      return '';
    }

    // Normalize Arabic commas to standard commas for unified processing
    final normalized = value.replaceAll('\u060C', ',').trim();

    final withoutPrefix = normalized.replaceFirst(_plusCodePrefixRegex, '').trim();
    final segments = withoutPrefix
        .split(',')
        .map((segment) => segment.trim())
        .where((segment) => segment.isNotEmpty)
        .where((segment) => !_plusCodeTokenRegex.hasMatch(segment))
        .toList();

    return segments.join(', ').trim();
  }

  static List<String> _splitAddress(String address) {
    if (address.isEmpty) {
      return const [];
    }
    // Handle both comma types
    return address
        .replaceAll('\u060C', ',')
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }

  static String? _buildStructuredSecondary({
    required List<Map<String, dynamic>> components,
    required String primaryName,
    required List<String> formattedSegments,
  }) {
    // 1. Core components that provide good context
    final route = _firstComponentValueByTypes(components, ['route']);
    final neighborhood = _firstComponentValueByTypes(components, _localDetailTypes);
    final city =
        _firstComponentValueByTypes(components, ['locality', 'postal_town']);

    final secondaryParts = <String>[];
    final seen = <String>{primaryName.toLowerCase()};

    void addPart(String part) {
      if (part.isEmpty) return;
      final key = part.toLowerCase();
      
      // Semantic check: don't add "حلب" if "Aleppo" is seen, and vice versa
      if (_hasSemanticDuplicate(seen, key)) {
        return;
      }

      if (!seen.contains(key)) {
        secondaryParts.add(part);
        seen.add(key);
      }
    }

    // 2. Build in order: Route/Neighborhood -> City
    addPart(route);
    addPart(neighborhood);
    addPart(city);

    // 3. If we don't have enough structured parts, fallback to formatted segments
    if (secondaryParts.length < 2) {
      for (final segment in formattedSegments) {
        addPart(segment);
        if (secondaryParts.length >= 2) break;
      }
    }

    if (secondaryParts.isEmpty) return null;

    // Join max 2 parts
    return secondaryParts.take(2).join(', ');
  }

  static bool _hasSemanticDuplicate(Set<String> seen, String key) {
    // Known bilingual pairs in the regions
    const List<Set<String>> bilingualPairs = [
      {'aleppo', 'حلب'},
      {'damascus', 'دمشق'},
      {'homs', 'حمص'},
      {'hama', 'حماه'},
      {'lattakia', 'اللاذقية', 'latakia'},
      {'tartous', 'طرطوس'},
    ];

    for (final pair in bilingualPairs) {
      if (pair.contains(key)) {
        // If we are looking at one of these, check if any OTHER member of this pair is already in 'seen'
        if (pair.any((member) => seen.contains(member) && member != key)) {
          return true;
        }
      }
    }
    return false;
  }




  static List<Map<String, dynamic>> _extractAddressComponents(
    Map<String, dynamic> json,
  ) {
    final components = json['address_components'] as List<dynamic>? ?? const [];
    return components.whereType<Map<String, dynamic>>().toList();
  }

  static String _buildGoogleLabel({
    required List<Map<String, dynamic>> components,
    required String formattedAddress,
  }) {
    final streetPart = _buildStreetPartFromComponents(components);
    final placePart = _firstComponentValueByTypes(
      components,
      _placeDetailTypes,
    );
    final localPart = _firstComponentValueByTypes(
      components,
      _localDetailTypes,
    );

    final excludedAdministrativeNames = _administrativeComponentNames(
      components,
    );

    final formattedSegments = _extractLocalSegmentsFromFormattedAddress(
      formattedAddress: formattedAddress,
      excludedAdministrativeNames: excludedAdministrativeNames,
    );

    final composed = _joinUniqueSegments(
      source: <String>[streetPart, placePart, localPart, ...formattedSegments],
      maxSegments: 2,
    );

    if (composed.isNotEmpty) {
      return composed;
    }

    return _firstComponentValueByTypes(components, <String>[
      'route',
      ..._placeDetailTypes,
      ..._localDetailTypes,
    ]);
  }

  static String _buildPlacesLabel({
    required String name,
    required String formattedAddress,
  }) {
    final localAddressSegments =
        _extractPlacesLocalSegmentsFromFormattedAddress(formattedAddress);

    final localAddress = localAddressSegments.join(', ');

    if (name.isEmpty && localAddress.isEmpty) {
      return '';
    }

    if (name.isEmpty) {
      return localAddress;
    }

    if (localAddress.isEmpty) {
      return name;
    }

    if (_isSameIgnoringCase(name, localAddress)) {
      return name;
    }

    return '$name - $localAddress';
  }

  static bool _isSameIgnoringCase(String first, String second) {
    return first.toLowerCase() == second.toLowerCase();
  }

  static List<String> _componentTypes(Map<String, dynamic> component) {
    final types = component['types'] as List<dynamic>? ?? const [];
    return types.map((type) => type.toString()).toList();
  }

  static bool _componentHasAnyType(
    Map<String, dynamic> component,
    List<String> types,
  ) {
    final componentTypes = _componentTypes(component);
    for (final type in types) {
      if (componentTypes.contains(type)) {
        return true;
      }
    }
    return false;
  }

  static String _firstComponentValueByTypes(
    List<Map<String, dynamic>> components,
    List<String> types,
  ) {
    for (final component in components) {
      if (!_componentHasAnyType(component, types)) {
        continue;
      }

      final value = _sanitizeDisplayText(
        component['long_name']?.toString() ?? '',
      );
      if (value.isNotEmpty) {
        return value;
      }
    }

    return '';
  }

  static Set<String> _administrativeComponentNames(
    List<Map<String, dynamic>> components,
  ) {
    final values = <String>{};

    for (final component in components) {
      if (!_componentHasAnyType(component, _administrativeTypes)) {
        continue;
      }

      final value = _sanitizeDisplayText(
        component['long_name']?.toString() ?? '',
      );
      if (value.isNotEmpty) {
        values.add(value.toLowerCase());
      }
    }

    return values;
  }

  static String _buildStreetPartFromComponents(
    List<Map<String, dynamic>> components,
  ) {
    final streetNumber = _firstComponentValueByTypes(components, const <String>[
      'street_number',
    ]);

    final route = _firstComponentValueByTypes(components, const <String>[
      'route',
    ]);

    if (streetNumber.isNotEmpty && route.isNotEmpty) {
      return '$streetNumber $route';
    }

    if (route.isNotEmpty) {
      return route;
    }

    return '';
  }

  static List<String> _extractLocalSegmentsFromFormattedAddress({
    required String formattedAddress,
    required Set<String> excludedAdministrativeNames,
  }) {
    if (formattedAddress.isEmpty) {
      return const <String>[];
    }

    final allSegments = _splitAddress(formattedAddress);

    final segments = allSegments
        .map(_sanitizeDisplayText)
        .where((segment) => segment.isNotEmpty)
        .where(
          (segment) =>
              !excludedAdministrativeNames.contains(segment.toLowerCase()),
        )
        .toList();

    if (segments.isEmpty) {
      // If everything was filtered out, keep the first segment of the original address
      // as it's better than nothing (e.g., if a city name is all we have)
      return allSegments.take(1).toList();
    }

    if (segments.length >= 3) {
      // Logic: take parts that aren't the broad administrative ones (usually last 2)
      final withoutAdministrative = segments.take(segments.length - 1).toList();
      return withoutAdministrative.take(2).toList();
    }

    return segments.take(2).toList();
  }

  static List<String> _extractPlacesLocalSegmentsFromFormattedAddress(
    String formattedAddress,
  ) {
    if (formattedAddress.isEmpty) {
      return const <String>[];
    }

    final segments = _splitAddress(formattedAddress)
        .map(_sanitizeDisplayText)
        .where((segment) => segment.isNotEmpty)
        .toList();

    if (segments.length < 2) {
      return segments;
    }

    // For places, we usually want the most specific parts
    final withoutCityCountry = segments.take(segments.length - 1).toList();
    return withoutCityCountry.take(2).toList();
  }


  static String _joinUniqueSegments({
    required List<String> source,
    required int maxSegments,
  }) {
    final output = <String>[];
    final seen = <String>{};

    for (final segment in source) {
      final clean = _sanitizeDisplayText(segment);
      if (clean.isEmpty) {
        continue;
      }

      final key = clean.toLowerCase();
      if (!seen.add(key)) {
        continue;
      }

      output.add(clean);
      if (output.length >= maxSegments) {
        break;
      }
    }

    return output.join(', ');
  }
}
