part of '../order_bloc.dart';

extension _StopsHandlers on OrderBloc {
  void _onActiveStopChanged(
    _ActiveStopChanged event,
    Emitter<OrderState> emit,
  ) {
    printM('[OrderBloc] activeStopChanged index=${event.index}');
    emit(
      state.copyWith(
        sheet: state.sheet.copyWith(activeStopIndex: event.index),
      ),
    );
  }

  Future<void> _onStopQueryChanged(
    _StopQueryChanged event,
    Emitter<OrderState> emit,
  ) async {
    printM(
      '[OrderBloc] stopQueryChanged index=${event.index} query="${event.query}"',
    );
    final nextQueries = List<String>.from(state.stops.queries);
    nextQueries[event.index] = event.query;

    final nextSuggestions =
        List<BlocStatus<List<OrderSavedLocationEntity>>>.from(
          state.stops.suggestionsState,
        );

    if (event.query.trim().isEmpty) {
      nextSuggestions[event.index] = state.stops.savedState.maybeWhen(
        success: (saved) =>
            BlocStatus.success(SavedLocationsHelper.sorted(saved)),
        orElse: () => const BlocStatus.initial(),
      );
    } else {
      nextSuggestions[event.index] = const BlocStatus.loading();
    }

    emit(
      state.copyWith(
        stops: state.stops.copyWith(
          queries: nextQueries,
          suggestionsState: nextSuggestions,
        ),
      ),
    );

    if (event.query.trim().isNotEmpty) {
      var biasLat = state.map.latitude;
      var biasLng = state.map.longitude;

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

      if (emit.isDone || state.stops.queries[event.index] != event.query) {
        return;
      }

      result.when(
        success: (locations) {
          final nextSuggestionsWithResults =
              List<BlocStatus<List<OrderSavedLocationEntity>>>.from(
                state.stops.suggestionsState,
              );
          nextSuggestionsWithResults[event.index] = BlocStatus.success(
            SavedLocationsHelper.fromSearchResults(locations),
          );
          emit(
            state.copyWith(
              stops: state.stops.copyWith(
                suggestionsState: nextSuggestionsWithResults,
              ),
            ),
          );
        },
        failure: (msg) {
          final nextSuggestionsWithError =
              List<BlocStatus<List<OrderSavedLocationEntity>>>.from(
                state.stops.suggestionsState,
              );
          nextSuggestionsWithError[event.index] = BlocStatus.failure(msg);
          emit(
            state.copyWith(
              stops: state.stops.copyWith(
                suggestionsState: nextSuggestionsWithError,
              ),
            ),
          );
        },
      );
    }
  }

  void _onStopCleared(_StopCleared event, Emitter<OrderState> emit) {
    final nextStops = List<OrderLocationEntity?>.from(state.stops.list);
    nextStops[event.index] = null;

    final nextQueries = List<String>.from(state.stops.queries);
    nextQueries[event.index] = '';

    final nextSuggestions =
        List<BlocStatus<List<OrderSavedLocationEntity>>>.from(
          state.stops.suggestionsState,
        );
    nextSuggestions[event.index] = state.stops.savedState.maybeWhen(
      success: (saved) =>
          BlocStatus.success(SavedLocationsHelper.sorted(saved)),
      orElse: () => const BlocStatus.initial(),
    );

    emit(
      state.copyWith(
        stops: state.stops.copyWith(
          list: nextStops,
          queries: nextQueries,
          suggestionsState: nextSuggestions,
        ),
        trip: state.trip.copyWith(
          routeState: const BlocStatus.initial(),
          carOptionsState: const BlocStatus.initial(),
        ),
      ),
    );

    _invalidateTripResolution();
    _invalidatePrefetch();
  }

  Future<void> _onStopSuggestionSelected(
    _StopSuggestionSelected event,
    Emitter<OrderState> emit,
  ) async {
    printM(
      '[OrderBloc] stopSuggestionSelected index=${event.index} label="${event.location.location.label}"',
    );
    final nextStops = List<OrderLocationEntity?>.from(state.stops.list);
    nextStops[event.index] = event.location.location;

    final nextQueries = List<String>.from(state.stops.queries);
    nextQueries[event.index] = event.location.location.label;

    printM(
      '[OrderBloc] stopSuggestionSelected emitting updated stopQueries: $nextQueries',
    );
    emit(
      state.copyWith(
        stops: state.stops.copyWith(list: nextStops, queries: nextQueries),
      ),
    );

    printM(
      '[OrderBloc] stopSuggestionSelected invalidating trip resolution and prefetch',
    );
    _invalidateTripResolution();
    _invalidatePrefetch();

    printM('[OrderBloc] stopSuggestionSelected trying start trip prefetch');
    _tryStartTripPrefetch(emit: emit, currentStops: nextStops);

    printM('[OrderBloc] stopSuggestionSelected saving location and refreshing');
    await _saveSelectedLocationAndRefresh(emit, event.location.location);
    printG('[OrderBloc] stopSuggestionSelected completed');
  }

  void _onStopAdded(_StopAdded event, Emitter<OrderState> emit) {
    if (state.stops.list.length >= 5) return;

    final nextStops = List<OrderLocationEntity?>.from(state.stops.list);
    nextStops.insert(nextStops.length - 1, null);

    final nextQueries = List<String>.from(state.stops.queries);
    nextQueries.insert(nextQueries.length - 1, '');

    final nextSuggestions =
        List<BlocStatus<List<OrderSavedLocationEntity>>>.from(
          state.stops.suggestionsState,
        );
    nextSuggestions.insert(
      nextSuggestions.length - 1,
      state.stops.savedState.maybeWhen(
        success: (saved) =>
            BlocStatus.success(SavedLocationsHelper.sorted(saved)),
        orElse: () => const BlocStatus.initial(),
      ),
    );

    emit(
      state.copyWith(
        stops: state.stops.copyWith(
          list: nextStops,
          queries: nextQueries,
          suggestionsState: nextSuggestions,
        ),
        sheet: state.sheet.copyWith(activeStopIndex: nextStops.length - 2),
      ),
    );

    _invalidateTripResolution();
    _invalidatePrefetch();
  }

  void _onStopRemoved(_StopRemoved event, Emitter<OrderState> emit) {
    if (state.stops.list.length <= 2) return;

    final nextStops = List<OrderLocationEntity?>.from(state.stops.list);
    nextStops.removeAt(event.index);

    final nextQueries = List<String>.from(state.stops.queries);
    nextQueries.removeAt(event.index);

    final nextSuggestions =
        List<BlocStatus<List<OrderSavedLocationEntity>>>.from(
          state.stops.suggestionsState,
        );
    nextSuggestions.removeAt(event.index);

    emit(
      state.copyWith(
        stops: state.stops.copyWith(
          list: nextStops,
          queries: nextQueries,
          suggestionsState: nextSuggestions,
        ),
        sheet: state.sheet.copyWith(activeStopIndex: 0),
      ),
    );

    _invalidateTripResolution();
    _invalidatePrefetch();
    _tryStartTripPrefetch(emit: emit, currentStops: nextStops);
  }

  void _onStopReordered(_StopReordered event, Emitter<OrderState> emit) {
    final nextStops = List<OrderLocationEntity?>.from(state.stops.list);
    final item = nextStops.removeAt(event.oldIndex);
    nextStops.insert(event.newIndex, item);

    final nextQueries = List<String>.from(state.stops.queries);
    final query = nextQueries.removeAt(event.oldIndex);
    nextQueries.insert(event.newIndex, query);

    final nextSuggestions =
        List<BlocStatus<List<OrderSavedLocationEntity>>>.from(
          state.stops.suggestionsState,
        );
    final suggestion = nextSuggestions.removeAt(event.oldIndex);
    nextSuggestions.insert(event.newIndex, suggestion);

    emit(
      state.copyWith(
        stops: state.stops.copyWith(
          list: nextStops,
          queries: nextQueries,
          suggestionsState: nextSuggestions,
        ),
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
      savedLocation: event.location,
    );
  }
}
