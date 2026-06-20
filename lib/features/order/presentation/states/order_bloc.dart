import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:customertaxi/core/services/client_config/client_config_service.dart';
import 'package:customertaxi/core/services/location/location_service.dart';
import 'package:customertaxi/core/services/realtime/realtime_event.dart';
import 'package:customertaxi/core/services/realtime/realtime_service.dart';
import 'package:customertaxi/utils/constants/app_flow_constants.dart';
import 'package:customertaxi/utils/helpers/app_strings.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/order_location_entity.dart';
import '../../domain/entities/order_location_request_entity.dart';
import '../../domain/entities/order_saved_location_entity.dart';
import '../../domain/entities/order_stripe_payment_entity.dart';
import '../../domain/entities/order_trip_car_option_entity.dart';
import '../../domain/entities/order_trip_response_entity.dart';
import '../../domain/entities/order_trip_route_entity.dart';
import '../../domain/facade/order_facade.dart';
import '../helpers/saved_locations_helper.dart';
import 'slices/order_booking_slice.dart';
import 'slices/order_map_slice.dart';
import 'slices/order_sheet_slice.dart';
import 'slices/order_stops_slice.dart';
import 'slices/order_trip_slice.dart';

export 'slices/order_booking_slice.dart';
export 'slices/order_map_slice.dart';
export 'slices/order_sheet_slice.dart';
export 'slices/order_stops_slice.dart';
export 'slices/order_trip_slice.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'handlers/lifecycle_handlers.dart';
part 'handlers/map_handlers.dart';
part 'handlers/stops_handlers.dart';
part 'handlers/suggestions_helpers.dart';
part 'handlers/trip_resolution_handlers.dart';
part 'handlers/booking_handlers.dart';
part 'order_bloc.freezed.dart';

@injectable
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc(
    this._facade,
    this._locationService,
    this._clientConfig,
    this._realtime,
  ) : super(const OrderState()) {
    printC('[OrderBloc] initialized');
    on<_Started>(_onStarted);
    on<_OrderNowPressed>(_onOrderNowPressed);
    on<_CollapseRequested>(_onCollapseRequested);
    on<_MapPickCancelled>(_onMapPickCancelled);
    on<_VehicleStepBackPressed>(_onVehicleStepBackPressed);
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
    on<_TripPrefetchCompleted>(_onTripPrefetchCompleted);
    on<_ConfirmOrderPressed>(_onConfirmOrderPressed);
    on<_ConfirmCarSelectionPressed>(_onConfirmCarSelectionPressed);
    on<_ConfirmBookingDetailsPressed>(_onConfirmBookingDetailsPressed);
    on<_BookingDetailsBackPressed>(_onBookingDetailsBackPressed);
    on<_ScheduleModeChanged>(_onScheduleModeChanged);
    on<_ScheduleTimeChanged>(_onScheduleTimeChanged);
    on<_PassengerNoteChanged>(_onPassengerNoteChanged);
    on<_FlightNumberChanged>(_onFlightNumberChanged);
    on<_PaymentSheetDismissed>(_onPaymentSheetDismissed);
  }

  final OrderFacade _facade;
  final LocationService _locationService;
  final ClientConfigService _clientConfig;
  final RealtimeService _realtime;

  int _tripResolutionToken = 0;
  int _prefetchToken = 0;

  void _invalidateTripResolution() => _tripResolutionToken++;
  bool _isTripResolutionTokenCurrent(int token) =>
      _tripResolutionToken == token;
  void _invalidatePrefetch() => _prefetchToken++;
  bool _isPrefetchTokenCurrent(int token) => _prefetchToken == token;
}
