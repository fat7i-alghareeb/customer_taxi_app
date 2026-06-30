# customertaxi (Flutter)

Passenger app for the customertaxi platform. Map-overlay booking flow with multi-stop trips, saved-location suggestions, real backend pricing, scheduled rides, and Stripe Payment Sheet checkout. Backend lives in the sibling `TAXI_SERVER/` project.

---

## At a glance

|                   |                                                                            |
| ----------------- | -------------------------------------------------------------------------- |
| Flutter SDK       | Standard stable channel                                                    |
| State management  | `bloc` 9 + `flutter_bloc` 9 + `freezed` (sealed states, exhaustive `when`) |
| DI                | `injectable` 2 + `get_it` 9 (code-generated container)                     |
| Routing           | `go_router` 17 (typed routes + auth/onboarding guards)                     |
| Local DB          | `objectbox` 5 (saved locations cache)                                      |
| Networking        | `dio` 5 + `dio_refresh_bot` (silent JWT refresh)                           |
| Maps              | `google_maps_flutter` + `geolocator` + `flutter_polyline_points`           |
| Payments          | `flutter_stripe` 12 (Payment Sheet)                                        |
| Auth              | Firebase Auth (phone + OTP) → backend JWT + refresh token                  |
| Push              | `firebase_messaging` + `flutter_local_notifications`                       |
| Forms             | `reactive_forms` 18                                                        |
| i18n              | `easy_localization` (9 languages)                                          |
| Responsive sizing | `flutter_screenutil` (mandatory `.sp` / `.h` / `.w`)                       |
| Animations        | `flutter_animate` (primary), tier-restricted policy                        |
| Env / secrets     | `envied` (compile-time obfuscation)                                        |

---

## Features

Every feature lives under [lib/features/](lib/features/) with the same `data / domain / presentation` layout.

| Feature                                  | Purpose                                                                                                                                                                  |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [auth](lib/features/auth/)               | Phone + OTP login via Firebase Auth, JWT exchange with backend                                                                                                           |
| [splash](lib/features/splash/)           | Minimum-delay splash with map warmup progress overlay                                                                                                                    |
| [onboarding](lib/features/onboarding/)   | First-launch intro carousel                                                                                                                                              |
| [permissions](lib/features/permissions/) | Location permission gate before entering Root                                                                                                                            |
| [root](lib/features/root/)               | Post-auth shell: full-screen Google Map, bottom nav, search-pill overlay. Hosts the Order overlay. See [root_feature_guide.md](lib/features/root/root_feature_guide.md). |
| [order](lib/features/order/)             | Booking flow: location entry → car selection → booking details → **Stripe Payment Sheet**. See [order_feature_guide.md](lib/features/order/order_feature_guide.md).      |
| [trip](lib/features/trip/)               | Trip history + active trip tracking                                                                                                                                      |
| [profile](lib/features/profile/)         | User profile management + photo upload                                                                                                                                   |
| [favorites](lib/features/favorites/)     | Saved trips (stub scaffold)                                                                                                                                              |

---

## Architecture

Strict Clean Architecture per feature:

```
lib/features/<feature>/
├── data/
│   ├── datasources/      # Remote (Dio) + Local (ObjectBox / SharedPrefs)
│   ├── models/           # Freezed DTOs with fromJson/toJson
│   ├── mappers/          # Model ↔ Entity translation
│   ├── repositories/     # Concrete repos implementing domain interfaces
│   └── params/           # Request parameter DTOs
├── domain/
│   ├── entities/         # Pure domain types (Freezed, no JSON)
│   ├── repositories/     # Abstract interfaces
│   └── facade/           # Public API used by blocs (single point of access)
└── presentation/
    ├── states/           # Bloc + Event + State (Freezed)
    └── ui/               # Screens, sections, atomic widgets (3-tier decomposition)
```

UI follows a 3-tier hierarchy: **Screens → Sections → atomic Widgets**, each in its own file. Async state is rendered via `StatusBuilder<T>` over `BlocStatus<T>` (initial / loading / success / failure).

Cross-feature foundation:

- [lib/core/](lib/core/) — cross-cutting services (DI, router, error handling, network, theming, notifications, ObjectBox, session, location, permissions, client config). See [core_architecture_overview.md](lib/core/core_architecture_overview.md).
- [lib/common/](lib/common/) — reusable UI widgets, forms, scaffolds, animations. See [common_folder_guide.md](lib/common/common_folder_guide.md).
- [lib/utils/](lib/utils/) — design tokens, constants, extensions, code-gen sources (strings, assets). See [utils_folder_guide.md](lib/utils/utils_folder_guide.md).

---

## Project structure

```
customertaxi/
├── lib/
│   ├── bootstrap.dart            # Strictly-ordered startup (see lib_overview.md)
│   ├── app.dart                  # Root widget + theme + localization wiring
│   ├── common/                   # Shared widgets, buttons, forms, scaffolds
│   ├── core/                     # DI, router, services, notifications, theme
│   ├── features/                 # All product features
│   └── utils/                    # Constants, extensions, helpers, generated
├── assets/
│   ├── l10n/                     # ar, en, de, es, fr, nl, pl, ro, uk
│   ├── images/                   # Generated via assets.gen.dart
│   └── svgs/
├── tool/
│   └── generate_feature.dart     # Scaffolds a new feature folder
├── android/  ios/                # Platform configuration
└── pubspec.yaml
```

The bootstrap order (engine binding → flavor → DI → localization → theme → auth → notifications → locale → guarded run → routing) is non-negotiable and documented in [lib_overview.md](lib/lib_overview.md).

---

## Getting started

### Prerequisites

- Flutter SDK (stable channel)
- A running `TAXI_SERVER` backend (see its README for setup)
- Google Maps API key (Android + iOS)
- Stripe publishable key (test mode for local dev)
- Firebase project with phone auth enabled

### Setup

```powershell
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

Configure secrets via `envied`-backed `.env` (see `lib/utils/env/`). Required keys: `googleMapsApiKey`, `stripePublishableKey`, `apiBaseUrl`, `firebaseOptions`.

Configure native maps API keys:

- Android: `android/app/src/main/AndroidManifest.xml` → `com.google.android.geo.API_KEY`
- iOS: `ios/Runner/AppDelegate.swift` → `GMSServices.provideAPIKey(...)`

### Run

```powershell
flutter run
```

---

## Common workflows

| Task                                                        | Command                                                    |
| ----------------------------------------------------------- | ---------------------------------------------------------- |
| Regenerate Freezed / Injectable / JsonSerializable / assets | `dart run build_runner build --delete-conflicting-outputs` |
| Scaffold a new feature                                      | `dart run tool/generate_feature.dart <feature_name>`       |
| Static analysis                                             | `flutter analyze`                                          |
| Format                                                      | `dart format lib/`                                         |
| Run tests                                                   | `flutter test`                                             |

---

## Refund issue flow

Cancelled trip details include a refund review entry point. The customer app submits refund issues to the backend as support records only; it does not create Stripe refunds, retry refunds, expose Stripe identifiers, or use WhatsApp as the source of truth. WhatsApp can be opened only after the backend review request is saved.

The passenger app also listens for the backend `RefundLifecycleChanged` SignalR event on related trip/user groups. This keeps the client aligned with backend refund state without exposing Stripe identifiers or raw Stripe errors to customers.

---

## Documentation map

| Document                                                                                                               | What it covers                                                        |
| ---------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| [SYSTEM_ARCHITECTURE.md](SYSTEM_ARCHITECTURE.md)                                                                       | Cross-project system design (passenger app + driver app + backend)    |
| [lib/lib_overview.md](lib/lib_overview.md)                                                                             | Bootstrap sequence and root-level conventions (mandatory read)        |
| [lib/features/features_overview.md](lib/features/features_overview.md)                                                 | Feature-layer conventions (bloc, state, status, UI tiers)             |
| [lib/core/core_architecture_overview.md](lib/core/core_architecture_overview.md)                                       | Core services and cross-cutting concerns                              |
| [lib/common/common_folder_guide.md](lib/common/common_folder_guide.md)                                                 | Shared widget library                                                 |
| [lib/utils/utils_folder_guide.md](lib/utils/utils_folder_guide.md)                                                     | Design tokens, extensions, generated sources                          |
| [lib/features/order/order_feature_guide.md](lib/features/order/order_feature_guide.md)                                 | The Order feature in depth — state slices, handlers, prefetch, Stripe |
| [lib/features/root/root_feature_guide.md](lib/features/root/root_feature_guide.md)                                     | Root shell, map integration, nav, Order overlay seam                  |
| [lib/core/router/router_guide.md](lib/core/router/router_guide.md)                                                     | Router refresh listenable + route guards                              |
| [lib/core/services/session/session_service_guide.md](lib/core/services/session/session_service_guide.md)               | JWT + refresh token lifecycle                                         |
| [lib/core/services/objectbox/objectbox_service_guide.md](lib/core/services/objectbox/objectbox_service_guide.md)       | Local DB usage patterns                                               |
| [lib/core/services/location/location_service_guide.md](lib/core/services/location/location_service_guide.md)           | Geolocator + map warmup                                               |
| [lib/core/services/permissions/permission_service_guide.md](lib/core/services/permissions/permission_service_guide.md) | Permission coordinator                                                |
| [lib/core/notification/notification.md](lib/core/notification/notification.md)                                         | FCM + local notifications                                             |
