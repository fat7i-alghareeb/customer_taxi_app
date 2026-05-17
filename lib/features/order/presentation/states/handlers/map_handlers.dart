part of '../order_bloc.dart';

extension _MapHandlers on OrderBloc {
  void _onSetOnMapPressed(_SetOnMapPressed event, Emitter<OrderState> emit) {
    printM('[OrderBloc] setOnMapPressed target=stop index=${event.index}');
    emit(
      state.copyWith(
        sheet: state.sheet.copyWith(
          mode: OrderSheetMode.mapPicking,
          mapPickingTarget: OrderLocationTarget.stop,
          activeStopIndex: event.index,
        ),
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
        map: OrderMapSlice(
          latitude: event.latitude,
          longitude: event.longitude,
          zoom: event.zoom,
        ),
      ),
    );
  }

  Future<void> _onConfirmMapPointPressed(
    _ConfirmMapPointPressed event,
    Emitter<OrderState> emit,
  ) async {
    _invalidateTripResolution();
    _invalidatePrefetch();
    final token = _tripResolutionToken;

    printM(
      '[OrderBloc] confirmMapPointPressed target=${state.sheet.mapPickingTarget.name} lat=${state.map.latitude} lng=${state.map.longitude}',
    );

    final result = await _facade.reverseGeocode(
      OrderReverseGeocodeRequestEntity(
        latitude: state.map.latitude,
        longitude: state.map.longitude,
      ),
    );

    await result.when(
      success: (location) async {
        if (!_isTripResolutionTokenCurrent(token)) return;

        printG(
          '[OrderBloc] confirmMapPoint reverseGeocode success label="${location.label}"',
        );

        final index = state.sheet.activeStopIndex;
        final nextStops = List<OrderLocationEntity?>.from(state.stops.list);
        nextStops[index] = location;

        final nextQueries = List<String>.from(state.stops.queries);
        nextQueries[index] = location.label;

        final nextSuggestions =
            List<BlocStatus<List<OrderSavedLocationEntity>>>.from(
              state.stops.suggestionsState,
            );
        nextSuggestions[index] = state.stops.savedState.maybeWhen(
          success: (saved) =>
              BlocStatus.success(SavedLocationsHelper.sorted(saved)),
          orElse: () => const BlocStatus.initial(),
        );

        final wasInCarSelectionOrBooking =
            state.sheet.expandedStep == OrderExpandedStep.carSelection ||
            state.sheet.expandedStep == OrderExpandedStep.bookingDetails;

        OrderState nextState;
        if (wasInCarSelectionOrBooking) {
          nextState = state.copyWith(
            stops: state.stops.copyWith(
              list: nextStops,
              queries: nextQueries,
              suggestionsState: nextSuggestions,
            ),
            sheet: state.sheet.copyWith(
              mode: OrderSheetMode.expanded,
              expandedStep: OrderExpandedStep.carSelection,
            ),
            trip: state.trip.copyWith(
              selectedCarTypeId: null,
              selectedQuoteId: null,
              routeState: const BlocStatus.initial(),
              carOptionsState: const BlocStatus.initial(),
            ),
          );
        } else {
          final reset = _resetTripFlowState(state);
          nextState = reset.copyWith(
            stops: reset.stops.copyWith(
              list: nextStops,
              queries: nextQueries,
              suggestionsState: nextSuggestions,
            ),
            sheet: reset.sheet.copyWith(mode: OrderSheetMode.expanded),
          );
        }

        emit(nextState);
        await _saveSelectedLocationAndRefresh(emit, location);

        if (wasInCarSelectionOrBooking) {
          add(const OrderEvent.confirmOrderPressed());
        } else {
          _tryStartTripPrefetch(emit: emit, currentStops: nextStops);
        }
      },
      failure: (_) async {
        if (!_isTripResolutionTokenCurrent(token)) return;
        printY('[OrderBloc] confirmMapPoint reverseGeocode failed');
        emit(
          state.copyWith(
            sheet: state.sheet.copyWith(mode: OrderSheetMode.expanded),
          ),
        );
      },
    );
  }

  void _onMapPickCancelled(_MapPickCancelled event, Emitter<OrderState> emit) {
    _invalidateTripResolution();
    _invalidatePrefetch();
    final reset = _resetTripFlowState(state);
    emit(
      reset.copyWith(
        sheet: reset.sheet.copyWith(mode: OrderSheetMode.expanded),
      ),
    );
  }

  void _onVehicleStepBackPressed(
    _VehicleStepBackPressed event,
    Emitter<OrderState> emit,
  ) {
    _invalidateTripResolution();
    _invalidatePrefetch();
    printM('[OrderBloc] vehicleStepBackPressed -> locationEntry (stops preserved)');
    emit(state.copyWith(
      sheet: state.sheet.copyWith(
        expandedStep: OrderExpandedStep.locationEntry,
        mapPickingTarget: OrderLocationTarget.stop,
      ),
      trip: const OrderTripSlice(),
      booking: OrderBookingSlice(scheduleMode: state.booking.scheduleMode),
    ));
  }
}
