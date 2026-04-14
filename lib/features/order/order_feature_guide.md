# Order Feature Guide

## Purpose

Order overlays the Root map with a 3-mode bottom sheet flow for selecting ride locations:

- Collapsed: animated hero surface with illustration and ambient motion.
- Expanded: immersive modular layout with pickup/destination blocks, smart map trigger, suggestions, and conditional confirm dock.
- Map pick: collapsed control bar with center pin and Confirm point.

The user stays on Root screen while all Order interaction logic remains inside the Order feature.

## Interaction Flow

1. Order starts in collapsed mode.
2. Tapping the collapsed hero expands to a full-height immersive sheet.
3. From is initialized from current location and reverse-geocoded into a readable address.
4. To starts empty.
5. Each field supports text search through Google geocoding and map-based picking.
6. Each field shows an in-field clear action while focused and non-empty; clearing resets only that field selection and suggestions while keeping focus.
7. Text search results are rendered in the dedicated area below the two fields inside expanded mode.
8. A single smart inline map trigger (context-aware by field focus) switches to map-pick mode with a visible center pin.
9. Confirm point reverse-geocodes the current map center and returns to expanded mode.
10. Confirm order is enabled only when both From and To are selected.
11. Expanded mode has an explicit close action that returns to collapsed mode, clears destination/suggestions, and restores pickup (From) to current location.
12. System back button collapses the Order sheet (instead of leaving Root) while Order is not collapsed.
13. Confirm order currently performs no submission by design.

## Core State Model

OrderBloc uses a UI state machine with:

- sheetMode: collapsed, expanded, mapPicking
- mapPickingTarget: from or to
- map camera center snapshot (latitude, longitude, zoom)
- fromLocationState / toLocationState
- fromSuggestionsState / toSuggestionsState

## Data Layer

Order feature uses Google geocoding APIs via Env.googleMapsApiKey:

- searchLocations(query) merges Geocode + Places Text Search results, then de-duplicates and caps list size.
- reverseGeocode(lat,lng)
- location labels are sanitized before display (plus-code fragments like `64G8+PF9` are removed, and place names are preferred when address context is too generic)

Data contracts:

- domain/entities/order_location_entity.dart
- domain/entities/order_location_request_entity.dart
- data/models/order_location_model.dart
- data/params/order_params.dart
- data/mappers/order_location_model_mapper.dart

## Root Integration Boundary

Root integration remains thin:

- RootScreen provides OrderBloc together with RootBloc.
- RootBody renders OrderBody as an overlay above RootMapSection.
- RootMapSection exposes camera-idle location callback so Order can confirm map center.

No additional route registration is required for this milestone.
