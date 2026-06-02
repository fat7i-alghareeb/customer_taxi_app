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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _OrderNowPressed value)?  orderNowPressed,TResult Function( _CollapseRequested value)?  collapseRequested,TResult Function( _MapPickCancelled value)?  mapPickCancelled,TResult Function( _VehicleStepBackPressed value)?  vehicleStepBackPressed,TResult Function( _SetOnMapPressed value)?  setOnMapPressed,TResult Function( _MapCameraTargetUpdated value)?  mapCameraTargetUpdated,TResult Function( _ConfirmMapPointPressed value)?  confirmMapPointPressed,TResult Function( _ActiveStopChanged value)?  activeStopChanged,TResult Function( _StopQueryChanged value)?  stopQueryChanged,TResult Function( _StopCleared value)?  stopCleared,TResult Function( _StopSuggestionSelected value)?  stopSuggestionSelected,TResult Function( _StopAdded value)?  stopAdded,TResult Function( _StopRemoved value)?  stopRemoved,TResult Function( _StopReordered value)?  stopReordered,TResult Function( _SavedLocationPinToggled value)?  savedLocationPinToggled,TResult Function( _CarTypeToggled value)?  carTypeToggled,TResult Function( _TripPrefetchCompleted value)?  tripPrefetchCompleted,TResult Function( _ConfirmOrderPressed value)?  confirmOrderPressed,TResult Function( _ConfirmCarSelectionPressed value)?  confirmCarSelectionPressed,TResult Function( _BookingDetailsBackPressed value)?  bookingDetailsBackPressed,TResult Function( _ScheduleModeChanged value)?  scheduleModeChanged,TResult Function( _ScheduleTimeChanged value)?  scheduleTimeChanged,TResult Function( _PassengerNoteChanged value)?  passengerNoteChanged,TResult Function( _ConfirmBookingDetailsPressed value)?  confirmBookingDetailsPressed,TResult Function( _PaymentSheetDismissed value)?  paymentSheetDismissed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _OrderNowPressed() when orderNowPressed != null:
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
return scheduleTimeChanged(_that);case _PassengerNoteChanged() when passengerNoteChanged != null:
return passengerNoteChanged(_that);case _ConfirmBookingDetailsPressed() when confirmBookingDetailsPressed != null:
return confirmBookingDetailsPressed(_that);case _PaymentSheetDismissed() when paymentSheetDismissed != null:
return paymentSheetDismissed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _OrderNowPressed value)  orderNowPressed,required TResult Function( _CollapseRequested value)  collapseRequested,required TResult Function( _MapPickCancelled value)  mapPickCancelled,required TResult Function( _VehicleStepBackPressed value)  vehicleStepBackPressed,required TResult Function( _SetOnMapPressed value)  setOnMapPressed,required TResult Function( _MapCameraTargetUpdated value)  mapCameraTargetUpdated,required TResult Function( _ConfirmMapPointPressed value)  confirmMapPointPressed,required TResult Function( _ActiveStopChanged value)  activeStopChanged,required TResult Function( _StopQueryChanged value)  stopQueryChanged,required TResult Function( _StopCleared value)  stopCleared,required TResult Function( _StopSuggestionSelected value)  stopSuggestionSelected,required TResult Function( _StopAdded value)  stopAdded,required TResult Function( _StopRemoved value)  stopRemoved,required TResult Function( _StopReordered value)  stopReordered,required TResult Function( _SavedLocationPinToggled value)  savedLocationPinToggled,required TResult Function( _CarTypeToggled value)  carTypeToggled,required TResult Function( _TripPrefetchCompleted value)  tripPrefetchCompleted,required TResult Function( _ConfirmOrderPressed value)  confirmOrderPressed,required TResult Function( _ConfirmCarSelectionPressed value)  confirmCarSelectionPressed,required TResult Function( _BookingDetailsBackPressed value)  bookingDetailsBackPressed,required TResult Function( _ScheduleModeChanged value)  scheduleModeChanged,required TResult Function( _ScheduleTimeChanged value)  scheduleTimeChanged,required TResult Function( _PassengerNoteChanged value)  passengerNoteChanged,required TResult Function( _ConfirmBookingDetailsPressed value)  confirmBookingDetailsPressed,required TResult Function( _PaymentSheetDismissed value)  paymentSheetDismissed,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _OrderNowPressed():
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
return scheduleTimeChanged(_that);case _PassengerNoteChanged():
return passengerNoteChanged(_that);case _ConfirmBookingDetailsPressed():
return confirmBookingDetailsPressed(_that);case _PaymentSheetDismissed():
return paymentSheetDismissed(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _OrderNowPressed value)?  orderNowPressed,TResult? Function( _CollapseRequested value)?  collapseRequested,TResult? Function( _MapPickCancelled value)?  mapPickCancelled,TResult? Function( _VehicleStepBackPressed value)?  vehicleStepBackPressed,TResult? Function( _SetOnMapPressed value)?  setOnMapPressed,TResult? Function( _MapCameraTargetUpdated value)?  mapCameraTargetUpdated,TResult? Function( _ConfirmMapPointPressed value)?  confirmMapPointPressed,TResult? Function( _ActiveStopChanged value)?  activeStopChanged,TResult? Function( _StopQueryChanged value)?  stopQueryChanged,TResult? Function( _StopCleared value)?  stopCleared,TResult? Function( _StopSuggestionSelected value)?  stopSuggestionSelected,TResult? Function( _StopAdded value)?  stopAdded,TResult? Function( _StopRemoved value)?  stopRemoved,TResult? Function( _StopReordered value)?  stopReordered,TResult? Function( _SavedLocationPinToggled value)?  savedLocationPinToggled,TResult? Function( _CarTypeToggled value)?  carTypeToggled,TResult? Function( _TripPrefetchCompleted value)?  tripPrefetchCompleted,TResult? Function( _ConfirmOrderPressed value)?  confirmOrderPressed,TResult? Function( _ConfirmCarSelectionPressed value)?  confirmCarSelectionPressed,TResult? Function( _BookingDetailsBackPressed value)?  bookingDetailsBackPressed,TResult? Function( _ScheduleModeChanged value)?  scheduleModeChanged,TResult? Function( _ScheduleTimeChanged value)?  scheduleTimeChanged,TResult? Function( _PassengerNoteChanged value)?  passengerNoteChanged,TResult? Function( _ConfirmBookingDetailsPressed value)?  confirmBookingDetailsPressed,TResult? Function( _PaymentSheetDismissed value)?  paymentSheetDismissed,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _OrderNowPressed() when orderNowPressed != null:
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
return scheduleTimeChanged(_that);case _PassengerNoteChanged() when passengerNoteChanged != null:
return passengerNoteChanged(_that);case _ConfirmBookingDetailsPressed() when confirmBookingDetailsPressed != null:
return confirmBookingDetailsPressed(_that);case _PaymentSheetDismissed() when paymentSheetDismissed != null:
return paymentSheetDismissed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  orderNowPressed,TResult Function()?  collapseRequested,TResult Function()?  mapPickCancelled,TResult Function()?  vehicleStepBackPressed,TResult Function( int index)?  setOnMapPressed,TResult Function( double latitude,  double longitude,  double zoom)?  mapCameraTargetUpdated,TResult Function()?  confirmMapPointPressed,TResult Function( int index)?  activeStopChanged,TResult Function( int index,  String query)?  stopQueryChanged,TResult Function( int index)?  stopCleared,TResult Function( int index,  OrderSavedLocationEntity location)?  stopSuggestionSelected,TResult Function()?  stopAdded,TResult Function( int index)?  stopRemoved,TResult Function( int oldIndex,  int newIndex)?  stopReordered,TResult Function( int stopIndex,  OrderSavedLocationEntity location)?  savedLocationPinToggled,TResult Function( String typeId)?  carTypeToggled,TResult Function( int token,  List<OrderLocationEntity> stops,  BlocStatus<OrderTripRouteEntity> routeState,  BlocStatus<List<OrderTripCarOptionEntity>> pricingState)?  tripPrefetchCompleted,TResult Function()?  confirmOrderPressed,TResult Function()?  confirmCarSelectionPressed,TResult Function()?  bookingDetailsBackPressed,TResult Function( OrderScheduleMode mode)?  scheduleModeChanged,TResult Function( DateTime? time)?  scheduleTimeChanged,TResult Function( String note)?  passengerNoteChanged,TResult Function()?  confirmBookingDetailsPressed,TResult Function()?  paymentSheetDismissed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _OrderNowPressed() when orderNowPressed != null:
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
return scheduleTimeChanged(_that.time);case _PassengerNoteChanged() when passengerNoteChanged != null:
return passengerNoteChanged(_that.note);case _ConfirmBookingDetailsPressed() when confirmBookingDetailsPressed != null:
return confirmBookingDetailsPressed();case _PaymentSheetDismissed() when paymentSheetDismissed != null:
return paymentSheetDismissed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  orderNowPressed,required TResult Function()  collapseRequested,required TResult Function()  mapPickCancelled,required TResult Function()  vehicleStepBackPressed,required TResult Function( int index)  setOnMapPressed,required TResult Function( double latitude,  double longitude,  double zoom)  mapCameraTargetUpdated,required TResult Function()  confirmMapPointPressed,required TResult Function( int index)  activeStopChanged,required TResult Function( int index,  String query)  stopQueryChanged,required TResult Function( int index)  stopCleared,required TResult Function( int index,  OrderSavedLocationEntity location)  stopSuggestionSelected,required TResult Function()  stopAdded,required TResult Function( int index)  stopRemoved,required TResult Function( int oldIndex,  int newIndex)  stopReordered,required TResult Function( int stopIndex,  OrderSavedLocationEntity location)  savedLocationPinToggled,required TResult Function( String typeId)  carTypeToggled,required TResult Function( int token,  List<OrderLocationEntity> stops,  BlocStatus<OrderTripRouteEntity> routeState,  BlocStatus<List<OrderTripCarOptionEntity>> pricingState)  tripPrefetchCompleted,required TResult Function()  confirmOrderPressed,required TResult Function()  confirmCarSelectionPressed,required TResult Function()  bookingDetailsBackPressed,required TResult Function( OrderScheduleMode mode)  scheduleModeChanged,required TResult Function( DateTime? time)  scheduleTimeChanged,required TResult Function( String note)  passengerNoteChanged,required TResult Function()  confirmBookingDetailsPressed,required TResult Function()  paymentSheetDismissed,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _OrderNowPressed():
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
return scheduleTimeChanged(_that.time);case _PassengerNoteChanged():
return passengerNoteChanged(_that.note);case _ConfirmBookingDetailsPressed():
return confirmBookingDetailsPressed();case _PaymentSheetDismissed():
return paymentSheetDismissed();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  orderNowPressed,TResult? Function()?  collapseRequested,TResult? Function()?  mapPickCancelled,TResult? Function()?  vehicleStepBackPressed,TResult? Function( int index)?  setOnMapPressed,TResult? Function( double latitude,  double longitude,  double zoom)?  mapCameraTargetUpdated,TResult? Function()?  confirmMapPointPressed,TResult? Function( int index)?  activeStopChanged,TResult? Function( int index,  String query)?  stopQueryChanged,TResult? Function( int index)?  stopCleared,TResult? Function( int index,  OrderSavedLocationEntity location)?  stopSuggestionSelected,TResult? Function()?  stopAdded,TResult? Function( int index)?  stopRemoved,TResult? Function( int oldIndex,  int newIndex)?  stopReordered,TResult? Function( int stopIndex,  OrderSavedLocationEntity location)?  savedLocationPinToggled,TResult? Function( String typeId)?  carTypeToggled,TResult? Function( int token,  List<OrderLocationEntity> stops,  BlocStatus<OrderTripRouteEntity> routeState,  BlocStatus<List<OrderTripCarOptionEntity>> pricingState)?  tripPrefetchCompleted,TResult? Function()?  confirmOrderPressed,TResult? Function()?  confirmCarSelectionPressed,TResult? Function()?  bookingDetailsBackPressed,TResult? Function( OrderScheduleMode mode)?  scheduleModeChanged,TResult? Function( DateTime? time)?  scheduleTimeChanged,TResult? Function( String note)?  passengerNoteChanged,TResult? Function()?  confirmBookingDetailsPressed,TResult? Function()?  paymentSheetDismissed,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _OrderNowPressed() when orderNowPressed != null:
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
return scheduleTimeChanged(_that.time);case _PassengerNoteChanged() when passengerNoteChanged != null:
return passengerNoteChanged(_that.note);case _ConfirmBookingDetailsPressed() when confirmBookingDetailsPressed != null:
return confirmBookingDetailsPressed();case _PaymentSheetDismissed() when paymentSheetDismissed != null:
return paymentSheetDismissed();case _:
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


class _PassengerNoteChanged implements OrderEvent {
  const _PassengerNoteChanged(this.note);
  

 final  String note;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PassengerNoteChangedCopyWith<_PassengerNoteChanged> get copyWith => __$PassengerNoteChangedCopyWithImpl<_PassengerNoteChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PassengerNoteChanged&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,note);

@override
String toString() {
  return 'OrderEvent.passengerNoteChanged(note: $note)';
}


}

/// @nodoc
abstract mixin class _$PassengerNoteChangedCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$PassengerNoteChangedCopyWith(_PassengerNoteChanged value, $Res Function(_PassengerNoteChanged) _then) = __$PassengerNoteChangedCopyWithImpl;
@useResult
$Res call({
 String note
});




}
/// @nodoc
class __$PassengerNoteChangedCopyWithImpl<$Res>
    implements _$PassengerNoteChangedCopyWith<$Res> {
  __$PassengerNoteChangedCopyWithImpl(this._self, this._then);

  final _PassengerNoteChanged _self;
  final $Res Function(_PassengerNoteChanged) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? note = null,}) {
  return _then(_PassengerNoteChanged(
null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
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


class _PaymentSheetDismissed implements OrderEvent {
  const _PaymentSheetDismissed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentSheetDismissed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent.paymentSheetDismissed()';
}


}




/// @nodoc
mixin _$OrderState {

 OrderSheetSlice get sheet; OrderMapSlice get map; OrderStopsSlice get stops; OrderTripSlice get trip; OrderBookingSlice get booking;
/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderStateCopyWith<OrderState> get copyWith => _$OrderStateCopyWithImpl<OrderState>(this as OrderState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderState&&(identical(other.sheet, sheet) || other.sheet == sheet)&&(identical(other.map, map) || other.map == map)&&(identical(other.stops, stops) || other.stops == stops)&&(identical(other.trip, trip) || other.trip == trip)&&(identical(other.booking, booking) || other.booking == booking));
}


@override
int get hashCode => Object.hash(runtimeType,sheet,map,stops,trip,booking);

@override
String toString() {
  return 'OrderState(sheet: $sheet, map: $map, stops: $stops, trip: $trip, booking: $booking)';
}


}

/// @nodoc
abstract mixin class $OrderStateCopyWith<$Res>  {
  factory $OrderStateCopyWith(OrderState value, $Res Function(OrderState) _then) = _$OrderStateCopyWithImpl;
@useResult
$Res call({
 OrderSheetSlice sheet, OrderMapSlice map, OrderStopsSlice stops, OrderTripSlice trip, OrderBookingSlice booking
});


$OrderSheetSliceCopyWith<$Res> get sheet;$OrderMapSliceCopyWith<$Res> get map;$OrderStopsSliceCopyWith<$Res> get stops;$OrderTripSliceCopyWith<$Res> get trip;$OrderBookingSliceCopyWith<$Res> get booking;

}
/// @nodoc
class _$OrderStateCopyWithImpl<$Res>
    implements $OrderStateCopyWith<$Res> {
  _$OrderStateCopyWithImpl(this._self, this._then);

  final OrderState _self;
  final $Res Function(OrderState) _then;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sheet = null,Object? map = null,Object? stops = null,Object? trip = null,Object? booking = null,}) {
  return _then(_self.copyWith(
sheet: null == sheet ? _self.sheet : sheet // ignore: cast_nullable_to_non_nullable
as OrderSheetSlice,map: null == map ? _self.map : map // ignore: cast_nullable_to_non_nullable
as OrderMapSlice,stops: null == stops ? _self.stops : stops // ignore: cast_nullable_to_non_nullable
as OrderStopsSlice,trip: null == trip ? _self.trip : trip // ignore: cast_nullable_to_non_nullable
as OrderTripSlice,booking: null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as OrderBookingSlice,
  ));
}
/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderSheetSliceCopyWith<$Res> get sheet {
  
  return $OrderSheetSliceCopyWith<$Res>(_self.sheet, (value) {
    return _then(_self.copyWith(sheet: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderMapSliceCopyWith<$Res> get map {
  
  return $OrderMapSliceCopyWith<$Res>(_self.map, (value) {
    return _then(_self.copyWith(map: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderStopsSliceCopyWith<$Res> get stops {
  
  return $OrderStopsSliceCopyWith<$Res>(_self.stops, (value) {
    return _then(_self.copyWith(stops: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderTripSliceCopyWith<$Res> get trip {
  
  return $OrderTripSliceCopyWith<$Res>(_self.trip, (value) {
    return _then(_self.copyWith(trip: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderBookingSliceCopyWith<$Res> get booking {
  
  return $OrderBookingSliceCopyWith<$Res>(_self.booking, (value) {
    return _then(_self.copyWith(booking: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OrderSheetSlice sheet,  OrderMapSlice map,  OrderStopsSlice stops,  OrderTripSlice trip,  OrderBookingSlice booking)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderState() when $default != null:
return $default(_that.sheet,_that.map,_that.stops,_that.trip,_that.booking);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OrderSheetSlice sheet,  OrderMapSlice map,  OrderStopsSlice stops,  OrderTripSlice trip,  OrderBookingSlice booking)  $default,) {final _that = this;
switch (_that) {
case _OrderState():
return $default(_that.sheet,_that.map,_that.stops,_that.trip,_that.booking);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OrderSheetSlice sheet,  OrderMapSlice map,  OrderStopsSlice stops,  OrderTripSlice trip,  OrderBookingSlice booking)?  $default,) {final _that = this;
switch (_that) {
case _OrderState() when $default != null:
return $default(_that.sheet,_that.map,_that.stops,_that.trip,_that.booking);case _:
  return null;

}
}

}

/// @nodoc


class _OrderState implements OrderState {
  const _OrderState({this.sheet = const OrderSheetSlice(), this.map = const OrderMapSlice(), this.stops = const OrderStopsSlice(), this.trip = const OrderTripSlice(), this.booking = const OrderBookingSlice()});
  

@override@JsonKey() final  OrderSheetSlice sheet;
@override@JsonKey() final  OrderMapSlice map;
@override@JsonKey() final  OrderStopsSlice stops;
@override@JsonKey() final  OrderTripSlice trip;
@override@JsonKey() final  OrderBookingSlice booking;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderStateCopyWith<_OrderState> get copyWith => __$OrderStateCopyWithImpl<_OrderState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderState&&(identical(other.sheet, sheet) || other.sheet == sheet)&&(identical(other.map, map) || other.map == map)&&(identical(other.stops, stops) || other.stops == stops)&&(identical(other.trip, trip) || other.trip == trip)&&(identical(other.booking, booking) || other.booking == booking));
}


@override
int get hashCode => Object.hash(runtimeType,sheet,map,stops,trip,booking);

@override
String toString() {
  return 'OrderState(sheet: $sheet, map: $map, stops: $stops, trip: $trip, booking: $booking)';
}


}

/// @nodoc
abstract mixin class _$OrderStateCopyWith<$Res> implements $OrderStateCopyWith<$Res> {
  factory _$OrderStateCopyWith(_OrderState value, $Res Function(_OrderState) _then) = __$OrderStateCopyWithImpl;
@override @useResult
$Res call({
 OrderSheetSlice sheet, OrderMapSlice map, OrderStopsSlice stops, OrderTripSlice trip, OrderBookingSlice booking
});


@override $OrderSheetSliceCopyWith<$Res> get sheet;@override $OrderMapSliceCopyWith<$Res> get map;@override $OrderStopsSliceCopyWith<$Res> get stops;@override $OrderTripSliceCopyWith<$Res> get trip;@override $OrderBookingSliceCopyWith<$Res> get booking;

}
/// @nodoc
class __$OrderStateCopyWithImpl<$Res>
    implements _$OrderStateCopyWith<$Res> {
  __$OrderStateCopyWithImpl(this._self, this._then);

  final _OrderState _self;
  final $Res Function(_OrderState) _then;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sheet = null,Object? map = null,Object? stops = null,Object? trip = null,Object? booking = null,}) {
  return _then(_OrderState(
sheet: null == sheet ? _self.sheet : sheet // ignore: cast_nullable_to_non_nullable
as OrderSheetSlice,map: null == map ? _self.map : map // ignore: cast_nullable_to_non_nullable
as OrderMapSlice,stops: null == stops ? _self.stops : stops // ignore: cast_nullable_to_non_nullable
as OrderStopsSlice,trip: null == trip ? _self.trip : trip // ignore: cast_nullable_to_non_nullable
as OrderTripSlice,booking: null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as OrderBookingSlice,
  ));
}

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderSheetSliceCopyWith<$Res> get sheet {
  
  return $OrderSheetSliceCopyWith<$Res>(_self.sheet, (value) {
    return _then(_self.copyWith(sheet: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderMapSliceCopyWith<$Res> get map {
  
  return $OrderMapSliceCopyWith<$Res>(_self.map, (value) {
    return _then(_self.copyWith(map: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderStopsSliceCopyWith<$Res> get stops {
  
  return $OrderStopsSliceCopyWith<$Res>(_self.stops, (value) {
    return _then(_self.copyWith(stops: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderTripSliceCopyWith<$Res> get trip {
  
  return $OrderTripSliceCopyWith<$Res>(_self.trip, (value) {
    return _then(_self.copyWith(trip: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderBookingSliceCopyWith<$Res> get booking {
  
  return $OrderBookingSliceCopyWith<$Res>(_self.booking, (value) {
    return _then(_self.copyWith(booking: value));
  });
}
}

// dart format on
