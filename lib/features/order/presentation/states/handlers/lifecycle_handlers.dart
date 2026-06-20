part of '../order_bloc.dart';

extension _LifecycleHandlers on OrderBloc {
  OrderState _resetTripFlowState(OrderState source) {
    final initialStops = [source.stops.list.first, null];
    final initialQueries = [source.stops.queries.first, ''];
    final initialSavedSuggestion = source.stops.savedState.maybeWhen(
      success: (saved) =>
          BlocStatus.success(SavedLocationsHelper.sorted(saved)),
      orElse: () => const BlocStatus<List<OrderSavedLocationEntity>>.initial(),
    );
    final initialSuggestions = <BlocStatus<List<OrderSavedLocationEntity>>>[
      initialSavedSuggestion,
      initialSavedSuggestion,
    ];

    return source.copyWith(
      sheet: source.sheet.copyWith(
        expandedStep: OrderExpandedStep.locationEntry,
        mapPickingTarget: OrderLocationTarget.stop,
        activeStopIndex: 1,
      ),
      stops: source.stops.copyWith(
        list: initialStops,
        queries: initialQueries,
        suggestionsState: initialSuggestions,
      ),
      trip: const OrderTripSlice(),
      booking: OrderBookingSlice(scheduleMode: source.booking.scheduleMode),
    );
  }

  Future<void> _onStarted(_Started event, Emitter<OrderState> emit) async {
    final savedLocationsResult = await _facade.getSavedLocations();
    savedLocationsResult.when(
      success: (saved) {
        emit(
          state.copyWith(
            stops: state.stops.copyWith(
              savedState: BlocStatus.success(
                SavedLocationsHelper.sorted(saved),
              ),
            ),
          ),
        );
      },
      failure: (_) => emit(
        state.copyWith(
          stops: state.stops.copyWith(savedState: const BlocStatus.initial()),
        ),
      ),
    );

    final lastKnown = await _locationService.getLastKnownPosition();
    final latitude = lastKnown?.latitude ?? MapConfig.defaultLat;
    final longitude = lastKnown?.longitude ?? MapConfig.defaultLng;

    final savedSuggestion = state.stops.savedState.maybeWhen(
      success: (saved) =>
          BlocStatus.success(SavedLocationsHelper.sorted(saved)),
      orElse: () => const BlocStatus<List<OrderSavedLocationEntity>>.initial(),
    );

    emit(
      state.copyWith(
        map: OrderMapSlice(
          latitude: latitude,
          longitude: longitude,
          zoom: MapConfig.focusZoom,
        ),
        stops: state.stops.copyWith(
          list: [null, null],
          queries: ['', ''],
          suggestionsState: [savedSuggestion, savedSuggestion],
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
        final nextStops = List<OrderLocationEntity?>.from(state.stops.list);
        nextStops[0] = location;

        final nextQueries = List<String>.from(state.stops.queries);
        nextQueries[0] = location.label;

        emit(
          state.copyWith(
            stops: state.stops.copyWith(list: nextStops, queries: nextQueries),
            sheet: state.sheet.copyWith(mode: OrderSheetMode.collapsed),
          ),
        );
      },
      failure: (_) {
        final fallback = SavedLocationsHelper.buildFallbackLocation(
          latitude: latitude,
          longitude: longitude,
        );
        printC(
          '[OrderBloc:_onStarted] fallback primary="${fallback.primaryName}" secondary="${fallback.secondaryAddress}"',
        );

        final nextStops = List<OrderLocationEntity?>.from(state.stops.list);
        nextStops[0] = fallback;

        final nextQueries = List<String>.from(state.stops.queries);
        nextQueries[0] = fallback.label;

        emit(
          state.copyWith(
            stops: state.stops.copyWith(list: nextStops, queries: nextQueries),
            sheet: state.sheet.copyWith(mode: OrderSheetMode.collapsed),
          ),
        );
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

    final reset = _resetTripFlowState(state);
    emit(
      reset.copyWith(
        sheet: reset.sheet.copyWith(mode: OrderSheetMode.expanded),
      ),
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
    final reset = _resetTripFlowState(state);
    emit(
      reset.copyWith(
        sheet: reset.sheet.copyWith(mode: OrderSheetMode.collapsed),
      ),
    );
  }
}
