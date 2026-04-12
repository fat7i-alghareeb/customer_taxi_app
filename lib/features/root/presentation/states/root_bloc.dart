import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:customertaxi/core/services/location/location_service.dart';
import 'package:customertaxi/core/services/permissions/permissions_coordinator.dart';
import 'package:customertaxi/utils/constants/app_flow_constants.dart';
import 'package:customertaxi/utils/helpers/app_strings.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/utils/bloc_status.dart';
import '../../domain/entities/root_map_location_entity.dart';

part 'root_event.dart';
part 'root_state.dart';
part 'root_bloc.freezed.dart';

@injectable
class RootBloc extends Bloc<RootEvent, RootState> {
  RootBloc(this._permissionsCoordinator, this._locationService)
    : super(const RootState()) {
    on<_Started>(_onStarted);
    on<_MapBootstrapRequested>(_onMapBootstrapRequested);
    on<_RecenterRequested>(_onRecenterRequested);
    on<_AccurateLocationResolved>(_onAccurateLocationResolved);
  }

  // ignore: unused_field
  final PermissionsCoordinator _permissionsCoordinator;
  final LocationService _locationService;

  Future<void> _onStarted(_Started event, Emitter<RootState> emit) async {
    printC('[RootBloc] started -> mapBootstrapRequested');
    add(const RootEvent.mapBootstrapRequested());
  }

  Future<void> _onMapBootstrapRequested(
    _MapBootstrapRequested event,
    Emitter<RootState> emit,
  ) async {
    printC('[RootBloc] map bootstrap start (fast mode)');
    emit(state.copyWith(mapBootstrapState: const BlocStatus.loading()));

    // 1. FAST PATH: Check last known position immediately
    final lastKnown = await _locationService.getLastKnownPosition();
    if (lastKnown != null) {
      printG('[RootBloc] bootstrap: found lastKnown position');
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
      // 2. FALLBACK PATH: Use Aleppo default pivot instantly
      printY('[RootBloc] bootstrap: no lastKnown, using default Aleppo');
      emit(
        state.copyWith(
          mapBootstrapState: BlocStatus.success(
            const RootMapLocationEntity(
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
          printG('[RootBloc] accurate location resolved background -> dispatch');
          add(RootEvent.accurateLocationResolved(location));
        },
        orElse: () {},
      );
    } catch (e) {
      printY('[RootBloc] background accurate resolution failed: $e');
    }
  }

  void _onAccurateLocationResolved(
    _AccurateLocationResolved event,
    Emitter<RootState> emit,
  ) {
    printG('[RootBloc] applying accurate location update');
    emit(state.copyWith(mapBootstrapState: BlocStatus.success(event.location)));
  }

  Future<void> _onRecenterRequested(
    _RecenterRequested event,
    Emitter<RootState> emit,
  ) async {
    printC('[RootBloc] recenter start (ultra-fast mode)');
    emit(state.copyWith(recenterState: const BlocStatus.loading()));

    // 1. FASTEST PATH: Immediate move to last known without checks
    final lastKnown = await _locationService.getLastKnownPosition();
    if (lastKnown != null) {
      printG('[RootBloc] recenter: immediate lastKnown resolution');
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
    printM('[RootBloc] resolveCurrentLocationStatus (lean mode)');
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
      printY('[RootBloc] getCurrentPosition failed: $e');
      return BlocStatus<RootMapLocationEntity>.failure(
        AppStrings.rootMapCurrentLocationUnavailable,
      );
    }
  }
}
