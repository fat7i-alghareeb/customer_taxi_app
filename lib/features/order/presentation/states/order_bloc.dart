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
import '../../domain/entities/order_trip_response_entity.dart';
import '../../domain/entities/order_trip_route_entity.dart';
import '../../domain/facade/order_facade.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

enum OrderSheetMode { collapsed, expanded, mapPicking }

enum OrderLocationTarget { stop, pickupPoint }

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
    on<_ActiveStopChanged>(_onActiveStopChanged);
    on<_StopQueryChanged>(_onStopQueryChanged);
    on<_StopCleared>(_onStopCleared);
    on<_StopSuggestionSelected>(_onStopSuggestionSelected);
    on<_StopAdded>(_onStopAdded);
    on<_StopRemoved>(_onStopRemoved);
    on<_StopReordered>(_onStopReordered);
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
    required int index,
    required List<OrderSavedLocationEntity> source,
  }) {
    final query = state.stopQueries[index];
    final targetHasSelection = state.stops[index] != null;

    printM(
      '[OrderBloc] buildSuggestionsState index=$index query="$query" sourceCount=${source.length} targetHasSelection=$targetHasSelection',
    );

    final trimmedQuery = query.trim();
    if (trimmedQuery.isNotEmpty) {
      return state.stopSuggestionsState[index];
    }

    if (targetHasSelection) {
      return const BlocStatus.initial();
    }

    final filtered = _filterSavedLocationsByQuery(query: '', saved: source);
    return BlocStatus.success(filtered);
  }

  void _refreshSuggestionsFromSavedLocations(
    Emitter<OrderState> emit,
    List<OrderSavedLocationEntity> saved,
  ) {
    final normalizedSaved = _normalizeSavedLocationsForUi(saved);

    final nextSuggestions =
        List<BlocStatus<List<OrderSavedLocationEntity>>>.generate(
          state.stops.length,
          (i) => _buildSuggestionsState(index: i, source: normalizedSaved),
        );

    if (emit.isDone) return;

    emit(
      state.copyWith(
        savedLocationsState: BlocStatus.success(normalizedSaved),
        stopSuggestionsState: nextSuggestions,
      ),
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
        final suggestionsByIdentity = <String, OrderSavedLocationEntity>{
          for (final item in sortedSaved) item.identityKey: item,
        };

        final nextSuggestions =
            List<BlocStatus<List<OrderSavedLocationEntity>>>.from(
              state.stopSuggestionsState,
            );

        for (var i = 0; i < nextSuggestions.length; i++) {
          final currentSuggestions = nextSuggestions[i];
          if (state.stopQueries[i].trim().isEmpty) {
            nextSuggestions[i] = BlocStatus.success(
              _filterSavedLocationsByQuery(query: '', saved: sortedSaved),
            );
          } else {
            nextSuggestions[i] = currentSuggestions.maybeWhen(
              success: (items) {
                return BlocStatus.success(
                  items
                      .map(
                        (item) =>
                            suggestionsByIdentity[item.identityKey] ?? item,
                      )
                      .toList(),
                );
              },
              orElse: () => currentSuggestions,
            );
          }
        }

        emit(
          state.copyWith(
            savedLocationsState: BlocStatus.success(sortedSaved),
            stopSuggestionsState: nextSuggestions,
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

  bool _isPrefetchCacheValid(List<OrderLocationEntity> stops) {
    final prefetchedStops = state.prefetchedStops;

    if (prefetchedStops.length != stops.length) {
      return false;
    }

    for (var i = 0; i < stops.length; i++) {
      if (!_isSameLocationCoordinates(prefetchedStops[i], stops[i])) {
        return false;
      }
    }

    return true;
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
          return;
        }

        printG(
          '[OrderBloc] confirmMapPoint reverseGeocode success label="${location.label}"',
        );

        final index = state.activeStopIndex;
        final nextStops = List<OrderLocationEntity?>.from(state.stops);
        nextStops[index] = location;

        final nextQueries = List<String>.from(state.stopQueries);
        nextQueries[index] = location.label;

        final nextSuggestions =
            List<BlocStatus<List<OrderSavedLocationEntity>>>.from(
              state.stopSuggestionsState,
            );
        nextSuggestions[index] = state.savedLocationsState.maybeWhen(
          success: (saved) => BlocStatus.success(_sortedSavedLocations(saved)),
          orElse: () => const BlocStatus.initial(),
        );

        final nextState = _resetTripFlowState(state).copyWith(
          stops: nextStops,
          stopQueries: nextQueries,
          stopSuggestionsState: nextSuggestions,
          sheetMode: OrderSheetMode.expanded,
        );

        emit(nextState);
        await _saveSelectedLocationAndRefresh(emit, location);
        _tryStartTripPrefetch(emit: emit, currentStops: nextStops);
      },
      failure: (_) async {
        if (!_isTripResolutionTokenCurrent(token)) return;

        printY('[OrderBloc] confirmMapPoint reverseGeocode failed');
        emit(state.copyWith(sheetMode: OrderSheetMode.expanded));
      },
    );
  }

  void _tryStartTripPrefetch({
    required Emitter<OrderState> emit,
    List<OrderLocationEntity?>? currentStops,
  }) {
    final resolvedStops = (currentStops ?? state.stops)
        .whereType<OrderLocationEntity>()
        .toList();

    if (resolvedStops.length < 2) {
      return;
    }

    if (_isPrefetchCacheValid(resolvedStops)) {
      return;
    }

    final token = ++_prefetchToken;

    emit(
      state.copyWith(
        prefetchedStops: resolvedStops,
        prefetchedTripRouteState: const BlocStatus.loading(),
        prefetchedTripCarOptionsState: const BlocStatus.loading(),
      ),
    );

    unawaited(_resolveTripPrefetch(token: token, stops: resolvedStops));
  }

  Future<void> _resolveTripPrefetch({
    required int token,
    required List<OrderLocationEntity> stops,
  }) async {
    final stopCoords = stops
        .map(
          (s) => OrderStopCoordinateEntity(
            latitude: s.latitude,
            longitude: s.longitude,
          ),
        )
        .toList();

    final routeFuture = _facade.getTripRoute(
      OrderTripRouteRequestEntity(stops: stopCoords),
    );

    final pricingFuture = _facade.getPricingQuotes(
      OrderPricingQuotesRequestEntity(stops: stopCoords),
    );

    routeFuture.then((routeResult) {
      if (!_isPrefetchTokenCurrent(token) || isClosed) return;

      final routeState = routeResult.when(
        success: BlocStatus<OrderTripRouteEntity>.success,
        failure: BlocStatus<OrderTripRouteEntity>.failure,
      );

      add(
        OrderEvent.tripPrefetchCompleted(
          token: token,
          stops: stops,
          routeState: routeState,
          pricingState: const BlocStatus.loading(),
        ),
      );
    });

    pricingFuture.then((pricingResult) {
      if (!_isPrefetchTokenCurrent(token) || isClosed) return;

      final pricingState = pricingResult.when(
        success: BlocStatus<List<OrderTripCarOptionEntity>>.success,
        failure: BlocStatus<List<OrderTripCarOptionEntity>>.failure,
      );

      add(
        OrderEvent.tripPrefetchCompleted(
          token: token,
          stops: stops,
          routeState: const BlocStatus.loading(),
          pricingState: pricingState,
        ),
      );
    });
  }

  void _onTripPrefetchCompleted(
    _TripPrefetchCompleted event,
    Emitter<OrderState> emit,
  ) {
    if (!_isPrefetchTokenCurrent(event.token)) return;

    final currentStops = state.stops.whereType<OrderLocationEntity>().toList();
    if (currentStops.length != event.stops.length) return;

    for (var i = 0; i < currentStops.length; i++) {
      if (!_isSameLocationCoordinates(currentStops[i], event.stops[i])) return;
    }

    final nextPrefetchedTripRouteState = !event.routeState.isLoading
        ? event.routeState
        : state.prefetchedTripRouteState;
    final nextPrefetchedTripCarOptionsState = !event.pricingState.isLoading
        ? event.pricingState
        : state.prefetchedTripCarOptionsState;

    final nextTripRouteState =
        state.tripRouteState.isLoading && !event.routeState.isLoading
            ? event.routeState
            : state.tripRouteState;
    final nextTripCarOptionsState =
        state.tripCarOptionsState.isLoading && !event.pricingState.isLoading
            ? event.pricingState
            : state.tripCarOptionsState;

    emit(
      state.copyWith(
        prefetchedStops: event.stops,
        prefetchedTripRouteState: nextPrefetchedTripRouteState,
        prefetchedTripCarOptionsState: nextPrefetchedTripCarOptionsState,
        tripRouteState: nextTripRouteState,
        tripCarOptionsState: nextTripCarOptionsState,
      ),
    );
  }

  OrderState _resetTripFlowState(OrderState source) {
    final initialStops = [source.stops.first, null];
    final initialQueries = [source.stopQueries.first, ''];
    final initialSuggestions = <BlocStatus<List<OrderSavedLocationEntity>>>[
      source.savedLocationsState.maybeWhen(
        success: (saved) => BlocStatus.success(_sortedSavedLocations(saved)),
        orElse: () => const BlocStatus.initial(),
      ),
      source.savedLocationsState.maybeWhen(
        success: (saved) => BlocStatus.success(_sortedSavedLocations(saved)),
        orElse: () => const BlocStatus.initial(),
      ),
    ];

    return source.copyWith(
      expandedStep: OrderExpandedStep.locationEntry,
      mapPickingTarget: OrderLocationTarget.stop,
      activeStopIndex: 1,
      stops: initialStops,
      stopQueries: initialQueries,
      stopSuggestionsState: initialSuggestions,
      pickupPointState: const BlocStatus.initial(),
      pickupStreetName: '',
      pickupHouseNumber: '',
      pickupConfirmationFeedbackState: const BlocStatus.initial(),
      tripRouteState: const BlocStatus.initial(),
      tripCarOptionsState: const BlocStatus.initial(),
      prefetchedTripRouteState: const BlocStatus.initial(),
      prefetchedTripCarOptionsState: const BlocStatus.initial(),
      prefetchedStops: [],
      selectedCarTypeId: null,
      selectedQuoteId: null,
      scheduledAt: null,
      paymentMethodId: null,
      tripRequestStatus: const BlocStatus.initial(),
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
    final savedLocationsResult = await _facade.getSavedLocations();
    savedLocationsResult.when(
      success: (saved) {
        emit(
          state.copyWith(
            savedLocationsState: BlocStatus.success(
              _sortedSavedLocations(saved),
            ),
          ),
        );
      },
      failure: (_) =>
          emit(state.copyWith(savedLocationsState: const BlocStatus.initial())),
    );

    final lastKnown = await _locationService.getLastKnownPosition();
    final latitude = lastKnown?.latitude ?? MapConfig.defaultLat;
    final longitude = lastKnown?.longitude ?? MapConfig.defaultLng;

    emit(
      state.copyWith(
        mapCameraLatitude: latitude,
        mapCameraLongitude: longitude,
        mapCameraZoom: MapConfig.focusZoom,
        stops: [null, null],
        stopQueries: ['', ''],
        stopSuggestionsState: [
          state.savedLocationsState.maybeWhen(
            success: (saved) =>
                BlocStatus.success(_sortedSavedLocations(saved)),
            orElse: () => const BlocStatus.initial(),
          ),
          state.savedLocationsState.maybeWhen(
            success: (saved) =>
                BlocStatus.success(_sortedSavedLocations(saved)),
            orElse: () => const BlocStatus.initial(),
          ),
        ],
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
        final nextStops = List<OrderLocationEntity?>.from(state.stops);
        nextStops[0] = location;

        final nextQueries = List<String>.from(state.stopQueries);
        nextQueries[0] = location.label;

        emit(
          state.copyWith(
            stops: nextStops,
            stopQueries: nextQueries,
            sheetMode: OrderSheetMode.collapsed,
          ),
        );
      },
      failure: (_) {
        final fallback = _buildFallbackLocation(
          latitude: latitude,
          longitude: longitude,
        );
        final nextStops = List<OrderLocationEntity?>.from(state.stops);
        nextStops[0] = fallback;

        final nextQueries = List<String>.from(state.stopQueries);
        nextQueries[0] = fallback.label;

        emit(
          state.copyWith(
            stops: nextStops,
            stopQueries: nextQueries,
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
    emit(
      _resetTripFlowState(state).copyWith(sheetMode: OrderSheetMode.collapsed),
    );
  }

  void _onActiveStopChanged(
    _ActiveStopChanged event,
    Emitter<OrderState> emit,
  ) {
    printM('[OrderBloc] activeStopChanged index=${event.index}');
    emit(state.copyWith(activeStopIndex: event.index));
  }

  Future<void> _onStopQueryChanged(
    _StopQueryChanged event,
    Emitter<OrderState> emit,
  ) async {
    printM('[OrderBloc] stopQueryChanged index=${event.index} query="${event.query}"');
    final nextQueries = List<String>.from(state.stopQueries);
    nextQueries[event.index] = event.query;

    final nextSuggestions =
        List<BlocStatus<List<OrderSavedLocationEntity>>>.from(
          state.stopSuggestionsState,
        );

    if (event.query.trim().isEmpty) {
      nextSuggestions[event.index] = state.savedLocationsState.maybeWhen(
        success: (saved) => BlocStatus.success(_sortedSavedLocations(saved)),
        orElse: () => const BlocStatus.initial(),
      );
    } else {
      nextSuggestions[event.index] = const BlocStatus.loading();
    }

    emit(
      state.copyWith(
        stopQueries: nextQueries,
        stopSuggestionsState: nextSuggestions,
      ),
    );

    if (event.query.trim().isNotEmpty) {
      var biasLat = state.mapCameraLatitude;
      var biasLng = state.mapCameraLongitude;

      try {
        final lastKnown = await _locationService.getLastKnownPosition();
        if (lastKnown != null) {
          biasLat = lastKnown.latitude;
          biasLng = lastKnown.longitude;
        }
      } catch (error) {
        printY('[OrderBloc] getLastKnownPosition failed: $error');
      }

      final result = await _facade.searchLocations(
        OrderLocationSearchRequestEntity(
          query: event.query,
          biasLat: biasLat,
          biasLng: biasLng,
        ),
      );

      if (emit.isDone || state.stopQueries[event.index] != event.query) return;

      result.when(
        success: (locations) {
          final nextSuggestionsWithResults =
              List<BlocStatus<List<OrderSavedLocationEntity>>>.from(
                state.stopSuggestionsState,
              );
          nextSuggestionsWithResults[event.index] = BlocStatus.success(
            _savedLocationsFromSearchResults(locations),
          );
          emit(
            state.copyWith(stopSuggestionsState: nextSuggestionsWithResults),
          );
        },
        failure: (msg) {
          final nextSuggestionsWithError =
              List<BlocStatus<List<OrderSavedLocationEntity>>>.from(
                state.stopSuggestionsState,
              );
          nextSuggestionsWithError[event.index] = BlocStatus.failure(msg);
          emit(state.copyWith(stopSuggestionsState: nextSuggestionsWithError));
        },
      );
    }
  }

  void _onStopCleared(_StopCleared event, Emitter<OrderState> emit) {
    final nextStops = List<OrderLocationEntity?>.from(state.stops);
    nextStops[event.index] = null;

    final nextQueries = List<String>.from(state.stopQueries);
    nextQueries[event.index] = '';

    final nextSuggestions =
        List<BlocStatus<List<OrderSavedLocationEntity>>>.from(
          state.stopSuggestionsState,
        );
    nextSuggestions[event.index] = state.savedLocationsState.maybeWhen(
      success: (saved) => BlocStatus.success(_sortedSavedLocations(saved)),
      orElse: () => const BlocStatus.initial(),
    );

    emit(
      state.copyWith(
        stops: nextStops,
        stopQueries: nextQueries,
        stopSuggestionsState: nextSuggestions,
        tripRouteState: const BlocStatus.initial(),
        tripCarOptionsState: const BlocStatus.initial(),
      ),
    );

    _invalidateTripResolution();
    _invalidatePrefetch();
  }

  Future<void> _onStopSuggestionSelected(
    _StopSuggestionSelected event,
    Emitter<OrderState> emit,
  ) async {
    printM('[OrderBloc] stopSuggestionSelected index=${event.index} label="${event.location.location.label}"');
    final nextStops = List<OrderLocationEntity?>.from(state.stops);
    nextStops[event.index] = event.location.location;

    final nextQueries = List<String>.from(state.stopQueries);
    nextQueries[event.index] = event.location.location.label;

    printM('[OrderBloc] stopSuggestionSelected emitting updated stopQueries: $nextQueries');
    emit(state.copyWith(stops: nextStops, stopQueries: nextQueries));

    printM('[OrderBloc] stopSuggestionSelected invalidating trip resolution and prefetch');
    _invalidateTripResolution();
    _invalidatePrefetch();
    
    printM('[OrderBloc] stopSuggestionSelected trying start trip prefetch');
    _tryStartTripPrefetch(emit: emit, currentStops: nextStops);

    printM('[OrderBloc] stopSuggestionSelected saving location and refreshing');
    await _saveSelectedLocationAndRefresh(emit, event.location.location);
    printG('[OrderBloc] stopSuggestionSelected completed');
  }

  void _onStopAdded(_StopAdded event, Emitter<OrderState> emit) {
    if (state.stops.length >= 5) return;

    final nextStops = List<OrderLocationEntity?>.from(state.stops);
    nextStops.insert(nextStops.length - 1, null);

    final nextQueries = List<String>.from(state.stopQueries);
    nextQueries.insert(nextQueries.length - 1, '');

    final nextSuggestions =
        List<BlocStatus<List<OrderSavedLocationEntity>>>.from(
          state.stopSuggestionsState,
        );
    nextSuggestions.insert(
      nextSuggestions.length - 1,
      state.savedLocationsState.maybeWhen(
        success: (saved) => BlocStatus.success(_sortedSavedLocations(saved)),
        orElse: () => const BlocStatus.initial(),
      ),
    );

    emit(
      state.copyWith(
        stops: nextStops,
        stopQueries: nextQueries,
        stopSuggestionsState: nextSuggestions,
        activeStopIndex: nextStops.length - 2,
      ),
    );

    _invalidateTripResolution();
    _invalidatePrefetch();
  }

  void _onStopRemoved(_StopRemoved event, Emitter<OrderState> emit) {
    if (state.stops.length <= 2) return;

    final nextStops = List<OrderLocationEntity?>.from(state.stops);
    nextStops.removeAt(event.index);

    final nextQueries = List<String>.from(state.stopQueries);
    nextQueries.removeAt(event.index);

    final nextSuggestions =
        List<BlocStatus<List<OrderSavedLocationEntity>>>.from(
          state.stopSuggestionsState,
        );
    nextSuggestions.removeAt(event.index);

    emit(
      state.copyWith(
        stops: nextStops,
        stopQueries: nextQueries,
        stopSuggestionsState: nextSuggestions,
        activeStopIndex: 0,
      ),
    );

    _invalidateTripResolution();
    _invalidatePrefetch();
    _tryStartTripPrefetch(emit: emit, currentStops: nextStops);
  }

  void _onStopReordered(_StopReordered event, Emitter<OrderState> emit) {
    final nextStops = List<OrderLocationEntity?>.from(state.stops);
    final item = nextStops.removeAt(event.oldIndex);
    nextStops.insert(event.newIndex, item);

    final nextQueries = List<String>.from(state.stopQueries);
    final query = nextQueries.removeAt(event.oldIndex);
    nextQueries.insert(event.newIndex, query);

    final nextSuggestions =
        List<BlocStatus<List<OrderSavedLocationEntity>>>.from(
          state.stopSuggestionsState,
        );
    final suggestion = nextSuggestions.removeAt(event.oldIndex);
    nextSuggestions.insert(event.newIndex, suggestion);

    emit(
      state.copyWith(
        stops: nextStops,
        stopQueries: nextQueries,
        stopSuggestionsState: nextSuggestions,
      ),
    );

    _invalidateTripResolution();
    _invalidatePrefetch();
    _tryStartTripPrefetch(emit: emit, currentStops: nextStops);
  }

  Future<void> _onSavedLocationPinToggled(
    _SavedLocationPinToggled event,
    Emitter<OrderState> emit,
  ) async {
    await _toggleSavedLocationPinAndRefresh(
      emit: emit,
      target: OrderLocationTarget.stop,
      savedLocation: event.location,
    );
  }

  void _onCarTypeToggled(_CarTypeToggled event, Emitter<OrderState> emit) {
    final selectedQuoteId = state.tripCarOptionsState.maybeWhen(
      success: (options) {
        for (final option in options) {
          if (option.typeId == event.typeId) {
            return option.quoteId;
          }
        }
        return null;
      },
      orElse: () => null,
    );

    emit(
      state.copyWith(
        selectedCarTypeId: event.typeId,
        selectedQuoteId: selectedQuoteId,
      ),
    );
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

  void _onMapPickCancelled(_MapPickCancelled event, Emitter<OrderState> emit) {
    if (state.mapPickingTarget == OrderLocationTarget.pickupPoint) {
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
    final target = state.expandedStep == OrderExpandedStep.pickupPoint
        ? OrderLocationTarget.pickupPoint
        : OrderLocationTarget.stop;
    printM('[OrderBloc] setOnMapPressed target=${target.name}');
    emit(
      state.copyWith(
        sheetMode: OrderSheetMode.mapPicking,
        mapPickingTarget: target,
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

    final fromLocation = state.stops.first;
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

    final startLocation = state.stops.first;
    if (startLocation == null) return;

    printC(
      '[OrderBloc] confirmCarSelectionPressed -> pickupPoint selectedType=${state.selectedCarTypeId}',
    );
    emit(
      state.copyWith(
        sheetMode: OrderSheetMode.expanded,
        expandedStep: OrderExpandedStep.pickupPoint,
        mapPickingTarget: OrderLocationTarget.pickupPoint,
        pickupPointState: BlocStatus.success(startLocation),
      ),
    );
  }

  void _onConfirmPickupPointPressed(
    _ConfirmPickupPointPressed event,
    Emitter<OrderState> emit,
  ) {
    final fromLocation = state.stops.first;
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

  Future<void> _onConfirmOrderPressed(
    _ConfirmOrderPressed event,
    Emitter<OrderState> emit,
  ) async {
    final resolvedStops = state.stops.whereType<OrderLocationEntity>().toList();
    if (resolvedStops.length < 2) {
      return;
    }

    final hasValidPrefetch = _isPrefetchCacheValid(resolvedStops);
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

    emit(
      state.copyWith(
        expandedStep: OrderExpandedStep.carSelection,
        tripRouteState: reusePrefetchedRoute
            ? prefetchedRouteState
            : const BlocStatus.loading(),
        tripCarOptionsState: reusePrefetchedPricing
            ? prefetchedPricingState
            : const BlocStatus.loading(),
        selectedCarTypeId: null,
        selectedQuoteId: null,
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

    final stopCoords = resolvedStops
        .map(
          (s) => OrderStopCoordinateEntity(
            latitude: s.latitude,
            longitude: s.longitude,
          ),
        )
        .toList();

    final routeFuture = !reusePrefetchedRoute
        ? _facade.getTripRoute(OrderTripRouteRequestEntity(stops: stopCoords))
        : null;
    final pricingFuture = !reusePrefetchedPricing
        ? _facade.getPricingQuotes(
            OrderPricingQuotesRequestEntity(stops: stopCoords),
          )
        : null;

    await Future.wait([
      if (routeFuture != null)
        routeFuture.then((result) {
          if (emit.isDone || !_isTripResolutionTokenCurrent(token) || isClosed) {
            printM('[OrderBloc] routeFuture ignored (token mismatch or closed)', tag: false);
            return;
          }
          result.when(
            success: (route) {
              printM('[OrderBloc] getTripRoute success points=${route.points.length}', tag: false);
              emit(state.copyWith(tripRouteState: BlocStatus.success(route)));
            },
            failure: (msg) {
              printR('[OrderBloc] getTripRoute failure: $msg', tag: false);
              emit(state.copyWith(tripRouteState: BlocStatus.failure(msg)));
            },
          );
        }),
      if (pricingFuture != null)
        pricingFuture.then((result) {
          if (emit.isDone || !_isTripResolutionTokenCurrent(token) || isClosed) {
            printM('[OrderBloc] pricingFuture ignored (token mismatch or closed)', tag: false);
            return;
          }
          result.when(
            success: (options) {
              printM('[OrderBloc] getPricingQuotes success count=${options.length}', tag: false);
              emit(state.copyWith(tripCarOptionsState: BlocStatus.success(options)));
            },
            failure: (msg) {
              printR('[OrderBloc] getPricingQuotes failure: $msg', tag: false);
              emit(state.copyWith(tripCarOptionsState: BlocStatus.failure(msg)));
            },
          );
        }),
    ]);
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
    final quoteId = state.selectedQuoteId;
    if (quoteId == null) {
      printY('[OrderBloc] confirmBookingDetailsPressed blocked (no quote)');
      return;
    }

    final resolvedStops = state.stops.whereType<OrderLocationEntity>().toList();
    if (resolvedStops.length < 2) {
      printY(
        '[OrderBloc] confirmBookingDetailsPressed blocked (locations not ready)',
      );
      return;
    }

    final paymentMethodId = state.paymentMethodId;
    if (paymentMethodId == null) {
      printY('[OrderBloc] confirmBookingDetailsPressed blocked (no payment method)');
      return;
    }

    emit(state.copyWith(tripRequestStatus: const BlocStatus.loading()));

    final pickupLocation = state.pickupPointState.maybeWhen(
      success: (loc) => loc,
      orElse: () => resolvedStops.first,
    );

    final finalStops = List<OrderLocationEntity>.from(resolvedStops);
    finalStops[0] = pickupLocation;

    final stopCoords = finalStops
        .map(
          (s) => OrderStopCoordinateEntity(
            latitude: s.latitude,
            longitude: s.longitude,
          ),
        )
        .toList();

    final result = await _facade.requestTrip(
      OrderRequestTripEntity(
        quoteId: quoteId,
        stops: stopCoords,
        scheduledAt: state.scheduledAt,
      ),
    );

    result.when(
      success: (trip) {
        printG('[OrderBloc] requestTrip success id=${trip.id}');
        emit(state.copyWith(tripRequestStatus: BlocStatus.success(trip)));
      },
      failure: (message) {
        printY('[OrderBloc] requestTrip failure=$message');
        emit(state.copyWith(tripRequestStatus: BlocStatus.failure(message)));
      },
    );
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
