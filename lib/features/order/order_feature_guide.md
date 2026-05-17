# Order Feature Guide

The Order feature overlays the Root map with a bottom-sheet booking flow:
**location entry → car selection → booking details → Stripe Payment Sheet.**

Everything lives under [lib/features/order/](lib/features/order/). One `OrderBloc` drives all state; the sheet renders into the Root map's `Stack` via `OrderBody`.

---

## State architecture

`OrderState` is a composed Freezed value holding **5 independent slices**. Each slice owns a cohesive concern; UI widgets read only the slice(s) they care about.

```dart
@freezed
abstract class OrderState with _$OrderState {
  const factory OrderState({
    @Default(OrderSheetSlice())  OrderSheetSlice  sheet,
    @Default(OrderMapSlice())    OrderMapSlice    map,
    @Default(OrderStopsSlice())  OrderStopsSlice  stops,
    @Default(OrderTripSlice())   OrderTripSlice   trip,
    @Default(OrderBookingSlice()) OrderBookingSlice booking,
  }) = _OrderState;
}
```

### Slices

| Slice               | File                                                                                   | Key fields                                                                                                                                      |
| ------------------- | -------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| `OrderSheetSlice`   | [slices/order_sheet_slice.dart](presentation/states/slices/order_sheet_slice.dart)     | `mode`, `expandedStep`, `mapPickingTarget`, `activeStopIndex`                                                                                   |
| `OrderMapSlice`     | [slices/order_map_slice.dart](presentation/states/slices/order_map_slice.dart)         | `latitude`, `longitude`, `zoom`                                                                                                                 |
| `OrderStopsSlice`   | [slices/order_stops_slice.dart](presentation/states/slices/order_stops_slice.dart)     | `list`, `queries`, `suggestionsState`, `savedState`                                                                                             |
| `OrderTripSlice`    | [slices/order_trip_slice.dart](presentation/states/slices/order_trip_slice.dart)       | `routeState`, `carOptionsState`, `prefetchedRouteState`, `prefetchedCarOptionsState`, `prefetchedStops`, `selectedCarTypeId`, `selectedQuoteId` |
| `OrderBookingSlice` | [slices/order_booking_slice.dart](presentation/states/slices/order_booking_slice.dart) | `scheduleMode`, `scheduledAt`, `tripRequestStatus`, `paymentSheetState`                                                                         |

### Enums

| Enum                  | Values                                              |
| --------------------- | --------------------------------------------------- |
| `OrderSheetMode`      | `collapsed` · `expanded` · `mapPicking`             |
| `OrderExpandedStep`   | `locationEntry` · `carSelection` · `bookingDetails` |
| `OrderLocationTarget` | `stop`                                              |
| `OrderScheduleMode`   | `now` · `later`                                     |

---

## Handler organization

`OrderBloc` is ~90 lines: constructor, `on<>` wiring for all 25 events, and two token-pair helpers. All handler logic lives in **6 `part` files** under [handlers/](presentation/states/handlers/) via private Dart extensions on `OrderBloc`. Dart resolves extension methods on `this` when calling `on<_E>(_handler)`, so handler tearoffs work transparently.

| Part file                                                                                   | Extension                 | Responsibility                                                                                                                            |
| ------------------------------------------------------------------------------------------- | ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| [lifecycle_handlers.dart](presentation/states/handlers/lifecycle_handlers.dart)             | `_LifecycleHandlers`      | `_resetTripFlowState`, started, orderNowPressed, collapseRequested                                                                        |
| [map_handlers.dart](presentation/states/handlers/map_handlers.dart)                         | `_MapHandlers`            | setOnMapPressed, mapCameraTargetUpdated, confirmMapPointPressed, mapPickCancelled, vehicleStepBackPressed                                 |
| [stops_handlers.dart](presentation/states/handlers/stops_handlers.dart)                     | `_StopsHandlers`          | activeStopChanged, stopQueryChanged, stopCleared, stopSuggestionSelected, stopAdded, stopRemoved, stopReordered, savedLocationPinToggled  |
| [suggestions_helpers.dart](presentation/states/handlers/suggestions_helpers.dart)           | `_SuggestionsHelpers`     | `_buildSuggestionsState`, `_refreshSuggestionsFromSavedLocations`, `_saveSelectedLocationAndRefresh`, `_toggleSavedLocationPinAndRefresh` |
| [trip_resolution_handlers.dart](presentation/states/handlers/trip_resolution_handlers.dart) | `_TripResolutionHandlers` | `_isPrefetchCacheValid`, `_tryStartTripPrefetch`, prefetch completion, carTypeToggled, confirmCarSelectionPressed, confirmOrderPressed    |
| [booking_handlers.dart](presentation/states/handlers/booking_handlers.dart)                 | `_BookingHandlers`        | bookingDetailsBackPressed, scheduleModeChanged, scheduleTimeChanged, paymentSheetDismissed, **confirmBookingDetailsPressed (Stripe)**     |

Pure sorting/normalization helpers live in [helpers/saved_locations_helper.dart](presentation/helpers/saved_locations_helper.dart) as a static class `SavedLocationsHelper`.

---

## Event surface

| Event factory                                                     | Parameters                          | Fired by                                    |
| ----------------------------------------------------------------- | ----------------------------------- | ------------------------------------------- |
| `started()`                                                       | —                                   | OrderView initState                         |
| `orderNowPressed()`                                               | —                                   | search pill / \_HomeCollapsedOverlay        |
| `collapseRequested()`                                             | —                                   | order_body listener on success, system back |
| `mapPickCancelled()`                                              | —                                   | map pick sheet cancel button, system back   |
| `vehicleStepBackPressed()`                                        | —                                   | system back when expandedStep=carSelection  |
| `setOnMapPressed({index})`                                        | `int index`                         | location entry "set on map" button          |
| `mapCameraTargetUpdated(lat, lng, zoom)`                          | `double` × 3                        | root_map_section camera-idle callback       |
| `confirmMapPointPressed()`                                        | —                                   | map pick sheet confirm button               |
| `activeStopChanged(index)`                                        | `int index`                         | stop tab tap                                |
| `stopQueryChanged(index, query)`                                  | `int, String`                       | text field onChange                         |
| `stopCleared(index)`                                              | `int index`                         | stop clear button                           |
| `stopSuggestionSelected(index, location)`                         | `int, OrderSavedLocationEntity`     | suggestion list tap                         |
| `stopAdded()`                                                     | —                                   | add-stop button                             |
| `stopRemoved(index)`                                              | `int index`                         | stop delete icon                            |
| `stopReordered(oldIndex, newIndex)`                               | `int, int`                          | drag-reorder handle                         |
| `savedLocationPinToggled({stopIndex, location})`                  | `int, OrderSavedLocationEntity`     | pin icon in suggestion row                  |
| `carTypeToggled(typeId)`                                          | `String typeId`                     | vehicle card tap                            |
| `tripPrefetchCompleted({token, stops, routeState, pricingState})` | `int, List, BlocStatus, BlocStatus` | internal prefetch futures                   |
| `confirmOrderPressed()`                                           | —                                   | location entry confirm button               |
| `confirmCarSelectionPressed()`                                    | —                                   | car selection confirm button                |
| `bookingDetailsBackPressed()`                                     | —                                   | booking details back button, system back    |
| `scheduleModeChanged(mode)`                                       | `OrderScheduleMode`                 | schedule toggle                             |
| `scheduleTimeChanged(time)`                                       | `DateTime?`                         | date/time picker                            |
| `confirmBookingDetailsPressed()`                                  | —                                   | "Confirm & Pay" button                      |
| `paymentSheetDismissed()`                                         | —                                   | dismissal of Stripe sheet                   |

---

## Canonical happy path

**1. Cold start** (`started`)

- Loads saved locations from ObjectBox → `stops.savedState = success([...sorted])`
- Reverse-geocodes current device position → `stops.list[0] = currentLocation`
- Sheet stays `collapsed`

**2. Tap "Order Now"** (`orderNowPressed`)

- `_resetTripFlowState`: clears trip slice, keeps `stops.list[0]`, resets `list[1]` → null
- `sheet.mode = expanded`, `sheet.expandedStep = locationEntry`, `sheet.activeStopIndex = 1`

**3. Type destination** (`stopQueryChanged(1, query)`)

- `stops.queries[1] = query`
- `stops.suggestionsState[1] = loading` → remote search → `success([results])`
- When query is empty, falls back to filtered saved locations

**4. Pick a suggestion** (`stopSuggestionSelected(1, location)`)

- `stops.list[1] = location.toOrderLocationEntity()`
- Saves location to ObjectBox in background
- **Prefetch fires**: `_tryStartTripPrefetch` increments `_prefetchToken` and launches two independent futures (route + pricing)

**5. Confirm locations** (`confirmOrderPressed`)

- `sheet.expandedStep = carSelection`
- If `_isPrefetchCacheValid(resolvedStops)` → promotes prefetched route/pricing to `trip.routeState` / `trip.carOptionsState`
- Otherwise fires fresh parallel fetch guarded by `_tripResolutionToken`

**6. Select a car** (`carTypeToggled(typeId)`)

- `trip.selectedCarTypeId = typeId`
- Looks up matching `quoteId` from `trip.carOptionsState.success.options`
- `trip.selectedQuoteId = quoteId`

**7. Confirm car** (`confirmCarSelectionPressed`)

- `sheet.expandedStep = bookingDetails`

**8. (Optional) Schedule** (`scheduleModeChanged(later)` + `scheduleTimeChanged(dt)`)

- `booking.scheduleMode = later`, `booking.scheduledAt = dt`

**9. Confirm & Pay** (`confirmBookingDetailsPressed`)

- `booking.tripRequestStatus = loading`
- Calls `_facade.requestTrip(OrderRequestTripEntity(quoteId, stops, scheduledAt?))`
- **If** `ClientConfigService.current.stripeEnabled` **and** `trip.stripePayment != null`:
  - `Stripe.instance.initPaymentSheet(clientSecret, merchantDisplayName:'customertaxi', country:'NL', email:always)`
  - `Stripe.instance.presentPaymentSheet()`
  - Success → `booking.paymentSheetState = success(null)`
  - `StripeException.Canceled` → `booking.tripRequestStatus = failure(paymentCanceled)`
  - Other `StripeException` → `booking.tripRequestStatus = failure(paymentFailed)`
- **If** Stripe disabled or no payment block: `booking.tripRequestStatus = success(trip)` directly

**10. Success listener** (in `order_body.dart`)

- `booking.tripRequestStatus.success` → shows success overlay → adds `collapseRequested`
- Sheet returns to `collapsed`

---

## Trip prefetch coordinator

`_tryStartTripPrefetch` fires after every stop mutation that produces ≥ 2 resolved stops.

- **Cache check**: `_isPrefetchCacheValid` compares each prefetched stop against current stops using `SavedLocationsHelper.isSameCoordinates` (epsilon 0.0001°). If all match, skips re-fetch.
- **Token**: `_prefetchToken` increments on every `_tryStartTripPrefetch` call. The token is captured before any async work.
- **Two independent futures**: `_resolveTripPrefetch` fires `getTripRoute` and `getPricingQuotes` in parallel. Each `.then()` checks `_isPrefetchTokenCurrent(token)` before calling `add(tripPrefetchCompleted(...))`.
- **Partial completion**: Each future emits its own `tripPrefetchCompleted` event. The handler merges: whichever of `routeState`/`pricingState` is not `loading` in the event replaces the corresponding slice field.
- **Promotion at confirmOrderPressed**: If the cache is valid, prefetched results move into `trip.routeState` / `trip.carOptionsState`, skipping a redundant network round-trip.

---

## Saved locations and suggestions

`stops.savedState` — global cache of `OrderSavedLocationEntity` from ObjectBox, loaded once at `started`. Updated after every `saveSelectedLocation` / `togglePinnedLocation` / `removeSavedLocation`.

`stops.suggestionsState[i]` — per-stop async list displayed in the suggestion panel:

- When `stops.queries[i]` is **empty**: shows filtered saved locations (sorted: pinned first, then recency).
- When **typed**: shows remote `searchLocations` results promoted to `OrderSavedLocationEntity` shape.

Pin toggle (`savedLocationPinToggled`) calls `_facade.togglePinnedLocation`, refreshes `stops.savedState`, then re-runs `_refreshSuggestionsFromSavedLocations` for all open stops whose queries are empty, keeping visible lists in sync without re-fetching.

---

## Stripe payment flow

Feature-gated by `ClientConfigService.current.stripeEnabled` (read from `/api/config` on app start).

If the backend returns an `OrderStripePaymentEntity` in the trip response:

```dart
await Stripe.instance.initPaymentSheet(
  paymentSheetParameters: SetupPaymentSheetParameters(
    paymentIntentClientSecret: stripePayment.clientSecret,
    merchantDisplayName: 'customertaxi',
    style: ThemeMode.system,
    returnURL: 'customertaxi://stripe-redirect',
    billingDetailsCollectionConfiguration:
        BillingDetailsCollectionConfiguration(email: CollectionMode.always),
    billingDetails: BillingDetails(address: Address(country: 'NL', ...)),
  ),
);
await Stripe.instance.presentPaymentSheet();
```

`StripeException.FailureCode.Canceled` is distinguished from other failures for user-facing messaging. The backend Stripe webhook (`POST /api/webhooks/stripe`) drives the final trip state machine; the bloc emits `tripRequestStatus = success` optimistically when the sheet succeeds.

---

## Data layer and facade

All domain interactions go through `OrderFacade` — a `@lazySingleton` delegating to `OrderRepository`.

| Method                             | Transport         | Purpose                                              |
| ---------------------------------- | ----------------- | ---------------------------------------------------- |
| `searchLocations(request)`         | Remote            | Text search for location suggestions                 |
| `reverseGeocode(request)`          | Remote            | Lat/lng → human-readable label                       |
| `getTripRoute(request)`            | Remote            | Polyline + distance/duration for stops               |
| `getPricingQuotes(request)`        | Remote            | Car options with prices per stop list                |
| `requestTrip(request)`             | Remote            | Create trip; returns trip id + optional Stripe block |
| `getTripCount()`                   | Remote            | Aggregate trip count for the passenger               |
| `getSavedLocations()`              | Local (ObjectBox) | Fetch passenger's saved + pinned locations           |
| `saveSelectedLocation(location)`   | Local (ObjectBox) | Upsert a picked location into saved list             |
| `togglePinnedLocation(location)`   | Local (ObjectBox) | Toggle pin flag; returns updated saved list          |
| `removeSavedLocation(identityKey)` | Local (ObjectBox) | Delete a saved location by identity key              |

Remote calls use Dio via [order_remote_datasource.dart](data/datasources/order_remote_datasource.dart). Local calls use ObjectBox via [order_local_datasource.dart](data/datasources/order_local_datasource.dart).

---

## Domain entities

| Entity                       | File                                                                                              | Purpose                                                                                                                                                                                                              |
| ---------------------------- | ------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `OrderLocationEntity`        | [entities/order_location_entity.dart](domain/entities/order_location_entity.dart)                 | A resolved lat/lng + label. Used for stops.                                                                                                                                                                          |
| `OrderSavedLocationEntity`   | [entities/order_saved_location_entity.dart](domain/entities/order_saved_location_entity.dart)     | Saved location with `isPinned`, `usageCount`, timestamps                                                                                                                                                             |
| `OrderTripRouteEntity`       | [entities/order_trip_route_entity.dart](domain/entities/order_trip_route_entity.dart)             | Encoded polyline points + distance/duration                                                                                                                                                                          |
| `OrderTripCarOptionEntity`   | [entities/order_trip_car_option_entity.dart](domain/entities/order_trip_car_option_entity.dart)   | Vehicle type card: `typeId`, `quoteId`, `name`, `price`                                                                                                                                                              |
| `OrderTripResponseEntity`    | [entities/order_trip_response_entity.dart](domain/entities/order_trip_response_entity.dart)       | Trip creation result: `id`, `status`, optional `stripePayment`                                                                                                                                                       |
| `OrderStripePaymentEntity`   | [entities/order_stripe_payment_entity.dart](domain/entities/order_stripe_payment_entity.dart)     | `clientSecret`, `publishableKey`, `paymentIntentId`                                                                                                                                                                  |
| `OrderLocationRequestEntity` | [entities/order_location_request_entity.dart](domain/entities/order_location_request_entity.dart) | Request param types: `OrderLocationSearchRequestEntity`, `OrderReverseGeocodeRequestEntity`, `OrderTripRouteRequestEntity`, `OrderPricingQuotesRequestEntity`, `OrderRequestTripEntity`, `OrderStopCoordinateEntity` |

---

## UI widget tree

```
RootScreen
└── BlocProvider<OrderBloc>           (order_view.dart)
    └── OrderBody                     (order_body.dart — BlocConsumer)
        ├── OrderCenterPinWidget      (when sheet.mode == mapPicking)
        └── OrderSheetSection         (when sheet.mode != collapsed)
            ├── OrderExpandedSheetWidget       (expanded)
            │   ├── OrderLocationEntryStepWidget   (expandedStep == locationEntry)
            │   ├── OrderVehicleSelectionStepWidget (expandedStep == carSelection)
            │   └── OrderBookingDetailsStepWidget  (expandedStep == bookingDetails)
            │       └── OrderSchedulePickerWidget
            └── OrderMapPickSheetWidget        (mapPicking)
```

`OrderBody` is the single `BlocConsumer`. Its `listener` handles:

- `booking.tripRequestStatus.success` → shows success overlay, adds `collapseRequested`
- `booking.tripRequestStatus.failure` → shows error overlay

`PopScope` in `OrderBody` intercepts system back and maps it to the correct collapse event based on `sheet.mode` + `sheet.expandedStep`.

---

## Root integration boundary

`RootScreen` provides both `RootBloc` and `OrderBloc` at the same scope level.

**[root_map_section.dart](../root/presentation/ui/widgets/map/root_map_section.dart)**

- Reads `orderState.trip.routeState` to draw the polyline overlay
- Reads `orderState.stops.list.first` / `.last` for pickup/dropoff markers
- Dispatches `mapCameraTargetUpdated(lat, lng, zoom)` on every `onCameraIdle`

**[root_body.dart](../root/presentation/ui/widgets/root_body.dart)**

- Reads `state.sheet.mode != OrderSheetMode.collapsed` to hide the bottom navigation bar when the sheet is open

**[root_home_tab_section.dart](../root/presentation/ui/widgets/home/root_home_tab_section.dart)**

- Shows `_HomeCollapsedOverlay` (search pill with "Now" and "Later" buttons) only when `sheet.mode == collapsed`
- "Now" → `scheduleModeChanged(now)` + `orderNowPressed`
- "Later" → `scheduleModeChanged(later)` + `orderNowPressed`
