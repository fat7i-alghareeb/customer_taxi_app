import 'dart:async';

import 'package:dio_refresh_bot/dio_refresh_bot.dart' show AuthStatus, Status;
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/helpers/colored_print.dart';
import '../client_config/client_config_service.dart';
import '../session/auth_manager.dart';
import 'realtime_connection_state.dart';
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
///    * `paused` / `hidden` → defer disconnect by [_backgroundGrace]. If the
///      user returns within the window the live socket is kept (a short app
///      switch must not tear realtime down); only after the window elapses do
///      we disconnect to avoid zombie sockets while the OS suspends us.
///    * `detached` → disconnect immediately (the app is terminating).
///    * `resumed` → cancel any pending background disconnect and reconnect
///      (idempotent — a no-op when the socket is still alive), but only if
///      auth is currently authenticated.
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

  /// How long the socket is kept alive after the app is backgrounded before we
  /// proactively disconnect. Covers quick app switches, checking a
  /// notification, taking a call, copying an address, etc. Long backgrounds are
  /// still covered by FCM push.
  static const Duration _backgroundGrace = Duration(minutes: 10);

  final RealtimeService _service;
  final AuthManager _authManager;
  final ClientConfigService _configService;

  StreamSubscription<AuthStatus>? _authSub;
  StreamSubscription<RealtimeConnectionState>? _stateSub;
  Timer? _backgroundDisconnectTimer;
  bool _started = false;

  /// Subscribes to auth + app lifecycle. Idempotent.
  void start() {
    if (_started) return;
    _started = true;
    unawaited(_startWhenConfigReady());
  }

  /// The client config is fetched in the background during bootstrap, so
  /// reading `signalREnabled` synchronously here would see the fail-open
  /// default (`false`) and leave this coordinator permanently inert.
  Future<void> _startWhenConfigReady() async {
    await _configService.ensureReady();

    if (!_configService.current.signalREnabled) {
      printY('$_logTag signalREnabled=false — coordinator inert');
      return;
    }

    WidgetsBinding.instance.addObserver(this);
    _authSub = _authManager.authStatusStream.listen(_onAuthStatus);
    // Mirror every socket transition to the console so the realtime layer can
    // be monitored live (disconnected → connecting → connected → reconnecting).
    _stateSub = _service.connectionState.listen(
      (state) => printC('$_logTag connectionState -> $state'),
    );

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
    _cancelBackgroundDisconnect();
    await _authSub?.cancel();
    _authSub = null;
    await _stateSub?.cancel();
    _stateSub = null;
    await _service.disconnect();
  }

  void _onAuthStatus(AuthStatus status) {
    if (!_configService.current.signalREnabled) return;

    switch (status.status) {
      case Status.authenticated:
        printC('$_logTag auth -> authenticated, connecting');
        _cancelBackgroundDisconnect();
        unawaited(_service.connect());
        break;
      case Status.unauthenticated:
        printY('$_logTag auth -> unauthenticated, disconnecting');
        _cancelBackgroundDisconnect();
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
        _cancelBackgroundDisconnect();
        if (_authManager.isAuthenticated) {
          // Idempotent: no-op when the socket survived the background, real
          // reconnect only if the OS dropped it.
          printC('$_logTag app resumed, ensuring connection');
          unawaited(_service.connect());
        }
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        _scheduleBackgroundDisconnect(state);
        break;
      case AppLifecycleState.detached:
        // App is terminating — drop the socket now, no grace period.
        printY('$_logTag app detached, disconnecting');
        _cancelBackgroundDisconnect();
        unawaited(_service.disconnect());
        break;
      case AppLifecycleState.inactive:
        // Transient — do nothing.
        break;
    }
  }

  /// Defers the disconnect by [_backgroundGrace] so a short background does not
  /// tear the socket down. Idempotent: a timer already in flight is kept.
  void _scheduleBackgroundDisconnect(AppLifecycleState state) {
    if (_backgroundDisconnectTimer != null) return;
    printY(
      '$_logTag app $state, disconnecting in '
      '${_backgroundGrace.inMinutes}m if still backgrounded',
    );
    _backgroundDisconnectTimer = Timer(_backgroundGrace, () {
      _backgroundDisconnectTimer = null;
      printY('$_logTag background grace elapsed, disconnecting');
      unawaited(_service.disconnect());
    });
  }

  void _cancelBackgroundDisconnect() {
    _backgroundDisconnectTimer?.cancel();
    _backgroundDisconnectTimer = null;
  }
}
