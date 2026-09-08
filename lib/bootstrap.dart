import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart'
    show SystemChrome, SystemUiMode, appFlavor;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'core/config/localization_config.dart';
import 'features/trip/presentation/coordinators/trip_completion_coordinator.dart';
import 'features/payment/presentation/states/wallet_cubit.dart';
import 'features/payment/presentation/ui/screens/betaling_screen.dart';
import 'features/trip/presentation/states/active_trip_cubit.dart';
import 'features/trip/presentation/ui/widgets/waiting_fee_settlement_flow.dart';
import 'firebase_options.dart';
import 'core/injection/injectable.dart';
import 'core/notification/notification_config.dart';
import 'core/notification/notification_coordinator.dart';
import 'core/notification/notification_init_options.dart';
import 'core/notification/notification_payload.dart';
import 'core/notification/notification_topics.dart';
import 'core/router/router_config.dart';
import 'core/services/app_version/app_version_gate_coordinator.dart';
import 'core/services/bootstrap_config/bootstrap_config_service.dart';
import 'core/services/app_version/app_version_service.dart';
import 'core/services/localization/locale_service.dart';
import 'core/services/media/media_picker_service.dart';
import 'core/services/realtime/realtime_lifecycle_coordinator.dart';
import 'core/services/session/auth_manager.dart';
import 'core/services/session/auth_state_notifier.dart';
import 'package:customertaxi/core/utils/result.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/chat/presentation/ui/screens/trip_chat_screen.dart';
import 'features/root/presentation/ui/screens/root_screen.dart';
import 'features/trip/presentation/states/trip_bloc.dart';
import 'core/theme/theme_controller.dart';
import 'common/widgets/stage_tools/stage_device_preview_controller.dart';
import 'flavors.dart' show F, Flavor;
import 'utils/constants/design_constants.dart';
import 'utils/helpers/startup_trace.dart';
import 'utils/helpers/colored_print.dart';

/// Common bootstrap entry point used by all flavors.
///
/// This function wires together all low-level initialization steps:
///
/// - Ensures Flutter bindings are initialized.
/// - Initializes EasyLocalization's core infrastructure.
/// - Configures dependency injection via Injectable / GetIt.
/// - Prepares the [AuthManager] and global Dio client.
/// - Resolves the initial locale using [LocaleService].
/// - Runs the provided widget tree inside a guarded zone with
///   EasyLocalization and the active [Flavor].
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // Important: keep `ensureInitialized` and `runApp` inside the same zone.
  await runZonedGuarded<Future<void>>(
    () async {
      //    Ensure Flutter engine + widget binding are ready before any
      //    plugins or framework APIs are used.
      StartupTrace.begin();
      WidgetsFlutterBinding.ensureInitialized();
      StartupTrace.mark('binding');
      if (defaultTargetPlatform == TargetPlatform.android) {
        // Cosmetic and slow on some OEMs — must not hold the native splash open.
        unawaited(
          FlutterDisplayMode.setHighRefreshRate().catchError(
            (Object e) => printY('[Bootstrap] setHighRefreshRate failed: $e'),
          ),
        );
      }
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      // The picker is not reachable until the user opens one, so it does not
      // need to block the first frame.
      unawaited(appMediaPickerService.initialize());

      // Select the active flavor (stage / production) based on the
      // compile-time value provided by the native layer. Defaults to
      // production so a build made without --flavor never ships the stage
      // dev-tools overlay.
      F.appFlavor = Flavor.values.firstWhere(
        (element) => element.name == appFlavor,
        orElse: () => Flavor.production,
      );

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      StartupTrace.mark('firebase');

      await configureDependencies();
      StartupTrace.mark('di');

      if (F.appFlavor == Flavor.stage) {
        if (!getIt.isRegistered<StageDevicePreviewController>()) {
          getIt.registerSingleton<StageDevicePreviewController>(
            StageDevicePreviewController(getIt()),
          );
        }
        await getIt<StageDevicePreviewController>().load();
      }

      // Permission dialog + FCM init/subscribe/getToken round trips used to sit
      // here awaited, adding ~4s to the native splash for nothing the first
      // frame needs. Fired and forgotten instead — same treatment already
      // applied to _syncAccountStateInBackground below. Notification taps that
      // arrive before this finishes are still handled: they come through
      // onNotificationTap/onForegroundNotification, which are only wired up
      // once this completes, and a cold-start tap is replayed via
      // getInitialMessage() inside it regardless of timing.
      unawaited(_initializeNotifications());
      StartupTrace.mark('notifications');

      // Three independent disk reads that used to run in series. They must
      // still come after configureDependencies() — the latter two resolve from
      // getIt — but nothing orders them against each other.
      await Future.wait<void>([
        EasyLocalization.ensureInitialized(),
        getIt<ThemeController>().initialize(),
        _initializeAuthAndNetwork(),
      ]);
      StartupTrace.mark('localization+theme+auth');

      unawaited(_syncAccountStateInBackground());

      StartupTrace.mark('account-sync');

      _startConfigFetchesInBackground();
      StartupTrace.mark('config-dispatch');

      await _initializeAppVersionGate();
      StartupTrace.mark('version-gate');

      _initializeRealtime();
      StartupTrace.mark('realtime');

      final initialLocale = await getIt<LocaleService>().resolveInitialLocale();
      StartupTrace.mark('locale');

      await _runGuardedApp(builder, initialLocale);
      StartupTrace.mark('runApp');
    },
    (error, stackTrace) {
      // Last-resort safety net for any exceptions that happen outside
      // of Flutter's normal error handling pipeline.
      log('Uncaught application error', error: error, stackTrace: stackTrace);
    },
  );
}

/// Initializes notifications.
///
/// Note:
/// - Firebase/FCM initialization is controlled by [NotificationInitOptions]
///   passed to [NotificationCoordinator.initialize].
Future<void> _initializeNotifications() async {
  try {
    final coordinator = getIt<NotificationCoordinator>();

    await coordinator.initialize(
      config: AppNotificationConfig.defaults(),
      options: const NotificationInitOptions(initializeFirebase: false),
      onNotificationTap: (payload) async {
        await _handleNotificationNavigation(payload);
      },
      onForegroundNotification: (payload) async {
        // Chat messages: the coordinator already showed the local banner and the
        // open chat updates live over SignalR — nothing else to route.
        if (_typeFromPayload(payload) == 'chat_message') {
          return;
        }
        // FCM already displays the foreground banner. SignalR/this callback
        // only refreshes authoritative trip state; it must not show a second overlay.
        _routeTripPayloadToBloc(payload);
      },
      onTokenRefresh: (token) async {
        await coordinator.subscribeToTopics(const [
          NotificationTopics.customers,
        ]);

        final authState = getIt<AuthStateNotifier>();
        if (authState.isAuthenticated) {
          try {
            final authRepo = getIt<AuthRepository>();
            await authRepo.updateFcmToken(token);
            printG('[Bootstrap] Dynamic FCM token refresh SUCCESS');
          } catch (e) {
            printY('[Bootstrap] Dynamic FCM token refresh failed: $e');
          }
        }
      },
    );

    printG('[Bootstrap] Notifications initialized');
  } catch (e) {
    printY('[Bootstrap] Notifications initialize failed: $e');
  }
}

Future<void> _handleNotificationNavigation(
  AppNotificationPayload payload,
) async {
  // Trip completed push tapped while the app was backgrounded/closed (SignalR
  // was disconnected). Route through the same coordinator so its de-dupe set is
  // shared with the realtime path and the rating sheet shows at most once.
  if (_typeFromPayload(payload) == 'trip_completed') {
    final completedTripId = _tripIdFromPayload(payload);
    if (completedTripId != null) {
      await getIt<TripCompletionCoordinator>().promptRatingForTrip(
        completedTripId,
      );
    } else {
      _navigateTo(RootScreen.pagePath);
    }
    return;
  }

  // A fee was charged to the wallet as debt. It is settled against the trip, so the per-trip
  // settlement sheet has nothing to collect — the money is owed on the account now. Send them
  // to the wallet, which is also where the booking block is explained.
  if (_typeFromPayload(payload) == 'wallet_debt') {
    unawaited(getIt<WalletCubit>().refresh());
    _navigateTo(BetalingScreen.pagePath);
    return;
  }

  // Outstanding waiting fee — open the on-session settlement sheet for the trip.
  if (_typeFromPayload(payload) == 'waiting_fee_due') {
    final feeTripId = _tripIdFromPayload(payload);
    _navigateTo(RootScreen.pagePath);
    if (feeTripId != null) {
      final context = getIt<AppRouterConfig>()
          .router
          .routerDelegate
          .navigatorKey
          .currentContext;
      if (context != null && context.mounted) {
        await showWaitingFeeSettlement(context, tripId: feeTripId);
      }
    }
    return;
  }

  // Chat message tapped — open the active trip so the user can read/reply.
  if (_typeFromPayload(payload) == 'chat_message') {
    final chatTripId = _tripIdFromPayload(payload);
    if (chatTripId != null) _routeTripPayloadToBloc(payload);
    if (chatTripId != null) {
      await _navigateToChatWhenReady(chatTripId);
    }
    return;
  }

  // If the payload carries a trip id, push it into the bloc so the trip is
  // loaded and the staged sheet renders in the correct stage.
  final tripId = _tripIdFromPayload(payload);
  if (tripId != null) {
    _routeTripPayloadToBloc(payload);
  }

  // Prefer an explicit deep-link if the backend supplied one; otherwise
  // fall back to the root screen when we only have a trip id; otherwise no-op.
  final explicitLocation = payload.toGoRouterLocation;
  final location = (explicitLocation != null && explicitLocation.isNotEmpty)
      ? explicitLocation
      : (tripId != null ? RootScreen.pagePath : null);

  if (location == null) {
    printC('[Notifications] Tap ignored (no route/deepLink/tripId)');
    return;
  }

  _navigateTo(location);
}

Future<void> _navigateToChatWhenReady(String tripId) async {
  for (var attempt = 0; attempt < 30; attempt++) {
    final authState = getIt<AuthStateNotifier>();
    final router = getIt<AppRouterConfig>().router;
    if (authState.isAuthenticated &&
        router.routerDelegate.navigatorKey.currentContext != null) {
      // push, not go: keeps whatever the user was on underneath so closing the
      // chat returns there. On a cold start the stack is still splash-only, so
      // the screen's safePop fallback covers that case.
      router.pushNamed(
        TripChatScreen.pageName,
        extra: TripChatScreenArgs(tripId: tripId),
      );
      return;
    }
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
  _navigateTo(RootScreen.pagePath);
}

/// If [payload] carries a `tripId`, ask the singleton [TripBloc] to start
/// streaming it so the active trip surface updates immediately. Called from
/// both the tap handler and the foreground push handler.
void _routeTripPayloadToBloc(AppNotificationPayload payload) {
  final tripId = _tripIdFromPayload(payload);
  if (tripId == null) return;
  try {
    getIt<TripBloc>().add(TripEvent.started(tripId));
    printG('[Notifications] Trip arrival routed to bloc tripId=$tripId');
  } catch (e) {
    printY('[Notifications] Trip routing failed: $e');
  }
}

String? _typeFromPayload(AppNotificationPayload payload) {
  final raw = payload.data['type'] ?? payload.data['Type'];
  if (raw is String && raw.trim().isNotEmpty) return raw.trim().toLowerCase();
  return null;
}

void _navigateTo(String location) {
  try {
    final router = getIt<AppRouterConfig>().router;
    router.go(location);
    printG('[Notifications] Navigated to $location');
  } catch (e) {
    printY('[Notifications] Navigation failed: $e (location=$location)');
  }
}

String? _tripIdFromPayload(AppNotificationPayload payload) {
  final raw =
      payload.data['tripId'] ??
      payload.data['TripId'] ??
      payload.data['trip_id'];
  if (raw is String && raw.trim().isNotEmpty) return raw;
  if (raw != null) {
    final asString = raw.toString();
    if (asString.trim().isNotEmpty) return asString;
  }
  return null;
}

/// Initializes the authentication layer and HTTP client.
///
/// Responsibilities:
/// - Creates and registers a single [AuthManager] instance.
/// - Awaits [AuthManager.initialize] so user/guest and token state are
///   loaded before the UI starts.
/// - Creates and registers a global Dio client so repositories can perform
///   network calls immediately.
/// Pushes the device's FCM token and preferred language up to the backend.
///
/// Two one-way syncs that nothing on the first frame depends on. They used to be
/// awaited inside [bootstrap], which put a Firebase `getToken()` round trip plus
/// two of our own POSTs directly on the critical path — and therefore inside the
/// native splash. Now fired and forgotten; failures are logged, never surfaced.
Future<void> _syncAccountStateInBackground() async {
  final authState = getIt<AuthStateNotifier>();
  if (authState.isAuthenticated) {
    try {
      final coordinator = getIt<NotificationCoordinator>();
      final token = await coordinator.getDeviceToken();
      if (token != null && token.isNotEmpty) {
        final authRepo = getIt<AuthRepository>();
        final result = await authRepo.updateFcmToken(token);
        result.when(
          success: (_) =>
              printG('[Bootstrap] Startup backup FCM token update SUCCESS'),
          failure: (msg) => printY(
            '[Bootstrap] Startup backup FCM token update failed: $msg',
          ),
        );
      }
    } catch (e) {
      printY('[Bootstrap] Startup backup FCM token update failed: $e');
    }

    // Re-verify if still authenticated (FCM sync or token refresh could have triggered logout)
    if (authState.isAuthenticated) {
      try {
        final localeService = getIt<LocaleService>();
        final code = await localeService.currentLanguageCode();
        final authRepo = getIt<AuthRepository>();
        final result = await authRepo.updatePreferredLanguage(code);
        result.when(
          success: (_) => printG(
            '[Bootstrap] Startup backup language update SUCCESS: $code',
          ),
          failure: (msg) => printY(
            '[Bootstrap] Startup backup language update failed: $msg',
          ),
        );
      } catch (e) {
        printY('[Bootstrap] Startup backup language update failed: $e');
      }
    }
  }
}

Future<void> _initializeAuthAndNetwork() async {
  final authManager = getIt<AuthManager>();
  await authManager.initialize();
}

/// Kicks off the single combined startup fetch without waiting on it.
///
/// One request replaces three (client config, support contact, version gate).
/// Nothing here blocks the first frame; consumers that need the config call
/// `ClientConfigService.ensureReady()`, and the update gate re-evaluates once
/// the payload lands.
void _startConfigFetchesInBackground() {
  unawaited(
    getIt<BootstrapConfigService>().fetchAll().then(
      (_) => getIt<AppVersionGateCoordinator>().evaluate(),
    ),
  );
}

/// Resolves the update verdict from the on-disk cache.
///
/// Only the cached read is awaited. It is a SharedPreferences lookup that is
/// already in memory, so the gate is decided in about a millisecond and startup
/// never waits on a network round trip for it.
///
/// The refresh arrives via [_startConfigFetchesInBackground], which re-evaluates
/// the coordinator once the combined payload lands. When it does, the coordinator
/// notifies `RouterRefreshListenable` and the guard re-runs, so a config change
/// still applies within the same session.
///
/// The one behavioural cost: on the very first launch after install there is no
/// cache, so a user who should be force-blocked gets a moment of the app before
/// the wall appears. The block still lands.
Future<void> _initializeAppVersionGate() async {
  await getIt<AppVersionService>().loadCached();
  await getIt<AppVersionGateCoordinator>().evaluate();
}

/// Starts the realtime coordinator.
///
/// The coordinator owns the SignalR connection lifecycle: it subscribes to
/// [AuthManager.authStatusStream] (connect on authenticated, disconnect on
/// unauthenticated) and to [WidgetsBindingObserver] (pause/resume with the
/// app). Gated by `ClientConfig.signalREnabled`.
void _initializeRealtime() {
  getIt<RealtimeLifecycleCoordinator>().start();
  // Listens for TripCompleted to open the rating sheet globally.
  getIt<TripCompletionCoordinator>().start();
  // Resolves the passenger's active trip so the Home tab can resume it and join
  // its realtime channel.
  getIt<ActiveTripCubit>().start();
  // Tracks the wallet balance app-wide so an outstanding debt is visible and enforced
  // wherever the customer is, not only on the wallet screen.
  getIt<WalletCubit>().start();
}

/// Runs the application inside a guarded zone and wraps it with
/// [EasyLocalization].
///
/// Parameters:
/// - [builder]: Factory that constructs the root widget tree.
/// - [initialLocale]: Locale that should be used as the starting
///   locale for the app.
///
/// This function also assigns the current [Flavor] based on the
/// native `appFlavor` and logs any uncaught errors via [log].
Future<void> _runGuardedApp(
  FutureOr<Widget> Function() builder,
  Locale initialLocale,
) async {
  // Build the actual root widget tree provided by the caller.
  final app = await builder();

  // Wrap the root app with EasyLocalization and ScreenUtil so that:
  // - Localized strings are available everywhere.
  // - The app starts with the resolved [initialLocale].
  // - Responsive sizing via ScreenUtil is available globally.
  final localizedApp = EasyLocalization(
    supportedLocales: AppLocalizationConfig.supportedLanguageCodes
        .map((code) => Locale(code))
        .toList(),
    path: AppLocalizationConfig.translationsPath,
    fallbackLocale: const Locale(AppLocalizationConfig.fallbackLanguageCode),
    startLocale: initialLocale,
    saveLocale: false,
    useOnlyLangCode: true,
    child: ScreenUtilInit(
      designSize: AppDesign.designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      fontSizeResolver: (fontSize, instance) {
        final width = instance.screenWidth;
        //TODO make this logic const to be used in any other plce the width values i mean
        double factor;
        if (width <= 320) {
          factor = 0.9;
        } else if (width <= 360) {
          factor = 0.95;
        } else if (width <= 400) {
          factor = 1.0;
        } else if (width <= 480) {
          factor = 1.05;
        } else {
          factor = 1.1;
        }

        return fontSize * factor;
      },
      builder: (context, _) => app,
    ),
  );

  // The first painted frame is when the OS finally drops the native splash, so
  // this mark is the number the whole startup budget is measured against.
  WidgetsBinding.instance.addPostFrameCallback(
    (_) => StartupTrace.markFirstFrame(),
  );

  // Finally render the localized app tree.
  runApp(localizedApp);
}
