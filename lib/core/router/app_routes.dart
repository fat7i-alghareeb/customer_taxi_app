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
        pageBuilder: (context, state) =>
            AppPageTransitions.build(state: state, child: const RootScreen()),
      ),
      GoRoute(
        path: AboutUsScreen.pagePath,
        name: AboutUsScreen.pageName,
        pageBuilder: (context, state) =>
            AppPageTransitions.build(state: state, child: const AboutUsScreen()),
      ),
      GoRoute(
        path: ContactUsScreen.pagePath,
        name: ContactUsScreen.pageName,
        pageBuilder: (context, state) =>
            AppPageTransitions.build(state: state, child: const ContactUsScreen()),
      ),
      GoRoute(
        path: ProfileSetupScreen.pagePath,
        name: ProfileSetupScreen.pageName,
        pageBuilder: (context, state) =>
            AppPageTransitions.build(state: state, child: const ProfileSetupScreen()),
      ),
      GoRoute(
        path: ActiveTripScreen.pagePath,
        name: ActiveTripScreen.pageName,
        pageBuilder: (context, state) =>
            AppPageTransitions.build(state: state, child: const ActiveTripScreen()),
      ),
      GoRoute(
        path: TripHistoryScreen.pagePath,
        name: TripHistoryScreen.pageName,
        pageBuilder: (context, state) =>
            AppPageTransitions.build(state: state, child: const TripHistoryScreen()),
      ),
      GoRoute(
        path: FavoritesScreen.pagePath,
        name: FavoritesScreen.pageName,
        pageBuilder: (context, state) =>
            AppPageTransitions.build(state: state, child: const FavoritesScreen()),
      ),
      GoRoute(
        path: LocationPickerScreen.pagePath,
        name: LocationPickerScreen.pageName,
        pageBuilder: (context, state) =>
            AppPageTransitions.build(state: state, child: const LocationPickerScreen()),
      ),
    ];
}
