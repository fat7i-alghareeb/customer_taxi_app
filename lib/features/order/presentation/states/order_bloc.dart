import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:customertaxi/core/services/location/location_service.dart';
import 'package:customertaxi/utils/constants/app_flow_constants.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/order_location_entity.dart';
import '../../domain/entities/order_location_request_entity.dart';
import '../../domain/facade/order_facade.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

enum OrderSheetMode { collapsed, expanded, mapPicking }

enum OrderLocationTarget { from, to }

@injectable
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc(this._facade, this._locationService) : super(const OrderState()) {
    printC('[OrderBloc] initialized');
    on<_Started>(_onStarted);
    on<_GetAllRequested>(_onGetAllRequested);
    on<_OrderNowPressed>(_onOrderNowPressed);
    on<_CollapseRequested>(_onCollapseRequested);
    on<_MapPickCancelled>(_onMapPickCancelled);
    on<_SetOnMapPressed>(_onSetOnMapPressed);
    on<_MapCameraTargetUpdated>(_onMapCameraTargetUpdated);
    on<_ConfirmMapPointPressed>(_onConfirmMapPointPressed);
    on<_FromQueryChanged>(_onFromQueryChanged);
    on<_ToQueryChanged>(_onToQueryChanged);
    on<_FromLocationCleared>(_onFromLocationCleared);
    on<_ToLocationCleared>(_onToLocationCleared);
    on<_FromSuggestionSelected>(_onFromSuggestionSelected);
    on<_ToSuggestionSelected>(_onToSuggestionSelected);
    on<_ConfirmOrderPressed>(_onConfirmOrderPressed);
  }

  final OrderFacade _facade;
  final LocationService _locationService;

  Future<void> _onStarted(_Started event, Emitter<OrderState> emit) async {
    printM('[OrderBloc] started');
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

  void _onOrderNowPressed(_OrderNowPressed event, Emitter<OrderState> emit) {
    printM('[OrderBloc] orderNowPressed -> expanded');
    emit(state.copyWith(sheetMode: OrderSheetMode.expanded));
  }

  Future<void> _onCollapseRequested(
    _CollapseRequested event,
    Emitter<OrderState> emit,
  ) async {
    printM(
      '[OrderBloc] collapseRequested -> collapsed + clear to/suggestions + restore from current location',
    );
    emit(
      state.copyWith(
        sheetMode: OrderSheetMode.collapsed,
        mapPickingTarget: OrderLocationTarget.from,
        fromLocationState: const BlocStatus.loading(),
        toLocationState: const BlocStatus.initial(),
        fromSuggestionsState: const BlocStatus.initial(),
        toSuggestionsState: const BlocStatus.initial(),
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
        printG(
          '[OrderBloc] collapseRequested restore from success label="${location.label}"',
        );
        emit(state.copyWith(fromLocationState: BlocStatus.success(location)));
      },
      failure: (_) {
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
    printM('[OrderBloc] mapPickCancelled -> expanded');
    emit(state.copyWith(sheetMode: OrderSheetMode.expanded));
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

  Future<void> _onConfirmMapPointPressed(
    _ConfirmMapPointPressed event,
    Emitter<OrderState> emit,
  ) async {
    printM(
      '[OrderBloc] confirmMapPointPressed target=${state.mapPickingTarget.name} lat=${state.mapCameraLatitude} lng=${state.mapCameraLongitude}',
    );
    final result = await _facade.reverseGeocode(
      OrderReverseGeocodeRequestEntity(
        latitude: state.mapCameraLatitude,
        longitude: state.mapCameraLongitude,
      ),
    );

    result.when(
      success: (location) {
        printG(
          '[OrderBloc] confirmMapPoint reverseGeocode success label="${location.label}"',
        );
        if (state.mapPickingTarget == OrderLocationTarget.from) {
          emit(
            state.copyWith(
              fromLocationState: BlocStatus.success(location),
              fromSuggestionsState: const BlocStatus.initial(),
              sheetMode: OrderSheetMode.expanded,
            ),
          );
          return;
        }

        emit(
          state.copyWith(
            toLocationState: BlocStatus.success(location),
            toSuggestionsState: const BlocStatus.initial(),
            sheetMode: OrderSheetMode.expanded,
          ),
        );
      },
      failure: (_) {
        printY(
          '[OrderBloc] confirmMapPoint reverseGeocode failed -> fallback label',
        );
        final fallback = OrderLocationEntity(
          latitude: state.mapCameraLatitude,
          longitude: state.mapCameraLongitude,
          label:
              '${state.mapCameraLatitude.toStringAsFixed(6)}, ${state.mapCameraLongitude.toStringAsFixed(6)}',
        );

        if (state.mapPickingTarget == OrderLocationTarget.from) {
          emit(
            state.copyWith(
              fromLocationState: BlocStatus.success(fallback),
              fromSuggestionsState: const BlocStatus.initial(),
              sheetMode: OrderSheetMode.expanded,
            ),
          );
          return;
        }

        emit(
          state.copyWith(
            toLocationState: BlocStatus.success(fallback),
            toSuggestionsState: const BlocStatus.initial(),
            sheetMode: OrderSheetMode.expanded,
          ),
        );
      },
    );
  }

  Future<void> _onFromQueryChanged(
    _FromQueryChanged event,
    Emitter<OrderState> emit,
  ) async {
    final query = event.query.trim();
    printC(
      '[OrderBloc] fromQueryChanged query="${event.query}" trimmed="$query"',
    );
    if (query.isEmpty) {
      printM(
        '[OrderBloc] fromQueryChanged cleared -> reset from suggestions and from location',
      );
      emit(
        state.copyWith(
          fromSuggestionsState: const BlocStatus.initial(),
          fromLocationState: const BlocStatus.initial(),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        fromSuggestionsState: const BlocStatus.loading(),
        fromLocationState: const BlocStatus.initial(),
      ),
    );

    final result = await _facade.searchLocations(
      OrderLocationSearchRequestEntity(query: query),
    );

    result.when(
      success: (locations) {
        printG(
          '[OrderBloc] fromQueryChanged success suggestions=${locations.length}',
        );
        emit(
          state.copyWith(fromSuggestionsState: BlocStatus.success(locations)),
        );
      },
      failure: (message) {
        printY('[OrderBloc] from search failed: $message');
        emit(state.copyWith(fromSuggestionsState: const BlocStatus.initial()));
      },
    );
  }

  Future<void> _onToQueryChanged(
    _ToQueryChanged event,
    Emitter<OrderState> emit,
  ) async {
    final query = event.query.trim();
    printC(
      '[OrderBloc] toQueryChanged query="${event.query}" trimmed="$query"',
    );
    if (query.isEmpty) {
      printM(
        '[OrderBloc] toQueryChanged cleared -> reset to suggestions and to location',
      );
      emit(
        state.copyWith(
          toSuggestionsState: const BlocStatus.initial(),
          toLocationState: const BlocStatus.initial(),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        toSuggestionsState: const BlocStatus.loading(),
        toLocationState: const BlocStatus.initial(),
      ),
    );

    final result = await _facade.searchLocations(
      OrderLocationSearchRequestEntity(query: query),
    );

    result.when(
      success: (locations) {
        printG(
          '[OrderBloc] toQueryChanged success suggestions=${locations.length}',
        );
        emit(state.copyWith(toSuggestionsState: BlocStatus.success(locations)));
      },
      failure: (message) {
        printY('[OrderBloc] to search failed: $message');
        emit(state.copyWith(toSuggestionsState: const BlocStatus.initial()));
      },
    );
  }

  void _onFromLocationCleared(
    _FromLocationCleared event,
    Emitter<OrderState> emit,
  ) {
    printM(
      '[OrderBloc] fromLocationCleared -> reset from location/suggestions',
    );
    emit(
      state.copyWith(
        fromLocationState: const BlocStatus.initial(),
        fromSuggestionsState: const BlocStatus.initial(),
      ),
    );
  }

  void _onToLocationCleared(
    _ToLocationCleared event,
    Emitter<OrderState> emit,
  ) {
    printM('[OrderBloc] toLocationCleared -> reset to location/suggestions');
    emit(
      state.copyWith(
        toLocationState: const BlocStatus.initial(),
        toSuggestionsState: const BlocStatus.initial(),
      ),
    );
  }

  void _onFromSuggestionSelected(
    _FromSuggestionSelected event,
    Emitter<OrderState> emit,
  ) {
    printM(
      '[OrderBloc] fromSuggestionSelected lat=${event.location.latitude} lng=${event.location.longitude} label="${event.location.label}"',
    );
    emit(
      state.copyWith(
        fromLocationState: BlocStatus.success(event.location),
        fromSuggestionsState: const BlocStatus.initial(),
      ),
    );
  }

  void _onToSuggestionSelected(
    _ToSuggestionSelected event,
    Emitter<OrderState> emit,
  ) {
    printM(
      '[OrderBloc] toSuggestionSelected lat=${event.location.latitude} lng=${event.location.longitude} label="${event.location.label}"',
    );
    emit(
      state.copyWith(
        toLocationState: BlocStatus.success(event.location),
        toSuggestionsState: const BlocStatus.initial(),
      ),
    );
  }

  void _onConfirmOrderPressed(
    _ConfirmOrderPressed event,
    Emitter<OrderState> emit,
  ) {
    printC(
      '[OrderBloc] confirmOrderPressed no-op fromReady=${state.fromLocationState.isSuccess} toReady=${state.toLocationState.isSuccess}',
    );
  }
}
