import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/helpers/colored_print.dart';
import '../../network/api_endpoints.dart';
import 'client_config_model.dart';

/// Remote client configuration (Stripe enablement, publishable key, SignalR).
///
/// The fetch is kicked off during bootstrap but deliberately **not awaited** —
/// it used to sit on the critical path and hold the native splash open for a
/// full round trip.
///
/// Because of that, anything that reads [current] to make a decision must first
/// `await` [ensureReady]. Reading [current] before the first fetch settles
/// returns [ClientConfigModel.disabled], which would silently switch Stripe and
/// SignalR off.
@singleton
class ClientConfigService {
  ClientConfigService(this._dio);

  final Dio _dio;

  final Completer<void> _readyCompleter = Completer<void>();

  ClientConfigModel _cached = ClientConfigModel.disabled;
  bool _fetchStarted = false;

  ClientConfigModel get current => _cached;

  bool get isReady => _readyCompleter.isCompleted;

  /// Resolves once the first fetch has settled — successfully or not.
  ///
  /// On failure it still completes, leaving the fail-open defaults in place, so
  /// callers degrade instead of hanging forever behind a dead backend.
  Future<void> ensureReady() {
    // Defensive: if nobody kicked the fetch off, start it rather than waiting on
    // a future that will never complete.
    if (!_fetchStarted) {
      unawaited(fetch());
    }
    return _readyCompleter.future;
  }

  /// Claims the in-flight slot before [BootstrapConfigService] issues the
  /// combined request, so a concurrent [ensureReady] waits for that request
  /// instead of firing a duplicate individual fetch.
  void markFetchDispatched() => _fetchStarted = true;

  /// Applies a payload already fetched by [BootstrapConfigService] and releases
  /// any [ensureReady] waiters, so the combined request satisfies them exactly
  /// as an individual fetch would.
  void adoptPayload(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      _cached = ClientConfigModel.fromJson(json);
      printG(
        '[ClientConfigService] adopted stripeEnabled=${_cached.stripeEnabled} '
        'signalREnabled=${_cached.signalREnabled}',
      );
    }

    _fetchStarted = true;
    if (!_readyCompleter.isCompleted) {
      _readyCompleter.complete();
    }
  }

  Future<void> fetch() async {
    _fetchStarted = true;
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.clientConfig,
      );
      final data = response.data;
      if (data != null) {
        _cached = ClientConfigModel.fromJson(data);
        printG(
          '[ClientConfigService] fetched stripeEnabled=${_cached.stripeEnabled} '
          'signalREnabled=${_cached.signalREnabled}',
        );
      }
    } catch (e) {
      printY('[ClientConfigService] fetch failed: $e — using defaults');
    } finally {
      // Must be in `finally`: completing only on success would deadlock every
      // ensureReady() caller whenever the request fails.
      if (!_readyCompleter.isCompleted) {
        _readyCompleter.complete();
      }
    }
  }
}
