import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:customertaxi/core/utils/bloc_status.dart';
import 'package:customertaxi/features/order/domain/entities/order_location_entity.dart';
import 'package:customertaxi/features/order/domain/entities/order_location_request_entity.dart';
import 'package:customertaxi/features/order/domain/entities/order_saved_location_entity.dart';
import 'package:customertaxi/features/order/domain/facade/order_facade.dart';

import 'package:customertaxi/core/services/location/location_service.dart';
import '../../../../core/utils/result.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';
part 'favorites_bloc.freezed.dart';

@injectable
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc(this._orderFacade, this._locationService) : super(const FavoritesState()) {
    on<_Started>(_onStarted);
    on<_LocationAdded>(_onLocationAdded);
    on<_LocationRemoved>(_onLocationRemoved);
    on<_PinToggled>(_onPinToggled);
    on<_SearchRequested>(_onSearchRequested);
  }

  final OrderFacade _orderFacade;
  final LocationService _locationService;

  Future<void> _onStarted(_Started event, Emitter<FavoritesState> emit) async {
    emit(state.copyWith(loadStatus: const BlocStatus.loading()));
    final result = await _orderFacade.getSavedLocations();
    
    result.when(
      success: (locations) => emit(state.copyWith(
        loadStatus: const BlocStatus.success(null),
        locations: locations,
      )),
      failure: (message) => emit(state.copyWith(
        loadStatus: BlocStatus.failure(message),
      )),
    );
  }

  Future<void> _onLocationAdded(_LocationAdded event, Emitter<FavoritesState> emit) async {
    emit(state.copyWith(actionStatus: const BlocStatus.loading()));
    final result = await _orderFacade.saveSelectedLocation(event.location);
    
    result.when(
      success: (locations) => emit(state.copyWith(
        actionStatus: const BlocStatus.success(null),
        locations: locations,
      )),
      failure: (message) => emit(state.copyWith(
        actionStatus: BlocStatus.failure(message),
      )),
    );
  }

  Future<void> _onLocationRemoved(_LocationRemoved event, Emitter<FavoritesState> emit) async {
    emit(state.copyWith(actionStatus: const BlocStatus.loading()));
    final result = await _orderFacade.removeSavedLocation(event.identityKey);
    
    result.when(
      success: (locations) => emit(state.copyWith(
        actionStatus: const BlocStatus.success(null),
        locations: locations,
      )),
      failure: (message) => emit(state.copyWith(
        actionStatus: BlocStatus.failure(message),
      )),
    );
  }

  Future<void> _onPinToggled(_PinToggled event, Emitter<FavoritesState> emit) async {
    emit(state.copyWith(actionStatus: const BlocStatus.loading()));
    final result = await _orderFacade.togglePinnedLocation(event.location);
    
    result.when(
      success: (locations) => emit(state.copyWith(
        actionStatus: const BlocStatus.success(null),
        locations: locations,
      )),
      failure: (message) => emit(state.copyWith(
        actionStatus: BlocStatus.failure(message),
      )),
    );
  }

  Future<void> _onSearchRequested(_SearchRequested event, Emitter<FavoritesState> emit) async {
    if (event.query.isEmpty) {
      emit(state.copyWith(
        searchStatus: const BlocStatus.initial(),
        searchResults: [],
      ));
      return;
    }
    emit(state.copyWith(searchStatus: const BlocStatus.loading()));
    
    double? biasLat;
    double? biasLng;

    try {
      final lastKnown = await _locationService.getLastKnownPosition();
      if (lastKnown != null) {
        biasLat = lastKnown.latitude;
        biasLng = lastKnown.longitude;
      }
    } catch (_) {}

    final result = await _orderFacade.searchLocations(
      OrderLocationSearchRequestEntity(
        query: event.query,
        biasLat: biasLat,
        biasLng: biasLng,
      ),
    );
    
    result.when(
      success: (locations) => emit(state.copyWith(
        searchStatus: const BlocStatus.success(null),
        searchResults: locations,
      )),
      failure: (message) => emit(state.copyWith(
        searchStatus: BlocStatus.failure(message),
      )),
    );
  }
}
