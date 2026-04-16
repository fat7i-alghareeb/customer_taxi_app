# Order Feature Guide

## Purpose

Order overlays the Root map with a 3-mode bottom sheet flow for selecting ride locations, then choosing a ride type:

- Collapsed: animated hero surface with illustration and ambient motion.
- Expanded (step 1): immersive modular layout with pickup/destination blocks, smart map trigger, suggestions, and conditional confirm dock.
- Expanded (step 2): route summary with Google-estimated trip time and selectable vehicle cards with price-only loading.
- Expanded (step 3): pickup-point refinement (map selection) with optional street and house-number details.
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
10. Confirm locations is enabled only when both From and To are selected.
11. When both From and To are selected (suggestion or map confirm), Order starts a silent background prefetch for route and pricing.
12. Confirm locations keeps the same UX flow, but reuses prefetched data instantly when cache matches current From/To; missing pieces continue loading and stale cache is discarded.
13. Route camera bounds auto-fit after route success and show explicit From/To markers.
14. Vehicle cards always render (Standard, Comfort, 8-passenger bus), while only price slots stay in loading state until pricing response arrives.
15. Vehicle selection is single-select with tap-again-to-deselect behavior.
16. Confirming car selection transitions to pickup-point step.
17. Pickup point is selected manually on map, reverse-geocoded, and accepted only if it is within 300 meters of the selected From location.
18. Street name and house number are optional fields stored in state and kept while navigating between pickup step and map pick mode.
19. Final confirm validates pickup selection, shows mocked overlay feedback, and then collapses/reset flow.
20. Back from pickup step returns to vehicle step without refetching route/pricing.
21. Back from vehicle step returns to location-entry step and clears route/pricing/selection so a fresh confirmation is required.
22. Expanded mode close returns to collapsed mode, clears destination/suggestions, clears route/pricing/selection, and restores pickup (From) to current location.
23. System back order: map-pick -> previous expanded step, pickup step -> vehicle step, vehicle step -> location step, then collapse.

## Core State Model

OrderBloc uses a UI state machine with:

- sheetMode: collapsed, expanded, mapPicking
- expandedStep: locationEntry, carSelection, pickupPoint
- mapPickingTarget: from, to, or pickupPoint
- map camera center snapshot (latitude, longitude, zoom)
- fromLocationState / toLocationState
- fromSuggestionsState / toSuggestionsState
- pickupPointState
- pickupStreetName / pickupHouseNumber
- pickupConfirmationFeedbackState (one-shot success/failure overlay trigger)
- tripRouteState (polyline points + Google ETA + distance)
- tripCarOptionsState (mocked car prices)
- prefetchedTripRouteState / prefetchedTripCarOptionsState
- prefetchedFromLocation / prefetchedToLocation (cache identity snapshot)
- selectedCarTypeId

## Data Layer

Order feature uses Google geocoding APIs via Env.googleMapsApiKey:

- searchLocations(query) merges Geocode + Places Text Search results, then de-duplicates and caps list size.
- reverseGeocode(lat,lng)
- getTripRoute(from,to) via Google Directions API (driving), with overview polyline decode and duration extraction.
- overview polyline decode runs in a background isolate to reduce UI-thread blocking before route state emission.
- getTripCarOptions(from,to) currently mocked with one response containing all three vehicle categories and USD prices.
- location labels are sanitized before display (plus-code fragments like `64G8+PF9` are removed, and place names are preferred when address context is too generic)

Data contracts:

- domain/entities/order_location_entity.dart
- domain/entities/order_location_request_entity.dart
- domain/entities/order_trip_route_entity.dart
- domain/entities/order_trip_car_option_entity.dart
- data/models/order_location_model.dart
- data/models/order_trip_route_model.dart
- data/models/order_trip_car_option_model.dart
- data/params/order_params.dart
- data/mappers/order_location_model_mapper.dart
- data/mappers/order_trip_route_model_mapper.dart
- data/mappers/order_trip_car_option_model_mapper.dart

## Root Integration Boundary

Root integration remains thin:

- RootScreen provides OrderBloc together with RootBloc.
- RootBody renders OrderBody as an overlay above RootMapSection.
- RootMapSection exposes camera-idle location callback so Order can confirm map center.
- RootMapSection renders trip polyline + From/To markers from Order state and auto-fits camera bounds on route success.

No additional route registration is required for this milestone.
