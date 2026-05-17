part of '../order_bloc.dart';

extension _SuggestionsHelpers on OrderBloc {
  BlocStatus<List<OrderSavedLocationEntity>> _buildSuggestionsState({
    required int index,
    required List<OrderSavedLocationEntity> source,
  }) {
    final query = state.stops.queries[index];
    final targetHasSelection = state.stops.list[index] != null;

    printM(
      '[OrderBloc] buildSuggestionsState index=$index query="$query" sourceCount=${source.length} targetHasSelection=$targetHasSelection',
    );

    final trimmedQuery = query.trim();
    if (trimmedQuery.isNotEmpty) {
      return state.stops.suggestionsState[index];
    }

    if (targetHasSelection) {
      return const BlocStatus.initial();
    }

    final filtered = SavedLocationsHelper.filterByQuery(
      query: '',
      saved: source,
    );
    return BlocStatus.success(filtered);
  }

  void _refreshSuggestionsFromSavedLocations(
    Emitter<OrderState> emit,
    List<OrderSavedLocationEntity> saved,
  ) {
    final normalizedSaved = SavedLocationsHelper.normalizeForUi(saved);

    final nextSuggestions =
        List<BlocStatus<List<OrderSavedLocationEntity>>>.generate(
          state.stops.list.length,
          (i) => _buildSuggestionsState(index: i, source: normalizedSaved),
        );

    if (emit.isDone) return;

    emit(
      state.copyWith(
        stops: state.stops.copyWith(
          savedState: BlocStatus.success(normalizedSaved),
          suggestionsState: nextSuggestions,
        ),
      ),
    );
  }

  List<OrderSavedLocationEntity> _buildFallbackSavedLocations(
    OrderLocationEntity location,
  ) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final identityKey = SavedLocationsHelper.identityKey(location);
    final currentSaved = state.stops.savedState.maybeWhen(
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

    return SavedLocationsHelper.normalizeForUi(merged.values.toList());
  }

  Future<void> _saveSelectedLocationAndRefresh(
    Emitter<OrderState> emit,
    OrderLocationEntity location,
  ) async {
    printM(
      '[OrderBloc] saveSelectedLocationAndRefresh start identity=${SavedLocationsHelper.identityKey(location)} label="${location.label}" emitDone=${emit.isDone}',
    );

    final result = await _facade.saveSelectedLocation(location);
    result.when(
      success: (saved) {
        printG(
          '[OrderBloc] saveSelectedLocation success identity=${SavedLocationsHelper.identityKey(location)} count=${saved.length}',
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
          '[OrderBloc] saveSelectedLocation applied in-memory fallback count=${fallbackSaved.length} identities=${SavedLocationsHelper.identityPreview(fallbackSaved)}',
        );
      },
    );
  }

  Future<void> _toggleSavedLocationPinAndRefresh({
    required Emitter<OrderState> emit,
    required OrderSavedLocationEntity savedLocation,
  }) async {
    final result = await _facade.togglePinnedLocation(savedLocation.location);

    result.when(
      success: (saved) {
        printG(
          '[OrderBloc] togglePinnedLocation success identity=${savedLocation.identityKey} count=${saved.length}',
        );

        final sortedSaved = SavedLocationsHelper.sorted(saved);
        final suggestionsByIdentity = <String, OrderSavedLocationEntity>{
          for (final item in sortedSaved) item.identityKey: item,
        };

        final nextSuggestions =
            List<BlocStatus<List<OrderSavedLocationEntity>>>.from(
              state.stops.suggestionsState,
            );

        for (var i = 0; i < nextSuggestions.length; i++) {
          final currentSuggestions = nextSuggestions[i];
          if (state.stops.queries[i].trim().isEmpty) {
            nextSuggestions[i] = BlocStatus.success(
              SavedLocationsHelper.filterByQuery(
                query: '',
                saved: sortedSaved,
              ),
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
            stops: state.stops.copyWith(
              savedState: BlocStatus.success(sortedSaved),
              suggestionsState: nextSuggestions,
            ),
          ),
        );
      },
      failure: (message) {
        printY('[OrderBloc] togglePinnedLocation failure=$message');
      },
    );
  }
}
