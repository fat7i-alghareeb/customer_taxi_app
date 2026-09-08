import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/helpers/colored_print.dart';
import '../../network/api_endpoints.dart';
import '../app_version/app_version_service.dart';
import '../client_config/client_config_service.dart';
import '../support_contact/support_contact_service.dart';

/// Fetches the whole startup payload in one request and fans it out.
///
/// Replaces three separate calls (client config, support contact, version gate).
/// It runs in the background — nothing here blocks the first frame — but folding
/// three round trips into one still matters: it is three chances to hit a slow
/// network reduced to one, and the update gate applies sooner.
///
/// Falls back to the individual endpoints if the combined call fails, so an
/// older backend or a partial deploy degrades instead of breaking.
@singleton
class BootstrapConfigService {
  BootstrapConfigService(
    this._dio,
    this._clientConfig,
    this._supportContact,
    this._appVersion,
  );

  final Dio _dio;
  final ClientConfigService _clientConfig;
  final SupportContactService _supportContact;
  final AppVersionService _appVersion;

  Future<void> fetchAll() async {
    // Claim the slot up front so an ensureReady() during the request waits for
    // this call rather than starting a second, individual one.
    _clientConfig.markFetchDispatched();

    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.bootstrapConfig,
        options: Options(
          receiveTimeout: const Duration(seconds: 8),
          sendTimeout: const Duration(seconds: 8),
        ),
      );

      final data = response.data;
      if (data == null) {
        printY('[BootstrapConfigService] empty payload — falling back');
        await _fetchIndividually();
        return;
      }

      _clientConfig.adoptPayload(_section(data, 'client'));
      _supportContact.adoptPayload(_section(data, 'support'));
      await _appVersion.adoptPayload(_section(data, 'appVersion'));

      printG('[BootstrapConfigService] startup payload applied in one request');
    } catch (e) {
      printY('[BootstrapConfigService] combined fetch failed: $e — falling back');
      await _fetchIndividually();
    }
  }

  /// Individual endpoints, used when the combined one is unavailable.
  Future<void> _fetchIndividually() async {
    await Future.wait<void>([
      _clientConfig.fetch(),
      _supportContact.fetch(),
      _appVersion.fetch(),
    ]);
  }

  /// Tolerates both camelCase and PascalCase, matching the other config models.
  Map<String, dynamic> _section(Map<String, dynamic> json, String key) {
    final value =
        json[key] ?? json['${key[0].toUpperCase()}${key.substring(1)}'];
    if (value is Map) return Map<String, dynamic>.from(value);
    return <String, dynamic>{};
  }
}
