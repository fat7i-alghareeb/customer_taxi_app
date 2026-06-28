part of 'router_config.dart';

/// * AppRouteRegistry
///
/// Single-responsibility class that knows how to register all core
/// app routes. Screen-specific files will eventually expose their own
/// static `routePath` / `routeName` and this registry will simply
/// reference them.
@lazySingleton
class AppRouteRegistry {
  const AppRouteRegistry();

  /// * All GoRouter routes for the app.
  List<GoRoute> get routes => [
    GoRoute(
      path: SplashScreen.pagePath,
      name: SplashScreen.pageName,
      pageBuilder: (context, state) =>
          AppPageTransitions.build(state: state, child: const SplashScreen()),
    ),
    GoRoute(
      path: OnboardingScreen.pagePath,
      name: OnboardingScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const OnboardingScreen(),
      ),
    ),
    GoRoute(
      path: PermissionGateScreen.pagePath,
      name: PermissionGateScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const PermissionGateScreen(),
      ),
    ),
    GoRoute(
      path: LoginScreen.pagePath,
      name: LoginScreen.pageName,
      pageBuilder: (context, state) =>
          AppPageTransitions.build(state: state, child: const LoginScreen()),
    ),
    GoRoute(
      path: RootScreen.pagePath,
      name: RootScreen.pageName,
      pageBuilder: (context, state) {
        final initialTab = state.extra is RootTab
            ? state.extra as RootTab
            : null;
        return AppPageTransitions.build(
          state: state,
          child: RootScreen(initialTab: initialTab),
        );
      },
    ),
    GoRoute(
      path: AboutUsScreen.pagePath,
      name: AboutUsScreen.pageName,
      pageBuilder: (context, state) =>
          AppPageTransitions.build(state: state, child: const AboutUsScreen()),
    ),
    GoRoute(
      path: CancellationPolicyScreen.pagePath,
      name: CancellationPolicyScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const CancellationPolicyScreen(),
      ),
    ),
    GoRoute(
      path: PrivacyPolicyScreen.pagePath,
      name: PrivacyPolicyScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const PrivacyPolicyScreen(),
      ),
    ),
    GoRoute(
      path: TermsAndConditionsScreen.pagePath,
      name: TermsAndConditionsScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const TermsAndConditionsScreen(),
      ),
    ),
    GoRoute(
      path: ContactUsScreen.pagePath,
      name: ContactUsScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const ContactUsScreen(),
      ),
    ),
    GoRoute(
      path: ProfileSetupScreen.pagePath,
      name: ProfileSetupScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const ProfileSetupScreen(),
      ),
    ),
    GoRoute(
      path: ActiveTripScreen.pagePath,
      name: ActiveTripScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const ActiveTripScreen(),
      ),
    ),
    GoRoute(
      path: TripHistoryScreen.pagePath,
      name: TripHistoryScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const TripHistoryScreen(),
      ),
    ),
    GoRoute(
      path: TripDetailsScreen.pagePath,
      name: TripDetailsScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const TripDetailsScreen(),
      ),
    ),
    GoRoute(
      path: TripReceiptScreen.pagePath,
      name: TripReceiptScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const TripReceiptScreen(),
      ),
    ),
    GoRoute(
      path: TripInvoiceScreen.pagePath,
      name: TripInvoiceScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const TripInvoiceScreen(),
      ),
    ),
    GoRoute(
      path: TripChatScreen.pagePath,
      name: TripChatScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: TripChatScreen(args: state.extra as TripChatScreenArgs),
      ),
    ),
    GoRoute(
      path: FavoritesScreen.pagePath,
      name: FavoritesScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const FavoritesScreen(),
      ),
    ),
    GoRoute(
      path: LocationPickerScreen.pagePath,
      name: LocationPickerScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: LocationPickerScreen(
          initialLocation: state.extra as RootMapLocationEntity?,
        ),
      ),
    ),
  ];
}
