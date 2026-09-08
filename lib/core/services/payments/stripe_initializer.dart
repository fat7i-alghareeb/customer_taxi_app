import 'dart:async';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/helpers/colored_print.dart';
import '../client_config/client_config_service.dart';

/// Configures the Stripe SDK on first use instead of during bootstrap.
///
/// Stripe setup depends on the remote client config, and awaiting that during
/// startup cost a network round trip inside the native splash. It now happens
/// lazily: every payment entry point calls [ensureReady] before opening a
/// payment sheet, which costs nothing once the config has landed (it almost
/// always has — payment screens sit several taps deep).
@lazySingleton
class StripeInitializer {
  StripeInitializer(this._configService);

  static const String _merchantIdentifier = 'merchant.dev.fat7i.customertaxi';
  static const String _urlScheme = 'customertaxi';

  final ClientConfigService _configService;

  Future<bool>? _pending;
  bool _applied = false;

  /// Ensures the SDK is configured. Returns false when Stripe is disabled
  /// remotely, has no publishable key, or native setup failed — callers should
  /// treat that as "card payment unavailable", not as a crash.
  ///
  /// Concurrent callers share one in-flight attempt.
  Future<bool> ensureReady() {
    if (_applied) return Future<bool>.value(true);
    return _pending ??= _apply();
  }

  Future<bool> _apply() async {
    try {
      await _configService.ensureReady();

      final config = _configService.current;
      if (!config.stripeEnabled || config.stripePublishableKey.isEmpty) {
        printY('[StripeInitializer] Stripe disabled or no publishable key');
        return false;
      }

      Stripe.publishableKey = config.stripePublishableKey;
      Stripe.merchantIdentifier = _merchantIdentifier;
      Stripe.urlScheme = _urlScheme;
      await Stripe.instance.applySettings();

      _applied = true;
      printG(
        '[StripeInitializer] initialized '
        'publishableKey=${config.stripePublishableKey.substring(0, 8)}…',
      );
      return true;
    } catch (e) {
      printY('[StripeInitializer] initialization failed: $e');
      return false;
    } finally {
      // Allow a later retry if this attempt did not succeed.
      if (!_applied) _pending = null;
    }
  }
}
