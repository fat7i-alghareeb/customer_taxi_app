# Order Feature Guide

## Purpose

Order overlays the Root map with a bottom sheet flow for selecting ride locations,
then choosing a ride type. The flow is triggered from the Home header search
pill.

- Expanded (step 1): immersive modular layout with pickup/destination blocks, smart map trigger, suggestions, and conditional confirm dock.
- Expanded (step 2): route summary with Google-estimated trip time and selectable vehicle cards with price-only loading.
- Expanded (step 3): pickup-point refinement (map selection) with optional street and house-number details.
- Map pick: collapsed control bar with center pin and Confirm point.

The user stays on Root screen while all Order interaction logic remains inside the Order feature.

## Interaction Flow

1. Order starts in collapsed (idle) mode with no visible sheet.
2. Tapping the Home header search pill expands to a full-height immersive sheet.
3. From is initialized from current location and reverse-geocoded into a readable address.
4. To starts empty.
5. Each field supports text search through Google geocoding and map-based picking.
6. Each field shows an in-field clear action while focused and non-empty; clearing resets only that field selection and suggestions while keeping focus.
7. Before typing, suggestions are sourced from persisted saved locations (From/To only) stored in ObjectBox.
8. Pressing Order Now reloads saved locations from local cache before interaction, so expanded suggestions always reflect latest persisted entries.
9. While typing, suggestions switch to remote Google results for the active field.
10. Each suggestion supports pin toggle from both long-press and dedicated pin icon.
11. Saved locations are capped to 10 items total (pinned + unpinned); overflow removes oldest unpinned first, then oldest pinned.
12. Selecting a suggestion or confirming a map point for From/To saves it to persistent history.
13. Text search results are rendered in the dedicated area below the two fields inside expanded mode.
14. A single smart inline map trigger (context-aware by field focus) switches to map-pick mode with a visible center pin.
15. Confirm point reverse-geocodes the current map center and returns to expanded mode.
16. Confirm locations is enabled only when both From and To are selected.
17. When both From and To are selected (suggestion or map confirm), Order starts a silent background prefetch for route and pricing.
18. Confirm locations keeps the same UX flow, but reuses prefetched data instantly when cache matches current From/To; missing pieces continue loading and stale cache is discarded.
19. Route camera bounds auto-fit after route success and show explicit From/To markers.
20. Vehicle cards always render (Standard, Comfort, 8-passenger bus), while only price slots stay in loading state until pricing response arrives.
21. Vehicle selection is single-select with tap-again-to-deselect behavior.
22. Confirming car selection transitions to pickup-point step.
23. Pickup point is selected manually on map, reverse-geocoded, and accepted only if it is within 300 meters of the selected From location.
24. Street name and house number are optional fields stored in state and kept while navigating between pickup step and map pick mode.
25. Final confirm validates pickup selection, shows mocked overlay feedback, and then collapses/reset flow.
26. Back from pickup step returns to vehicle step without refetching route/pricing.
27. Back from vehicle step returns to location-entry step and clears route/pricing/selection so a fresh confirmation is required.
28. Expanded mode close returns to collapsed mode, clears destination/suggestions, clears route/pricing/selection, and restores pickup (From) to current location.
29. System back order: map-pick -> previous expanded step, pickup step -> vehicle step, vehicle step -> location step, then collapse.

## Core State Model

OrderBloc uses a UI state machine with:

- sheetMode: collapsed, expanded, mapPicking
- expandedStep: locationEntry, carSelection, pickupPoint
- mapPickingTarget: from, to, or pickupPoint
- map camera center snapshot (latitude, longitude, zoom)
- fromLocationState / toLocationState
- savedLocationsState
- fromSuggestionsState / toSuggestionsState
- fromQuery / toQuery
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
- overview polyline decode uses a hybrid strategy: long encoded paths run in a background isolate, while short paths decode inline to avoid isolate overhead.
- getTripCarOptions(from,to) currently mocked with one response containing all three vehicle categories and USD prices.
- getSavedLocations()/saveSelectedLocation()/togglePinnedLocation() persist suggestions in ObjectBox local cache (`order.saved_locations.v1`).
- ObjectBox cache key uses unique-conflict replace strategy to keep cache upsert idempotent under fast repeated writes.
- Local cache upsert performs duplicate-row repair and recovery-by-recreate if ObjectBox write conflicts occur.
- If local persistence fails, OrderBloc applies an in-memory fallback update so suggestions still appear in the current session.
- From/To selection persistence is awaited inside event handlers so saved-suggestions refresh emits only while the handler is active (prevents late-emitter assertion).
- location labels are sanitized and rendered with a street-first priority (street number + route, then POI/premise, then neighborhood/sublocality), while city/country-only and coordinate labels are not used for user-facing output

Data contracts:

- domain/entities/order_location_entity.dart
- domain/entities/order_location_request_entity.dart
- domain/entities/order_trip_route_entity.dart
- domain/entities/order_trip_car_option_entity.dart
- data/models/order_location_model.dart
- data/models/order_trip_route_model.dart
- data/models/order_trip_car_option_model.dart
- data/models/order_saved_location_cache_model.dart
- data/params/order_params.dart
- data/mappers/order_location_model_mapper.dart
- data/mappers/order_trip_route_model_mapper.dart
- data/mappers/order_trip_car_option_model_mapper.dart
- data/mappers/order_saved_location_cache_model_mapper.dart
- data/datasources/order_local_datasource.dart

## Root Integration Boundary

Root integration remains thin:

- RootScreen provides OrderBloc together with RootBloc.
- RootHomeTabSection renders OrderBody as an overlay above RootMapSection.
- RootMapSection exposes camera-idle location callback so Order can confirm map center.
- RootMapSection renders trip polyline + From/To markers from Order state and auto-fits camera bounds on route success.

No additional route registration is required for this milestone.
