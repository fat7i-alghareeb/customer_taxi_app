import 'dart:async';

import 'package:dio_refresh_bot/dio_refresh_bot.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../core/router/app_page_transitions.dart';
import '../../features/auth/presentation/ui/screens/login_screen.dart';
import '../../features/onboarding/presentation/ui/screens/onboarding_screen.dart';
import '../../features/permissions/presentation/ui/screens/permission_gate_screen.dart';
import '../../features/root/presentation/ui/screens/root_screen.dart';
import '../../features/root/presentation/ui/widgets/root_body.dart';
import '../../features/root/presentation/ui/screens/about_us_screen.dart';
import '../../features/root/presentation/ui/screens/cancellation_policy_screen.dart';
import '../../features/root/presentation/ui/screens/contact_us_screen.dart';
import '../../features/profile/presentation/ui/screens/profile_setup_screen.dart';
import '../../features/trip/presentation/ui/screens/active_trip_screen.dart';
import '../../features/trip/presentation/ui/screens/trip_details_screen.dart';
import '../../features/trip/presentation/ui/screens/trip_history_screen.dart';
import '../../features/trip/presentation/ui/screens/trip_invoice_screen.dart';
import '../../features/trip/presentation/ui/screens/trip_receipt_screen.dart';
import '../../features/favorites/presentation/ui/screens/favorites_screen.dart';
import '../../features/order/presentation/ui/screens/location_picker_screen.dart';
import '../../features/splash/presentation/ui/screens/splash_screen.dart';
import '../services/location/startup_map_warmup_coordinator.dart';
import '../../utils/constants/app_flow_constants.dart';
import '../../utils/helpers/colored_print.dart';
import '../services/onboarding/onboarding_service.dart';
import '../services/permissions/permissions_coordinator.dart';
import '../services/session/auth_state_notifier.dart';

part 'app_routes.dart';

/// * RouterRefreshListenable
///
/// Bridges authentication status, onboarding state, and an internal
/// splash delay into a single [Listenable] used by GoRouter.
class RouterRefreshListenable extends ChangeNotifier {
  RouterRefreshListenable({
    required this.authState,
    required this.onboardingService,
    required this.permissionsCoordinator,
    required this.mapWarmupCoordinator,
  }) {
    // * Listen to all reactive sources that affect routing.
    authState.addListener(_onSourceChanged);
    onboardingService.addListener(_onSourceChanged);
    permissionsCoordinator.addListener(_onSourceChanged);
    mapWarmupCoordinator.addListener(_onSourceChanged);

    // * Ensure the splash is visible for at least [SplashConfig.initialDelay]
    //   even if auth/onboarding resolve instantly.
    Future<void>.delayed(SplashConfig.initialDelay, () {
      _splashDelayElapsed = true;
      printC('${RouterLogTags.router} splash delay elapsed ⏱');
      notifyListeners();
    });
  }

  final AuthStateNotifier authState;
  final OnboardingService onboardingService;
  final PermissionsCoordinator permissionsCoordinator;
  final StartupMapWarmupCoordinator mapWarmupCoordinator;

  bool _splashDelayElapsed = false;
  int _refreshTick = 0;

  bool get splashDelayElapsed => _splashDelayElapsed;
  bool get mapWarmupFinished => mapWarmupCoordinator.isWarmupFinished;

  void _onSourceChanged() {
    _refreshTick++;
    printM(
      '${RouterLogTags.router} refresh #$_refreshTick '
      'status=${authState.authStatus.status} '
      'isGuest=${authState.isGuest} '
      'splashDelayElapsed=$_splashDelayElapsed '
      'mapWarmupFinished=$mapWarmupFinished '
      'mapWarmupState=${mapWarmupCoordinator.state.name}',
    );
    notifyListeners();
  }

  @override
  void dispose() {
    authState.removeListener(_onSourceChanged);
    onboardingService.removeListener(_onSourceChanged);
    permissionsCoordinator.removeListener(_onSourceChanged);
    mapWarmupCoordinator.removeListener(_onSourceChanged);
    super.dispose();
  }
}

/// * AppRouterConfig
///
/// High-level configuration object that owns the [GoRouter] instance and
/// wires together:
/// - [RouterRefreshListenable]
/// - [AppRouteRegistry]
/// - [AppRouteGuard]
@lazySingleton
class AppRouterConfig {
  AppRouterConfig(
    this._authState,
    this._onboardingService,
    this._permissionsCoordinator,
    this._mapWarmupCoordinator,
    this._routeRegistry,
  ) {
    _refresh = RouterRefreshListenable(
      authState: _authState,
      onboardingService: _onboardingService,
      permissionsCoordinator: _permissionsCoordinator,
      mapWarmupCoordinator: _mapWarmupCoordinator,
    );

    _guard = AppRouteGuard(
      authState: _authState,
      onboardingService: _onboardingService,
      permissionsCoordinator: _permissionsCoordinator,
      splashPath: SplashScreen.pagePath,
      permissionPath: PermissionGateScreen.pagePath,
      onboardingPath: OnboardingScreen.pagePath,
      loginPath: LoginScreen.pagePath,
      rootPath: RootScreen.pagePath,
      profileSetupPath: ProfileSetupScreen.pagePath,
    );

    _router = GoRouter(
      // * Initial route is the splash screen.
      initialLocation: SplashScreen.pagePath,
      routes: _routeRegistry.routes,
      refreshListenable: _refresh,
      redirect: (context, state) => _guard.handleRedirect(
        state: state,
        splashDelayElapsed: _refresh.splashDelayElapsed,
        mapWarmupFinished: _refresh.mapWarmupFinished,
      ),
      errorPageBuilder: (context, state) {
        printY(
          '${RouterLogTags.redirect} unmatched route '
          'location="${state.uri}" -> splash fallback',
        );
        return AppPageTransitions.build(
          state: state,
          child: const SplashScreen(),
        );
      },
    );
  }

  final AuthStateNotifier _authState;
  final OnboardingService _onboardingService;
  final PermissionsCoordinator _permissionsCoordinator;
  final StartupMapWarmupCoordinator _mapWarmupCoordinator;
  final AppRouteRegistry _routeRegistry;

  late final RouterRefreshListenable _refresh;
  late final AppRouteGuard _guard;
  late final GoRouter _router;

  GoRouter get router => _router;
}

/// * AppRouteGuard
///
/// Isolated class that owns all redirect / guard logic for the router so
/// the rules stay in one focused place instead of being spread across
/// multiple functions.
class AppRouteGuard {
  AppRouteGuard({
    required this.authState,
    required this.onboardingService,
    required this.permissionsCoordinator,
    required this.splashPath,
    required this.permissionPath,
    required this.onboardingPath,
    required this.loginPath,
    required this.rootPath,
    required this.profileSetupPath,
  });

  final AuthStateNotifier authState;
  final OnboardingService onboardingService;
  final PermissionsCoordinator permissionsCoordinator;
  final String splashPath;
  final String permissionPath;
  final String onboardingPath;
  final String loginPath;
  final String rootPath;
  final String profileSetupPath;

  int _redirectCycleCounter = 0;

  bool _isStaleCycle(int cycleId) => cycleId != _redirectCycleCounter;

  /// Internal onboarding guard result so we can explicitly block auth checks
  /// while onboarding is still incomplete.
  ({String? redirect, bool blockAuth}) _onboardingOutcome({
    required String? redirect,
    required bool blockAuth,
  }) => (redirect: redirect, blockAuth: blockAuth);

  /// * Central route-guard / redirect logic.
  ///
  /// Rules:
  /// - While status is [Status.initial] OR splash delay not elapsed → stay on
  ///   splash.
  /// - If onboarding enabled and not finished → go to onboarding.
  /// - After onboarding:
  ///   - If auth enabled:
  ///     - unauthenticated → login
  ///     - authenticated → root
  ///   - If auth disabled → root
  FutureOr<String?> handleRedirect({
    required GoRouterState state,
    required bool splashDelayElapsed,
    required bool mapWarmupFinished,
  }) async {
    final cycleId = ++_redirectCycleCounter;

    final currentPath = state.matchedLocation;
    final initialStatus = authState.authStatus.status;
    final initialGuest = authState.isGuest;

    printM(
      '${RouterLogTags.redirect} #$cycleId start '
      'currentPath="$currentPath" '
      'status=$initialStatus isGuest=$initialGuest '
      'splashDelayElapsed=$splashDelayElapsed '
      'mapWarmupFinished=$mapWarmupFinished',
    );

    // 1) Splash / initial state.
    final splashRedirect = _handleSplash(
      currentPath: currentPath,
      status: initialStatus,
      splashDelayElapsed: splashDelayElapsed,
      mapWarmupFinished: mapWarmupFinished,
    );
    if (splashRedirect != null) {
      printC(
        '${RouterLogTags.redirect} #$cycleId decision -> "$splashRedirect" '
        '(splash gate)',
      );
      return splashRedirect;
    }

    // Important: while splash is still active (delay not elapsed OR auth status
    // still bootstrapping), we must NOT run onboarding/auth redirects.
    // Otherwise GoRouter can immediately redirect away from the splash route
    // before the first frame is painted, making the splash appear to never show.
    if (!splashDelayElapsed ||
        initialStatus == Status.initial ||
        !mapWarmupFinished) {
      printC(
        '${RouterLogTags.redirect} #$cycleId decision -> stay '
        '(waiting splash/auth bootstrap/map warmup)',
      );
      return null;
    }

    // 2) Onboarding.
    final onboardingOutcome = await _handleOnboarding(currentPath, cycleId);
    if (_isStaleCycle(cycleId)) {
      printY(
        '${RouterLogTags.redirect} #$cycleId stale after onboarding gate, drop decision',
      );
      return null;
    }
    if (onboardingOutcome.redirect != null) {
      printC(
        '${RouterLogTags.redirect} #$cycleId decision -> "${onboardingOutcome.redirect}" '
        '(onboarding gate)',
      );
      return onboardingOutcome.redirect;
    }

    if (onboardingOutcome.blockAuth) {
      printC(
        '${RouterLogTags.redirect} #$cycleId decision -> stay '
        '(onboarding pending, permission/auth gate blocked)',
      );
      return null;
    }

    // 3) Permission Gate.
    final permissionOutcome = await _handlePermissionGate(currentPath, cycleId);
    if (_isStaleCycle(cycleId)) {
      printY(
        '${RouterLogTags.redirect} #$cycleId stale after permission gate, drop decision',
      );
      return null;
    }
    if (permissionOutcome.redirect != null) {
      printC(
        '${RouterLogTags.redirect} #$cycleId decision -> "${permissionOutcome.redirect}" '
        '(permission gate)',
      );
      return permissionOutcome.redirect;
    }

    if (permissionOutcome.blockAuth) {
      printC(
        '${RouterLogTags.redirect} #$cycleId decision -> stay '
        '(permission pending, auth gate blocked)',
      );
      return null;
    }

    final latestStatus = authState.authStatus.status;
    final latestGuest = authState.isGuest;
    final latestAuthenticated =
        latestStatus == Status.authenticated && !latestGuest;
    final canEnterApp = latestAuthenticated || latestGuest;

    printM(
      '${RouterLogTags.redirect} #$cycleId auth snapshot '
      'status=$latestStatus isGuest=$latestGuest canEnterApp=$canEnterApp',
    );

    final authRedirect = _handleAuth(
      currentPath: currentPath,
      canEnterApp: canEnterApp,
      cycleId: cycleId,
    );
    if (authRedirect != null) {
      printG('${RouterLogTags.redirect} #$cycleId decision -> "$authRedirect"');
      return authRedirect;
    }

    // 5) Profile Setup.
    final profileRedirect = _handleProfileSetup(
      currentPath: currentPath,
      isAuthenticated: latestAuthenticated,
    );
    if (profileRedirect != null) {
      printG('${RouterLogTags.redirect} #$cycleId decision -> "$profileRedirect" (profile-gate)');
      return profileRedirect;
    }

    printG(
      '${RouterLogTags.redirect} #$cycleId decision -> stay on "$currentPath"',
    );
    return null;
  }

  String? _handleSplash({
    required String currentPath,
    required Status status,
    required bool splashDelayElapsed,
    required bool mapWarmupFinished,
  }) {
    if (!splashDelayElapsed || status == Status.initial || !mapWarmupFinished) {
      if (currentPath != splashPath) {
        printC(
          '${RouterLogTags.redirect} → splash '
          '(bootstrapping/map warmup gate)',
        );
        return splashPath;
      }
      return null;
    }
    return null;
  }

  Future<({String? redirect, bool blockAuth})> _handlePermissionGate(
    String currentPath,
    int cycleId,
  ) async {
    if (!AppFlowConfig.permissionGateEnabled) {
      return (redirect: null, blockAuth: false);
    }

    try {
      final hasForegroundPermission = await permissionsCoordinator
          .isForegroundLocationGranted();

      printM(
        '${RouterLogTags.redirect} #$cycleId permission '
        'foregroundGranted=$hasForegroundPermission currentPath="$currentPath"',
      );

      if (!hasForegroundPermission) {
        if (currentPath != permissionPath) {
          printC(
            '${RouterLogTags.redirect} #$cycleId -> permission-gate (location required)',
          );
          return (redirect: permissionPath, blockAuth: true);
        }
        return (redirect: null, blockAuth: true);
      }

      return (redirect: null, blockAuth: false);
    } catch (e) {
      printY('${RouterLogTags.redirect} #$cycleId permission gate error: $e');
      return (redirect: null, blockAuth: false);
    }
  }

  Future<({String? redirect, bool blockAuth})> _handleOnboarding(
    String currentPath,
    int cycleId,
  ) async {
    if (!AppFlowConfig.onboardingEnabled) {
      return _onboardingOutcome(redirect: null, blockAuth: false);
    }

    final finished = await onboardingService.isOnboardingFinished();
    printM(
      '${RouterLogTags.redirect} #$cycleId onboarding '
      'finished=$finished currentPath="$currentPath"',
    );

    if (!finished) {
      if (currentPath != onboardingPath) {
        printC(
          '${RouterLogTags.redirect} #$cycleId -> onboarding (not finished)',
        );
        return _onboardingOutcome(redirect: onboardingPath, blockAuth: true);
      }
      return _onboardingOutcome(redirect: null, blockAuth: true);
    }

    // Onboarding is finished but user is still on the onboarding page.
    // Fall through to auth redirects so the router moves them forward.
    return _onboardingOutcome(redirect: null, blockAuth: false);
  }

  String? _handleAuth({
    required String currentPath,
    required bool canEnterApp,
    required int cycleId,
  }) {
    if (!AppFlowConfig.authEnabled) {
      if (currentPath != rootPath) {
        printG('${RouterLogTags.redirect} #$cycleId auth disabled -> root');
        return rootPath;
      }
      return null;
    }

    if (!canEnterApp) {
      if (currentPath != loginPath) {
        printY('${RouterLogTags.redirect} #$cycleId unauthenticated -> login');
        return loginPath;
      }
      return null;
    }

    if (currentPath == splashPath ||
        currentPath == permissionPath ||
        currentPath == loginPath ||
        currentPath == onboardingPath) {
      // * Check profile setup BEFORE returning rootPath.
      final profileRedirect = _handleProfileSetup(
        currentPath: currentPath,
        isAuthenticated: true,
      );
      if (profileRedirect != null) {
        printG('${RouterLogTags.redirect} #$cycleId authenticated -> $profileRedirect (profile gate)');
        return profileRedirect;
      }

      printG('${RouterLogTags.redirect} #$cycleId authenticated -> root');
      return rootPath;
    }

    return null;
  }

  String? _handleProfileSetup({
    required String currentPath,
    required bool isAuthenticated,
  }) {
    if (!isAuthenticated) return null;

    final user = authState.user;
    final hasName = user?.name != null && user!.name!.isNotEmpty;

    if (!hasName) {
      if (currentPath != profileSetupPath) {
        return profileSetupPath;
      }
      return null;
    }

    if (currentPath == profileSetupPath) {
      return rootPath;
    }

    return null;
  }
}
