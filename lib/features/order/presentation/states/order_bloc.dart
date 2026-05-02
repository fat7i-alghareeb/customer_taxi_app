import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:customertaxi/core/services/location/location_service.dart';
import 'package:customertaxi/utils/constants/app_flow_constants.dart';
import 'package:customertaxi/utils/helpers/app_strings.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../constants/order_constants.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/order_location_entity.dart';
import '../../domain/entities/order_location_request_entity.dart';
import '../../domain/entities/order_saved_location_entity.dart';
import '../../domain/entities/order_trip_car_option_entity.dart';
import '../../domain/entities/order_trip_route_entity.dart';
import '../../domain/facade/order_facade.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

enum OrderSheetMode { collapsed, expanded, mapPicking }

enum OrderLocationTarget { from, to, pickupPoint }

enum OrderExpandedStep {
  locationEntry,
  carSelection,
  pickupPoint,
  bookingDetails,
}

@injectable
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc(this._facade, this._locationService) : super(const OrderState()) {
    printC('[OrderBloc] initialized');
    on<_Started>(_onStarted);
    on<_GetAllRequested>(_onGetAllRequested);
    on<_OrderNowPressed>(_onOrderNowPressed);
    on<_CollapseRequested>(_onCollapseRequested);
    on<_MapPickCancelled>(_onMapPickCancelled);
    on<_VehicleStepBackPressed>(_onVehicleStepBackPressed);
    on<_PickupPointBackPressed>(_onPickupPointBackPressed);
    on<_SetOnMapPressed>(_onSetOnMapPressed);
    on<_MapCameraTargetUpdated>(_onMapCameraTargetUpdated);
    on<_ConfirmMapPointPressed>(_onConfirmMapPointPressed);
    on<_FromQueryChanged>(_onFromQueryChanged);
    on<_ToQueryChanged>(_onToQueryChanged);
    on<_FromLocationCleared>(_onFromLocationCleared);
    on<_ToLocationCleared>(_onToLocationCleared);
    on<_FromSuggestionSelected>(_onFromSuggestionSelected);
    on<_ToSuggestionSelected>(_onToSuggestionSelected);
    on<_SavedLocationPinToggled>(_onSavedLocationPinToggled);
    on<_CarTypeToggled>(_onCarTypeToggled);
    on<_PickupStreetChanged>(_onPickupStreetChanged);
    on<_PickupHouseNumberChanged>(_onPickupHouseNumberChanged);
    on<_TripPrefetchCompleted>(_onTripPrefetchCompleted);
    on<_ConfirmOrderPressed>(_onConfirmOrderPressed);
    on<_ConfirmCarSelectionPressed>(_onConfirmCarSelectionPressed);
    on<_ConfirmPickupPointPressed>(_onConfirmPickupPointPressed);
    on<_PickupConfirmationFeedbackCleared>(
      _onPickupConfirmationFeedbackCleared,
    );
    on<_ConfirmBookingDetailsPressed>(_onConfirmBookingDetailsPressed);
    on<_BookingDetailsBackPressed>(_onBookingDetailsBackPressed);
    on<_ScheduleTimeChanged>(_onScheduleTimeChanged);
    on<_PaymentMethodChanged>(_onPaymentMethodChanged);
  }

  final OrderFacade _facade;
  final LocationService _locationService;
  static const int _maxSavedLocationsCount = 10;
  int _tripResolutionToken = 0;
  int _prefetchToken = 0;

  void _invalidateTripResolution() {
    _tripResolutionToken++;
  }

  bool _isTripResolutionTokenCurrent(int token) {
    return _tripResolutionToken == token;
  }

  void _invalidatePrefetch() {
    _prefetchToken++;
  }

  bool _isPrefetchTokenCurrent(int token) {
    return _prefetchToken == token;
  }

  String _buildIdentityKey(OrderLocationEntity location) {
    return '${location.latitude.toStringAsFixed(6)},${location.longitude.toStringAsFixed(6)}';
  }

  String _savedIdentityPreview(List<OrderSavedLocationEntity> saved) {
    if (saved.isEmpty) {
      return '[]';
    }

    return '[${saved.map((item) => item.identityKey).join('|')}]';
  }

  int _suggestionCountFromState(
    BlocStatus<List<OrderSavedLocationEntity>> status,
  ) {
    return status.maybeWhen(success: (items) => items.length, orElse: () => -1);
  }

  List<OrderSavedLocationEntity> _sortedSavedLocations(
    List<OrderSavedLocationEntity> locations,
  ) {
    final sorted = List<OrderSavedLocationEntity>.from(locations);
    sorted.sort((first, second) {
      if (first.isPinned != second.isPinned) {
        return first.isPinned ? -1 : 1;
      }

      return second.touchedAtMillis.compareTo(first.touchedAtMillis);
    });

    return sorted;
  }

  List<OrderSavedLocationEntity> _normalizeSavedLocationsForUi(
    List<OrderSavedLocationEntity> locations,
  ) {
    final normalized = _sortedSavedLocations(locations);

    while (normalized.length > _maxSavedLocationsCount) {
      final unpinnedIndex = normalized.lastIndexWhere((item) => !item.isPinned);
      final removeIndex = unpinnedIndex != -1
          ? unpinnedIndex
          : normalized.length - 1;
      normalized.removeAt(removeIndex);
    }

    return normalized;
  }

  List<OrderSavedLocationEntity> _filterSavedLocationsByQuery({
    required String query,
    required List<OrderSavedLocationEntity> saved,
  }) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) {
      return _sortedSavedLocations(saved);
    }

    final filtered = saved.where((item) {
      return item.location.label.toLowerCase().contains(normalizedQuery);
    }).toList();

    return _sortedSavedLocations(filtered);
  }

  List<OrderSavedLocationEntity> _savedLocationsFromSearchResults(
    List<OrderLocationEntity> locations,
  ) {
    final now = DateTime.now().millisecondsSinceEpoch;

    return locations
        .map(
          (location) => OrderSavedLocationEntity(
            identityKey: _buildIdentityKey(location),
            location: location,
            isPinned: false,
            touchedAtMillis: now,
          ),
        )
        .toList();
  }

  BlocStatus<List<OrderSavedLocationEntity>> _buildSuggestionsState({
    required OrderLocationTarget target,
    required List<OrderSavedLocationEntity> source,
  }) {
    final query = target == OrderLocationTarget.from
        ? state.fromQuery
        : state.toQuery;

    final targetHasSelection = target == OrderLocationTarget.from
        ? state.fromLocationState.isSuccess
        : state.toLocationState.isSuccess;

    printM(
      '[OrderBloc] buildSuggestionsState target=${target.name} query="$query" sourceCount=${source.length} targetHasSelection=$targetHasSelection',
    );

    final trimmedQuery = query.trim();
    if (trimmedQuery.isNotEmpty) {
      printM(
        '[OrderBloc] buildSuggestionsState target=${target.name} keep existing suggestions because query is not empty',
      );
      return target == OrderLocationTarget.from
          ? state.fromSuggestionsState
          : state.toSuggestionsState;
    }

    if (targetHasSelection) {
      printM(
        '[OrderBloc] buildSuggestionsState target=${target.name} return initial because target already selected',
      );
      return const BlocStatus.initial();
    }

    final filtered = _filterSavedLocationsByQuery(query: '', saved: source);
    printM(
      '[OrderBloc] buildSuggestionsState target=${target.name} using saved suggestions count=${filtered.length}',
    );

    return BlocStatus.success(filtered);
  }

  void _refreshSuggestionsFromSavedLocations(
    Emitter<OrderState> emit,
    List<OrderSavedLocationEntity> saved,
  ) {
    final normalizedSaved = _normalizeSavedLocationsForUi(saved);

    printM(
      '[OrderBloc] refreshSuggestions start rawCount=${saved.length} normalizedCount=${normalizedSaved.length} fromQuery="${state.fromQuery}" toQuery="${state.toQuery}" fromSelected=${state.fromLocationState.isSuccess} toSelected=${state.toLocationState.isSuccess}',
    );
    printM(
      '[OrderBloc] refreshSuggestions identities=${_savedIdentityPreview(normalizedSaved)}',
    );

    final fromSuggestionsState = _buildSuggestionsState(
      target: OrderLocationTarget.from,
      source: normalizedSaved,
    );
    final toSuggestionsState = _buildSuggestionsState(
      target: OrderLocationTarget.to,
      source: normalizedSaved,
    );

    final fromCount = _suggestionCountFromState(fromSuggestionsState);
    final toCount = _suggestionCountFromState(toSuggestionsState);

    if (emit.isDone) {
      printY(
        '[OrderBloc] refreshSuggestions skipped emit because handler is done fromCount=$fromCount toCount=$toCount',
      );
      return;
    }

    emit(
      state.copyWith(
        savedLocationsState: BlocStatus.success(normalizedSaved),
        fromSuggestionsState: fromSuggestionsState,
        toSuggestionsState: toSuggestionsState,
      ),
    );

    printC(
      '[OrderBloc] refreshSuggestions emitted fromSuggestions=$fromCount toSuggestions=$toCount',
    );
  }

  List<OrderSavedLocationEntity> _buildFallbackSavedLocations(
    OrderLocationEntity location,
  ) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final identityKey = _buildIdentityKey(location);
    final currentSaved = state.savedLocationsState.maybeWhen(
      success: (saved) => saved,
      orElse: () => const <OrderSavedLocationEntity>[],
    );

    final merged = <String, OrderSavedLocationEntity>{
      for (final item in currentSaved) item.identityKey: item,
    };

    final previous = merged[identityKey];
    merged[identityKey] = OrderSavedLocationEntity(
      identityKey: identityKey,
      location: location,
      isPinned: previous?.isPinned ?? false,
      touchedAtMillis: now,
    );

    return _normalizeSavedLocationsForUi(merged.values.toList());
  }

  Future<void> _saveSelectedLocationAndRefresh(
    Emitter<OrderState> emit,
    OrderLocationEntity location,
  ) async {
    printM(
      '[OrderBloc] saveSelectedLocationAndRefresh start identity=${_buildIdentityKey(location)} label="${location.label}" emitDone=${emit.isDone}',
    );

    final result = await _facade.saveSelectedLocation(location);
    result.when(
      success: (saved) {
        printG(
          '[OrderBloc] saveSelectedLocation success identity=${_buildIdentityKey(location)} count=${saved.length}',
        );

        if (emit.isDone) {
          printY(
            '[OrderBloc] saveSelectedLocation success skipped refresh because handler is done',
          );
          return;
        }

        _refreshSuggestionsFromSavedLocations(emit, saved);
      },
      failure: (message) {
        printY('[OrderBloc] saveSelectedLocation failure=$message');

        final fallbackSaved = _buildFallbackSavedLocations(location);

        if (emit.isDone) {
          printY(
            '[OrderBloc] saveSelectedLocation failure skipped fallback refresh because handler is done',
          );
          return;
        }

        _refreshSuggestionsFromSavedLocations(emit, fallbackSaved);

        printY(
          '[OrderBloc] saveSelectedLocation applied in-memory fallback count=${fallbackSaved.length} identities=${_savedIdentityPreview(fallbackSaved)}',
        );
      },
    );
  }

  Future<void> _toggleSavedLocationPinAndRefresh({
    required Emitter<OrderState> emit,
    required OrderLocationTarget target,
    required OrderSavedLocationEntity savedLocation,
  }) async {
    final result = await _facade.togglePinnedLocation(savedLocation.location);

    result.when(
      success: (saved) {
        printG(
          '[OrderBloc] togglePinnedLocation success identity=${savedLocation.identityKey} count=${saved.length}',
        );

        final sortedSaved = _sortedSavedLocations(saved);
        final savedByIdentity = <String, OrderSavedLocationEntity>{
          for (final item in sortedSaved) item.identityKey: item,
        };

        var nextFromSuggestionsState = state.fromSuggestionsState;
        var nextToSuggestionsState = state.toSuggestionsState;

        if (target == OrderLocationTarget.from) {
          if (state.fromQuery.trim().isEmpty) {
            nextFromSuggestionsState = BlocStatus.success(
              _filterSavedLocationsByQuery(query: '', saved: sortedSaved),
            );
          } else {
            nextFromSuggestionsState = state.fromSuggestionsState.maybeWhen(
              success: (items) {
                return BlocStatus.success(
                  items
                      .map((item) => savedByIdentity[item.identityKey] ?? item)
                      .toList(),
                );
              },
              orElse: () => state.fromSuggestionsState,
            );
          }
        }

        if (target == OrderLocationTarget.to) {
          if (state.toQuery.trim().isEmpty) {
            nextToSuggestionsState = BlocStatus.success(
              _filterSavedLocationsByQuery(query: '', saved: sortedSaved),
            );
          } else {
            nextToSuggestionsState = state.toSuggestionsState.maybeWhen(
              success: (items) {
                return BlocStatus.success(
                  items
                      .map((item) => savedByIdentity[item.identityKey] ?? item)
                      .toList(),
                );
              },
              orElse: () => state.toSuggestionsState,
            );
          }
        }

        emit(
          state.copyWith(
            savedLocationsState: BlocStatus.success(sortedSaved),
            fromSuggestionsState: nextFromSuggestionsState,
            toSuggestionsState: nextToSuggestionsState,
          ),
        );
      },
      failure: (message) {
        printY('[OrderBloc] togglePinnedLocation failure=$message');
      },
    );
  }

  bool _isSameLocationCoordinates(
    OrderLocationEntity first,
    OrderLocationEntity second,
  ) {
    const epsilon = 0.0001;
    return (first.latitude - second.latitude).abs() <= epsilon &&
        (first.longitude - second.longitude).abs() <= epsilon;
  }

  bool _isPrefetchCacheValid(
    OrderLocationEntity fromLocation,
    OrderLocationEntity toLocation,
  ) {
    final prefetchedFromLocation = state.prefetchedFromLocation;
    final prefetchedToLocation = state.prefetchedToLocation;

    if (prefetchedFromLocation == null || prefetchedToLocation == null) {
      return false;
    }

    return _isSameLocationCoordinates(prefetchedFromLocation, fromLocation) &&
        _isSameLocationCoordinates(prefetchedToLocation, toLocation);
  }

  void _tryStartTripPrefetch({
    required Emitter<OrderState> emit,
    OrderLocationEntity? fromLocation,
    OrderLocationEntity? toLocation,
  }) {
    final resolvedFromLocation =
        fromLocation ?? _extractLocation(state.fromLocationState);
    final resolvedToLocation =
        toLocation ?? _extractLocation(state.toLocationState);

    if (resolvedFromLocation == null || resolvedToLocation == null) {
      return;
    }

    final token = ++_prefetchToken;

    printM(
      '[OrderBloc] startTripPrefetch token=$token from=(${resolvedFromLocation.latitude},${resolvedFromLocation.longitude}) to=(${resolvedToLocation.latitude},${resolvedToLocation.longitude})',
    );

    emit(
      state.copyWith(
        prefetchedFromLocation: resolvedFromLocation,
        prefetchedToLocation: resolvedToLocation,
        prefetchedTripRouteState: const BlocStatus.loading(),
        prefetchedTripCarOptionsState: const BlocStatus.loading(),
      ),
    );

    unawaited(
      _resolveTripPrefetch(
        token: token,
        fromLocation: resolvedFromLocation,
        toLocation: resolvedToLocation,
      ),
    );
  }

  Future<void> _resolveTripPrefetch({
    required int token,
    required OrderLocationEntity fromLocation,
    required OrderLocationEntity toLocation,
  }) async {
    final routeFuture = _facade.getTripRoute(
      OrderTripRouteRequestEntity(
        fromLatitude: fromLocation.latitude,
        fromLongitude: fromLocation.longitude,
        toLatitude: toLocation.latitude,
        toLongitude: toLocation.longitude,
      ),
    );

    final pricingFuture = _facade.getTripCarOptions(
      OrderTripPricingRequestEntity(
        fromLatitude: fromLocation.latitude,
        fromLongitude: fromLocation.longitude,
        toLatitude: toLocation.latitude,
        toLongitude: toLocation.longitude,
      ),
    );

    routeFuture.then((routeResult) {
      if (!_isPrefetchTokenCurrent(token) || isClosed) {
        return;
      }

      final routeState = routeResult.when(
        success: BlocStatus<OrderTripRouteEntity>.success,
        failure: BlocStatus<OrderTripRouteEntity>.failure,
      );

      add(
        OrderEvent.tripPrefetchCompleted(
          token: token,
          fromLocation: fromLocation,
          toLocation: toLocation,
          routeState: routeState,
          pricingState: const BlocStatus.loading(),
        ),
      );
    });

    pricingFuture.then((pricingResult) {
      if (!_isPrefetchTokenCurrent(token) || isClosed) {
        return;
      }

      final pricingState = pricingResult.when(
        success: BlocStatus<List<OrderTripCarOptionEntity>>.success,
        failure: BlocStatus<List<OrderTripCarOptionEntity>>.failure,
      );

      add(
        OrderEvent.tripPrefetchCompleted(
          token: token,
          fromLocation: fromLocation,
          toLocation: toLocation,
          routeState: const BlocStatus.loading(),
          pricingState: pricingState,
        ),
      );
    });

    await Future.wait<void>(<Future<void>>[
      routeFuture.then((_) {}),
      pricingFuture.then((_) {}),
    ]);

    if (!_isPrefetchTokenCurrent(token) || isClosed) {
      printM('[OrderBloc] dropTripPrefetch token=$token (stale/closed)');
      return;
    }
  }

  void _onTripPrefetchCompleted(
    _TripPrefetchCompleted event,
    Emitter<OrderState> emit,
  ) {
    if (!_isPrefetchTokenCurrent(event.token)) {
      return;
    }

    final currentFromLocation = _extractLocation(state.fromLocationState);
    final currentToLocation = _extractLocation(state.toLocationState);

    if (currentFromLocation == null || currentToLocation == null) {
      return;
    }

    final pairStillCurrent =
        _isSameLocationCoordinates(currentFromLocation, event.fromLocation) &&
        _isSameLocationCoordinates(currentToLocation, event.toLocation);

    if (!pairStillCurrent) {
      return;
    }

    var nextPrefetchedTripRouteState = state.prefetchedTripRouteState;
    var nextPrefetchedTripCarOptionsState = state.prefetchedTripCarOptionsState;

    if (!event.routeState.isLoading) {
      nextPrefetchedTripRouteState = event.routeState;
    }

    if (!event.pricingState.isLoading) {
      nextPrefetchedTripCarOptionsState = event.pricingState;
    }

    var nextTripRouteState = state.tripRouteState;
    var nextTripCarOptionsState = state.tripCarOptionsState;

    if (state.tripRouteState.isLoading && !event.routeState.isLoading) {
      nextTripRouteState = event.routeState;
    }

    if (state.tripCarOptionsState.isLoading && !event.pricingState.isLoading) {
      nextTripCarOptionsState = event.pricingState;
    }

    emit(
      state.copyWith(
        prefetchedFromLocation: event.fromLocation,
        prefetchedToLocation: event.toLocation,
        prefetchedTripRouteState: nextPrefetchedTripRouteState,
        prefetchedTripCarOptionsState: nextPrefetchedTripCarOptionsState,
        tripRouteState: nextTripRouteState,
        tripCarOptionsState: nextTripCarOptionsState,
      ),
    );
  }

  OrderState _resetTripFlowState(OrderState source) {
    return source.copyWith(
      expandedStep: OrderExpandedStep.locationEntry,
      mapPickingTarget: OrderLocationTarget.from,
      fromQuery: '',
      toQuery: '',
      fromSuggestionsState: source.savedLocationsState.maybeWhen(
        success: (saved) => BlocStatus.success(_sortedSavedLocations(saved)),
        orElse: () => const BlocStatus.initial(),
      ),
      toSuggestionsState: source.savedLocationsState.maybeWhen(
        success: (saved) => BlocStatus.success(_sortedSavedLocations(saved)),
        orElse: () => const BlocStatus.initial(),
      ),
      pickupPointState: const BlocStatus.initial(),
      pickupStreetName: '',
      pickupHouseNumber: '',
      pickupConfirmationFeedbackState: const BlocStatus.initial(),
      tripRouteState: const BlocStatus.initial(),
      tripCarOptionsState: const BlocStatus.initial(),
      prefetchedTripRouteState: const BlocStatus.initial(),
      prefetchedTripCarOptionsState: const BlocStatus.initial(),
      prefetchedFromLocation: null,
      prefetchedToLocation: null,
      selectedCarTypeId: null,
      scheduledAt: null,
      paymentMethodId: null,
    );
  }

  OrderLocationEntity? _extractLocation(
    BlocStatus<OrderLocationEntity> locationState,
  ) {
    return locationState.maybeWhen(
      success: (location) => location,
      orElse: () => null,
    );
  }

  OrderLocationEntity _buildFallbackLocation({
    required double latitude,
    required double longitude,
  }) {
    final coords =
        '${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}';
    final fallback = OrderLocationEntity(
      latitude: latitude,
      longitude: longitude,
      label: coords,
      primaryName: AppStrings.droppedPin,
      secondaryAddress: coords,
    );

    printC(
      '[OrderBloc:_buildFallbackLocation] primary="${fallback.primaryName}" secondary="${fallback.secondaryAddress}"',
    );

    return fallback;

  }


  Future<void> _onStarted(_Started event, Emitter<OrderState> emit) async {
    printM('[OrderBloc] started');

    final savedLocationsResult = await _facade.getSavedLocations();
    savedLocationsResult.when(
      success: (saved) {
        printG('[OrderBloc] loaded savedLocations count=${saved.length}');
        printM(
          '[OrderBloc] loaded savedLocations identities=${_savedIdentityPreview(saved)}',
        );
        emit(
          state.copyWith(
            savedLocationsState: BlocStatus.success(
              _sortedSavedLocations(saved),
            ),
          ),
        );
      },
      failure: (message) {
        printY('[OrderBloc] getSavedLocations failed=$message');
        emit(state.copyWith(savedLocationsState: const BlocStatus.initial()));
      },
    );

    final lastKnown = await _locationService.getLastKnownPosition();

    final latitude = lastKnown?.latitude ?? MapConfig.defaultLat;
    final longitude = lastKnown?.longitude ?? MapConfig.defaultLng;
    printC(
      '[OrderBloc] bootstrap map target lat=$latitude lng=$longitude fromLastKnown=${lastKnown != null}',
    );

    emit(
      state.copyWith(
        mapCameraLatitude: latitude,
        mapCameraLongitude: longitude,
        mapCameraZoom: MapConfig.focusZoom,
        fromLocationState: const BlocStatus.loading(),
        fromQuery: '',
        toQuery: '',
        fromSuggestionsState: state.savedLocationsState.maybeWhen(
          success: (saved) => BlocStatus.success(_sortedSavedLocations(saved)),
          orElse: () => const BlocStatus.initial(),
        ),
        toSuggestionsState: state.savedLocationsState.maybeWhen(
          success: (saved) => BlocStatus.success(_sortedSavedLocations(saved)),
          orElse: () => const BlocStatus.initial(),
        ),
      ),
    );

    final result = await _facade.reverseGeocode(
      OrderReverseGeocodeRequestEntity(
        latitude: latitude,
        longitude: longitude,
      ),
    );

    result.when(
      success: (location) {
        printG(
          '[OrderBloc] started reverseGeocode success label="${location.label}"',
        );
        emit(
          state.copyWith(
            fromLocationState: BlocStatus.success(location),
            sheetMode: OrderSheetMode.collapsed,
          ),
        );
      },
      failure: (_) {
        printY(
          '[OrderBloc] started reverseGeocode failed -> using coordinate fallback',
        );
        final fallback = OrderLocationEntity(
          latitude: latitude,
          longitude: longitude,
          label:
              '${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}',
          primaryName: AppStrings.droppedPin,
          secondaryAddress:
              '${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}',
        );

        printC(
          '[OrderBloc:onStarted:fallback] primary="${fallback.primaryName}" secondary="${fallback.secondaryAddress}"',
        );

        emit(
          state.copyWith(
            fromLocationState: BlocStatus.success(fallback),
            sheetMode: OrderSheetMode.collapsed,
          ),
        );

      },
    );
  }

  Future<void> _onGetAllRequested(
    _GetAllRequested event,
    Emitter<OrderState> emit,
  ) async {
    printM('[OrderBloc] getAllRequested');
    emit(state.copyWith(getAllState: const BlocStatus.loading()));

    final result = await _facade.getAllOrders();
    result.when(
      success: (data) {
        printG('[OrderBloc] getAllRequested success count=${data.length}');
        emit(state.copyWith(getAllState: BlocStatus.success(data)));
      },
      failure: (message) {
        printY('[OrderBloc] getAllRequested failure=$message');
        emit(state.copyWith(getAllState: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onOrderNowPressed(
    _OrderNowPressed event,
    Emitter<OrderState> emit,
  ) async {
    _invalidateTripResolution();
    _invalidatePrefetch();
    printM('[OrderBloc] orderNowPressed -> expanded + refresh saved locations');
    emit(
      _resetTripFlowState(state).copyWith(sheetMode: OrderSheetMode.expanded),
    );

    final savedLocationsResult = await _facade.getSavedLocations();
    savedLocationsResult.when(
      success: (saved) {
        printG(
          '[OrderBloc] orderNowPressed loaded savedLocations count=${saved.length}',
        );
        _refreshSuggestionsFromSavedLocations(emit, saved);
      },
      failure: (message) {
        printY('[OrderBloc] orderNowPressed getSavedLocations failed=$message');
      },
    );
  }

  Future<void> _onCollapseRequested(
    _CollapseRequested event,
    Emitter<OrderState> emit,
  ) async {
    _invalidateTripResolution();
    _invalidatePrefetch();
    final token = _tripResolutionToken;

    printM(
      '[OrderBloc] collapseRequested -> collapsed + clear to/suggestions + restore from current location',
    );
    emit(
      _resetTripFlowState(state).copyWith(
        sheetMode: OrderSheetMode.collapsed,
        mapPickingTarget: OrderLocationTarget.from,
        fromLocationState: const BlocStatus.loading(),
        toLocationState: const BlocStatus.initial(),
        fromQuery: '',
        toQuery: '',
        fromSuggestionsState: state.savedLocationsState.maybeWhen(
          success: (saved) => BlocStatus.success(_sortedSavedLocations(saved)),
          orElse: () => const BlocStatus.initial(),
        ),
        toSuggestionsState: state.savedLocationsState.maybeWhen(
          success: (saved) => BlocStatus.success(_sortedSavedLocations(saved)),
          orElse: () => const BlocStatus.initial(),
        ),
      ),
    );

    final lastKnown = await _locationService.getLastKnownPosition();
    final latitude = lastKnown?.latitude ?? MapConfig.defaultLat;
    final longitude = lastKnown?.longitude ?? MapConfig.defaultLng;

    printC(
      '[OrderBloc] collapseRequested restore from lat=$latitude lng=$longitude fromLastKnown=${lastKnown != null}',
    );

    final result = await _facade.reverseGeocode(
      OrderReverseGeocodeRequestEntity(
        latitude: latitude,
        longitude: longitude,
      ),
    );

    result.when(
      success: (location) {
        if (!_isTripResolutionTokenCurrent(token)) {
          return;
        }

        printG(
          '[OrderBloc] collapseRequested restore from success label="${location.label}"',
        );
        emit(state.copyWith(fromLocationState: BlocStatus.success(location)));
      },
      failure: (_) {
        if (!_isTripResolutionTokenCurrent(token)) {
          return;
        }

        printY(
          '[OrderBloc] collapseRequested restore from failed -> using coordinate fallback',
        );
        emit(
          state.copyWith(
            fromLocationState: BlocStatus.success(
              OrderLocationEntity(
                latitude: latitude,
                longitude: longitude,
                label:
                    '${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}',
              ),
            ),
          ),
        );
      },
    );
  }

  void _onMapPickCancelled(_MapPickCancelled event, Emitter<OrderState> emit) {
    if (state.mapPickingTarget == OrderLocationTarget.pickupPoint) {
      printM(
        '[OrderBloc] mapPickCancelled pickupPoint -> expanded pickupPoint',
      );
      emit(
        state.copyWith(
          sheetMode: OrderSheetMode.expanded,
          expandedStep: OrderExpandedStep.pickupPoint,
        ),
      );
      return;
    }

    _invalidateTripResolution();
    _invalidatePrefetch();
    printM('[OrderBloc] mapPickCancelled -> expanded');
    emit(
      _resetTripFlowState(state).copyWith(sheetMode: OrderSheetMode.expanded),
    );
  }

  void _onVehicleStepBackPressed(
    _VehicleStepBackPressed event,
    Emitter<OrderState> emit,
  ) {
    _invalidateTripResolution();
    _invalidatePrefetch();
    printM('[OrderBloc] vehicleStepBackPressed -> locationEntry');
    emit(_resetTripFlowState(state));
  }

  void _onPickupPointBackPressed(
    _PickupPointBackPressed event,
    Emitter<OrderState> emit,
  ) {
    printM('[OrderBloc] pickupPointBackPressed -> carSelection');
    emit(
      state.copyWith(
        sheetMode: OrderSheetMode.expanded,
        expandedStep: OrderExpandedStep.carSelection,
      ),
    );
  }

  void _onSetOnMapPressed(_SetOnMapPressed event, Emitter<OrderState> emit) {
    printM('[OrderBloc] setOnMapPressed target=${event.target.name}');
    emit(
      state.copyWith(
        sheetMode: OrderSheetMode.mapPicking,
        mapPickingTarget: event.target,
      ),
    );
  }

  void _onMapCameraTargetUpdated(
    _MapCameraTargetUpdated event,
    Emitter<OrderState> emit,
  ) {
    printC(
      '[OrderBloc] mapCameraTargetUpdated lat=${event.latitude} lng=${event.longitude} zoom=${event.zoom}',
    );
    emit(
      state.copyWith(
        mapCameraLatitude: event.latitude,
        mapCameraLongitude: event.longitude,
        mapCameraZoom: event.zoom,
      ),
    );
  }

  Future<void> _handlePickupMapPointConfirmation(
    Emitter<OrderState> emit,
  ) async {
    printM(
      '[OrderBloc] confirmPickupMapPointPressed lat=${state.mapCameraLatitude} lng=${state.mapCameraLongitude}',
    );

    final fromLocation = _extractLocation(state.fromLocationState);
    if (fromLocation == null) {
      emit(
        state.copyWith(
          sheetMode: OrderSheetMode.expanded,
          expandedStep: OrderExpandedStep.pickupPoint,
          pickupPointState: const BlocStatus.initial(),
          pickupConfirmationFeedbackState: BlocStatus.failure(
            AppStrings.somethingWentWrong,
          ),
        ),
      );
      return;
    }

    final result = await _facade.reverseGeocode(
      OrderReverseGeocodeRequestEntity(
        latitude: state.mapCameraLatitude,
        longitude: state.mapCameraLongitude,
      ),
    );

    if (state.sheetMode != OrderSheetMode.mapPicking ||
        state.mapPickingTarget != OrderLocationTarget.pickupPoint) {
      return;
    }

    final pickupLocation = result.when(
      success: (location) => location,
      failure: (_) => _buildFallbackLocation(
        latitude: state.mapCameraLatitude,
        longitude: state.mapCameraLongitude,
      ),
    );

    final distanceMeters = Geolocator.distanceBetween(
      fromLocation.latitude,
      fromLocation.longitude,
      pickupLocation.latitude,
      pickupLocation.longitude,
    );

    if (distanceMeters > OrderConstants.pickupPointMaxDistanceMeters) {
      printY(
        '[OrderBloc] pickupPoint rejected distance=${distanceMeters.toStringAsFixed(1)}m',
      );
      emit(
        state.copyWith(
          sheetMode: OrderSheetMode.expanded,
          expandedStep: OrderExpandedStep.pickupPoint,
          pickupPointState: const BlocStatus.initial(),
          pickupConfirmationFeedbackState: BlocStatus.failure(
            AppStrings.pickupPointTooFar,
          ),
        ),
      );
      return;
    }

    printG(
      '[OrderBloc] pickupPoint selected distance=${distanceMeters.toStringAsFixed(1)}m label="${pickupLocation.label}"',
    );
    emit(
      state.copyWith(
        sheetMode: OrderSheetMode.expanded,
        expandedStep: OrderExpandedStep.pickupPoint,
        pickupPointState: BlocStatus.success(pickupLocation),
        pickupConfirmationFeedbackState: const BlocStatus.initial(),
      ),
    );
  }

  Future<void> _onConfirmMapPointPressed(
    _ConfirmMapPointPressed event,
    Emitter<OrderState> emit,
  ) async {
    if (state.mapPickingTarget == OrderLocationTarget.pickupPoint) {
      await _handlePickupMapPointConfirmation(emit);
      return;
    }

    _invalidateTripResolution();
    _invalidatePrefetch();
    final token = _tripResolutionToken;

    printM(
      '[OrderBloc] confirmMapPointPressed target=${state.mapPickingTarget.name} lat=${state.mapCameraLatitude} lng=${state.mapCameraLongitude}',
    );
    final result = await _facade.reverseGeocode(
      OrderReverseGeocodeRequestEntity(
        latitude: state.mapCameraLatitude,
        longitude: state.mapCameraLongitude,
      ),
    );

    await result.when(
      success: (location) async {
        if (!_isTripResolutionTokenCurrent(token)) {
          printY(
            '[OrderBloc] confirmMapPoint success dropped because token is stale token=$token current=$_tripResolutionToken',
          );
          return;
        }

        printG(
          '[OrderBloc] confirmMapPoint reverseGeocode success label="${location.label}"',
        );
        if (state.mapPickingTarget == OrderLocationTarget.from) {
          final nextState = _resetTripFlowState(state).copyWith(
            fromLocationState: BlocStatus.success(location),
            fromQuery: '',
            fromSuggestionsState: const BlocStatus.initial(),
            sheetMode: OrderSheetMode.expanded,
          );

          emit(nextState);
          printM(
            '[OrderBloc] confirmMapPoint from -> persist start identity=${_buildIdentityKey(location)}',
          );
          await _saveSelectedLocationAndRefresh(emit, location);
          printM(
            '[OrderBloc] confirmMapPoint from -> persist complete identity=${_buildIdentityKey(location)}',
          );

          final toLocation = _extractLocation(nextState.toLocationState);
          if (toLocation != null) {
            _tryStartTripPrefetch(
              emit: emit,
              fromLocation: location,
              toLocation: toLocation,
            );
          }

          return;
        }

        if (state.mapPickingTarget != OrderLocationTarget.to) {
          return;
        }

        final nextState = _resetTripFlowState(state).copyWith(
          toLocationState: BlocStatus.success(location),
          toQuery: '',
          toSuggestionsState: const BlocStatus.initial(),
          sheetMode: OrderSheetMode.expanded,
        );

        emit(nextState);
        printM(
          '[OrderBloc] confirmMapPoint to -> persist start identity=${_buildIdentityKey(location)}',
        );
        await _saveSelectedLocationAndRefresh(emit, location);
        printM(
          '[OrderBloc] confirmMapPoint to -> persist complete identity=${_buildIdentityKey(location)}',
        );

        final fromLocation = _extractLocation(nextState.fromLocationState);
        if (fromLocation != null) {
          _tryStartTripPrefetch(
            emit: emit,
            fromLocation: fromLocation,
            toLocation: location,
          );
        }
      },
      failure: (_) async {
        if (!_isTripResolutionTokenCurrent(token)) {
          printY(
            '[OrderBloc] confirmMapPoint failure dropped because token is stale token=$token current=$_tripResolutionToken',
          );
          return;
        }

        printY(
          '[OrderBloc] confirmMapPoint reverseGeocode failed -> fallback label',
        );
        final fallback = OrderLocationEntity(
          latitude: state.mapCameraLatitude,
          longitude: state.mapCameraLongitude,
          label:
              '${state.mapCameraLatitude.toStringAsFixed(6)}, ${state.mapCameraLongitude.toStringAsFixed(6)}',
          primaryName: AppStrings.droppedPin,
          secondaryAddress:
              '${state.mapCameraLatitude.toStringAsFixed(6)}, ${state.mapCameraLongitude.toStringAsFixed(6)}',
        );

        printC(
          '[OrderBloc:onConfirmMapPoint:fallback] primary="${fallback.primaryName}" secondary="${fallback.secondaryAddress}"',
        );



        if (state.mapPickingTarget == OrderLocationTarget.from) {
          final nextState = _resetTripFlowState(state).copyWith(
            fromLocationState: BlocStatus.success(fallback),
            fromQuery: '',
            fromSuggestionsState: const BlocStatus.initial(),
            sheetMode: OrderSheetMode.expanded,
          );

          emit(nextState);
          printM(
            '[OrderBloc] confirmMapPoint from fallback -> persist start identity=${_buildIdentityKey(fallback)}',
          );
          await _saveSelectedLocationAndRefresh(emit, fallback);
          printM(
            '[OrderBloc] confirmMapPoint from fallback -> persist complete identity=${_buildIdentityKey(fallback)}',
          );

          final toLocation = _extractLocation(nextState.toLocationState);
          if (toLocation != null) {
            _tryStartTripPrefetch(
              emit: emit,
              fromLocation: fallback,
              toLocation: toLocation,
            );
          }

          return;
        }

        if (state.mapPickingTarget != OrderLocationTarget.to) {
          return;
        }

        final nextState = _resetTripFlowState(state).copyWith(
          toLocationState: BlocStatus.success(fallback),
          toQuery: '',
          toSuggestionsState: const BlocStatus.initial(),
          sheetMode: OrderSheetMode.expanded,
        );

        emit(nextState);
        printM(
          '[OrderBloc] confirmMapPoint to fallback -> persist start identity=${_buildIdentityKey(fallback)}',
        );
        await _saveSelectedLocationAndRefresh(emit, fallback);
        printM(
          '[OrderBloc] confirmMapPoint to fallback -> persist complete identity=${_buildIdentityKey(fallback)}',
        );

        final fromLocation = _extractLocation(nextState.fromLocationState);
        if (fromLocation != null) {
          _tryStartTripPrefetch(
            emit: emit,
            fromLocation: fromLocation,
            toLocation: fallback,
          );
        }
      },
    );
  }

  Future<void> _onFromQueryChanged(
    _FromQueryChanged event,
    Emitter<OrderState> emit,
  ) async {
    _invalidateTripResolution();
    _invalidatePrefetch();

    final query = event.query.trim();
    printC(
      '[OrderBloc] fromQueryChanged query="${event.query}" trimmed="$query"',
    );

    if (query.isEmpty) {
      printM('[OrderBloc] fromQueryChanged cleared -> show saved suggestions');
      final savedCount = state.savedLocationsState.maybeWhen(
        success: (saved) => saved.length,
        orElse: () => 0,
      );
      printM(
        '[OrderBloc] fromQueryChanged cleared savedCount=$savedCount fromSelected=${state.fromLocationState.isSuccess}',
      );
      emit(
        _resetTripFlowState(state).copyWith(
          fromQuery: '',
          fromSuggestionsState: state.savedLocationsState.maybeWhen(
            success: (saved) => BlocStatus.success(
              _filterSavedLocationsByQuery(query: '', saved: saved),
            ),
            orElse: () => const BlocStatus.initial(),
          ),
          fromLocationState: const BlocStatus.initial(),
        ),
      );
      return;
    }

    emit(
      _resetTripFlowState(state).copyWith(
        fromQuery: query,
        fromSuggestionsState: const BlocStatus.loading(),
        fromLocationState: const BlocStatus.initial(),
      ),
    );

    final result = await _facade.searchLocations(
      OrderLocationSearchRequestEntity(query: query),
    );

    result.when(
      success: (locations) {
        if (state.fromQuery != query) {
          return;
        }

        printG(
          '[OrderBloc] fromQueryChanged success suggestions=${locations.length}',
        );
        emit(
          state.copyWith(
            fromSuggestionsState: BlocStatus.success(
              _savedLocationsFromSearchResults(locations),
            ),
          ),
        );
      },
      failure: (message) {
        if (state.fromQuery != query) {
          return;
        }

        printY('[OrderBloc] from search failed: $message');
        emit(state.copyWith(fromSuggestionsState: const BlocStatus.initial()));
      },
    );
  }

  Future<void> _onToQueryChanged(
    _ToQueryChanged event,
    Emitter<OrderState> emit,
  ) async {
    _invalidateTripResolution();
    _invalidatePrefetch();

    final query = event.query.trim();
    printC(
      '[OrderBloc] toQueryChanged query="${event.query}" trimmed="$query"',
    );

    if (query.isEmpty) {
      printM('[OrderBloc] toQueryChanged cleared -> show saved suggestions');
      final savedCount = state.savedLocationsState.maybeWhen(
        success: (saved) => saved.length,
        orElse: () => 0,
      );
      printM(
        '[OrderBloc] toQueryChanged cleared savedCount=$savedCount toSelected=${state.toLocationState.isSuccess}',
      );
      emit(
        _resetTripFlowState(state).copyWith(
          toQuery: '',
          toSuggestionsState: state.savedLocationsState.maybeWhen(
            success: (saved) => BlocStatus.success(
              _filterSavedLocationsByQuery(query: '', saved: saved),
            ),
            orElse: () => const BlocStatus.initial(),
          ),
          toLocationState: const BlocStatus.initial(),
        ),
      );
      return;
    }

    emit(
      _resetTripFlowState(state).copyWith(
        toQuery: query,
        toSuggestionsState: const BlocStatus.loading(),
        toLocationState: const BlocStatus.initial(),
      ),
    );

    final result = await _facade.searchLocations(
      OrderLocationSearchRequestEntity(query: query),
    );

    result.when(
      success: (locations) {
        if (state.toQuery != query) {
          return;
        }

        printG(
          '[OrderBloc] toQueryChanged success suggestions=${locations.length}',
        );
        emit(
          state.copyWith(
            toSuggestionsState: BlocStatus.success(
              _savedLocationsFromSearchResults(locations),
            ),
          ),
        );
      },
      failure: (message) {
        if (state.toQuery != query) {
          return;
        }

        printY('[OrderBloc] to search failed: $message');
        emit(state.copyWith(toSuggestionsState: const BlocStatus.initial()));
      },
    );
  }

  void _onFromLocationCleared(
    _FromLocationCleared event,
    Emitter<OrderState> emit,
  ) {
    _invalidateTripResolution();
    _invalidatePrefetch();
    printM(
      '[OrderBloc] fromLocationCleared -> reset from location/suggestions',
    );
    emit(
      _resetTripFlowState(state).copyWith(
        fromQuery: '',
        fromLocationState: const BlocStatus.initial(),
        fromSuggestionsState: state.savedLocationsState.maybeWhen(
          success: (saved) => BlocStatus.success(
            _filterSavedLocationsByQuery(query: '', saved: saved),
          ),
          orElse: () => const BlocStatus.initial(),
        ),
      ),
    );
  }

  void _onToLocationCleared(
    _ToLocationCleared event,
    Emitter<OrderState> emit,
  ) {
    _invalidateTripResolution();
    _invalidatePrefetch();
    printM('[OrderBloc] toLocationCleared -> reset to location/suggestions');
    emit(
      _resetTripFlowState(state).copyWith(
        toQuery: '',
        toLocationState: const BlocStatus.initial(),
        toSuggestionsState: state.savedLocationsState.maybeWhen(
          success: (saved) => BlocStatus.success(
            _filterSavedLocationsByQuery(query: '', saved: saved),
          ),
          orElse: () => const BlocStatus.initial(),
        ),
      ),
    );
  }

  Future<void> _onFromSuggestionSelected(
    _FromSuggestionSelected event,
    Emitter<OrderState> emit,
  ) async {
    _invalidateTripResolution();
    _invalidatePrefetch();
    printM(
      '[OrderBloc] fromSuggestionSelected lat=${event.location.location.latitude} lng=${event.location.location.longitude} label="${event.location.location.label}"',
    );

    final nextState = _resetTripFlowState(state).copyWith(
      fromQuery: '',
      fromLocationState: BlocStatus.success(event.location.location),
      fromSuggestionsState: const BlocStatus.initial(),
    );

    emit(nextState);
    printM(
      '[OrderBloc] fromSuggestionSelected persist start identity=${event.location.identityKey}',
    );
    await _saveSelectedLocationAndRefresh(emit, event.location.location);
    printM(
      '[OrderBloc] fromSuggestionSelected persist complete identity=${event.location.identityKey}',
    );

    final toLocation = _extractLocation(nextState.toLocationState);
    if (toLocation != null) {
      _tryStartTripPrefetch(
        emit: emit,
        fromLocation: event.location.location,
        toLocation: toLocation,
      );
    }
  }

  Future<void> _onToSuggestionSelected(
    _ToSuggestionSelected event,
    Emitter<OrderState> emit,
  ) async {
    _invalidateTripResolution();
    _invalidatePrefetch();
    printM(
      '[OrderBloc] toSuggestionSelected lat=${event.location.location.latitude} lng=${event.location.location.longitude} label="${event.location.location.label}"',
    );

    final nextState = _resetTripFlowState(state).copyWith(
      toQuery: '',
      toLocationState: BlocStatus.success(event.location.location),
      toSuggestionsState: const BlocStatus.initial(),
    );

    emit(nextState);
    printM(
      '[OrderBloc] toSuggestionSelected persist start identity=${event.location.identityKey}',
    );
    await _saveSelectedLocationAndRefresh(emit, event.location.location);
    printM(
      '[OrderBloc] toSuggestionSelected persist complete identity=${event.location.identityKey}',
    );

    final fromLocation = _extractLocation(nextState.fromLocationState);
    if (fromLocation != null) {
      _tryStartTripPrefetch(
        emit: emit,
        fromLocation: fromLocation,
        toLocation: event.location.location,
      );
    }
  }

  Future<void> _onSavedLocationPinToggled(
    _SavedLocationPinToggled event,
    Emitter<OrderState> emit,
  ) async {
    if (event.target == OrderLocationTarget.pickupPoint) {
      return;
    }

    printM(
      '[OrderBloc] savedLocationPinToggled target=${event.target.name} identity=${event.location.identityKey}',
    );

    await _toggleSavedLocationPinAndRefresh(
      emit: emit,
      target: event.target,
      savedLocation: event.location,
    );
  }

  void _onCarTypeToggled(_CarTypeToggled event, Emitter<OrderState> emit) {
    final nextSelection = state.selectedCarTypeId == event.typeId
        ? null
        : event.typeId;

    printM('[OrderBloc] carTypeToggled selectedType=$nextSelection');
    emit(state.copyWith(selectedCarTypeId: nextSelection));
  }

  void _onPickupStreetChanged(
    _PickupStreetChanged event,
    Emitter<OrderState> emit,
  ) {
    emit(state.copyWith(pickupStreetName: event.value));
  }

  void _onPickupHouseNumberChanged(
    _PickupHouseNumberChanged event,
    Emitter<OrderState> emit,
  ) {
    emit(state.copyWith(pickupHouseNumber: event.value));
  }

  Future<void> _onConfirmOrderPressed(
    _ConfirmOrderPressed event,
    Emitter<OrderState> emit,
  ) async {
    final fromLocation = _extractLocation(state.fromLocationState);
    final toLocation = _extractLocation(state.toLocationState);

    if (fromLocation == null || toLocation == null) {
      printY('[OrderBloc] confirmOrderPressed blocked (locations not ready)');
      return;
    }

    final hasValidPrefetch = _isPrefetchCacheValid(fromLocation, toLocation);

    final prefetchedRouteState = hasValidPrefetch
        ? state.prefetchedTripRouteState
        : const BlocStatus<OrderTripRouteEntity>.initial();
    final prefetchedPricingState = hasValidPrefetch
        ? state.prefetchedTripCarOptionsState
        : const BlocStatus<List<OrderTripCarOptionEntity>>.initial();

    final reusePrefetchedRoute =
        prefetchedRouteState.isSuccess || prefetchedRouteState.isLoading;
    final reusePrefetchedPricing =
        prefetchedPricingState.isSuccess || prefetchedPricingState.isLoading;

    printM(
      '[OrderBloc] confirmOrderPressed hasValidPrefetch=$hasValidPrefetch reuseRoute=$reusePrefetchedRoute reusePricing=$reusePrefetchedPricing',
    );

    emit(
      state.copyWith(
        expandedStep: OrderExpandedStep.carSelection,
        tripRouteState: reusePrefetchedRoute && prefetchedRouteState.isSuccess
            ? prefetchedRouteState
            : const BlocStatus.loading(),
        tripCarOptionsState:
            reusePrefetchedPricing && prefetchedPricingState.isSuccess
            ? prefetchedPricingState
            : const BlocStatus.loading(),
        selectedCarTypeId: null,
        pickupPointState: const BlocStatus.initial(),
        pickupStreetName: '',
        pickupHouseNumber: '',
        pickupConfirmationFeedbackState: const BlocStatus.initial(),
      ),
    );

    if (reusePrefetchedRoute && reusePrefetchedPricing) {
      return;
    }

    final token = ++_tripResolutionToken;

    Future<Result<OrderTripRouteEntity>>? routeFuture;
    Future<Result<List<OrderTripCarOptionEntity>>>? pricingFuture;

    if (!reusePrefetchedRoute) {
      routeFuture = _facade.getTripRoute(
        OrderTripRouteRequestEntity(
          fromLatitude: fromLocation.latitude,
          fromLongitude: fromLocation.longitude,
          toLatitude: toLocation.latitude,
          toLongitude: toLocation.longitude,
        ),
      );
    }

    if (!reusePrefetchedPricing) {
      pricingFuture = _facade.getTripCarOptions(
        OrderTripPricingRequestEntity(
          fromLatitude: fromLocation.latitude,
          fromLongitude: fromLocation.longitude,
          toLatitude: toLocation.latitude,
          toLongitude: toLocation.longitude,
        ),
      );
    }

    if (routeFuture != null) {
      final routeResult = await routeFuture;
      if (!_isTripResolutionTokenCurrent(token)) {
        return;
      }

      routeResult.when(
        success: (route) {
          printG(
            '[OrderBloc] confirmOrderPressed route success duration="${route.durationText}" points=${route.points.length}',
          );
          emit(state.copyWith(tripRouteState: BlocStatus.success(route)));
        },
        failure: (message) {
          printY('[OrderBloc] confirmOrderPressed route failure=$message');
          emit(state.copyWith(tripRouteState: BlocStatus.failure(message)));
        },
      );
    }

    if (pricingFuture != null) {
      final pricingResult = await pricingFuture;
      if (!_isTripResolutionTokenCurrent(token)) {
        return;
      }

      pricingResult.when(
        success: (options) {
          printG(
            '[OrderBloc] confirmOrderPressed pricing success options=${options.length}',
          );
          emit(
            state.copyWith(tripCarOptionsState: BlocStatus.success(options)),
          );
        },
        failure: (message) {
          printY('[OrderBloc] confirmOrderPressed pricing failure=$message');
          emit(
            state.copyWith(tripCarOptionsState: BlocStatus.failure(message)),
          );
        },
      );
    }
  }

  void _onConfirmCarSelectionPressed(
    _ConfirmCarSelectionPressed event,
    Emitter<OrderState> emit,
  ) {
    if (state.selectedCarTypeId == null ||
        state.selectedCarTypeId!.trim().isEmpty) {
      printY(
        '[OrderBloc] confirmCarSelectionPressed blocked (no car selected)',
      );
      return;
    }

    printC(
      '[OrderBloc] confirmCarSelectionPressed -> pickupPoint selectedType=${state.selectedCarTypeId}',
    );
    emit(
      state.copyWith(
        sheetMode: OrderSheetMode.expanded,
        expandedStep: OrderExpandedStep.pickupPoint,
        mapPickingTarget: OrderLocationTarget.pickupPoint,
        pickupPointState: state.fromLocationState,
      ),
    );
  }


  void _onConfirmPickupPointPressed(
    _ConfirmPickupPointPressed event,
    Emitter<OrderState> emit,
  ) {
    final fromLocation = _extractLocation(state.fromLocationState);
    final pickupLocation = state.pickupPointState.maybeWhen(
      success: (location) => location,
      orElse: () => null,
    );

    if (fromLocation == null) {
      emit(
        state.copyWith(
          pickupConfirmationFeedbackState: BlocStatus.failure(
            AppStrings.somethingWentWrong,
          ),
        ),
      );
      return;
    }

    if (pickupLocation == null) {
      emit(
        state.copyWith(
          pickupConfirmationFeedbackState: BlocStatus.failure(
            AppStrings.pickupPointRequired,
          ),
        ),
      );
      return;
    }

    final distanceMeters = Geolocator.distanceBetween(
      fromLocation.latitude,
      fromLocation.longitude,
      pickupLocation.latitude,
      pickupLocation.longitude,
    );

    if (distanceMeters > OrderConstants.pickupPointMaxDistanceMeters) {
      emit(
        state.copyWith(
          pickupConfirmationFeedbackState: BlocStatus.failure(
            AppStrings.pickupPointTooFar,
          ),
        ),
      );
      return;
    }

    printG(
      '[OrderBloc] confirmPickupPointPressed success pickup="${pickupLocation.label}" street="${state.pickupStreetName}" house="${state.pickupHouseNumber}" -> move to bookingDetails',
    );
    emit(
      state.copyWith(
        expandedStep: OrderExpandedStep.bookingDetails,
        sheetMode: OrderSheetMode.expanded,
      ),
    );
  }

  void _onBookingDetailsBackPressed(
    _BookingDetailsBackPressed event,
    Emitter<OrderState> emit,
  ) {
    emit(state.copyWith(expandedStep: OrderExpandedStep.pickupPoint));
  }

  void _onScheduleTimeChanged(
    _ScheduleTimeChanged event,
    Emitter<OrderState> emit,
  ) {
    emit(state.copyWith(scheduledAt: event.time));
  }

  void _onPaymentMethodChanged(
    _PaymentMethodChanged event,
    Emitter<OrderState> emit,
  ) {
    emit(state.copyWith(paymentMethodId: event.methodId));
  }

  Future<void> _onConfirmBookingDetailsPressed(
    _ConfirmBookingDetailsPressed event,
    Emitter<OrderState> emit,
  ) async {
    printG(
      '[OrderBloc] confirmBookingDetailsPressed scheduledAt=${state.scheduledAt} paymentMethodId=${state.paymentMethodId}',
    );

    // Final order confirmation logic goes here
    emit(
      state.copyWith(
        pickupConfirmationFeedbackState: BlocStatus.success(
          AppStrings.orderConfirmedSuccess,
        ),
      ),
    );
    add(const OrderEvent.collapseRequested());
  }

  void _onPickupConfirmationFeedbackCleared(
    _PickupConfirmationFeedbackCleared event,
    Emitter<OrderState> emit,
  ) {
    if (state.pickupConfirmationFeedbackState.isInit) {
      return;
    }

    emit(
      state.copyWith(
        pickupConfirmationFeedbackState: const BlocStatus.initial(),
      ),
    );
  }
}
