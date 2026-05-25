# Flutter App - System Flows & Orchestration

This document details Phase 2.5 of our deep dive into the Flutter customer taxi application (`customertaxi`), focusing on how different layers communicate to create cohesive user flows.

## 1. Realtime SignalR Flow (`RealtimeLifecycleCoordinator`)

The app uses Microsoft SignalR for realtime updates (like driver tracking and trip status changes).

- **Lifecycle Mastery**: To save battery and prevent zombie connections, the connection is governed by the `RealtimeLifecycleCoordinator`. 
- **Triggers**: It observes both `AuthManager.authStatusStream` and OS-level `WidgetsBindingObserver`.
  - *Paused/Backgrounded* → Disconnect immediately.
  - *Resumed* → Reconnect (only if authenticated).
  - *Logged Out* → Disconnect immediately.
- **Consumption**: The UI and BLoCs NEVER call `.connect()` or `.disconnect()` directly. They only listen to the `RealtimeService.events` stream and pattern-match against `RealtimeEvent` (e.g., `RealtimeEvent.tripStatusChanged`).

## 2. Global Guard Routing Flow

Routing is not passive; it actively prevents users from reaching invalid states.
- When the app starts, the `RouterRefreshListenable` blocks entry until `SplashConfig.initialDelay` finishes.
- If the user hasn't seen the Onboarding screen, `AppRouteGuard` forces them there.
- If Location permissions are denied, it forces them to the `PermissionGateScreen` (Location is a hard requirement to use the app).
- If unauthenticated, they are forced to `LoginScreen`.
- If authenticated but missing a name, they are forced to `ProfileSetupScreen`.
- Only when ALL conditions are met can the user reach the `RootScreen` (Home Map).

## 3. Order & Trip Flow

### Step 1: Location Picking
The user starts at the `RootScreen` and can pick locations using the `LocationPickerScreen`. This screen leverages Google Maps (`RootMapCanvasWidget`) and reverse-geocodes the map's center coordinate via the `OrderRepository`.

### Step 2: Quote & Pre-Trip
Once pickup and drop-off are confirmed, the `OrderBloc` generates a quote. The user reviews the price, selects a car type, and dispatches the `OrderEvent.confirmRequested()`.

### Step 3: Active Trip (SignalR Handshake)
Once the order is placed, the backend creates a Trip. The app's `TripBloc` subscribes to that specific trip's SignalR group (`RealtimeService.joinTripGroup(tripId)`).
As the driver approaches, the backend pushes events, the `TripBloc` receives them via the `events` stream, and updates its `BlocStatus<TripEntity> activeTripStatus`, instantly updating the UI.

## 4. The Auth Flow (Firebase + Backend JWT)

- **Firebase OTP**: User enters phone -> Firebase sends SMS -> User enters code -> Firebase returns `IdToken`.
- **Backend Handshake**: The app sends the `IdToken` and FCM token to the ASP.NET backend.
- **JWT Storage**: The backend verifies the Firebase token and returns a custom JWT.
- **Session Refresh**: The app saves the JWT to `StorageService` via `AuthManager`. `dio_refresh_bot` takes over, automatically intercepting 401s, refreshing the token behind the scenes, and replaying failed requests without the user ever noticing.

---
*End of Phase 2.5 Analysis. The entire Flutter application has been successfully mapped and documented.*
