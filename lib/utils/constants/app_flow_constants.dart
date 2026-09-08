/// App flow and routing related constants.
class OnboardingStorageKeys {
  OnboardingStorageKeys._();

  /// Persistent flag indicating that onboarding was completed at least once.
  static const String finished = 'onboarding.finished';
}

/// Permission flow related persistent keys.
class PermissionFlowStorageKeys {
  PermissionFlowStorageKeys._();

  /// Tracks whether post-splash notification soft prompt was attempted.
  static const String notificationSoftPrompted =
      'permission.notificationSoftPrompted';
}

/// Configuration for splash screen behavior.
class SplashConfig {
  SplashConfig._();

  /// Minimal time the splash screen should remain visible before
  /// navigation logic can move away from it.
  ///
  /// Deliberately a held brand beat, not a loading delay — trimmed from 4s
  /// because at that length it started reading as lag rather than polish.
  static const Duration initialDelay = Duration(milliseconds: 2500);

  /// Maximum time allowed for map warmup during splash before falling back
  /// and continuing startup flow.
  ///
  /// The warmup pre-creates the GoogleMap platform view so the root map appears
  /// instantly, but it is best-effort: routing no longer blocks on it once
  /// [initialDelay] has elapsed, so this is only the ceiling for how long the
  /// hidden map keeps trying.
  static const Duration mapWarmupTimeout = Duration(milliseconds: 2500);

  static Duration durationForSplashScreen =
      initialDelay - const Duration(milliseconds: 1000);
}

/// Global switches controlling which startup flows are active.
class AppFlowConfig {
  AppFlowConfig._();

  /// * Enable or disable the onboarding flow.
  static const bool onboardingEnabled = true;

  /// * Enable or disable authentication-based routing.
  static const bool authEnabled = true;

  /// * Enable startup permission gate before onboarding/auth/root.
  static const bool permissionGateEnabled = true;

  /// * Enable the remote app update check (force / soft update) at startup.
  ///
  /// Mirrors the backend `AppUpdateCheckEnabled` config key on purpose: when
  /// someone is debugging "why isn't the gate firing" they should be looking for
  /// two switches with the same name, not translating between two. Both must be
  /// true for the gate to run. This one is compile-time, so it exists as a last
  /// resort if the backend is misconfigured *and* unreachable.
  static const bool appUpdateCheckEnabled = true;
}

/// Map related configuration and defaults.
class MapConfig {
  MapConfig._();

  /// Default starting point if no location can be found (Rotterdam Center).
  ///
  /// Also the fallback bias for address search, which the backend rejects
  /// without coordinates — see [LocationService.resolveSearchBias].
  static const double defaultLat = 51.9225;
  static const double defaultLng = 4.47917;

  /// Zoom level used when the map initially loads in broad view.
  static const double initialZoom = 10;

  /// Zoom level used when focused on the user's precise location.
  static const double focusZoom = 18.0;

  /// Zoom level used during the middle of a cinematic flight animation.
  /// Higher values mean less "zoom out" during recentering.
  static const double flightZoomOut = 18.0;

  /// Duration of the cinematic recentering flight.
  static const Duration flightDuration = Duration(milliseconds: 100);

  /// Clean Silver Map Style JSON
  static const String silverMapStyle = r'''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]
''';
}

/// Log tags for routing / flow related components.
class RouterLogTags {
  RouterLogTags._();

  static const String router = '[Router]';
  static const String redirect = '[RouterRedirect]';
}
