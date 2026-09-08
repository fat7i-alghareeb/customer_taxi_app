import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../utils/helpers/colored_print.dart';
import '../../network/api_endpoints.dart';
import '../storage/storage_service.dart';
import 'app_version_config_model.dart';

/// Fetches the remote version gate configuration and the installed version.
///
/// Shaped like [ClientConfigService] rather than a repository on purpose: this
/// runs on the startup path and must never surface an error, so every failure
/// collapses to the fail-open [AppVersionConfigModel.disabled] default.
///
/// The last successful payload is mirrored into shared preferences so a cold
/// start can resolve the gate from disk in about a millisecond instead of
/// waiting on the network. See [loadCached].
@singleton
class AppVersionService {
  AppVersionService(this._dio, this._storage);

  /// Shared preferences key holding the last successful payload.
  static const String _cacheKey = 'appVersion.lastConfig';

  final Dio _dio;
  final StorageService _storage;

  AppVersionConfigModel _cached = AppVersionConfigModel.disabled;
  String? _installedVersion;

  AppVersionConfigModel get current => _cached;

  /// Restores the last known config from disk.
  ///
  /// Backed by SharedPreferences, which is already loaded before DI completes,
  /// so this is an in-memory map lookup behind an async wrapper — fast enough to
  /// await during bootstrap. A first-ever launch has nothing cached and simply
  /// stays on the fail-open default until the network fetch lands.
  Future<void> loadCached() async {
    try {
      final raw = await _storage.readString(_cacheKey);
      if (raw == null || raw.isEmpty) {
        printC('[AppVersionService] no cached config yet');
        return;
      }

      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        _cached = AppVersionConfigModel.fromJson(decoded);
        printG('[AppVersionService] restored cached config from disk');
      }
    } catch (e) {
      // A corrupt entry must never block startup; the default already applies.
      printY('[AppVersionService] cache read failed: $e — using defaults');
    }
  }

  /// Applies a payload already fetched by [BootstrapConfigService] and mirrors
  /// it to disk, so the next cold start still resolves the gate instantly.
  Future<void> adoptPayload(Map<String, dynamic> json) async {
    if (json.isEmpty) return;

    _cached = AppVersionConfigModel.fromJson(json);
    printG('[AppVersionService] adopted enabled=${_cached.enabled}');
    await _persist(json);
  }

  Future<void> fetch() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.appVersionConfig,
        // Tighter than the 30s global timeout. This no longer blocks startup,
        // but a request left hanging for half a minute would delay the gate
        // applying to a user who should be blocked.
        options: Options(
          receiveTimeout: const Duration(seconds: 6),
          sendTimeout: const Duration(seconds: 6),
        ),
      );
      final data = response.data;
      if (data != null) {
        _cached = AppVersionConfigModel.fromJson(data);
        printG(
          '[AppVersionService] fetched enabled=${_cached.enabled} '
          'android=${_cached.android.minimumRequiredVersion}/${_cached.android.latestVersion} '
          'ios=${_cached.ios.minimumRequiredVersion}/${_cached.ios.latestVersion}',
        );
        await _persist(data);
      }
    } catch (e) {
      printY('[AppVersionService] fetch failed: $e — using defaults');
    }
  }

  Future<void> _persist(Map<String, dynamic> data) async {
    try {
      await _storage.writeString(_cacheKey, jsonEncode(data));
    } catch (e) {
      // Losing the cache only costs speed on the next cold start.
      printY('[AppVersionService] cache write failed: $e');
    }
  }

  /// Installed versionName, e.g. `1.0.3`. Empty when it cannot be read, which
  /// the gate treats as "cannot compare" and therefore "do not block".
  Future<String> installedVersion() async {
    final cached = _installedVersion;
    if (cached != null) return cached;

    try {
      final info = await PackageInfo.fromPlatform();
      _installedVersion = info.version.trim();
    } catch (e) {
      printY('[AppVersionService] package info failed: $e');
      _installedVersion = '';
    }

    return _installedVersion!;
  }
}
