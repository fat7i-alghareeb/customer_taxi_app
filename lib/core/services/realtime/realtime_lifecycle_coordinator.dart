import 'dart:async';

import 'package:dio_refresh_bot/dio_refresh_bot.dart' show AuthStatus, Status;
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/helpers/colored_print.dart';
import '../client_config/client_config_service.dart';
import '../session/auth_manager.dart';
import 'realtime_service.dart';

/// Owns the realtime connection lifecycle.
///
/// Single source of truth for when [RealtimeService.connect] /
/// [RealtimeService.disconnect] is called. Features must NOT touch the
/// service directly for lifecycle — they only consume events and trip
/// groups.
///
/// Wires two triggers:
///
/// 1. **Auth state** (via [AuthManager.authStatusStream]):
///    * `Status.authenticated` → connect.
///    * `Status.unauthenticated` → disconnect.
///
/// 2. **App lifecycle** (via [WidgetsBindingObserver]):
///    * `paused` / `detached` / `hidden` → disconnect (no zombie sockets
///      while the OS suspends us).
///    * `resumed` → reconnect, but only if auth is currently authenticated.
///
/// Also gated by [ClientConfigService.current.signalREnabled]: when false,
/// [start] is a no-op (polling fallback continues to drive trip updates).
@lazySingleton
class RealtimeLifecycleCoordinator with WidgetsBindingObserver {
  RealtimeLifecycleCoordinator(
    this._service,
    this._authManager,
    this._configService,
  );

  static const String _logTag = '[Realtime/Lifecycle]';

  final RealtimeService _service;
  final AuthManager _authManager;
  final ClientConfigService _configService;

  StreamSubscription<AuthStatus>? _authSub;
  bool _started = false;

  /// Subscribes to auth + app lifecycle. Idempotent.
  void start() {
    if (_started) return;
    _started = true;

    if (!_configService.current.signalREnabled) {
      printY('$_logTag signalREnabled=false — coordinator inert');
      return;
    }

    WidgetsBinding.instance.addObserver(this);
    _authSub = _authManager.authStatusStream.listen(_onAuthStatus);

    // Best-effort initial connect: the auth stream only emits on changes,
    // so if we are already authenticated at startup we need to kick a
    // connect now.
    if (_authManager.isAuthenticated) {
      printC('$_logTag authenticated at startup — connecting');
      unawaited(_service.connect());
    }
  }

  Future<void> stop() async {
    if (!_started) return;
    _started = false;
    WidgetsBinding.instance.removeObserver(this);
    await _authSub?.cancel();
    _authSub = null;
    await _service.disconnect();
  }

  void _onAuthStatus(AuthStatus status) {
    if (!_configService.current.signalREnabled) return;

    switch (status.status) {
      case Status.authenticated:
        printC('$_logTag auth -> authenticated, connecting');
        unawaited(_service.connect());
        break;
      case Status.unauthenticated:
        printY('$_logTag auth -> unauthenticated, disconnecting');
        unawaited(_service.disconnect());
        break;
      case Status.initial:
        // Wait until auth resolves.
        break;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_configService.current.signalREnabled) return;

    switch (state) {
      case AppLifecycleState.resumed:
        if (_authManager.isAuthenticated) {
          printC('$_logTag app resumed, reconnecting');
          unawaited(_service.connect());
        }
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        printY('$_logTag app $state, disconnecting');
        unawaited(_service.disconnect());
        break;
      case AppLifecycleState.inactive:
        // Transient — do nothing.
        break;
    }
  }
}
