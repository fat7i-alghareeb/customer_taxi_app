import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart'
    show SystemChrome, SystemUiMode, appFlavor;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'core/config/localization_config.dart';
import 'features/trip/presentation/coordinators/trip_completion_coordinator.dart';
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
import 'core/services/client_config/client_config_service.dart';
import 'core/services/localization/locale_service.dart';
import 'core/services/media/media_picker_service.dart';
import 'core/services/realtime/realtime_lifecycle_coordinator.dart';
import 'core/services/session/auth_manager.dart';
import 'core/services/session/auth_state_notifier.dart';
import 'core/services/support_contact/support_contact_service.dart';
import 'package:customertaxi/core/utils/result.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/chat/presentation/ui/screens/trip_chat_screen.dart';
import 'features/root/presentation/ui/screens/root_screen.dart';
import 'features/trip/presentation/states/trip_bloc.dart';
import 'core/theme/theme_controller.dart';
import 'common/widgets/stage_tools/stage_device_preview_controller.dart';
import 'flavors.dart' show F, Flavor;
import 'utils/constants/design_constants.dart';
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
      WidgetsFlutterBinding.ensureInitialized();
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      await appMediaPickerService.initialize();

      // Select the active flavor (stage / production) based on the
      // compile-time value provided by the native layer.
      F.appFlavor = Flavor.values.firstWhere(
        (element) => element.name == appFlavor,
        orElse: () => Flavor.stage,
      );

      printG('[Bootstrap] initializing Firebase...');
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      printG('[Bootstrap] Firebase initialized');

      printG('[Bootstrap] configureDependencies starting...');
      await configureDependencies();
      printG('[Bootstrap] configureDependencies done');

      if (F.appFlavor == Flavor.stage) {
        if (!getIt.isRegistered<StageDevicePreviewController>()) {
          getIt.registerSingleton<StageDevicePreviewController>(
            StageDevicePreviewController(getIt()),
          );
        }
        await getIt<StageDevicePreviewController>().load();
      }

      printG('[Bootstrap] initializing notifications...');
      await _initializeNotifications();
      printG('[Bootstrap] notifications initialized');

      printG('[Bootstrap] initializing EasyLocalization...');
      await EasyLocalization.ensureInitialized();
      printG('[Bootstrap] EasyLocalization ready');

      printG('[Bootstrap] initializing ThemeController...');
      await getIt<ThemeController>().initialize();
      printG('[Bootstrap] ThemeController ready');

      printG('[Bootstrap] initializing Auth and Network...');
      await _initializeAuthAndNetwork();
      printG('[Bootstrap] Auth and Network ready');

      // Backup FCM token check on startup if authenticated
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

      printG('[Bootstrap] fetching client config...');
      await _initializeClientConfig();
      printG('[Bootstrap] client config ready');

      printG('[Bootstrap] starting realtime coordinator...');
      _initializeRealtime();
      printG('[Bootstrap] realtime coordinator started');

      printG('[Bootstrap] resolving initial locale...');
      final initialLocale = await getIt<LocaleService>().resolveInitialLocale();
      printG('[Bootstrap] initialLocale resolved: $initialLocale');

      printG('[Bootstrap] running app builder...');
      await _runGuardedApp(builder, initialLocale);
      printG('[Bootstrap] app running');
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
      router.goNamed(
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
Future<void> _initializeAuthAndNetwork() async {
  final authManager = getIt<AuthManager>();
  await authManager.initialize();
}

/// Fetches remote client config and initializes Stripe if enabled.
Future<void> _initializeClientConfig() async {
  final configService = getIt<ClientConfigService>();
  await configService.fetch();

  final config = configService.current;
  if (config.stripeEnabled && config.stripePublishableKey.isNotEmpty) {
    Stripe.publishableKey = config.stripePublishableKey;
    Stripe.merchantIdentifier = 'merchant.dev.fat7i.customertaxi';
    Stripe.urlScheme = 'customertaxi';
    await Stripe.instance.applySettings();
    printG(
      '[Bootstrap] Stripe initialized publishableKey=${config.stripePublishableKey.substring(0, 8)}…',
    );
  } else {
    printY('[Bootstrap] Stripe disabled or no publishable key — skipping init');
  }

  // Prefetch the support contact so the in-trip "Report problem" action opens
  // instantly. Failures are tolerated — the service falls back to a default.
  await getIt<SupportContactService>().fetch();
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

  // Finally render the localized app tree.
  runApp(localizedApp);
}
