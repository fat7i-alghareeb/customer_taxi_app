// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent()';
}


}

/// @nodoc
class $OrderEventCopyWith<$Res>  {
$OrderEventCopyWith(OrderEvent _, $Res Function(OrderEvent) __);
}


/// Adds pattern-matching-related methods to [OrderEvent].
extension OrderEventPatterns on OrderEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _GetAllRequested value)?  getAllRequested,TResult Function( _OrderNowPressed value)?  orderNowPressed,TResult Function( _CollapseRequested value)?  collapseRequested,TResult Function( _MapPickCancelled value)?  mapPickCancelled,TResult Function( _VehicleStepBackPressed value)?  vehicleStepBackPressed,TResult Function( _SetOnMapPressed value)?  setOnMapPressed,TResult Function( _MapCameraTargetUpdated value)?  mapCameraTargetUpdated,TResult Function( _ConfirmMapPointPressed value)?  confirmMapPointPressed,TResult Function( _ActiveStopChanged value)?  activeStopChanged,TResult Function( _StopQueryChanged value)?  stopQueryChanged,TResult Function( _StopCleared value)?  stopCleared,TResult Function( _StopSuggestionSelected value)?  stopSuggestionSelected,TResult Function( _StopAdded value)?  stopAdded,TResult Function( _StopRemoved value)?  stopRemoved,TResult Function( _StopReordered value)?  stopReordered,TResult Function( _SavedLocationPinToggled value)?  savedLocationPinToggled,TResult Function( _CarTypeToggled value)?  carTypeToggled,TResult Function( _TripPrefetchCompleted value)?  tripPrefetchCompleted,TResult Function( _ConfirmOrderPressed value)?  confirmOrderPressed,TResult Function( _ConfirmCarSelectionPressed value)?  confirmCarSelectionPressed,TResult Function( _BookingDetailsBackPressed value)?  bookingDetailsBackPressed,TResult Function( _ScheduleModeChanged value)?  scheduleModeChanged,TResult Function( _ScheduleTimeChanged value)?  scheduleTimeChanged,TResult Function( _PaymentMethodChanged value)?  paymentMethodChanged,TResult Function( _ConfirmBookingDetailsPressed value)?  confirmBookingDetailsPressed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _GetAllRequested() when getAllRequested != null:
return getAllRequested(_that);case _OrderNowPressed() when orderNowPressed != null:
return orderNowPressed(_that);case _CollapseRequested() when collapseRequested != null:
return collapseRequested(_that);case _MapPickCancelled() when mapPickCancelled != null:
return mapPickCancelled(_that);case _VehicleStepBackPressed() when vehicleStepBackPressed != null:
return vehicleStepBackPressed(_that);case _SetOnMapPressed() when setOnMapPressed != null:
return setOnMapPressed(_that);case _MapCameraTargetUpdated() when mapCameraTargetUpdated != null:
return mapCameraTargetUpdated(_that);case _ConfirmMapPointPressed() when confirmMapPointPressed != null:
return confirmMapPointPressed(_that);case _ActiveStopChanged() when activeStopChanged != null:
return activeStopChanged(_that);case _StopQueryChanged() when stopQueryChanged != null:
return stopQueryChanged(_that);case _StopCleared() when stopCleared != null:
return stopCleared(_that);case _StopSuggestionSelected() when stopSuggestionSelected != null:
return stopSuggestionSelected(_that);case _StopAdded() when stopAdded != null:
return stopAdded(_that);case _StopRemoved() when stopRemoved != null:
return stopRemoved(_that);case _StopReordered() when stopReordered != null:
return stopReordered(_that);case _SavedLocationPinToggled() when savedLocationPinToggled != null:
return savedLocationPinToggled(_that);case _CarTypeToggled() when carTypeToggled != null:
return carTypeToggled(_that);case _TripPrefetchCompleted() when tripPrefetchCompleted != null:
return tripPrefetchCompleted(_that);case _ConfirmOrderPressed() when confirmOrderPressed != null:
return confirmOrderPressed(_that);case _ConfirmCarSelectionPressed() when confirmCarSelectionPressed != null:
return confirmCarSelectionPressed(_that);case _BookingDetailsBackPressed() when bookingDetailsBackPressed != null:
return bookingDetailsBackPressed(_that);case _ScheduleModeChanged() when scheduleModeChanged != null:
return scheduleModeChanged(_that);case _ScheduleTimeChanged() when scheduleTimeChanged != null:
return scheduleTimeChanged(_that);case _PaymentMethodChanged() when paymentMethodChanged != null:
return paymentMethodChanged(_that);case _ConfirmBookingDetailsPressed() when confirmBookingDetailsPressed != null:
return confirmBookingDetailsPressed(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _GetAllRequested value)  getAllRequested,required TResult Function( _OrderNowPressed value)  orderNowPressed,required TResult Function( _CollapseRequested value)  collapseRequested,required TResult Function( _MapPickCancelled value)  mapPickCancelled,required TResult Function( _VehicleStepBackPressed value)  vehicleStepBackPressed,required TResult Function( _SetOnMapPressed value)  setOnMapPressed,required TResult Function( _MapCameraTargetUpdated value)  mapCameraTargetUpdated,required TResult Function( _ConfirmMapPointPressed value)  confirmMapPointPressed,required TResult Function( _ActiveStopChanged value)  activeStopChanged,required TResult Function( _StopQueryChanged value)  stopQueryChanged,required TResult Function( _StopCleared value)  stopCleared,required TResult Function( _StopSuggestionSelected value)  stopSuggestionSelected,required TResult Function( _StopAdded value)  stopAdded,required TResult Function( _StopRemoved value)  stopRemoved,required TResult Function( _StopReordered value)  stopReordered,required TResult Function( _SavedLocationPinToggled value)  savedLocationPinToggled,required TResult Function( _CarTypeToggled value)  carTypeToggled,required TResult Function( _TripPrefetchCompleted value)  tripPrefetchCompleted,required TResult Function( _ConfirmOrderPressed value)  confirmOrderPressed,required TResult Function( _ConfirmCarSelectionPressed value)  confirmCarSelectionPressed,required TResult Function( _BookingDetailsBackPressed value)  bookingDetailsBackPressed,required TResult Function( _ScheduleModeChanged value)  scheduleModeChanged,required TResult Function( _ScheduleTimeChanged value)  scheduleTimeChanged,required TResult Function( _PaymentMethodChanged value)  paymentMethodChanged,required TResult Function( _ConfirmBookingDetailsPressed value)  confirmBookingDetailsPressed,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _GetAllRequested():
return getAllRequested(_that);case _OrderNowPressed():
return orderNowPressed(_that);case _CollapseRequested():
return collapseRequested(_that);case _MapPickCancelled():
return mapPickCancelled(_that);case _VehicleStepBackPressed():
return vehicleStepBackPressed(_that);case _SetOnMapPressed():
return setOnMapPressed(_that);case _MapCameraTargetUpdated():
return mapCameraTargetUpdated(_that);case _ConfirmMapPointPressed():
return confirmMapPointPressed(_that);case _ActiveStopChanged():
return activeStopChanged(_that);case _StopQueryChanged():
return stopQueryChanged(_that);case _StopCleared():
return stopCleared(_that);case _StopSuggestionSelected():
return stopSuggestionSelected(_that);case _StopAdded():
return stopAdded(_that);case _StopRemoved():
return stopRemoved(_that);case _StopReordered():
return stopReordered(_that);case _SavedLocationPinToggled():
return savedLocationPinToggled(_that);case _CarTypeToggled():
return carTypeToggled(_that);case _TripPrefetchCompleted():
return tripPrefetchCompleted(_that);case _ConfirmOrderPressed():
return confirmOrderPressed(_that);case _ConfirmCarSelectionPressed():
return confirmCarSelectionPressed(_that);case _BookingDetailsBackPressed():
return bookingDetailsBackPressed(_that);case _ScheduleModeChanged():
return scheduleModeChanged(_that);case _ScheduleTimeChanged():
return scheduleTimeChanged(_that);case _PaymentMethodChanged():
return paymentMethodChanged(_that);case _ConfirmBookingDetailsPressed():
return confirmBookingDetailsPressed(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _GetAllRequested value)?  getAllRequested,TResult? Function( _OrderNowPressed value)?  orderNowPressed,TResult? Function( _CollapseRequested value)?  collapseRequested,TResult? Function( _MapPickCancelled value)?  mapPickCancelled,TResult? Function( _VehicleStepBackPressed value)?  vehicleStepBackPressed,TResult? Function( _SetOnMapPressed value)?  setOnMapPressed,TResult? Function( _MapCameraTargetUpdated value)?  mapCameraTargetUpdated,TResult? Function( _ConfirmMapPointPressed value)?  confirmMapPointPressed,TResult? Function( _ActiveStopChanged value)?  activeStopChanged,TResult? Function( _StopQueryChanged value)?  stopQueryChanged,TResult? Function( _StopCleared value)?  stopCleared,TResult? Function( _StopSuggestionSelected value)?  stopSuggestionSelected,TResult? Function( _StopAdded value)?  stopAdded,TResult? Function( _StopRemoved value)?  stopRemoved,TResult? Function( _StopReordered value)?  stopReordered,TResult? Function( _SavedLocationPinToggled value)?  savedLocationPinToggled,TResult? Function( _CarTypeToggled value)?  carTypeToggled,TResult? Function( _TripPrefetchCompleted value)?  tripPrefetchCompleted,TResult? Function( _ConfirmOrderPressed value)?  confirmOrderPressed,TResult? Function( _ConfirmCarSelectionPressed value)?  confirmCarSelectionPressed,TResult? Function( _BookingDetailsBackPressed value)?  bookingDetailsBackPressed,TResult? Function( _ScheduleModeChanged value)?  scheduleModeChanged,TResult? Function( _ScheduleTimeChanged value)?  scheduleTimeChanged,TResult? Function( _PaymentMethodChanged value)?  paymentMethodChanged,TResult? Function( _ConfirmBookingDetailsPressed value)?  confirmBookingDetailsPressed,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _GetAllRequested() when getAllRequested != null:
return getAllRequested(_that);case _OrderNowPressed() when orderNowPressed != null:
return orderNowPressed(_that);case _CollapseRequested() when collapseRequested != null:
return collapseRequested(_that);case _MapPickCancelled() when mapPickCancelled != null:
return mapPickCancelled(_that);case _VehicleStepBackPressed() when vehicleStepBackPressed != null:
return vehicleStepBackPressed(_that);case _SetOnMapPressed() when setOnMapPressed != null:
return setOnMapPressed(_that);case _MapCameraTargetUpdated() when mapCameraTargetUpdated != null:
return mapCameraTargetUpdated(_that);case _ConfirmMapPointPressed() when confirmMapPointPressed != null:
return confirmMapPointPressed(_that);case _ActiveStopChanged() when activeStopChanged != null:
return activeStopChanged(_that);case _StopQueryChanged() when stopQueryChanged != null:
return stopQueryChanged(_that);case _StopCleared() when stopCleared != null:
return stopCleared(_that);case _StopSuggestionSelected() when stopSuggestionSelected != null:
return stopSuggestionSelected(_that);case _StopAdded() when stopAdded != null:
return stopAdded(_that);case _StopRemoved() when stopRemoved != null:
return stopRemoved(_that);case _StopReordered() when stopReordered != null:
return stopReordered(_that);case _SavedLocationPinToggled() when savedLocationPinToggled != null:
return savedLocationPinToggled(_that);case _CarTypeToggled() when carTypeToggled != null:
return carTypeToggled(_that);case _TripPrefetchCompleted() when tripPrefetchCompleted != null:
return tripPrefetchCompleted(_that);case _ConfirmOrderPressed() when confirmOrderPressed != null:
return confirmOrderPressed(_that);case _ConfirmCarSelectionPressed() when confirmCarSelectionPressed != null:
return confirmCarSelectionPressed(_that);case _BookingDetailsBackPressed() when bookingDetailsBackPressed != null:
return bookingDetailsBackPressed(_that);case _ScheduleModeChanged() when scheduleModeChanged != null:
return scheduleModeChanged(_that);case _ScheduleTimeChanged() when scheduleTimeChanged != null:
return scheduleTimeChanged(_that);case _PaymentMethodChanged() when paymentMethodChanged != null:
return paymentMethodChanged(_that);case _ConfirmBookingDetailsPressed() when confirmBookingDetailsPressed != null:
return confirmBookingDetailsPressed(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  getAllRequested,TResult Function()?  orderNowPressed,TResult Function()?  collapseRequested,TResult Function()?  mapPickCancelled,TResult Function()?  vehicleStepBackPressed,TResult Function( int index)?  setOnMapPressed,TResult Function( double latitude,  double longitude,  double zoom)?  mapCameraTargetUpdated,TResult Function()?  confirmMapPointPressed,TResult Function( int index)?  activeStopChanged,TResult Function( int index,  String query)?  stopQueryChanged,TResult Function( int index)?  stopCleared,TResult Function( int index,  OrderSavedLocationEntity location)?  stopSuggestionSelected,TResult Function()?  stopAdded,TResult Function( int index)?  stopRemoved,TResult Function( int oldIndex,  int newIndex)?  stopReordered,TResult Function( int stopIndex,  OrderSavedLocationEntity location)?  savedLocationPinToggled,TResult Function( String typeId)?  carTypeToggled,TResult Function( int token,  List<OrderLocationEntity> stops,  BlocStatus<OrderTripRouteEntity> routeState,  BlocStatus<List<OrderTripCarOptionEntity>> pricingState)?  tripPrefetchCompleted,TResult Function()?  confirmOrderPressed,TResult Function()?  confirmCarSelectionPressed,TResult Function()?  bookingDetailsBackPressed,TResult Function( OrderScheduleMode mode)?  scheduleModeChanged,TResult Function( DateTime? time)?  scheduleTimeChanged,TResult Function( String methodId)?  paymentMethodChanged,TResult Function()?  confirmBookingDetailsPressed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _GetAllRequested() when getAllRequested != null:
return getAllRequested();case _OrderNowPressed() when orderNowPressed != null:
return orderNowPressed();case _CollapseRequested() when collapseRequested != null:
return collapseRequested();case _MapPickCancelled() when mapPickCancelled != null:
return mapPickCancelled();case _VehicleStepBackPressed() when vehicleStepBackPressed != null:
return vehicleStepBackPressed();case _SetOnMapPressed() when setOnMapPressed != null:
return setOnMapPressed(_that.index);case _MapCameraTargetUpdated() when mapCameraTargetUpdated != null:
return mapCameraTargetUpdated(_that.latitude,_that.longitude,_that.zoom);case _ConfirmMapPointPressed() when confirmMapPointPressed != null:
return confirmMapPointPressed();case _ActiveStopChanged() when activeStopChanged != null:
return activeStopChanged(_that.index);case _StopQueryChanged() when stopQueryChanged != null:
return stopQueryChanged(_that.index,_that.query);case _StopCleared() when stopCleared != null:
return stopCleared(_that.index);case _StopSuggestionSelected() when stopSuggestionSelected != null:
return stopSuggestionSelected(_that.index,_that.location);case _StopAdded() when stopAdded != null:
return stopAdded();case _StopRemoved() when stopRemoved != null:
return stopRemoved(_that.index);case _StopReordered() when stopReordered != null:
return stopReordered(_that.oldIndex,_that.newIndex);case _SavedLocationPinToggled() when savedLocationPinToggled != null:
return savedLocationPinToggled(_that.stopIndex,_that.location);case _CarTypeToggled() when carTypeToggled != null:
return carTypeToggled(_that.typeId);case _TripPrefetchCompleted() when tripPrefetchCompleted != null:
return tripPrefetchCompleted(_that.token,_that.stops,_that.routeState,_that.pricingState);case _ConfirmOrderPressed() when confirmOrderPressed != null:
return confirmOrderPressed();case _ConfirmCarSelectionPressed() when confirmCarSelectionPressed != null:
return confirmCarSelectionPressed();case _BookingDetailsBackPressed() when bookingDetailsBackPressed != null:
return bookingDetailsBackPressed();case _ScheduleModeChanged() when scheduleModeChanged != null:
return scheduleModeChanged(_that.mode);case _ScheduleTimeChanged() when scheduleTimeChanged != null:
return scheduleTimeChanged(_that.time);case _PaymentMethodChanged() when paymentMethodChanged != null:
return paymentMethodChanged(_that.methodId);case _ConfirmBookingDetailsPressed() when confirmBookingDetailsPressed != null:
return confirmBookingDetailsPressed();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  getAllRequested,required TResult Function()  orderNowPressed,required TResult Function()  collapseRequested,required TResult Function()  mapPickCancelled,required TResult Function()  vehicleStepBackPressed,required TResult Function( int index)  setOnMapPressed,required TResult Function( double latitude,  double longitude,  double zoom)  mapCameraTargetUpdated,required TResult Function()  confirmMapPointPressed,required TResult Function( int index)  activeStopChanged,required TResult Function( int index,  String query)  stopQueryChanged,required TResult Function( int index)  stopCleared,required TResult Function( int index,  OrderSavedLocationEntity location)  stopSuggestionSelected,required TResult Function()  stopAdded,required TResult Function( int index)  stopRemoved,required TResult Function( int oldIndex,  int newIndex)  stopReordered,required TResult Function( int stopIndex,  OrderSavedLocationEntity location)  savedLocationPinToggled,required TResult Function( String typeId)  carTypeToggled,required TResult Function( int token,  List<OrderLocationEntity> stops,  BlocStatus<OrderTripRouteEntity> routeState,  BlocStatus<List<OrderTripCarOptionEntity>> pricingState)  tripPrefetchCompleted,required TResult Function()  confirmOrderPressed,required TResult Function()  confirmCarSelectionPressed,required TResult Function()  bookingDetailsBackPressed,required TResult Function( OrderScheduleMode mode)  scheduleModeChanged,required TResult Function( DateTime? time)  scheduleTimeChanged,required TResult Function( String methodId)  paymentMethodChanged,required TResult Function()  confirmBookingDetailsPressed,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _GetAllRequested():
return getAllRequested();case _OrderNowPressed():
return orderNowPressed();case _CollapseRequested():
return collapseRequested();case _MapPickCancelled():
return mapPickCancelled();case _VehicleStepBackPressed():
return vehicleStepBackPressed();case _SetOnMapPressed():
return setOnMapPressed(_that.index);case _MapCameraTargetUpdated():
return mapCameraTargetUpdated(_that.latitude,_that.longitude,_that.zoom);case _ConfirmMapPointPressed():
return confirmMapPointPressed();case _ActiveStopChanged():
return activeStopChanged(_that.index);case _StopQueryChanged():
return stopQueryChanged(_that.index,_that.query);case _StopCleared():
return stopCleared(_that.index);case _StopSuggestionSelected():
return stopSuggestionSelected(_that.index,_that.location);case _StopAdded():
return stopAdded();case _StopRemoved():
return stopRemoved(_that.index);case _StopReordered():
return stopReordered(_that.oldIndex,_that.newIndex);case _SavedLocationPinToggled():
return savedLocationPinToggled(_that.stopIndex,_that.location);case _CarTypeToggled():
return carTypeToggled(_that.typeId);case _TripPrefetchCompleted():
return tripPrefetchCompleted(_that.token,_that.stops,_that.routeState,_that.pricingState);case _ConfirmOrderPressed():
return confirmOrderPressed();case _ConfirmCarSelectionPressed():
return confirmCarSelectionPressed();case _BookingDetailsBackPressed():
return bookingDetailsBackPressed();case _ScheduleModeChanged():
return scheduleModeChanged(_that.mode);case _ScheduleTimeChanged():
return scheduleTimeChanged(_that.time);case _PaymentMethodChanged():
return paymentMethodChanged(_that.methodId);case _ConfirmBookingDetailsPressed():
return confirmBookingDetailsPressed();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  getAllRequested,TResult? Function()?  orderNowPressed,TResult? Function()?  collapseRequested,TResult? Function()?  mapPickCancelled,TResult? Function()?  vehicleStepBackPressed,TResult? Function( int index)?  setOnMapPressed,TResult? Function( double latitude,  double longitude,  double zoom)?  mapCameraTargetUpdated,TResult? Function()?  confirmMapPointPressed,TResult? Function( int index)?  activeStopChanged,TResult? Function( int index,  String query)?  stopQueryChanged,TResult? Function( int index)?  stopCleared,TResult? Function( int index,  OrderSavedLocationEntity location)?  stopSuggestionSelected,TResult? Function()?  stopAdded,TResult? Function( int index)?  stopRemoved,TResult? Function( int oldIndex,  int newIndex)?  stopReordered,TResult? Function( int stopIndex,  OrderSavedLocationEntity location)?  savedLocationPinToggled,TResult? Function( String typeId)?  carTypeToggled,TResult? Function( int token,  List<OrderLocationEntity> stops,  BlocStatus<OrderTripRouteEntity> routeState,  BlocStatus<List<OrderTripCarOptionEntity>> pricingState)?  tripPrefetchCompleted,TResult? Function()?  confirmOrderPressed,TResult? Function()?  confirmCarSelectionPressed,TResult? Function()?  bookingDetailsBackPressed,TResult? Function( OrderScheduleMode mode)?  scheduleModeChanged,TResult? Function( DateTime? time)?  scheduleTimeChanged,TResult? Function( String methodId)?  paymentMethodChanged,TResult? Function()?  confirmBookingDetailsPressed,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _GetAllRequested() when getAllRequested != null:
return getAllRequested();case _OrderNowPressed() when orderNowPressed != null:
return orderNowPressed();case _CollapseRequested() when collapseRequested != null:
return collapseRequested();case _MapPickCancelled() when mapPickCancelled != null:
return mapPickCancelled();case _VehicleStepBackPressed() when vehicleStepBackPressed != null:
return vehicleStepBackPressed();case _SetOnMapPressed() when setOnMapPressed != null:
return setOnMapPressed(_that.index);case _MapCameraTargetUpdated() when mapCameraTargetUpdated != null:
return mapCameraTargetUpdated(_that.latitude,_that.longitude,_that.zoom);case _ConfirmMapPointPressed() when confirmMapPointPressed != null:
return confirmMapPointPressed();case _ActiveStopChanged() when activeStopChanged != null:
return activeStopChanged(_that.index);case _StopQueryChanged() when stopQueryChanged != null:
return stopQueryChanged(_that.index,_that.query);case _StopCleared() when stopCleared != null:
return stopCleared(_that.index);case _StopSuggestionSelected() when stopSuggestionSelected != null:
return stopSuggestionSelected(_that.index,_that.location);case _StopAdded() when stopAdded != null:
return stopAdded();case _StopRemoved() when stopRemoved != null:
return stopRemoved(_that.index);case _StopReordered() when stopReordered != null:
return stopReordered(_that.oldIndex,_that.newIndex);case _SavedLocationPinToggled() when savedLocationPinToggled != null:
return savedLocationPinToggled(_that.stopIndex,_that.location);case _CarTypeToggled() when carTypeToggled != null:
return carTypeToggled(_that.typeId);case _TripPrefetchCompleted() when tripPrefetchCompleted != null:
return tripPrefetchCompleted(_that.token,_that.stops,_that.routeState,_that.pricingState);case _ConfirmOrderPressed() when confirmOrderPressed != null:
return confirmOrderPressed();case _ConfirmCarSelectionPressed() when confirmCarSelectionPressed != null:
return confirmCarSelectionPressed();case _BookingDetailsBackPressed() when bookingDetailsBackPressed != null:
return bookingDetailsBackPressed();case _ScheduleModeChanged() when scheduleModeChanged != null:
return scheduleModeChanged(_that.mode);case _ScheduleTimeChanged() when scheduleTimeChanged != null:
return scheduleTimeChanged(_that.time);case _PaymentMethodChanged() when paymentMethodChanged != null:
return paymentMethodChanged(_that.methodId);case _ConfirmBookingDetailsPressed() when confirmBookingDetailsPressed != null:
return confirmBookingDetailsPressed();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements OrderEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent.started()';
}


}




/// @nodoc


class _GetAllRequested implements OrderEvent {
  const _GetAllRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetAllRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent.getAllRequested()';
}


}




/// @nodoc


class _OrderNowPressed implements OrderEvent {
  const _OrderNowPressed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderNowPressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent.orderNowPressed()';
}


}




/// @nodoc


class _CollapseRequested implements OrderEvent {
  const _CollapseRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollapseRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent.collapseRequested()';
}


}




/// @nodoc


class _MapPickCancelled implements OrderEvent {
  const _MapPickCancelled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapPickCancelled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent.mapPickCancelled()';
}


}




/// @nodoc


class _VehicleStepBackPressed implements OrderEvent {
  const _VehicleStepBackPressed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehicleStepBackPressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent.vehicleStepBackPressed()';
}


}




/// @nodoc


class _SetOnMapPressed implements OrderEvent {
  const _SetOnMapPressed({required this.index});
  

 final  int index;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetOnMapPressedCopyWith<_SetOnMapPressed> get copyWith => __$SetOnMapPressedCopyWithImpl<_SetOnMapPressed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetOnMapPressed&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'OrderEvent.setOnMapPressed(index: $index)';
}


}

/// @nodoc
abstract mixin class _$SetOnMapPressedCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$SetOnMapPressedCopyWith(_SetOnMapPressed value, $Res Function(_SetOnMapPressed) _then) = __$SetOnMapPressedCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class __$SetOnMapPressedCopyWithImpl<$Res>
    implements _$SetOnMapPressedCopyWith<$Res> {
  __$SetOnMapPressedCopyWithImpl(this._self, this._then);

  final _SetOnMapPressed _self;
  final $Res Function(_SetOnMapPressed) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(_SetOnMapPressed(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _MapCameraTargetUpdated implements OrderEvent {
  const _MapCameraTargetUpdated({required this.latitude, required this.longitude, required this.zoom});
  

 final  double latitude;
 final  double longitude;
 final  double zoom;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapCameraTargetUpdatedCopyWith<_MapCameraTargetUpdated> get copyWith => __$MapCameraTargetUpdatedCopyWithImpl<_MapCameraTargetUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapCameraTargetUpdated&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.zoom, zoom) || other.zoom == zoom));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,zoom);

@override
String toString() {
  return 'OrderEvent.mapCameraTargetUpdated(latitude: $latitude, longitude: $longitude, zoom: $zoom)';
}


}

/// @nodoc
abstract mixin class _$MapCameraTargetUpdatedCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$MapCameraTargetUpdatedCopyWith(_MapCameraTargetUpdated value, $Res Function(_MapCameraTargetUpdated) _then) = __$MapCameraTargetUpdatedCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, double zoom
});




}
/// @nodoc
class __$MapCameraTargetUpdatedCopyWithImpl<$Res>
    implements _$MapCameraTargetUpdatedCopyWith<$Res> {
  __$MapCameraTargetUpdatedCopyWithImpl(this._self, this._then);

  final _MapCameraTargetUpdated _self;
  final $Res Function(_MapCameraTargetUpdated) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? zoom = null,}) {
  return _then(_MapCameraTargetUpdated(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,zoom: null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class _ConfirmMapPointPressed implements OrderEvent {
  const _ConfirmMapPointPressed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmMapPointPressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent.confirmMapPointPressed()';
}


}




/// @nodoc


class _ActiveStopChanged implements OrderEvent {
  const _ActiveStopChanged(this.index);
  

 final  int index;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveStopChangedCopyWith<_ActiveStopChanged> get copyWith => __$ActiveStopChangedCopyWithImpl<_ActiveStopChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveStopChanged&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'OrderEvent.activeStopChanged(index: $index)';
}


}

/// @nodoc
abstract mixin class _$ActiveStopChangedCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$ActiveStopChangedCopyWith(_ActiveStopChanged value, $Res Function(_ActiveStopChanged) _then) = __$ActiveStopChangedCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class __$ActiveStopChangedCopyWithImpl<$Res>
    implements _$ActiveStopChangedCopyWith<$Res> {
  __$ActiveStopChangedCopyWithImpl(this._self, this._then);

  final _ActiveStopChanged _self;
  final $Res Function(_ActiveStopChanged) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(_ActiveStopChanged(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _StopQueryChanged implements OrderEvent {
  const _StopQueryChanged(this.index, this.query);
  

 final  int index;
 final  String query;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StopQueryChangedCopyWith<_StopQueryChanged> get copyWith => __$StopQueryChangedCopyWithImpl<_StopQueryChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StopQueryChanged&&(identical(other.index, index) || other.index == index)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,index,query);

@override
String toString() {
  return 'OrderEvent.stopQueryChanged(index: $index, query: $query)';
}


}

/// @nodoc
abstract mixin class _$StopQueryChangedCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$StopQueryChangedCopyWith(_StopQueryChanged value, $Res Function(_StopQueryChanged) _then) = __$StopQueryChangedCopyWithImpl;
@useResult
$Res call({
 int index, String query
});




}
/// @nodoc
class __$StopQueryChangedCopyWithImpl<$Res>
    implements _$StopQueryChangedCopyWith<$Res> {
  __$StopQueryChangedCopyWithImpl(this._self, this._then);

  final _StopQueryChanged _self;
  final $Res Function(_StopQueryChanged) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,Object? query = null,}) {
  return _then(_StopQueryChanged(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _StopCleared implements OrderEvent {
  const _StopCleared(this.index);
  

 final  int index;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StopClearedCopyWith<_StopCleared> get copyWith => __$StopClearedCopyWithImpl<_StopCleared>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StopCleared&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'OrderEvent.stopCleared(index: $index)';
}


}

/// @nodoc
abstract mixin class _$StopClearedCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$StopClearedCopyWith(_StopCleared value, $Res Function(_StopCleared) _then) = __$StopClearedCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class __$StopClearedCopyWithImpl<$Res>
    implements _$StopClearedCopyWith<$Res> {
  __$StopClearedCopyWithImpl(this._self, this._then);

  final _StopCleared _self;
  final $Res Function(_StopCleared) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(_StopCleared(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _StopSuggestionSelected implements OrderEvent {
  const _StopSuggestionSelected(this.index, this.location);
  

 final  int index;
 final  OrderSavedLocationEntity location;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StopSuggestionSelectedCopyWith<_StopSuggestionSelected> get copyWith => __$StopSuggestionSelectedCopyWithImpl<_StopSuggestionSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StopSuggestionSelected&&(identical(other.index, index) || other.index == index)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,index,location);

@override
String toString() {
  return 'OrderEvent.stopSuggestionSelected(index: $index, location: $location)';
}


}

/// @nodoc
abstract mixin class _$StopSuggestionSelectedCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$StopSuggestionSelectedCopyWith(_StopSuggestionSelected value, $Res Function(_StopSuggestionSelected) _then) = __$StopSuggestionSelectedCopyWithImpl;
@useResult
$Res call({
 int index, OrderSavedLocationEntity location
});




}
/// @nodoc
class __$StopSuggestionSelectedCopyWithImpl<$Res>
    implements _$StopSuggestionSelectedCopyWith<$Res> {
  __$StopSuggestionSelectedCopyWithImpl(this._self, this._then);

  final _StopSuggestionSelected _self;
  final $Res Function(_StopSuggestionSelected) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,Object? location = null,}) {
  return _then(_StopSuggestionSelected(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as OrderSavedLocationEntity,
  ));
}


}

/// @nodoc


class _StopAdded implements OrderEvent {
  const _StopAdded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StopAdded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent.stopAdded()';
}


}




/// @nodoc


class _StopRemoved implements OrderEvent {
  const _StopRemoved(this.index);
  

 final  int index;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StopRemovedCopyWith<_StopRemoved> get copyWith => __$StopRemovedCopyWithImpl<_StopRemoved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StopRemoved&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'OrderEvent.stopRemoved(index: $index)';
}


}

/// @nodoc
abstract mixin class _$StopRemovedCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$StopRemovedCopyWith(_StopRemoved value, $Res Function(_StopRemoved) _then) = __$StopRemovedCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class __$StopRemovedCopyWithImpl<$Res>
    implements _$StopRemovedCopyWith<$Res> {
  __$StopRemovedCopyWithImpl(this._self, this._then);

  final _StopRemoved _self;
  final $Res Function(_StopRemoved) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(_StopRemoved(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _StopReordered implements OrderEvent {
  const _StopReordered(this.oldIndex, this.newIndex);
  

 final  int oldIndex;
 final  int newIndex;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StopReorderedCopyWith<_StopReordered> get copyWith => __$StopReorderedCopyWithImpl<_StopReordered>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StopReordered&&(identical(other.oldIndex, oldIndex) || other.oldIndex == oldIndex)&&(identical(other.newIndex, newIndex) || other.newIndex == newIndex));
}


@override
int get hashCode => Object.hash(runtimeType,oldIndex,newIndex);

@override
String toString() {
  return 'OrderEvent.stopReordered(oldIndex: $oldIndex, newIndex: $newIndex)';
}


}

/// @nodoc
abstract mixin class _$StopReorderedCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$StopReorderedCopyWith(_StopReordered value, $Res Function(_StopReordered) _then) = __$StopReorderedCopyWithImpl;
@useResult
$Res call({
 int oldIndex, int newIndex
});




}
/// @nodoc
class __$StopReorderedCopyWithImpl<$Res>
    implements _$StopReorderedCopyWith<$Res> {
  __$StopReorderedCopyWithImpl(this._self, this._then);

  final _StopReordered _self;
  final $Res Function(_StopReordered) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? oldIndex = null,Object? newIndex = null,}) {
  return _then(_StopReordered(
null == oldIndex ? _self.oldIndex : oldIndex // ignore: cast_nullable_to_non_nullable
as int,null == newIndex ? _self.newIndex : newIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _SavedLocationPinToggled implements OrderEvent {
  const _SavedLocationPinToggled({required this.stopIndex, required this.location});
  

 final  int stopIndex;
 final  OrderSavedLocationEntity location;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedLocationPinToggledCopyWith<_SavedLocationPinToggled> get copyWith => __$SavedLocationPinToggledCopyWithImpl<_SavedLocationPinToggled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedLocationPinToggled&&(identical(other.stopIndex, stopIndex) || other.stopIndex == stopIndex)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,stopIndex,location);

@override
String toString() {
  return 'OrderEvent.savedLocationPinToggled(stopIndex: $stopIndex, location: $location)';
}


}

/// @nodoc
abstract mixin class _$SavedLocationPinToggledCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$SavedLocationPinToggledCopyWith(_SavedLocationPinToggled value, $Res Function(_SavedLocationPinToggled) _then) = __$SavedLocationPinToggledCopyWithImpl;
@useResult
$Res call({
 int stopIndex, OrderSavedLocationEntity location
});




}
/// @nodoc
class __$SavedLocationPinToggledCopyWithImpl<$Res>
    implements _$SavedLocationPinToggledCopyWith<$Res> {
  __$SavedLocationPinToggledCopyWithImpl(this._self, this._then);

  final _SavedLocationPinToggled _self;
  final $Res Function(_SavedLocationPinToggled) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stopIndex = null,Object? location = null,}) {
  return _then(_SavedLocationPinToggled(
stopIndex: null == stopIndex ? _self.stopIndex : stopIndex // ignore: cast_nullable_to_non_nullable
as int,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as OrderSavedLocationEntity,
  ));
}


}

/// @nodoc


class _CarTypeToggled implements OrderEvent {
  const _CarTypeToggled(this.typeId);
  

 final  String typeId;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CarTypeToggledCopyWith<_CarTypeToggled> get copyWith => __$CarTypeToggledCopyWithImpl<_CarTypeToggled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CarTypeToggled&&(identical(other.typeId, typeId) || other.typeId == typeId));
}


@override
int get hashCode => Object.hash(runtimeType,typeId);

@override
String toString() {
  return 'OrderEvent.carTypeToggled(typeId: $typeId)';
}


}

/// @nodoc
abstract mixin class _$CarTypeToggledCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$CarTypeToggledCopyWith(_CarTypeToggled value, $Res Function(_CarTypeToggled) _then) = __$CarTypeToggledCopyWithImpl;
@useResult
$Res call({
 String typeId
});




}
/// @nodoc
class __$CarTypeToggledCopyWithImpl<$Res>
    implements _$CarTypeToggledCopyWith<$Res> {
  __$CarTypeToggledCopyWithImpl(this._self, this._then);

  final _CarTypeToggled _self;
  final $Res Function(_CarTypeToggled) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? typeId = null,}) {
  return _then(_CarTypeToggled(
null == typeId ? _self.typeId : typeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _TripPrefetchCompleted implements OrderEvent {
   _TripPrefetchCompleted({required this.token, required final  List<OrderLocationEntity> stops, required this.routeState, required this.pricingState}): _stops = stops;
  

 final  int token;
 final  List<OrderLocationEntity> _stops;
 List<OrderLocationEntity> get stops {
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stops);
}

 final  BlocStatus<OrderTripRouteEntity> routeState;
 final  BlocStatus<List<OrderTripCarOptionEntity>> pricingState;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripPrefetchCompletedCopyWith<_TripPrefetchCompleted> get copyWith => __$TripPrefetchCompletedCopyWithImpl<_TripPrefetchCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripPrefetchCompleted&&(identical(other.token, token) || other.token == token)&&const DeepCollectionEquality().equals(other._stops, _stops)&&(identical(other.routeState, routeState) || other.routeState == routeState)&&(identical(other.pricingState, pricingState) || other.pricingState == pricingState));
}


@override
int get hashCode => Object.hash(runtimeType,token,const DeepCollectionEquality().hash(_stops),routeState,pricingState);

@override
String toString() {
  return 'OrderEvent.tripPrefetchCompleted(token: $token, stops: $stops, routeState: $routeState, pricingState: $pricingState)';
}


}

/// @nodoc
abstract mixin class _$TripPrefetchCompletedCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$TripPrefetchCompletedCopyWith(_TripPrefetchCompleted value, $Res Function(_TripPrefetchCompleted) _then) = __$TripPrefetchCompletedCopyWithImpl;
@useResult
$Res call({
 int token, List<OrderLocationEntity> stops, BlocStatus<OrderTripRouteEntity> routeState, BlocStatus<List<OrderTripCarOptionEntity>> pricingState
});


$BlocStatusCopyWith<OrderTripRouteEntity, $Res> get routeState;$BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res> get pricingState;

}
/// @nodoc
class __$TripPrefetchCompletedCopyWithImpl<$Res>
    implements _$TripPrefetchCompletedCopyWith<$Res> {
  __$TripPrefetchCompletedCopyWithImpl(this._self, this._then);

  final _TripPrefetchCompleted _self;
  final $Res Function(_TripPrefetchCompleted) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? token = null,Object? stops = null,Object? routeState = null,Object? pricingState = null,}) {
  return _then(_TripPrefetchCompleted(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as int,stops: null == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<OrderLocationEntity>,routeState: null == routeState ? _self.routeState : routeState // ignore: cast_nullable_to_non_nullable
as BlocStatus<OrderTripRouteEntity>,pricingState: null == pricingState ? _self.pricingState : pricingState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<OrderTripCarOptionEntity>>,
  ));
}

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<OrderTripRouteEntity, $Res> get routeState {
  
  return $BlocStatusCopyWith<OrderTripRouteEntity, $Res>(_self.routeState, (value) {
    return _then(_self.copyWith(routeState: value));
  });
}/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res> get pricingState {
  
  return $BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res>(_self.pricingState, (value) {
    return _then(_self.copyWith(pricingState: value));
  });
}
}

/// @nodoc


class _ConfirmOrderPressed implements OrderEvent {
  const _ConfirmOrderPressed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmOrderPressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent.confirmOrderPressed()';
}


}




/// @nodoc


class _ConfirmCarSelectionPressed implements OrderEvent {
  const _ConfirmCarSelectionPressed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmCarSelectionPressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent.confirmCarSelectionPressed()';
}


}




/// @nodoc


class _BookingDetailsBackPressed implements OrderEvent {
  const _BookingDetailsBackPressed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingDetailsBackPressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent.bookingDetailsBackPressed()';
}


}




/// @nodoc


class _ScheduleModeChanged implements OrderEvent {
  const _ScheduleModeChanged(this.mode);
  

 final  OrderScheduleMode mode;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleModeChangedCopyWith<_ScheduleModeChanged> get copyWith => __$ScheduleModeChangedCopyWithImpl<_ScheduleModeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleModeChanged&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,mode);

@override
String toString() {
  return 'OrderEvent.scheduleModeChanged(mode: $mode)';
}


}

/// @nodoc
abstract mixin class _$ScheduleModeChangedCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$ScheduleModeChangedCopyWith(_ScheduleModeChanged value, $Res Function(_ScheduleModeChanged) _then) = __$ScheduleModeChangedCopyWithImpl;
@useResult
$Res call({
 OrderScheduleMode mode
});




}
/// @nodoc
class __$ScheduleModeChangedCopyWithImpl<$Res>
    implements _$ScheduleModeChangedCopyWith<$Res> {
  __$ScheduleModeChangedCopyWithImpl(this._self, this._then);

  final _ScheduleModeChanged _self;
  final $Res Function(_ScheduleModeChanged) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mode = null,}) {
  return _then(_ScheduleModeChanged(
null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as OrderScheduleMode,
  ));
}


}

/// @nodoc


class _ScheduleTimeChanged implements OrderEvent {
  const _ScheduleTimeChanged(this.time);
  

 final  DateTime? time;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleTimeChangedCopyWith<_ScheduleTimeChanged> get copyWith => __$ScheduleTimeChangedCopyWithImpl<_ScheduleTimeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleTimeChanged&&(identical(other.time, time) || other.time == time));
}


@override
int get hashCode => Object.hash(runtimeType,time);

@override
String toString() {
  return 'OrderEvent.scheduleTimeChanged(time: $time)';
}


}

/// @nodoc
abstract mixin class _$ScheduleTimeChangedCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$ScheduleTimeChangedCopyWith(_ScheduleTimeChanged value, $Res Function(_ScheduleTimeChanged) _then) = __$ScheduleTimeChangedCopyWithImpl;
@useResult
$Res call({
 DateTime? time
});




}
/// @nodoc
class __$ScheduleTimeChangedCopyWithImpl<$Res>
    implements _$ScheduleTimeChangedCopyWith<$Res> {
  __$ScheduleTimeChangedCopyWithImpl(this._self, this._then);

  final _ScheduleTimeChanged _self;
  final $Res Function(_ScheduleTimeChanged) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? time = freezed,}) {
  return _then(_ScheduleTimeChanged(
freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class _PaymentMethodChanged implements OrderEvent {
  const _PaymentMethodChanged(this.methodId);
  

 final  String methodId;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentMethodChangedCopyWith<_PaymentMethodChanged> get copyWith => __$PaymentMethodChangedCopyWithImpl<_PaymentMethodChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentMethodChanged&&(identical(other.methodId, methodId) || other.methodId == methodId));
}


@override
int get hashCode => Object.hash(runtimeType,methodId);

@override
String toString() {
  return 'OrderEvent.paymentMethodChanged(methodId: $methodId)';
}


}

/// @nodoc
abstract mixin class _$PaymentMethodChangedCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$PaymentMethodChangedCopyWith(_PaymentMethodChanged value, $Res Function(_PaymentMethodChanged) _then) = __$PaymentMethodChangedCopyWithImpl;
@useResult
$Res call({
 String methodId
});




}
/// @nodoc
class __$PaymentMethodChangedCopyWithImpl<$Res>
    implements _$PaymentMethodChangedCopyWith<$Res> {
  __$PaymentMethodChangedCopyWithImpl(this._self, this._then);

  final _PaymentMethodChanged _self;
  final $Res Function(_PaymentMethodChanged) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? methodId = null,}) {
  return _then(_PaymentMethodChanged(
null == methodId ? _self.methodId : methodId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ConfirmBookingDetailsPressed implements OrderEvent {
  const _ConfirmBookingDetailsPressed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmBookingDetailsPressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent.confirmBookingDetailsPressed()';
}


}




/// @nodoc
mixin _$OrderState {

 BlocStatus<List<OrderEntity>> get getAllState; OrderSheetMode get sheetMode; OrderExpandedStep get expandedStep; OrderLocationTarget get mapPickingTarget; double get mapCameraLatitude; double get mapCameraLongitude; double get mapCameraZoom; List<OrderLocationEntity?> get stops; List<String> get stopQueries; List<BlocStatus<List<OrderSavedLocationEntity>>> get stopSuggestionsState; int get activeStopIndex; BlocStatus<List<OrderSavedLocationEntity>> get savedLocationsState; BlocStatus<OrderTripRouteEntity> get tripRouteState; BlocStatus<List<OrderTripCarOptionEntity>> get tripCarOptionsState; BlocStatus<OrderTripRouteEntity> get prefetchedTripRouteState; BlocStatus<List<OrderTripCarOptionEntity>> get prefetchedTripCarOptionsState; List<OrderLocationEntity> get prefetchedStops; String? get selectedCarTypeId; String? get selectedQuoteId; OrderScheduleMode get scheduleMode; DateTime? get scheduledAt; String? get paymentMethodId; BlocStatus<OrderTripResponseEntity> get tripRequestStatus;
/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderStateCopyWith<OrderState> get copyWith => _$OrderStateCopyWithImpl<OrderState>(this as OrderState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderState&&(identical(other.getAllState, getAllState) || other.getAllState == getAllState)&&(identical(other.sheetMode, sheetMode) || other.sheetMode == sheetMode)&&(identical(other.expandedStep, expandedStep) || other.expandedStep == expandedStep)&&(identical(other.mapPickingTarget, mapPickingTarget) || other.mapPickingTarget == mapPickingTarget)&&(identical(other.mapCameraLatitude, mapCameraLatitude) || other.mapCameraLatitude == mapCameraLatitude)&&(identical(other.mapCameraLongitude, mapCameraLongitude) || other.mapCameraLongitude == mapCameraLongitude)&&(identical(other.mapCameraZoom, mapCameraZoom) || other.mapCameraZoom == mapCameraZoom)&&const DeepCollectionEquality().equals(other.stops, stops)&&const DeepCollectionEquality().equals(other.stopQueries, stopQueries)&&const DeepCollectionEquality().equals(other.stopSuggestionsState, stopSuggestionsState)&&(identical(other.activeStopIndex, activeStopIndex) || other.activeStopIndex == activeStopIndex)&&(identical(other.savedLocationsState, savedLocationsState) || other.savedLocationsState == savedLocationsState)&&(identical(other.tripRouteState, tripRouteState) || other.tripRouteState == tripRouteState)&&(identical(other.tripCarOptionsState, tripCarOptionsState) || other.tripCarOptionsState == tripCarOptionsState)&&(identical(other.prefetchedTripRouteState, prefetchedTripRouteState) || other.prefetchedTripRouteState == prefetchedTripRouteState)&&(identical(other.prefetchedTripCarOptionsState, prefetchedTripCarOptionsState) || other.prefetchedTripCarOptionsState == prefetchedTripCarOptionsState)&&const DeepCollectionEquality().equals(other.prefetchedStops, prefetchedStops)&&(identical(other.selectedCarTypeId, selectedCarTypeId) || other.selectedCarTypeId == selectedCarTypeId)&&(identical(other.selectedQuoteId, selectedQuoteId) || other.selectedQuoteId == selectedQuoteId)&&(identical(other.scheduleMode, scheduleMode) || other.scheduleMode == scheduleMode)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.paymentMethodId, paymentMethodId) || other.paymentMethodId == paymentMethodId)&&(identical(other.tripRequestStatus, tripRequestStatus) || other.tripRequestStatus == tripRequestStatus));
}


@override
int get hashCode => Object.hashAll([runtimeType,getAllState,sheetMode,expandedStep,mapPickingTarget,mapCameraLatitude,mapCameraLongitude,mapCameraZoom,const DeepCollectionEquality().hash(stops),const DeepCollectionEquality().hash(stopQueries),const DeepCollectionEquality().hash(stopSuggestionsState),activeStopIndex,savedLocationsState,tripRouteState,tripCarOptionsState,prefetchedTripRouteState,prefetchedTripCarOptionsState,const DeepCollectionEquality().hash(prefetchedStops),selectedCarTypeId,selectedQuoteId,scheduleMode,scheduledAt,paymentMethodId,tripRequestStatus]);

@override
String toString() {
  return 'OrderState(getAllState: $getAllState, sheetMode: $sheetMode, expandedStep: $expandedStep, mapPickingTarget: $mapPickingTarget, mapCameraLatitude: $mapCameraLatitude, mapCameraLongitude: $mapCameraLongitude, mapCameraZoom: $mapCameraZoom, stops: $stops, stopQueries: $stopQueries, stopSuggestionsState: $stopSuggestionsState, activeStopIndex: $activeStopIndex, savedLocationsState: $savedLocationsState, tripRouteState: $tripRouteState, tripCarOptionsState: $tripCarOptionsState, prefetchedTripRouteState: $prefetchedTripRouteState, prefetchedTripCarOptionsState: $prefetchedTripCarOptionsState, prefetchedStops: $prefetchedStops, selectedCarTypeId: $selectedCarTypeId, selectedQuoteId: $selectedQuoteId, scheduleMode: $scheduleMode, scheduledAt: $scheduledAt, paymentMethodId: $paymentMethodId, tripRequestStatus: $tripRequestStatus)';
}


}

/// @nodoc
abstract mixin class $OrderStateCopyWith<$Res>  {
  factory $OrderStateCopyWith(OrderState value, $Res Function(OrderState) _then) = _$OrderStateCopyWithImpl;
@useResult
$Res call({
 BlocStatus<List<OrderEntity>> getAllState, OrderSheetMode sheetMode, OrderExpandedStep expandedStep, OrderLocationTarget mapPickingTarget, double mapCameraLatitude, double mapCameraLongitude, double mapCameraZoom, List<OrderLocationEntity?> stops, List<String> stopQueries, List<BlocStatus<List<OrderSavedLocationEntity>>> stopSuggestionsState, int activeStopIndex, BlocStatus<List<OrderSavedLocationEntity>> savedLocationsState, BlocStatus<OrderTripRouteEntity> tripRouteState, BlocStatus<List<OrderTripCarOptionEntity>> tripCarOptionsState, BlocStatus<OrderTripRouteEntity> prefetchedTripRouteState, BlocStatus<List<OrderTripCarOptionEntity>> prefetchedTripCarOptionsState, List<OrderLocationEntity> prefetchedStops, String? selectedCarTypeId, String? selectedQuoteId, OrderScheduleMode scheduleMode, DateTime? scheduledAt, String? paymentMethodId, BlocStatus<OrderTripResponseEntity> tripRequestStatus
});


$BlocStatusCopyWith<List<OrderEntity>, $Res> get getAllState;$BlocStatusCopyWith<List<OrderSavedLocationEntity>, $Res> get savedLocationsState;$BlocStatusCopyWith<OrderTripRouteEntity, $Res> get tripRouteState;$BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res> get tripCarOptionsState;$BlocStatusCopyWith<OrderTripRouteEntity, $Res> get prefetchedTripRouteState;$BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res> get prefetchedTripCarOptionsState;$BlocStatusCopyWith<OrderTripResponseEntity, $Res> get tripRequestStatus;

}
/// @nodoc
class _$OrderStateCopyWithImpl<$Res>
    implements $OrderStateCopyWith<$Res> {
  _$OrderStateCopyWithImpl(this._self, this._then);

  final OrderState _self;
  final $Res Function(OrderState) _then;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? getAllState = null,Object? sheetMode = null,Object? expandedStep = null,Object? mapPickingTarget = null,Object? mapCameraLatitude = null,Object? mapCameraLongitude = null,Object? mapCameraZoom = null,Object? stops = null,Object? stopQueries = null,Object? stopSuggestionsState = null,Object? activeStopIndex = null,Object? savedLocationsState = null,Object? tripRouteState = null,Object? tripCarOptionsState = null,Object? prefetchedTripRouteState = null,Object? prefetchedTripCarOptionsState = null,Object? prefetchedStops = null,Object? selectedCarTypeId = freezed,Object? selectedQuoteId = freezed,Object? scheduleMode = null,Object? scheduledAt = freezed,Object? paymentMethodId = freezed,Object? tripRequestStatus = null,}) {
  return _then(_self.copyWith(
getAllState: null == getAllState ? _self.getAllState : getAllState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<OrderEntity>>,sheetMode: null == sheetMode ? _self.sheetMode : sheetMode // ignore: cast_nullable_to_non_nullable
as OrderSheetMode,expandedStep: null == expandedStep ? _self.expandedStep : expandedStep // ignore: cast_nullable_to_non_nullable
as OrderExpandedStep,mapPickingTarget: null == mapPickingTarget ? _self.mapPickingTarget : mapPickingTarget // ignore: cast_nullable_to_non_nullable
as OrderLocationTarget,mapCameraLatitude: null == mapCameraLatitude ? _self.mapCameraLatitude : mapCameraLatitude // ignore: cast_nullable_to_non_nullable
as double,mapCameraLongitude: null == mapCameraLongitude ? _self.mapCameraLongitude : mapCameraLongitude // ignore: cast_nullable_to_non_nullable
as double,mapCameraZoom: null == mapCameraZoom ? _self.mapCameraZoom : mapCameraZoom // ignore: cast_nullable_to_non_nullable
as double,stops: null == stops ? _self.stops : stops // ignore: cast_nullable_to_non_nullable
as List<OrderLocationEntity?>,stopQueries: null == stopQueries ? _self.stopQueries : stopQueries // ignore: cast_nullable_to_non_nullable
as List<String>,stopSuggestionsState: null == stopSuggestionsState ? _self.stopSuggestionsState : stopSuggestionsState // ignore: cast_nullable_to_non_nullable
as List<BlocStatus<List<OrderSavedLocationEntity>>>,activeStopIndex: null == activeStopIndex ? _self.activeStopIndex : activeStopIndex // ignore: cast_nullable_to_non_nullable
as int,savedLocationsState: null == savedLocationsState ? _self.savedLocationsState : savedLocationsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<OrderSavedLocationEntity>>,tripRouteState: null == tripRouteState ? _self.tripRouteState : tripRouteState // ignore: cast_nullable_to_non_nullable
as BlocStatus<OrderTripRouteEntity>,tripCarOptionsState: null == tripCarOptionsState ? _self.tripCarOptionsState : tripCarOptionsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<OrderTripCarOptionEntity>>,prefetchedTripRouteState: null == prefetchedTripRouteState ? _self.prefetchedTripRouteState : prefetchedTripRouteState // ignore: cast_nullable_to_non_nullable
as BlocStatus<OrderTripRouteEntity>,prefetchedTripCarOptionsState: null == prefetchedTripCarOptionsState ? _self.prefetchedTripCarOptionsState : prefetchedTripCarOptionsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<OrderTripCarOptionEntity>>,prefetchedStops: null == prefetchedStops ? _self.prefetchedStops : prefetchedStops // ignore: cast_nullable_to_non_nullable
as List<OrderLocationEntity>,selectedCarTypeId: freezed == selectedCarTypeId ? _self.selectedCarTypeId : selectedCarTypeId // ignore: cast_nullable_to_non_nullable
as String?,selectedQuoteId: freezed == selectedQuoteId ? _self.selectedQuoteId : selectedQuoteId // ignore: cast_nullable_to_non_nullable
as String?,scheduleMode: null == scheduleMode ? _self.scheduleMode : scheduleMode // ignore: cast_nullable_to_non_nullable
as OrderScheduleMode,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,paymentMethodId: freezed == paymentMethodId ? _self.paymentMethodId : paymentMethodId // ignore: cast_nullable_to_non_nullable
as String?,tripRequestStatus: null == tripRequestStatus ? _self.tripRequestStatus : tripRequestStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<OrderTripResponseEntity>,
  ));
}
/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<OrderEntity>, $Res> get getAllState {
  
  return $BlocStatusCopyWith<List<OrderEntity>, $Res>(_self.getAllState, (value) {
    return _then(_self.copyWith(getAllState: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<OrderSavedLocationEntity>, $Res> get savedLocationsState {
  
  return $BlocStatusCopyWith<List<OrderSavedLocationEntity>, $Res>(_self.savedLocationsState, (value) {
    return _then(_self.copyWith(savedLocationsState: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<OrderTripRouteEntity, $Res> get tripRouteState {
  
  return $BlocStatusCopyWith<OrderTripRouteEntity, $Res>(_self.tripRouteState, (value) {
    return _then(_self.copyWith(tripRouteState: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res> get tripCarOptionsState {
  
  return $BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res>(_self.tripCarOptionsState, (value) {
    return _then(_self.copyWith(tripCarOptionsState: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<OrderTripRouteEntity, $Res> get prefetchedTripRouteState {
  
  return $BlocStatusCopyWith<OrderTripRouteEntity, $Res>(_self.prefetchedTripRouteState, (value) {
    return _then(_self.copyWith(prefetchedTripRouteState: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res> get prefetchedTripCarOptionsState {
  
  return $BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res>(_self.prefetchedTripCarOptionsState, (value) {
    return _then(_self.copyWith(prefetchedTripCarOptionsState: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<OrderTripResponseEntity, $Res> get tripRequestStatus {
  
  return $BlocStatusCopyWith<OrderTripResponseEntity, $Res>(_self.tripRequestStatus, (value) {
    return _then(_self.copyWith(tripRequestStatus: value));
  });
}
}


/// Adds pattern-matching-related methods to [OrderState].
extension OrderStatePatterns on OrderState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderState value)  $default,){
final _that = this;
switch (_that) {
case _OrderState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderState value)?  $default,){
final _that = this;
switch (_that) {
case _OrderState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlocStatus<List<OrderEntity>> getAllState,  OrderSheetMode sheetMode,  OrderExpandedStep expandedStep,  OrderLocationTarget mapPickingTarget,  double mapCameraLatitude,  double mapCameraLongitude,  double mapCameraZoom,  List<OrderLocationEntity?> stops,  List<String> stopQueries,  List<BlocStatus<List<OrderSavedLocationEntity>>> stopSuggestionsState,  int activeStopIndex,  BlocStatus<List<OrderSavedLocationEntity>> savedLocationsState,  BlocStatus<OrderTripRouteEntity> tripRouteState,  BlocStatus<List<OrderTripCarOptionEntity>> tripCarOptionsState,  BlocStatus<OrderTripRouteEntity> prefetchedTripRouteState,  BlocStatus<List<OrderTripCarOptionEntity>> prefetchedTripCarOptionsState,  List<OrderLocationEntity> prefetchedStops,  String? selectedCarTypeId,  String? selectedQuoteId,  OrderScheduleMode scheduleMode,  DateTime? scheduledAt,  String? paymentMethodId,  BlocStatus<OrderTripResponseEntity> tripRequestStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderState() when $default != null:
return $default(_that.getAllState,_that.sheetMode,_that.expandedStep,_that.mapPickingTarget,_that.mapCameraLatitude,_that.mapCameraLongitude,_that.mapCameraZoom,_that.stops,_that.stopQueries,_that.stopSuggestionsState,_that.activeStopIndex,_that.savedLocationsState,_that.tripRouteState,_that.tripCarOptionsState,_that.prefetchedTripRouteState,_that.prefetchedTripCarOptionsState,_that.prefetchedStops,_that.selectedCarTypeId,_that.selectedQuoteId,_that.scheduleMode,_that.scheduledAt,_that.paymentMethodId,_that.tripRequestStatus);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlocStatus<List<OrderEntity>> getAllState,  OrderSheetMode sheetMode,  OrderExpandedStep expandedStep,  OrderLocationTarget mapPickingTarget,  double mapCameraLatitude,  double mapCameraLongitude,  double mapCameraZoom,  List<OrderLocationEntity?> stops,  List<String> stopQueries,  List<BlocStatus<List<OrderSavedLocationEntity>>> stopSuggestionsState,  int activeStopIndex,  BlocStatus<List<OrderSavedLocationEntity>> savedLocationsState,  BlocStatus<OrderTripRouteEntity> tripRouteState,  BlocStatus<List<OrderTripCarOptionEntity>> tripCarOptionsState,  BlocStatus<OrderTripRouteEntity> prefetchedTripRouteState,  BlocStatus<List<OrderTripCarOptionEntity>> prefetchedTripCarOptionsState,  List<OrderLocationEntity> prefetchedStops,  String? selectedCarTypeId,  String? selectedQuoteId,  OrderScheduleMode scheduleMode,  DateTime? scheduledAt,  String? paymentMethodId,  BlocStatus<OrderTripResponseEntity> tripRequestStatus)  $default,) {final _that = this;
switch (_that) {
case _OrderState():
return $default(_that.getAllState,_that.sheetMode,_that.expandedStep,_that.mapPickingTarget,_that.mapCameraLatitude,_that.mapCameraLongitude,_that.mapCameraZoom,_that.stops,_that.stopQueries,_that.stopSuggestionsState,_that.activeStopIndex,_that.savedLocationsState,_that.tripRouteState,_that.tripCarOptionsState,_that.prefetchedTripRouteState,_that.prefetchedTripCarOptionsState,_that.prefetchedStops,_that.selectedCarTypeId,_that.selectedQuoteId,_that.scheduleMode,_that.scheduledAt,_that.paymentMethodId,_that.tripRequestStatus);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlocStatus<List<OrderEntity>> getAllState,  OrderSheetMode sheetMode,  OrderExpandedStep expandedStep,  OrderLocationTarget mapPickingTarget,  double mapCameraLatitude,  double mapCameraLongitude,  double mapCameraZoom,  List<OrderLocationEntity?> stops,  List<String> stopQueries,  List<BlocStatus<List<OrderSavedLocationEntity>>> stopSuggestionsState,  int activeStopIndex,  BlocStatus<List<OrderSavedLocationEntity>> savedLocationsState,  BlocStatus<OrderTripRouteEntity> tripRouteState,  BlocStatus<List<OrderTripCarOptionEntity>> tripCarOptionsState,  BlocStatus<OrderTripRouteEntity> prefetchedTripRouteState,  BlocStatus<List<OrderTripCarOptionEntity>> prefetchedTripCarOptionsState,  List<OrderLocationEntity> prefetchedStops,  String? selectedCarTypeId,  String? selectedQuoteId,  OrderScheduleMode scheduleMode,  DateTime? scheduledAt,  String? paymentMethodId,  BlocStatus<OrderTripResponseEntity> tripRequestStatus)?  $default,) {final _that = this;
switch (_that) {
case _OrderState() when $default != null:
return $default(_that.getAllState,_that.sheetMode,_that.expandedStep,_that.mapPickingTarget,_that.mapCameraLatitude,_that.mapCameraLongitude,_that.mapCameraZoom,_that.stops,_that.stopQueries,_that.stopSuggestionsState,_that.activeStopIndex,_that.savedLocationsState,_that.tripRouteState,_that.tripCarOptionsState,_that.prefetchedTripRouteState,_that.prefetchedTripCarOptionsState,_that.prefetchedStops,_that.selectedCarTypeId,_that.selectedQuoteId,_that.scheduleMode,_that.scheduledAt,_that.paymentMethodId,_that.tripRequestStatus);case _:
  return null;

}
}

}

/// @nodoc


class _OrderState implements OrderState {
  const _OrderState({this.getAllState = const BlocStatus<List<OrderEntity>>.initial(), this.sheetMode = OrderSheetMode.collapsed, this.expandedStep = OrderExpandedStep.locationEntry, this.mapPickingTarget = OrderLocationTarget.stop, this.mapCameraLatitude = MapConfig.defaultLat, this.mapCameraLongitude = MapConfig.defaultLng, this.mapCameraZoom = MapConfig.initialZoom, final  List<OrderLocationEntity?> stops = const [null, null], final  List<String> stopQueries = const ['', ''], final  List<BlocStatus<List<OrderSavedLocationEntity>>> stopSuggestionsState = const [BlocStatus<List<OrderSavedLocationEntity>>.initial(), BlocStatus<List<OrderSavedLocationEntity>>.initial()], this.activeStopIndex = 0, this.savedLocationsState = const BlocStatus<List<OrderSavedLocationEntity>>.initial(), this.tripRouteState = const BlocStatus<OrderTripRouteEntity>.initial(), this.tripCarOptionsState = const BlocStatus<List<OrderTripCarOptionEntity>>.initial(), this.prefetchedTripRouteState = const BlocStatus<OrderTripRouteEntity>.initial(), this.prefetchedTripCarOptionsState = const BlocStatus<List<OrderTripCarOptionEntity>>.initial(), final  List<OrderLocationEntity> prefetchedStops = const [], this.selectedCarTypeId, this.selectedQuoteId, this.scheduleMode = OrderScheduleMode.now, this.scheduledAt, this.paymentMethodId, this.tripRequestStatus = const BlocStatus<OrderTripResponseEntity>.initial()}): _stops = stops,_stopQueries = stopQueries,_stopSuggestionsState = stopSuggestionsState,_prefetchedStops = prefetchedStops;
  

@override@JsonKey() final  BlocStatus<List<OrderEntity>> getAllState;
@override@JsonKey() final  OrderSheetMode sheetMode;
@override@JsonKey() final  OrderExpandedStep expandedStep;
@override@JsonKey() final  OrderLocationTarget mapPickingTarget;
@override@JsonKey() final  double mapCameraLatitude;
@override@JsonKey() final  double mapCameraLongitude;
@override@JsonKey() final  double mapCameraZoom;
 final  List<OrderLocationEntity?> _stops;
@override@JsonKey() List<OrderLocationEntity?> get stops {
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stops);
}

 final  List<String> _stopQueries;
@override@JsonKey() List<String> get stopQueries {
  if (_stopQueries is EqualUnmodifiableListView) return _stopQueries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stopQueries);
}

 final  List<BlocStatus<List<OrderSavedLocationEntity>>> _stopSuggestionsState;
@override@JsonKey() List<BlocStatus<List<OrderSavedLocationEntity>>> get stopSuggestionsState {
  if (_stopSuggestionsState is EqualUnmodifiableListView) return _stopSuggestionsState;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stopSuggestionsState);
}

@override@JsonKey() final  int activeStopIndex;
@override@JsonKey() final  BlocStatus<List<OrderSavedLocationEntity>> savedLocationsState;
@override@JsonKey() final  BlocStatus<OrderTripRouteEntity> tripRouteState;
@override@JsonKey() final  BlocStatus<List<OrderTripCarOptionEntity>> tripCarOptionsState;
@override@JsonKey() final  BlocStatus<OrderTripRouteEntity> prefetchedTripRouteState;
@override@JsonKey() final  BlocStatus<List<OrderTripCarOptionEntity>> prefetchedTripCarOptionsState;
 final  List<OrderLocationEntity> _prefetchedStops;
@override@JsonKey() List<OrderLocationEntity> get prefetchedStops {
  if (_prefetchedStops is EqualUnmodifiableListView) return _prefetchedStops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prefetchedStops);
}

@override final  String? selectedCarTypeId;
@override final  String? selectedQuoteId;
@override@JsonKey() final  OrderScheduleMode scheduleMode;
@override final  DateTime? scheduledAt;
@override final  String? paymentMethodId;
@override@JsonKey() final  BlocStatus<OrderTripResponseEntity> tripRequestStatus;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderStateCopyWith<_OrderState> get copyWith => __$OrderStateCopyWithImpl<_OrderState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderState&&(identical(other.getAllState, getAllState) || other.getAllState == getAllState)&&(identical(other.sheetMode, sheetMode) || other.sheetMode == sheetMode)&&(identical(other.expandedStep, expandedStep) || other.expandedStep == expandedStep)&&(identical(other.mapPickingTarget, mapPickingTarget) || other.mapPickingTarget == mapPickingTarget)&&(identical(other.mapCameraLatitude, mapCameraLatitude) || other.mapCameraLatitude == mapCameraLatitude)&&(identical(other.mapCameraLongitude, mapCameraLongitude) || other.mapCameraLongitude == mapCameraLongitude)&&(identical(other.mapCameraZoom, mapCameraZoom) || other.mapCameraZoom == mapCameraZoom)&&const DeepCollectionEquality().equals(other._stops, _stops)&&const DeepCollectionEquality().equals(other._stopQueries, _stopQueries)&&const DeepCollectionEquality().equals(other._stopSuggestionsState, _stopSuggestionsState)&&(identical(other.activeStopIndex, activeStopIndex) || other.activeStopIndex == activeStopIndex)&&(identical(other.savedLocationsState, savedLocationsState) || other.savedLocationsState == savedLocationsState)&&(identical(other.tripRouteState, tripRouteState) || other.tripRouteState == tripRouteState)&&(identical(other.tripCarOptionsState, tripCarOptionsState) || other.tripCarOptionsState == tripCarOptionsState)&&(identical(other.prefetchedTripRouteState, prefetchedTripRouteState) || other.prefetchedTripRouteState == prefetchedTripRouteState)&&(identical(other.prefetchedTripCarOptionsState, prefetchedTripCarOptionsState) || other.prefetchedTripCarOptionsState == prefetchedTripCarOptionsState)&&const DeepCollectionEquality().equals(other._prefetchedStops, _prefetchedStops)&&(identical(other.selectedCarTypeId, selectedCarTypeId) || other.selectedCarTypeId == selectedCarTypeId)&&(identical(other.selectedQuoteId, selectedQuoteId) || other.selectedQuoteId == selectedQuoteId)&&(identical(other.scheduleMode, scheduleMode) || other.scheduleMode == scheduleMode)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.paymentMethodId, paymentMethodId) || other.paymentMethodId == paymentMethodId)&&(identical(other.tripRequestStatus, tripRequestStatus) || other.tripRequestStatus == tripRequestStatus));
}


@override
int get hashCode => Object.hashAll([runtimeType,getAllState,sheetMode,expandedStep,mapPickingTarget,mapCameraLatitude,mapCameraLongitude,mapCameraZoom,const DeepCollectionEquality().hash(_stops),const DeepCollectionEquality().hash(_stopQueries),const DeepCollectionEquality().hash(_stopSuggestionsState),activeStopIndex,savedLocationsState,tripRouteState,tripCarOptionsState,prefetchedTripRouteState,prefetchedTripCarOptionsState,const DeepCollectionEquality().hash(_prefetchedStops),selectedCarTypeId,selectedQuoteId,scheduleMode,scheduledAt,paymentMethodId,tripRequestStatus]);

@override
String toString() {
  return 'OrderState(getAllState: $getAllState, sheetMode: $sheetMode, expandedStep: $expandedStep, mapPickingTarget: $mapPickingTarget, mapCameraLatitude: $mapCameraLatitude, mapCameraLongitude: $mapCameraLongitude, mapCameraZoom: $mapCameraZoom, stops: $stops, stopQueries: $stopQueries, stopSuggestionsState: $stopSuggestionsState, activeStopIndex: $activeStopIndex, savedLocationsState: $savedLocationsState, tripRouteState: $tripRouteState, tripCarOptionsState: $tripCarOptionsState, prefetchedTripRouteState: $prefetchedTripRouteState, prefetchedTripCarOptionsState: $prefetchedTripCarOptionsState, prefetchedStops: $prefetchedStops, selectedCarTypeId: $selectedCarTypeId, selectedQuoteId: $selectedQuoteId, scheduleMode: $scheduleMode, scheduledAt: $scheduledAt, paymentMethodId: $paymentMethodId, tripRequestStatus: $tripRequestStatus)';
}


}

/// @nodoc
abstract mixin class _$OrderStateCopyWith<$Res> implements $OrderStateCopyWith<$Res> {
  factory _$OrderStateCopyWith(_OrderState value, $Res Function(_OrderState) _then) = __$OrderStateCopyWithImpl;
@override @useResult
$Res call({
 BlocStatus<List<OrderEntity>> getAllState, OrderSheetMode sheetMode, OrderExpandedStep expandedStep, OrderLocationTarget mapPickingTarget, double mapCameraLatitude, double mapCameraLongitude, double mapCameraZoom, List<OrderLocationEntity?> stops, List<String> stopQueries, List<BlocStatus<List<OrderSavedLocationEntity>>> stopSuggestionsState, int activeStopIndex, BlocStatus<List<OrderSavedLocationEntity>> savedLocationsState, BlocStatus<OrderTripRouteEntity> tripRouteState, BlocStatus<List<OrderTripCarOptionEntity>> tripCarOptionsState, BlocStatus<OrderTripRouteEntity> prefetchedTripRouteState, BlocStatus<List<OrderTripCarOptionEntity>> prefetchedTripCarOptionsState, List<OrderLocationEntity> prefetchedStops, String? selectedCarTypeId, String? selectedQuoteId, OrderScheduleMode scheduleMode, DateTime? scheduledAt, String? paymentMethodId, BlocStatus<OrderTripResponseEntity> tripRequestStatus
});


@override $BlocStatusCopyWith<List<OrderEntity>, $Res> get getAllState;@override $BlocStatusCopyWith<List<OrderSavedLocationEntity>, $Res> get savedLocationsState;@override $BlocStatusCopyWith<OrderTripRouteEntity, $Res> get tripRouteState;@override $BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res> get tripCarOptionsState;@override $BlocStatusCopyWith<OrderTripRouteEntity, $Res> get prefetchedTripRouteState;@override $BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res> get prefetchedTripCarOptionsState;@override $BlocStatusCopyWith<OrderTripResponseEntity, $Res> get tripRequestStatus;

}
/// @nodoc
class __$OrderStateCopyWithImpl<$Res>
    implements _$OrderStateCopyWith<$Res> {
  __$OrderStateCopyWithImpl(this._self, this._then);

  final _OrderState _self;
  final $Res Function(_OrderState) _then;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? getAllState = null,Object? sheetMode = null,Object? expandedStep = null,Object? mapPickingTarget = null,Object? mapCameraLatitude = null,Object? mapCameraLongitude = null,Object? mapCameraZoom = null,Object? stops = null,Object? stopQueries = null,Object? stopSuggestionsState = null,Object? activeStopIndex = null,Object? savedLocationsState = null,Object? tripRouteState = null,Object? tripCarOptionsState = null,Object? prefetchedTripRouteState = null,Object? prefetchedTripCarOptionsState = null,Object? prefetchedStops = null,Object? selectedCarTypeId = freezed,Object? selectedQuoteId = freezed,Object? scheduleMode = null,Object? scheduledAt = freezed,Object? paymentMethodId = freezed,Object? tripRequestStatus = null,}) {
  return _then(_OrderState(
getAllState: null == getAllState ? _self.getAllState : getAllState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<OrderEntity>>,sheetMode: null == sheetMode ? _self.sheetMode : sheetMode // ignore: cast_nullable_to_non_nullable
as OrderSheetMode,expandedStep: null == expandedStep ? _self.expandedStep : expandedStep // ignore: cast_nullable_to_non_nullable
as OrderExpandedStep,mapPickingTarget: null == mapPickingTarget ? _self.mapPickingTarget : mapPickingTarget // ignore: cast_nullable_to_non_nullable
as OrderLocationTarget,mapCameraLatitude: null == mapCameraLatitude ? _self.mapCameraLatitude : mapCameraLatitude // ignore: cast_nullable_to_non_nullable
as double,mapCameraLongitude: null == mapCameraLongitude ? _self.mapCameraLongitude : mapCameraLongitude // ignore: cast_nullable_to_non_nullable
as double,mapCameraZoom: null == mapCameraZoom ? _self.mapCameraZoom : mapCameraZoom // ignore: cast_nullable_to_non_nullable
as double,stops: null == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<OrderLocationEntity?>,stopQueries: null == stopQueries ? _self._stopQueries : stopQueries // ignore: cast_nullable_to_non_nullable
as List<String>,stopSuggestionsState: null == stopSuggestionsState ? _self._stopSuggestionsState : stopSuggestionsState // ignore: cast_nullable_to_non_nullable
as List<BlocStatus<List<OrderSavedLocationEntity>>>,activeStopIndex: null == activeStopIndex ? _self.activeStopIndex : activeStopIndex // ignore: cast_nullable_to_non_nullable
as int,savedLocationsState: null == savedLocationsState ? _self.savedLocationsState : savedLocationsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<OrderSavedLocationEntity>>,tripRouteState: null == tripRouteState ? _self.tripRouteState : tripRouteState // ignore: cast_nullable_to_non_nullable
as BlocStatus<OrderTripRouteEntity>,tripCarOptionsState: null == tripCarOptionsState ? _self.tripCarOptionsState : tripCarOptionsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<OrderTripCarOptionEntity>>,prefetchedTripRouteState: null == prefetchedTripRouteState ? _self.prefetchedTripRouteState : prefetchedTripRouteState // ignore: cast_nullable_to_non_nullable
as BlocStatus<OrderTripRouteEntity>,prefetchedTripCarOptionsState: null == prefetchedTripCarOptionsState ? _self.prefetchedTripCarOptionsState : prefetchedTripCarOptionsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<OrderTripCarOptionEntity>>,prefetchedStops: null == prefetchedStops ? _self._prefetchedStops : prefetchedStops // ignore: cast_nullable_to_non_nullable
as List<OrderLocationEntity>,selectedCarTypeId: freezed == selectedCarTypeId ? _self.selectedCarTypeId : selectedCarTypeId // ignore: cast_nullable_to_non_nullable
as String?,selectedQuoteId: freezed == selectedQuoteId ? _self.selectedQuoteId : selectedQuoteId // ignore: cast_nullable_to_non_nullable
as String?,scheduleMode: null == scheduleMode ? _self.scheduleMode : scheduleMode // ignore: cast_nullable_to_non_nullable
as OrderScheduleMode,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,paymentMethodId: freezed == paymentMethodId ? _self.paymentMethodId : paymentMethodId // ignore: cast_nullable_to_non_nullable
as String?,tripRequestStatus: null == tripRequestStatus ? _self.tripRequestStatus : tripRequestStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<OrderTripResponseEntity>,
  ));
}

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<OrderEntity>, $Res> get getAllState {
  
  return $BlocStatusCopyWith<List<OrderEntity>, $Res>(_self.getAllState, (value) {
    return _then(_self.copyWith(getAllState: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<OrderSavedLocationEntity>, $Res> get savedLocationsState {
  
  return $BlocStatusCopyWith<List<OrderSavedLocationEntity>, $Res>(_self.savedLocationsState, (value) {
    return _then(_self.copyWith(savedLocationsState: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<OrderTripRouteEntity, $Res> get tripRouteState {
  
  return $BlocStatusCopyWith<OrderTripRouteEntity, $Res>(_self.tripRouteState, (value) {
    return _then(_self.copyWith(tripRouteState: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res> get tripCarOptionsState {
  
  return $BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res>(_self.tripCarOptionsState, (value) {
    return _then(_self.copyWith(tripCarOptionsState: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<OrderTripRouteEntity, $Res> get prefetchedTripRouteState {
  
  return $BlocStatusCopyWith<OrderTripRouteEntity, $Res>(_self.prefetchedTripRouteState, (value) {
    return _then(_self.copyWith(prefetchedTripRouteState: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res> get prefetchedTripCarOptionsState {
  
  return $BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res>(_self.prefetchedTripCarOptionsState, (value) {
    return _then(_self.copyWith(prefetchedTripCarOptionsState: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<OrderTripResponseEntity, $Res> get tripRequestStatus {
  
  return $BlocStatusCopyWith<OrderTripResponseEntity, $Res>(_self.tripRequestStatus, (value) {
    return _then(_self.copyWith(tripRequestStatus: value));
  });
}
}

// dart format on
