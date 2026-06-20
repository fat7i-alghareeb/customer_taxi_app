part of '../order_bloc.dart';

extension _TripResolutionHandlers on OrderBloc {
  bool _isPrefetchCacheValid(List<OrderLocationEntity> stops) {
    final prefetchedStops = state.trip.prefetchedStops;

    if (prefetchedStops.length != stops.length) return false;

    for (var i = 0; i < stops.length; i++) {
      if (!SavedLocationsHelper.isSameCoordinates(
        prefetchedStops[i],
        stops[i],
      )) {
        return false;
      }
    }

    return true;
  }

  void _tryStartTripPrefetch({
    required Emitter<OrderState> emit,
    List<OrderLocationEntity?>? currentStops,
  }) {
    final resolvedStops = (currentStops ?? state.stops.list)
        .whereType<OrderLocationEntity>()
        .toList();

    if (resolvedStops.length < 2) return;
    if (_isPrefetchCacheValid(resolvedStops)) return;

    final token = ++_prefetchToken;

    emit(
      state.copyWith(
        trip: state.trip.copyWith(
          prefetchedStops: resolvedStops,
          prefetchedRouteState: const BlocStatus.loading(),
          prefetchedCarOptionsState: const BlocStatus.loading(),
        ),
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
            isAirport: s.isAirport,
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

    final currentStops = state.stops.list
        .whereType<OrderLocationEntity>()
        .toList();
    if (currentStops.length != event.stops.length) return;

    for (var i = 0; i < currentStops.length; i++) {
      if (!SavedLocationsHelper.isSameCoordinates(
        currentStops[i],
        event.stops[i],
      )) {
        return;
      }
    }

    final trip = state.trip;
    final nextPrefetchedRoute = !event.routeState.isLoading
        ? event.routeState
        : trip.prefetchedRouteState;
    final nextPrefetchedCarOptions = !event.pricingState.isLoading
        ? event.pricingState
        : trip.prefetchedCarOptionsState;

    final nextRouteState =
        trip.routeState.isLoading && !event.routeState.isLoading
        ? event.routeState
        : trip.routeState;
    final nextCarOptionsState =
        trip.carOptionsState.isLoading && !event.pricingState.isLoading
        ? event.pricingState
        : trip.carOptionsState;

    emit(
      state.copyWith(
        trip: trip.copyWith(
          prefetchedStops: event.stops,
          prefetchedRouteState: nextPrefetchedRoute,
          prefetchedCarOptionsState: nextPrefetchedCarOptions,
          routeState: nextRouteState,
          carOptionsState: nextCarOptionsState,
        ),
      ),
    );
  }

  void _onCarTypeToggled(_CarTypeToggled event, Emitter<OrderState> emit) {
    final selectedQuoteId = state.trip.carOptionsState.maybeWhen(
      success: (options) {
        for (final option in options) {
          if (option.typeId == event.typeId) return option.quoteId;
        }
        return null;
      },
      orElse: () => null,
    );

    emit(
      state.copyWith(
        trip: state.trip.copyWith(
          selectedCarTypeId: event.typeId,
          selectedQuoteId: selectedQuoteId,
        ),
      ),
    );
  }

  void _onConfirmCarSelectionPressed(
    _ConfirmCarSelectionPressed event,
    Emitter<OrderState> emit,
  ) {
    final selectedCarTypeId = state.trip.selectedCarTypeId;
    if (selectedCarTypeId == null || selectedCarTypeId.trim().isEmpty) {
      printY(
        '[OrderBloc] confirmCarSelectionPressed blocked (no car selected)',
      );
      return;
    }

    final startLocation = state.stops.list.first;
    if (startLocation == null) return;
    if (startLocation.isAirport) {
      final flightNumber = state.booking.flightNumber
          .trim()
          .replaceAll(RegExp(r'\s+'), ' ')
          .toUpperCase();
      final isValid =
          flightNumber.length >= 2 &&
          flightNumber.length <= 15 &&
          RegExp(
            r'^[A-Z0-9](?:[A-Z0-9 -]{0,13}[A-Z0-9])?$',
          ).hasMatch(flightNumber);
      if (!isValid) {
        printY(
          '[OrderBloc] confirmCarSelectionPressed blocked (invalid flight number)',
        );
        return;
      }
    }

    printC(
      '[OrderBloc] confirmCarSelectionPressed -> bookingDetails selectedType=$selectedCarTypeId',
    );
    emit(
      state.copyWith(
        sheet: state.sheet.copyWith(
          mode: OrderSheetMode.expanded,
          expandedStep: OrderExpandedStep.bookingDetails,
        ),
      ),
    );
  }

  Future<void> _onConfirmOrderPressed(
    _ConfirmOrderPressed event,
    Emitter<OrderState> emit,
  ) async {
    final resolvedStops = state.stops.list
        .whereType<OrderLocationEntity>()
        .toList();
    if (resolvedStops.length < 2) return;

    final hasValidPrefetch = _isPrefetchCacheValid(resolvedStops);
    final prefetchedRouteState = hasValidPrefetch
        ? state.trip.prefetchedRouteState
        : const BlocStatus<OrderTripRouteEntity>.initial();
    final prefetchedPricingState = hasValidPrefetch
        ? state.trip.prefetchedCarOptionsState
        : const BlocStatus<List<OrderTripCarOptionEntity>>.initial();

    final reusePrefetchedRoute =
        prefetchedRouteState.isSuccess || prefetchedRouteState.isLoading;
    final reusePrefetchedPricing =
        prefetchedPricingState.isSuccess || prefetchedPricingState.isLoading;

    emit(
      state.copyWith(
        sheet: state.sheet.copyWith(
          expandedStep: OrderExpandedStep.carSelection,
        ),
        trip: state.trip.copyWith(
          routeState: reusePrefetchedRoute
              ? prefetchedRouteState
              : const BlocStatus.loading(),
          carOptionsState: reusePrefetchedPricing
              ? prefetchedPricingState
              : const BlocStatus.loading(),
          selectedCarTypeId: null,
          selectedQuoteId: null,
        ),
      ),
    );

    if (reusePrefetchedRoute && reusePrefetchedPricing) return;

    final token = ++_tripResolutionToken;

    final stopCoords = resolvedStops
        .map(
          (s) => OrderStopCoordinateEntity(
            latitude: s.latitude,
            longitude: s.longitude,
            isAirport: s.isAirport,
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
          if (emit.isDone ||
              !_isTripResolutionTokenCurrent(token) ||
              isClosed) {
            printM(
              '[OrderBloc] routeFuture ignored (token mismatch or closed)',
              tag: false,
            );
            return;
          }
          result.when(
            success: (route) {
              printM(
                '[OrderBloc] getTripRoute success points=${route.points.length}',
                tag: false,
              );
              emit(
                state.copyWith(
                  trip: state.trip.copyWith(
                    routeState: BlocStatus.success(route),
                  ),
                ),
              );
            },
            failure: (msg) {
              printR('[OrderBloc] getTripRoute failure: $msg', tag: false);
              emit(
                state.copyWith(
                  trip: state.trip.copyWith(
                    routeState: BlocStatus.failure(msg),
                  ),
                ),
              );
            },
          );
        }),
      if (pricingFuture != null)
        pricingFuture.then((result) {
          if (emit.isDone ||
              !_isTripResolutionTokenCurrent(token) ||
              isClosed) {
            printM(
              '[OrderBloc] pricingFuture ignored (token mismatch or closed)',
              tag: false,
            );
            return;
          }
          result.when(
            success: (options) {
              printM(
                '[OrderBloc] getPricingQuotes success count=${options.length}',
                tag: false,
              );
              emit(
                state.copyWith(
                  trip: state.trip.copyWith(
                    carOptionsState: BlocStatus.success(options),
                  ),
                ),
              );
            },
            failure: (msg) {
              printR('[OrderBloc] getPricingQuotes failure: $msg', tag: false);
              emit(
                state.copyWith(
                  trip: state.trip.copyWith(
                    carOptionsState: BlocStatus.failure(msg),
                  ),
                ),
              );
            },
          );
        }),
    ]);
  }
}
