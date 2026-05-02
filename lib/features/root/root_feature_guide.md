# Root Feature Guide

## Purpose

Root is the post-auth shell and now hosts the taxi baseline map surface inside
the Home tab, with a bottom nav shell for the other placeholder tabs.

## Map Baseline

The root map implementation is optimized for first-release performance:

- Full body map rendering (no SafeArea padding in Root screen scaffold config).
- Manual location refresh strategy (no continuous stream in this milestone).
- Essential controls only: recenter, zoom in, zoom out, compass toggle.
- GoogleMap controller lifecycle is owned by a dedicated map section widget.

## File Structure

- presentation/ui/screens/root_screen.dart
  - Route entry and BlocProvider wiring.
- presentation/ui/widgets/root_body.dart
  - Root tab shell with PageView + bottom nav.
- presentation/ui/widgets/home/root_home_tab_section.dart
  - Home tab map bootstrap + overlays.
- presentation/ui/widgets/home/root_header_search_pill_widget.dart
  - Tappable header search pill overlay.
- presentation/ui/widgets/nav/root_bottom_nav_bar.dart
  - Bottom nav container.
- presentation/ui/widgets/nav/root_bottom_nav_item.dart
  - Individual nav item button.
- presentation/ui/widgets/placeholders/root_placeholder_tab_section.dart
  - Placeholder tab content.
- presentation/ui/widgets/map/root_map_section.dart
  - Stateful map orchestration, camera updates, control integration.
- presentation/ui/widgets/map/root_map_canvas_widget.dart
  - GoogleMap rendering and map options.
- presentation/ui/widgets/map/root_map_controls_section.dart
  - Overlay controls composition.
- presentation/ui/widgets/map/root*map*\*\_button_widget.dart
  - Atomic control actions.

## Interaction Rules

- Initial map center is resolved through RootBloc bootstrap event.
- Recenter uses RootEvent.recenterRequested and updates camera manually.
- Header search pill triggers OrderEvent.orderNowPressed.
- Bottom nav hides on Home when Order is expanded or map picking.
- Zoom/compass actions are handled locally in map section for low overhead.

## Map Key Setup

Map rendering requires a valid Google Maps API key per platform.

- Android reads `GOOGLE_MAPS_API_KEY` from project `.env` (or Gradle property).
- iOS reads `GoogleMapsApiKey` from `Info.plist`.
- Placeholder values such as `{apiKey}` are treated as invalid and will log a warning.
- For Android, the key must be authorized in Google Cloud for the exact package and SHA-1 pair:
  - `dev.fat7i.customertaxi.stage` + debug SHA-1
  - `dev.fat7i.customertaxi` + release SHA-1

## Future Extensions

The map stack intentionally leaves center and top regions free for future taxi overlays:

- trip request card
- driver status chips
- route polyline and destination markers
- surge/zone layers
