/// Version gate rules for a single platform.
///
/// An empty [storeUrl] or version means "not configured": the gate treats that
/// platform as ungated rather than guessing.
class AppVersionPlatformModel {
  const AppVersionPlatformModel({
    required this.latestVersion,
    required this.minimumRequiredVersion,
    required this.storeUrl,
  });

  final String latestVersion;
  final String minimumRequiredVersion;
  final String storeUrl;

  factory AppVersionPlatformModel.fromJson(Map<String, dynamic> json) {
    return AppVersionPlatformModel(
      latestVersion: _str(json, 'latestVersion'),
      minimumRequiredVersion: _str(json, 'minimumRequiredVersion'),
      storeUrl: _str(json, 'storeUrl'),
    );
  }

  static const AppVersionPlatformModel empty = AppVersionPlatformModel(
    latestVersion: '',
    minimumRequiredVersion: '',
    storeUrl: '',
  );
}

/// Remote version gate configuration, read once at bootstrap.
class AppVersionConfigModel {
  const AppVersionConfigModel({
    required this.enabled,
    required this.android,
    required this.ios,
  });

  final bool enabled;
  final AppVersionPlatformModel android;
  final AppVersionPlatformModel ios;

  factory AppVersionConfigModel.fromJson(Map<String, dynamic> json) {
    return AppVersionConfigModel(
      enabled: _bool(json, 'enabled'),
      android: AppVersionPlatformModel.fromJson(_map(json, 'android')),
      ios: AppVersionPlatformModel.fromJson(_map(json, 'ios')),
    );
  }

  /// Fail-open default used before the first fetch and after any failure.
  static const AppVersionConfigModel disabled = AppVersionConfigModel(
    enabled: false,
    android: AppVersionPlatformModel.empty,
    ios: AppVersionPlatformModel.empty,
  );
}

/// The backend serialises camelCase today; tolerate PascalCase too so a future
/// JSON policy change cannot silently blank every field.
dynamic _raw(Map<String, dynamic> json, String key) =>
    json[key] ?? json['${key[0].toUpperCase()}${key.substring(1)}'];

String _str(Map<String, dynamic> json, String key) =>
    _raw(json, key)?.toString() ?? '';

bool _bool(Map<String, dynamic> json, String key) {
  final value = _raw(json, key);
  if (value is bool) return value;
  return value?.toString().toLowerCase() == 'true';
}

Map<String, dynamic> _map(Map<String, dynamic> json, String key) {
  final value = _raw(json, key);
  if (value is Map) return Map<String, dynamic>.from(value);
  return <String, dynamic>{};
}
