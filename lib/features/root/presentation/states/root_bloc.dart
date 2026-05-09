import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:customertaxi/core/services/location/location_service.dart';
import 'package:customertaxi/core/services/permissions/permissions_coordinator.dart';
import 'package:customertaxi/utils/constants/app_flow_constants.dart';
import 'package:customertaxi/utils/helpers/app_strings.dart';

import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../../order/domain/facade/order_facade.dart';
import '../../domain/entities/root_map_location_entity.dart';

part 'root_event.dart';
part 'root_state.dart';
part 'root_bloc.freezed.dart';

@injectable
class RootBloc extends Bloc<RootEvent, RootState> {
  RootBloc(
    this._permissionsCoordinator,
    this._locationService,
    this._orderFacade,
  ) : super(const RootState()) {
    on<_Started>(_onStarted);
    on<_MapBootstrapRequested>(_onMapBootstrapRequested);
    on<_RecenterRequested>(_onRecenterRequested);
    on<_AccurateLocationResolved>(_onAccurateLocationResolved);
    on<_TripCountRequested>(_onTripCountRequested);
  }

  final PermissionsCoordinator _permissionsCoordinator;
  final LocationService _locationService;
  final OrderFacade _orderFacade;

  Future<void> _onStarted(_Started event, Emitter<RootState> emit) async {
    add(const RootEvent.mapBootstrapRequested());
    add(const RootEvent.tripCountRequested());
  }

  Future<void> _onMapBootstrapRequested(
    _MapBootstrapRequested event,
    Emitter<RootState> emit,
  ) async {
    // 1. Ensure permissions are handled
    await _permissionsCoordinator.ensureForegroundLocationRequired();

    // 2. FAST PATH: Check last known position immediately
    final lastKnown = await _locationService.getLastKnownPosition();
    if (lastKnown != null) {
      emit(
        state.copyWith(
          mapBootstrapState: BlocStatus.success(
            RootMapLocationEntity(
              latitude: lastKnown.latitude,
              longitude: lastKnown.longitude,
              zoom: MapConfig.initialZoom, // Start zoomed out as requested
            ),
          ),
        ),
      );
    } else {
      // 3. FALLBACK PATH: Use Aleppo default pivot instantly
      emit(
        state.copyWith(
          mapBootstrapState: const BlocStatus.success(
            RootMapLocationEntity(
              latitude: MapConfig.defaultLat,
              longitude: MapConfig.defaultLng,
              zoom: MapConfig.initialZoom, // Start zoomed out
            ),
          ),
        ),
      );
    }

    // 3. BACKGROUND PATH: Resolve high-accuracy center
    // We don't await this so the user sees the map instantly.
    // We use a detached logic that dispatches a new event once ready.
    _resolveAccurateLocation();
  }

  Future<void> _resolveAccurateLocation() async {
    try {
      final status = await _resolveCurrentLocationStatus();
      status.maybeWhen(
        success: (location) {
          add(RootEvent.accurateLocationResolved(location));
        },
        orElse: () {},
      );
    } catch (e) {
      // Silent resolution failure
    }
  }

  void _onAccurateLocationResolved(
    _AccurateLocationResolved event,
    Emitter<RootState> emit,
  ) {
    emit(state.copyWith(mapBootstrapState: BlocStatus.success(event.location)));
  }

  Future<void> _onRecenterRequested(
    _RecenterRequested event,
    Emitter<RootState> emit,
  ) async {
    emit(state.copyWith(recenterState: const BlocStatus.loading()));

    // 1. FASTEST PATH: Immediate move to last known without checks
    final lastKnown = await _locationService.getLastKnownPosition();
    if (lastKnown != null) {
      final location = RootMapLocationEntity(
        latitude: lastKnown.latitude,
        longitude: lastKnown.longitude,
        zoom: MapConfig.focusZoom,
      );
      emit(
        state.copyWith(
          mapBootstrapState: BlocStatus.success(location),
          recenterState: BlocStatus.success(location),
        ),
      );
    }

    // 2. ACCURATE PATH: Resolve in background
    _resolveAccurateLocation();
  }

  Future<BlocStatus<RootMapLocationEntity>>
  _resolveCurrentLocationStatus() async {
    try {
      final position = await _locationService.getCurrentPosition();
      return BlocStatus<RootMapLocationEntity>.success(
        RootMapLocationEntity(
          latitude: position.latitude,
          longitude: position.longitude,
          zoom: MapConfig.focusZoom,
        ),
      );
    } catch (e) {
      return BlocStatus<RootMapLocationEntity>.failure(
        AppStrings.rootMapCurrentLocationUnavailable,
      );
    }
  }

  Future<void> _onTripCountRequested(
    _TripCountRequested event,
    Emitter<RootState> emit,
  ) async {
    emit(state.copyWith(tripCountState: const BlocStatus.loading()));

    final result = await _orderFacade.getTripCount();

    result.when(
      success: (count) {
        emit(state.copyWith(tripCountState: BlocStatus.success(count)));
      },
      failure: (message) {
        emit(state.copyWith(tripCountState: BlocStatus.failure(message)));
      },
    );
  }
}

