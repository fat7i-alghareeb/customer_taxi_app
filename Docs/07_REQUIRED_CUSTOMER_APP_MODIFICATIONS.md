# 07. Required Customer App Modifications (`customertaxi`)

> **This document is the single source of truth for all changes needed in the existing Customer Flutter App to integrate with the expanded backend and new Dashboard App.**
> Every item is cross-referenced against the actual Flutter docs and backend source code.

---

## 1. Real-Time Tracking UI (`features/root/presentation/ui/widgets/map/`) — **COMPLETED**

### A. The Driver Marker (Vehicle Tracking on Map) — **COMPLETED**

Currently, the map focuses on static location picking. It must now support dynamic asset tracking.

- **Implementation**: The `RootMapCanvasWidget` must accept a `DriverLocationEntity? activeDriverLocation` from the `TripBloc`.
- **Custom Bitmap**: Create a custom Google Maps `BitmapDescriptor` representing a top-down car icon. Use different assets per `VehicleType` if desired (car, van, wheelchair-accessible vehicle).

### B. Smooth Interpolation (Crucial UX) — **COMPLETED**

- GPS pings arrive via SignalR every 5–10 seconds.
- Simply jumping the marker to new coordinates looks terrible ("teleporting").
- **Modification**: Use `TweenAnimationBuilder` or `flutter_animarker`. When a new coordinate arrives, calculate the bearing (rotation angle) and smoothly animate the marker from old → new coordinates over the ping interval.

### C. Privacy-Aware Map Display — **COMPLETED**

- The customer MUST NOT see the driver as a person — only as a car icon.
- No driver name label on the map marker.
- Only the vehicle icon moving along the route.

---

## 2. Active Trip State Sheets (`features/trip/presentation/ui/sheets/`) — **COMPLETED**

The `TripBloc` will now receive new SignalR events from the backend as the Driver executes the full lifecycle. The UI must react to these state changes instantly.

### A. "Driver En Route" Sheet — **COMPLETED**
- **Trigger**: `TripStatus.DriverEnRoute`
- **UI Elements**:
  - **Vehicle Banner ONLY**: Car Make, Model, Color, and License Plate (large font for visual identification).
  - **Live ETA**: Calculate remaining time using driver's live GPS vs the pickup point. "Arriving in ~4 mins."
  - **Action Button**: "Cancel Ride" (allowed until driver arrives).
  - ❌ **NO driver name, photo, phone number, or rating** — strict privacy.

### B. "Driver Arrived" Sheet — **COMPLETED**
- **Trigger**: `TripStatus.DriverArrived` (from new `DriverArrived` SignalR event)
- **UX Modification**:
  - Play a distinct notification sound.
  - Change the sheet accent color (e.g., green highlight).
  - Show prominent banner: **"Your driver is outside"**.
  - Display vehicle info again (Make/Model/Color/Plate) so the passenger can identify the car.
  - ❌ **NO driver identity info** — only vehicle details.

### C. "In Progress" Sheet — **COMPLETED**
- **Trigger**: `TripStatus.InProgress`
- The map automatically re-centers to show the route from current location → Drop-off destination.
- Show ETA to destination.
- "Cancel" button is hidden (ride already started).

### D. "Completed" Sheet — **COMPLETED**
- **Trigger**: `TripStatus.Completed`
- Show trip summary: Fare, Duration, Distance.
- ❌ **No rating sheet** — ratings are skipped for V1 per business decision.
- Simple "Done" button returns user to home screen.

---

## 3. SignalR Consumption Updates (`core/services/realtime/`) — **COMPLETED**

### A. Handle New Event Types — **COMPLETED**

The `RealtimeService` must handle 2 new SignalR method callbacks from the server:
1. `"DriverEnRoute"` → `RealtimeEvent.driverEnRoute`
2. `"DriverArrived"` → `RealtimeEvent.driverArrived`

These must be added to the `RealtimeEvent` union and propagated to the `TripBloc`.

### B. Handle `DriverLocationUpdated` Payload — **COMPLETED**

- The `LocationTrackingHub` will push `DriverLocationUpdated(lat, lng)` events.
- The `RealtimeService` must connect to the **new** hub at `/hubs/location` (in addition to `/hubs/trips`) when an active trip is in `DriverEnRoute` or `DriverArrived` status.
- Avoid full screen rebuilds on every GPS ping. Only rebuild the marker layer on the `RootMapCanvasWidget`.

### C. Connection Lifecycle — **COMPLETED**

- Connect to `/hubs/location` ONLY when there is an active trip with a driver assigned.
- Disconnect from `/hubs/location` when the trip transitions to `InProgress` (no longer need live tracking from the separate hub — the main trip updates suffice) or `Completed`.

---

## 4. FCM Push Notifications (`firebase_messaging`) — **COMPLETED**

The app must be upgraded to support background notifications so users know when their driver arrives even if the app is closed.

### A. Firebase Integration — **COMPLETED**
- `firebase_messaging` is likely already included (Firebase is already initialized). Verify and ensure it's in `pubspec.yaml`.
- Request iOS Notification Permissions during app boot (`requestPermission()`).
- Retrieve the device FCM Token and send it to the backend upon login: `PUT /api/v1/users/me/fcm-token`.
- Re-register on token refresh via `FirebaseMessaging.instance.onTokenRefresh`.

### B. Notification Handling — **COMPLETED**
- **Foreground Messages**: Catch via `FirebaseMessaging.onMessage`. Show a sleek in-app toast/banner for non-intrusive updates (e.g., "Your driver is 3 minutes away").
- **Background/Terminated**: Register the top-level `@pragma('vm:entry-point')` handler. Tapping a notification (e.g., "Your driver has arrived") should use `go_router` deep linking to jump directly back into the active Trip sheet.

### C. Important FCM Payloads to Handle — **COMPLETED**
| Event | Notification Title | Notification Body |
|---|---|---|
| `DriverAssigned` | "Driver Assigned" | "A vehicle ({Make} {Model}, {Color}) is heading your way." |
| `DriverEnRoute` | "Driver En Route" | "Your {Color} {Make} {Model} ({Plate}) is on the way!" |
| `DriverArrived` | "Driver Arrived" | "Your ride is outside. Look for the {Color} {Make} {Model}." |
| `TripCompleted` | "Trip Complete" | "Your trip is complete. Fare: {Amount} {Currency}." |
| `TripCancelled` | "Trip Cancelled" | "Your trip has been cancelled." |

> **Note**: FCM payloads MUST NOT contain driver name, phone, or personal info — only vehicle details and trip status.

---

## 5. Customer Privacy & Data Protection — **COMPLETED**

### A. Strict Driver Data Obfuscation — **COMPLETED**

The Customer App must **NEVER** display:
- ❌ Driver's full name
- ❌ Driver's phone number
- ❌ Driver's profile photo
- ❌ Driver's rating or personal metrics
- ❌ Driver's personal address

### B. What IS Allowed

The Customer App MAY display:
- ✅ Vehicle Make (e.g., "Toyota")
- ✅ Vehicle Model (e.g., "Camry")
- ✅ Vehicle Color (e.g., "White")
- ✅ Vehicle License Plate (e.g., "AB-123-CD") — **in large text for easy identification**
- ✅ Vehicle Type name (e.g., "Standard", "XL Van")
- ✅ Trip status text (e.g., "Driver is on the way", "Driver has arrived")
- ✅ Driver's GPS position (as a car icon on the map — no identity attached)

### C. Backend DTO Enforcement

The backend MUST enforce this by returning a `PassengerTripDto` that only includes vehicle data, not driver personal data. The customer app should not even receive driver identity fields in API responses.

---

## 6. Trip DTO Changes — **COMPLETED**

The `TripDto` or `ActiveTripDto` returned to Passenger-role users must be updated to include:
```dart
class ActiveTripDto {
  final String tripId;
  final String referenceCode;
  final String status;           // "DriverEnRoute", "DriverArrived", etc.
  final String? vehicleMake;
  final String? vehicleModel;
  final String? vehicleColor;
  final String? vehiclePlate;
  final String? vehicleTypeName;
  final double? driverLat;       // For map tracking only — no identity
  final double? driverLng;
  final DateTime? etaToPickup;
  // ❌ NO driverName, driverPhone, driverPhoto fields
}
```

---

## 7. Completed Customer Implementations (Phase Summary)

### A. Dynamic Map Tracking & Bearing Rotation — **COMPLETED**
- **Scaled Car Marker:** Created `createVehicleMarker` to load and scale the orange car asset `assets/images/legacyCar.png` inside [map_marker_generator.dart](file:///c:/Users/Fat7i/myProject/fat7i/customertaxi/lib/features/root/presentation/utils/map_marker_generator.dart).
- **Rotated Marker:** Updated [root_map_canvas_widget.dart](file:///c:/Users/Fat7i/myProject/fat7i/customertaxi/lib/features/root/presentation/ui/widgets/map/root_map_canvas_widget.dart) to accept active coordinates/bearings and render a rotated vehicle marker on Google Maps.
- **Smooth Interpolation & Auto-bounding:** Smoothly glides vehicle markers over 4 seconds and auto-bounds the view boundaries inside [active_trip_body.dart](file:///c:/Users/Fat7i/myProject/fat7i/customertaxi/lib/features/trip/presentation/ui/widgets/active_trip_body.dart).

### B. Glassmorphic Status Bottom Sheets — **COMPLETED**
- **Staggered Sheet UI:** Fully implemented visual sheets for **Driver En Route** (vehicle info, live ETA, cancel action), **Driver Arrived** (success green banner, beep sound + premium vibration, cancel action), **In Progress** (ETA to destination, concealed cancel), and **Completed** (fare and currency totals) inside [active_trip_body.dart](file:///c:/Users/Fat7i/myProject/fat7i/customertaxi/lib/features/trip/presentation/ui/widgets/active_trip_body.dart).
- **Deep Linking Support:** Modified [active_trip_screen.dart](file:///c:/Users/Fat7i/myProject/fat7i/customertaxi/lib/features/trip/presentation/ui/screens/active_trip_screen.dart) to parse trip IDs dynamically from deep-links or manual parameters.
- **Privacy Standard:** Strictly obfuscated all driver identity parameters (names, photos, ratings) across all UI layers.

### C. Bootstrap, FCM & Topic Subscriptions — **COMPLETED**
- **FCM Initialization:** Enabled FCM with startup permissions, token refreshes, and startup checks inside [bootstrap.dart](file:///c:/Users/Fat7i/myProject/fat7i/customertaxi/lib/bootstrap.dart).
- **Auto-Subscription:** Modified `AppNotificationConfig.defaults()` inside [notification_config.dart](file:///c:/Users/Fat7i/myProject/fat7i/customertaxi/lib/core/notification/notification_config.dart) to automatically subscribe all customer clients to the `'customers'` topic on startup.

### D. Implicit Background Language Synchronization — **COMPLETED**
- **Sleek Locale Syncing:** Overrode `changeLanguage` inside [locale_service.dart](file:///c:/Users/Fat7i/myProject/fat7i/customertaxi/lib/core/services/localization/locale_service.dart) to trigger `unawaited(authRepo.updatePreferredLanguage(code))` in the background silently.
- **Client Networking:** Exposed the PUT call inside [api_endpoints.dart](file:///c:/Users/Fat7i/myProject/fat7i/customertaxi/lib/core/network/api_endpoints.dart), [auth_remote_datasource.dart](file:///c:/Users/Fat7i/myProject/fat7i/customertaxi/lib/features/auth/data/datasources/auth_remote_datasource.dart), and repositories.

---

## 8. Summary of Customer Status

| Category | Status | Details |
|---|---|---|
| New SignalR event handlers | **COMPLETED** | `DriverEnRoute`, `DriverArrived` |
| UI Sheet updates | **COMPLETED** | Glassmorphic EnRoute, Arrived, InProgress, and Completed sheets |
| Tracking & Interpolation | **COMPLETED** | Flat rotated markers and smooth 4s gliding algorithms |
| FCM Token & Sync | **COMPLETED** | Startup registration and dynamic onTokenRefresh upload |
| FCM Auto-Subscription | **COMPLETED** | Registered default subscription to `'customers'` topic |
| Silent Language Sync | **COMPLETED** | Implicit PUT update background trigger in `LocaleService` |
| Privacy enforcement | **COMPLETED** | 100% anonymized UI with zero driver leakages |

