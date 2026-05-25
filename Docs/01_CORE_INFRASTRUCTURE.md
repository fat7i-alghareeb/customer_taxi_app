# Flutter App - Core Infrastructure Analysis

This document details the first phase of our deep dive into the Flutter customer taxi application (`customertaxi`), focusing on the `lib/core`, bootstrapping, and configuration layers.

## 1. App Bootstrapping (`main.dart` & `bootstrap.dart`)

The application avoids logic in `main.dart`, strictly delegating to `bootstrap.dart` to manage a deterministic initialization sequence inside a `runZonedGuarded` block.

**Initialization Sequence:**
1. **Engine Binding:** `WidgetsFlutterBinding.ensureInitialized()` is called first.
2. **System UI:** Forces edge-to-edge mode.
3. **Flavors:** Discovers if the app is running in `stage` or `production` via native channels.
4. **Firebase:** Initializes Firebase via `DefaultFirebaseOptions`.
5. **Dependency Injection:** Invokes `configureDependencies()` (Injectable/GetIt).
6. **Notifications:** Wires up `NotificationCoordinator` (delayed prompt).
7. **Localization:** Boots `EasyLocalization`.
8. **Theme & UI:** Initializes `ThemeController`.
9. **Auth & Networking:** Invokes `AuthManager.initialize()`. This reads JWTs from local storage so the global `Dio` client is authenticated immediately.
10. **Client Config:** Fetches settings (like Stripe Publishable Key) via `ClientConfigService`.
11. **Realtime:** Boots `RealtimeLifecycleCoordinator` to manage SignalR lifecycle based on app focus and auth status.
12. **Guarded App Run:** Wraps the root `App` widget in `EasyLocalization` and `ScreenUtilInit` for responsive sizing.

## 2. Dependency Injection (`injectable.dart`)

The app uses `get_it` combined with `injectable`.
- Global instance: `final GetIt getIt = GetIt.instance;`
- Primitives (like `StorageService` or `ObjectBoxService`) are registered manually or via `@preResolve` modules.
- The rest of the app relies on `@lazySingleton` or `@injectable`.

## 3. Navigation & Routing (`router_config.dart`)

The application uses `go_router` combined with a sophisticated guard system.

- **`AppRouterConfig`**: Owns the `GoRouter` instance.
- **`RouterRefreshListenable`**: A custom `ChangeNotifier` that triggers router re-evaluations. It listens to:
  - `AuthStateNotifier`
  - `OnboardingService`
  - `PermissionsCoordinator`
  - `StartupMapWarmupCoordinator`
  - It also enforces a minimum splash duration (`SplashConfig.initialDelay`).
- **`AppRouteGuard`**: The absolute source of truth for redirects. It evaluates state linearly:
  1. Blocks transitions if splash delay is incomplete or map is warming up.
  2. Redirects to Onboarding if incomplete.
  3. Redirects to Permission Gate (Location) if required.
  4. Redirects to Login if unauthenticated.
  5. Redirects to Profile Setup if authenticated but name is missing.
  6. Allows entry to `RootScreen` only if all above gates are cleared.

## 4. Authentication (`auth_manager.dart` & `auth_state_notifier.dart`)

The app cleanly separates the *manager* from the *reactive state*.

- **`AuthStateNotifier`**: A pure `ChangeNotifier` holding the current `UserEntity`, `isGuest` flag, and `AuthStatus`. It acts as the reactive source of truth for the UI and Router.
- **`AuthManager`**: Exposes the imperative API (`login()`, `logout()`, `continueAsGuest()`). It orchestrates saving user JSON to `StorageService` and saving the JWT to `JwtTokenStorage`. It also pipes the token stream from `dio_refresh_bot` directly into the `AuthStateNotifier`.

## 5. Networking Pipeline (`dio_client.dart`)

The API layer uses `Dio` and is built purely through functional composition in `createDioClient()`.

**Interceptor Pipeline:**
1. **`MemoryAwareInterceptor`**: Guards against extremely large payloads crashing the app (likely checking `Content-Length`).
2. **`RefreshTokenInterceptor` (`dio_refresh_bot`)**:
   - Intercepts 401s and token expiration.
   - Attaches `Authorization: Bearer <token>` to requests.
   - Uses a secondary `tokenDio` to hit `ApiEndpoints.refreshToken` transparently.
   - On refresh failure (or revoked token), triggers `authManager.logout()`.
3. **`LocalizationInterceptor`**: Injects headers based on the current locale and timezone.
4. **`CustomDioInterceptor`**: Beautiful terminal logging for debugging (only in `kDebugMode`).
5. **`ErrorInterceptor`**: Catches all Dio exceptions and maps them into custom domain `AppException` types.

## 6. Local Persistence (`objectbox_service.dart`)

The app uses `ObjectBox` for high-performance local storage (NOSQL).
- Avoids manual `SharedPreferences` for complex objects.
- Uses a singleton `Store` injected via `ObjectBoxService`.
- Exposes data via `ObjectBoxDao<T>`, wrapping generic CRUD (`findFirst`, `put`, `watchQuery`).
- Enforces Clean Architecture: Domain entities are annotated with `@Entity()` and `@Id(objId)`, meaning the same entity can be used for API models and local storage without complex mappers, provided they include the internal `objId`.

---
*End of Phase 2.1 Analysis. Next: Phase 2.2 - Design System & Common UI Layer.*
