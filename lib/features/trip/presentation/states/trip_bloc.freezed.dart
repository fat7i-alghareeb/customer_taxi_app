// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TripEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TripEvent()';
}


}

/// @nodoc
class $TripEventCopyWith<$Res>  {
$TripEventCopyWith(TripEvent _, $Res Function(TripEvent) __);
}


/// Adds pattern-matching-related methods to [TripEvent].
extension TripEventPatterns on TripEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _PollingTick value)?  pollingTick,TResult Function( _CancelRequested value)?  cancelRequested,TResult Function( _PassengerNoteSubmitted value)?  passengerNoteSubmitted,TResult Function( _CompensationClaimSubmitted value)?  compensationClaimSubmitted,TResult Function( _StopPolling value)?  stopPolling,TResult Function( _HistoryStarted value)?  historyStarted,TResult Function( _SearchChanged value)?  searchChanged,TResult Function( _NextPageRequested value)?  nextPageRequested,TResult Function( _DriverLocationUpdated value)?  driverLocationUpdated,TResult Function( _LoadReceipt value)?  loadReceipt,TResult Function( _LoadInvoice value)?  loadInvoice,TResult Function( _LoadInvoicePdf value)?  loadInvoicePdf,TResult Function( _ScheduledTimeUpdateRequested value)?  scheduledTimeUpdateRequested,TResult Function( _EditPreviewRequested value)?  editPreviewRequested,TResult Function( _EditApplyRequested value)?  editApplyRequested,TResult Function( _EditAppliedReceived value)?  editAppliedReceived,TResult Function( _EditStatusReset value)?  editStatusReset,TResult Function( _EditSettlementAcknowledged value)?  editSettlementAcknowledged,TResult Function( _BagCountUpdateRequested value)?  bagCountUpdateRequested,TResult Function( _NoDriverPostponeRequested value)?  noDriverPostponeRequested,TResult Function( _NoDriverCancelRequested value)?  noDriverCancelRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _PollingTick() when pollingTick != null:
return pollingTick(_that);case _CancelRequested() when cancelRequested != null:
return cancelRequested(_that);case _PassengerNoteSubmitted() when passengerNoteSubmitted != null:
return passengerNoteSubmitted(_that);case _CompensationClaimSubmitted() when compensationClaimSubmitted != null:
return compensationClaimSubmitted(_that);case _StopPolling() when stopPolling != null:
return stopPolling(_that);case _HistoryStarted() when historyStarted != null:
return historyStarted(_that);case _SearchChanged() when searchChanged != null:
return searchChanged(_that);case _NextPageRequested() when nextPageRequested != null:
return nextPageRequested(_that);case _DriverLocationUpdated() when driverLocationUpdated != null:
return driverLocationUpdated(_that);case _LoadReceipt() when loadReceipt != null:
return loadReceipt(_that);case _LoadInvoice() when loadInvoice != null:
return loadInvoice(_that);case _LoadInvoicePdf() when loadInvoicePdf != null:
return loadInvoicePdf(_that);case _ScheduledTimeUpdateRequested() when scheduledTimeUpdateRequested != null:
return scheduledTimeUpdateRequested(_that);case _EditPreviewRequested() when editPreviewRequested != null:
return editPreviewRequested(_that);case _EditApplyRequested() when editApplyRequested != null:
return editApplyRequested(_that);case _EditAppliedReceived() when editAppliedReceived != null:
return editAppliedReceived(_that);case _EditStatusReset() when editStatusReset != null:
return editStatusReset(_that);case _EditSettlementAcknowledged() when editSettlementAcknowledged != null:
return editSettlementAcknowledged(_that);case _BagCountUpdateRequested() when bagCountUpdateRequested != null:
return bagCountUpdateRequested(_that);case _NoDriverPostponeRequested() when noDriverPostponeRequested != null:
return noDriverPostponeRequested(_that);case _NoDriverCancelRequested() when noDriverCancelRequested != null:
return noDriverCancelRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _PollingTick value)  pollingTick,required TResult Function( _CancelRequested value)  cancelRequested,required TResult Function( _PassengerNoteSubmitted value)  passengerNoteSubmitted,required TResult Function( _CompensationClaimSubmitted value)  compensationClaimSubmitted,required TResult Function( _StopPolling value)  stopPolling,required TResult Function( _HistoryStarted value)  historyStarted,required TResult Function( _SearchChanged value)  searchChanged,required TResult Function( _NextPageRequested value)  nextPageRequested,required TResult Function( _DriverLocationUpdated value)  driverLocationUpdated,required TResult Function( _LoadReceipt value)  loadReceipt,required TResult Function( _LoadInvoice value)  loadInvoice,required TResult Function( _LoadInvoicePdf value)  loadInvoicePdf,required TResult Function( _ScheduledTimeUpdateRequested value)  scheduledTimeUpdateRequested,required TResult Function( _EditPreviewRequested value)  editPreviewRequested,required TResult Function( _EditApplyRequested value)  editApplyRequested,required TResult Function( _EditAppliedReceived value)  editAppliedReceived,required TResult Function( _EditStatusReset value)  editStatusReset,required TResult Function( _EditSettlementAcknowledged value)  editSettlementAcknowledged,required TResult Function( _BagCountUpdateRequested value)  bagCountUpdateRequested,required TResult Function( _NoDriverPostponeRequested value)  noDriverPostponeRequested,required TResult Function( _NoDriverCancelRequested value)  noDriverCancelRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _PollingTick():
return pollingTick(_that);case _CancelRequested():
return cancelRequested(_that);case _PassengerNoteSubmitted():
return passengerNoteSubmitted(_that);case _CompensationClaimSubmitted():
return compensationClaimSubmitted(_that);case _StopPolling():
return stopPolling(_that);case _HistoryStarted():
return historyStarted(_that);case _SearchChanged():
return searchChanged(_that);case _NextPageRequested():
return nextPageRequested(_that);case _DriverLocationUpdated():
return driverLocationUpdated(_that);case _LoadReceipt():
return loadReceipt(_that);case _LoadInvoice():
return loadInvoice(_that);case _LoadInvoicePdf():
return loadInvoicePdf(_that);case _ScheduledTimeUpdateRequested():
return scheduledTimeUpdateRequested(_that);case _EditPreviewRequested():
return editPreviewRequested(_that);case _EditApplyRequested():
return editApplyRequested(_that);case _EditAppliedReceived():
return editAppliedReceived(_that);case _EditStatusReset():
return editStatusReset(_that);case _EditSettlementAcknowledged():
return editSettlementAcknowledged(_that);case _BagCountUpdateRequested():
return bagCountUpdateRequested(_that);case _NoDriverPostponeRequested():
return noDriverPostponeRequested(_that);case _NoDriverCancelRequested():
return noDriverCancelRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _PollingTick value)?  pollingTick,TResult? Function( _CancelRequested value)?  cancelRequested,TResult? Function( _PassengerNoteSubmitted value)?  passengerNoteSubmitted,TResult? Function( _CompensationClaimSubmitted value)?  compensationClaimSubmitted,TResult? Function( _StopPolling value)?  stopPolling,TResult? Function( _HistoryStarted value)?  historyStarted,TResult? Function( _SearchChanged value)?  searchChanged,TResult? Function( _NextPageRequested value)?  nextPageRequested,TResult? Function( _DriverLocationUpdated value)?  driverLocationUpdated,TResult? Function( _LoadReceipt value)?  loadReceipt,TResult? Function( _LoadInvoice value)?  loadInvoice,TResult? Function( _LoadInvoicePdf value)?  loadInvoicePdf,TResult? Function( _ScheduledTimeUpdateRequested value)?  scheduledTimeUpdateRequested,TResult? Function( _EditPreviewRequested value)?  editPreviewRequested,TResult? Function( _EditApplyRequested value)?  editApplyRequested,TResult? Function( _EditAppliedReceived value)?  editAppliedReceived,TResult? Function( _EditStatusReset value)?  editStatusReset,TResult? Function( _EditSettlementAcknowledged value)?  editSettlementAcknowledged,TResult? Function( _BagCountUpdateRequested value)?  bagCountUpdateRequested,TResult? Function( _NoDriverPostponeRequested value)?  noDriverPostponeRequested,TResult? Function( _NoDriverCancelRequested value)?  noDriverCancelRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _PollingTick() when pollingTick != null:
return pollingTick(_that);case _CancelRequested() when cancelRequested != null:
return cancelRequested(_that);case _PassengerNoteSubmitted() when passengerNoteSubmitted != null:
return passengerNoteSubmitted(_that);case _CompensationClaimSubmitted() when compensationClaimSubmitted != null:
return compensationClaimSubmitted(_that);case _StopPolling() when stopPolling != null:
return stopPolling(_that);case _HistoryStarted() when historyStarted != null:
return historyStarted(_that);case _SearchChanged() when searchChanged != null:
return searchChanged(_that);case _NextPageRequested() when nextPageRequested != null:
return nextPageRequested(_that);case _DriverLocationUpdated() when driverLocationUpdated != null:
return driverLocationUpdated(_that);case _LoadReceipt() when loadReceipt != null:
return loadReceipt(_that);case _LoadInvoice() when loadInvoice != null:
return loadInvoice(_that);case _LoadInvoicePdf() when loadInvoicePdf != null:
return loadInvoicePdf(_that);case _ScheduledTimeUpdateRequested() when scheduledTimeUpdateRequested != null:
return scheduledTimeUpdateRequested(_that);case _EditPreviewRequested() when editPreviewRequested != null:
return editPreviewRequested(_that);case _EditApplyRequested() when editApplyRequested != null:
return editApplyRequested(_that);case _EditAppliedReceived() when editAppliedReceived != null:
return editAppliedReceived(_that);case _EditStatusReset() when editStatusReset != null:
return editStatusReset(_that);case _EditSettlementAcknowledged() when editSettlementAcknowledged != null:
return editSettlementAcknowledged(_that);case _BagCountUpdateRequested() when bagCountUpdateRequested != null:
return bagCountUpdateRequested(_that);case _NoDriverPostponeRequested() when noDriverPostponeRequested != null:
return noDriverPostponeRequested(_that);case _NoDriverCancelRequested() when noDriverCancelRequested != null:
return noDriverCancelRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String tripId)?  started,TResult Function()?  pollingTick,TResult Function( String? note)?  cancelRequested,TResult Function( String? passengerNote)?  passengerNoteSubmitted,TResult Function( String note,  List<String> evidenceUrls)?  compensationClaimSubmitted,TResult Function()?  stopPolling,TResult Function()?  historyStarted,TResult Function( String query)?  searchChanged,TResult Function()?  nextPageRequested,TResult Function( double latitude,  double longitude,  int? etaToPickupSeconds,  int? distanceToPickupMeters,  String? routeToPickupPolyline)?  driverLocationUpdated,TResult Function( String tripId)?  loadReceipt,TResult Function( String tripId)?  loadInvoice,TResult Function( String tripId,  String languageCode)?  loadInvoicePdf,TResult Function( DateTime? scheduledAtUtc)?  scheduledTimeUpdateRequested,TResult Function( List<TripStopEntity>? stops,  int? passengerCount)?  editPreviewRequested,TResult Function( List<TripStopEntity>? stops,  int? passengerCount,  double expectedDelta,  String? previewToken)?  editApplyRequested,TResult Function( double newFare,  String currency,  double delta)?  editAppliedReceived,TResult Function()?  editStatusReset,TResult Function()?  editSettlementAcknowledged,TResult Function( int count)?  bagCountUpdateRequested,TResult Function()?  noDriverPostponeRequested,TResult Function( String? note)?  noDriverCancelRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.tripId);case _PollingTick() when pollingTick != null:
return pollingTick();case _CancelRequested() when cancelRequested != null:
return cancelRequested(_that.note);case _PassengerNoteSubmitted() when passengerNoteSubmitted != null:
return passengerNoteSubmitted(_that.passengerNote);case _CompensationClaimSubmitted() when compensationClaimSubmitted != null:
return compensationClaimSubmitted(_that.note,_that.evidenceUrls);case _StopPolling() when stopPolling != null:
return stopPolling();case _HistoryStarted() when historyStarted != null:
return historyStarted();case _SearchChanged() when searchChanged != null:
return searchChanged(_that.query);case _NextPageRequested() when nextPageRequested != null:
return nextPageRequested();case _DriverLocationUpdated() when driverLocationUpdated != null:
return driverLocationUpdated(_that.latitude,_that.longitude,_that.etaToPickupSeconds,_that.distanceToPickupMeters,_that.routeToPickupPolyline);case _LoadReceipt() when loadReceipt != null:
return loadReceipt(_that.tripId);case _LoadInvoice() when loadInvoice != null:
return loadInvoice(_that.tripId);case _LoadInvoicePdf() when loadInvoicePdf != null:
return loadInvoicePdf(_that.tripId,_that.languageCode);case _ScheduledTimeUpdateRequested() when scheduledTimeUpdateRequested != null:
return scheduledTimeUpdateRequested(_that.scheduledAtUtc);case _EditPreviewRequested() when editPreviewRequested != null:
return editPreviewRequested(_that.stops,_that.passengerCount);case _EditApplyRequested() when editApplyRequested != null:
return editApplyRequested(_that.stops,_that.passengerCount,_that.expectedDelta,_that.previewToken);case _EditAppliedReceived() when editAppliedReceived != null:
return editAppliedReceived(_that.newFare,_that.currency,_that.delta);case _EditStatusReset() when editStatusReset != null:
return editStatusReset();case _EditSettlementAcknowledged() when editSettlementAcknowledged != null:
return editSettlementAcknowledged();case _BagCountUpdateRequested() when bagCountUpdateRequested != null:
return bagCountUpdateRequested(_that.count);case _NoDriverPostponeRequested() when noDriverPostponeRequested != null:
return noDriverPostponeRequested();case _NoDriverCancelRequested() when noDriverCancelRequested != null:
return noDriverCancelRequested(_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String tripId)  started,required TResult Function()  pollingTick,required TResult Function( String? note)  cancelRequested,required TResult Function( String? passengerNote)  passengerNoteSubmitted,required TResult Function( String note,  List<String> evidenceUrls)  compensationClaimSubmitted,required TResult Function()  stopPolling,required TResult Function()  historyStarted,required TResult Function( String query)  searchChanged,required TResult Function()  nextPageRequested,required TResult Function( double latitude,  double longitude,  int? etaToPickupSeconds,  int? distanceToPickupMeters,  String? routeToPickupPolyline)  driverLocationUpdated,required TResult Function( String tripId)  loadReceipt,required TResult Function( String tripId)  loadInvoice,required TResult Function( String tripId,  String languageCode)  loadInvoicePdf,required TResult Function( DateTime? scheduledAtUtc)  scheduledTimeUpdateRequested,required TResult Function( List<TripStopEntity>? stops,  int? passengerCount)  editPreviewRequested,required TResult Function( List<TripStopEntity>? stops,  int? passengerCount,  double expectedDelta,  String? previewToken)  editApplyRequested,required TResult Function( double newFare,  String currency,  double delta)  editAppliedReceived,required TResult Function()  editStatusReset,required TResult Function()  editSettlementAcknowledged,required TResult Function( int count)  bagCountUpdateRequested,required TResult Function()  noDriverPostponeRequested,required TResult Function( String? note)  noDriverCancelRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started(_that.tripId);case _PollingTick():
return pollingTick();case _CancelRequested():
return cancelRequested(_that.note);case _PassengerNoteSubmitted():
return passengerNoteSubmitted(_that.passengerNote);case _CompensationClaimSubmitted():
return compensationClaimSubmitted(_that.note,_that.evidenceUrls);case _StopPolling():
return stopPolling();case _HistoryStarted():
return historyStarted();case _SearchChanged():
return searchChanged(_that.query);case _NextPageRequested():
return nextPageRequested();case _DriverLocationUpdated():
return driverLocationUpdated(_that.latitude,_that.longitude,_that.etaToPickupSeconds,_that.distanceToPickupMeters,_that.routeToPickupPolyline);case _LoadReceipt():
return loadReceipt(_that.tripId);case _LoadInvoice():
return loadInvoice(_that.tripId);case _LoadInvoicePdf():
return loadInvoicePdf(_that.tripId,_that.languageCode);case _ScheduledTimeUpdateRequested():
return scheduledTimeUpdateRequested(_that.scheduledAtUtc);case _EditPreviewRequested():
return editPreviewRequested(_that.stops,_that.passengerCount);case _EditApplyRequested():
return editApplyRequested(_that.stops,_that.passengerCount,_that.expectedDelta,_that.previewToken);case _EditAppliedReceived():
return editAppliedReceived(_that.newFare,_that.currency,_that.delta);case _EditStatusReset():
return editStatusReset();case _EditSettlementAcknowledged():
return editSettlementAcknowledged();case _BagCountUpdateRequested():
return bagCountUpdateRequested(_that.count);case _NoDriverPostponeRequested():
return noDriverPostponeRequested();case _NoDriverCancelRequested():
return noDriverCancelRequested(_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String tripId)?  started,TResult? Function()?  pollingTick,TResult? Function( String? note)?  cancelRequested,TResult? Function( String? passengerNote)?  passengerNoteSubmitted,TResult? Function( String note,  List<String> evidenceUrls)?  compensationClaimSubmitted,TResult? Function()?  stopPolling,TResult? Function()?  historyStarted,TResult? Function( String query)?  searchChanged,TResult? Function()?  nextPageRequested,TResult? Function( double latitude,  double longitude,  int? etaToPickupSeconds,  int? distanceToPickupMeters,  String? routeToPickupPolyline)?  driverLocationUpdated,TResult? Function( String tripId)?  loadReceipt,TResult? Function( String tripId)?  loadInvoice,TResult? Function( String tripId,  String languageCode)?  loadInvoicePdf,TResult? Function( DateTime? scheduledAtUtc)?  scheduledTimeUpdateRequested,TResult? Function( List<TripStopEntity>? stops,  int? passengerCount)?  editPreviewRequested,TResult? Function( List<TripStopEntity>? stops,  int? passengerCount,  double expectedDelta,  String? previewToken)?  editApplyRequested,TResult? Function( double newFare,  String currency,  double delta)?  editAppliedReceived,TResult? Function()?  editStatusReset,TResult? Function()?  editSettlementAcknowledged,TResult? Function( int count)?  bagCountUpdateRequested,TResult? Function()?  noDriverPostponeRequested,TResult? Function( String? note)?  noDriverCancelRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.tripId);case _PollingTick() when pollingTick != null:
return pollingTick();case _CancelRequested() when cancelRequested != null:
return cancelRequested(_that.note);case _PassengerNoteSubmitted() when passengerNoteSubmitted != null:
return passengerNoteSubmitted(_that.passengerNote);case _CompensationClaimSubmitted() when compensationClaimSubmitted != null:
return compensationClaimSubmitted(_that.note,_that.evidenceUrls);case _StopPolling() when stopPolling != null:
return stopPolling();case _HistoryStarted() when historyStarted != null:
return historyStarted();case _SearchChanged() when searchChanged != null:
return searchChanged(_that.query);case _NextPageRequested() when nextPageRequested != null:
return nextPageRequested();case _DriverLocationUpdated() when driverLocationUpdated != null:
return driverLocationUpdated(_that.latitude,_that.longitude,_that.etaToPickupSeconds,_that.distanceToPickupMeters,_that.routeToPickupPolyline);case _LoadReceipt() when loadReceipt != null:
return loadReceipt(_that.tripId);case _LoadInvoice() when loadInvoice != null:
return loadInvoice(_that.tripId);case _LoadInvoicePdf() when loadInvoicePdf != null:
return loadInvoicePdf(_that.tripId,_that.languageCode);case _ScheduledTimeUpdateRequested() when scheduledTimeUpdateRequested != null:
return scheduledTimeUpdateRequested(_that.scheduledAtUtc);case _EditPreviewRequested() when editPreviewRequested != null:
return editPreviewRequested(_that.stops,_that.passengerCount);case _EditApplyRequested() when editApplyRequested != null:
return editApplyRequested(_that.stops,_that.passengerCount,_that.expectedDelta,_that.previewToken);case _EditAppliedReceived() when editAppliedReceived != null:
return editAppliedReceived(_that.newFare,_that.currency,_that.delta);case _EditStatusReset() when editStatusReset != null:
return editStatusReset();case _EditSettlementAcknowledged() when editSettlementAcknowledged != null:
return editSettlementAcknowledged();case _BagCountUpdateRequested() when bagCountUpdateRequested != null:
return bagCountUpdateRequested(_that.count);case _NoDriverPostponeRequested() when noDriverPostponeRequested != null:
return noDriverPostponeRequested();case _NoDriverCancelRequested() when noDriverCancelRequested != null:
return noDriverCancelRequested(_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements TripEvent {
  const _Started(this.tripId);
  

 final  String tripId;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartedCopyWith<_Started> get copyWith => __$StartedCopyWithImpl<_Started>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started&&(identical(other.tripId, tripId) || other.tripId == tripId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId);

@override
String toString() {
  return 'TripEvent.started(tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class _$StartedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) _then) = __$StartedCopyWithImpl;
@useResult
$Res call({
 String tripId
});




}
/// @nodoc
class __$StartedCopyWithImpl<$Res>
    implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(this._self, this._then);

  final _Started _self;
  final $Res Function(_Started) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,}) {
  return _then(_Started(
null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PollingTick implements TripEvent {
  const _PollingTick();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollingTick);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TripEvent.pollingTick()';
}


}




/// @nodoc


class _CancelRequested implements TripEvent {
  const _CancelRequested({this.note});
  

 final  String? note;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CancelRequestedCopyWith<_CancelRequested> get copyWith => __$CancelRequestedCopyWithImpl<_CancelRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CancelRequested&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,note);

@override
String toString() {
  return 'TripEvent.cancelRequested(note: $note)';
}


}

/// @nodoc
abstract mixin class _$CancelRequestedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$CancelRequestedCopyWith(_CancelRequested value, $Res Function(_CancelRequested) _then) = __$CancelRequestedCopyWithImpl;
@useResult
$Res call({
 String? note
});




}
/// @nodoc
class __$CancelRequestedCopyWithImpl<$Res>
    implements _$CancelRequestedCopyWith<$Res> {
  __$CancelRequestedCopyWithImpl(this._self, this._then);

  final _CancelRequested _self;
  final $Res Function(_CancelRequested) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? note = freezed,}) {
  return _then(_CancelRequested(
note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _PassengerNoteSubmitted implements TripEvent {
  const _PassengerNoteSubmitted(this.passengerNote);
  

 final  String? passengerNote;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PassengerNoteSubmittedCopyWith<_PassengerNoteSubmitted> get copyWith => __$PassengerNoteSubmittedCopyWithImpl<_PassengerNoteSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PassengerNoteSubmitted&&(identical(other.passengerNote, passengerNote) || other.passengerNote == passengerNote));
}


@override
int get hashCode => Object.hash(runtimeType,passengerNote);

@override
String toString() {
  return 'TripEvent.passengerNoteSubmitted(passengerNote: $passengerNote)';
}


}

/// @nodoc
abstract mixin class _$PassengerNoteSubmittedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$PassengerNoteSubmittedCopyWith(_PassengerNoteSubmitted value, $Res Function(_PassengerNoteSubmitted) _then) = __$PassengerNoteSubmittedCopyWithImpl;
@useResult
$Res call({
 String? passengerNote
});




}
/// @nodoc
class __$PassengerNoteSubmittedCopyWithImpl<$Res>
    implements _$PassengerNoteSubmittedCopyWith<$Res> {
  __$PassengerNoteSubmittedCopyWithImpl(this._self, this._then);

  final _PassengerNoteSubmitted _self;
  final $Res Function(_PassengerNoteSubmitted) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? passengerNote = freezed,}) {
  return _then(_PassengerNoteSubmitted(
freezed == passengerNote ? _self.passengerNote : passengerNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _CompensationClaimSubmitted implements TripEvent {
  const _CompensationClaimSubmitted({required this.note, final  List<String> evidenceUrls = const []}): _evidenceUrls = evidenceUrls;
  

 final  String note;
 final  List<String> _evidenceUrls;
@JsonKey() List<String> get evidenceUrls {
  if (_evidenceUrls is EqualUnmodifiableListView) return _evidenceUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_evidenceUrls);
}


/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompensationClaimSubmittedCopyWith<_CompensationClaimSubmitted> get copyWith => __$CompensationClaimSubmittedCopyWithImpl<_CompensationClaimSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompensationClaimSubmitted&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other._evidenceUrls, _evidenceUrls));
}


@override
int get hashCode => Object.hash(runtimeType,note,const DeepCollectionEquality().hash(_evidenceUrls));

@override
String toString() {
  return 'TripEvent.compensationClaimSubmitted(note: $note, evidenceUrls: $evidenceUrls)';
}


}

/// @nodoc
abstract mixin class _$CompensationClaimSubmittedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$CompensationClaimSubmittedCopyWith(_CompensationClaimSubmitted value, $Res Function(_CompensationClaimSubmitted) _then) = __$CompensationClaimSubmittedCopyWithImpl;
@useResult
$Res call({
 String note, List<String> evidenceUrls
});




}
/// @nodoc
class __$CompensationClaimSubmittedCopyWithImpl<$Res>
    implements _$CompensationClaimSubmittedCopyWith<$Res> {
  __$CompensationClaimSubmittedCopyWithImpl(this._self, this._then);

  final _CompensationClaimSubmitted _self;
  final $Res Function(_CompensationClaimSubmitted) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? note = null,Object? evidenceUrls = null,}) {
  return _then(_CompensationClaimSubmitted(
note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,evidenceUrls: null == evidenceUrls ? _self._evidenceUrls : evidenceUrls // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class _StopPolling implements TripEvent {
  const _StopPolling();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StopPolling);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TripEvent.stopPolling()';
}


}




/// @nodoc


class _HistoryStarted implements TripEvent {
  const _HistoryStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TripEvent.historyStarted()';
}


}




/// @nodoc


class _SearchChanged implements TripEvent {
  const _SearchChanged(this.query);
  

 final  String query;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchChangedCopyWith<_SearchChanged> get copyWith => __$SearchChangedCopyWithImpl<_SearchChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'TripEvent.searchChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class _$SearchChangedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$SearchChangedCopyWith(_SearchChanged value, $Res Function(_SearchChanged) _then) = __$SearchChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$SearchChangedCopyWithImpl<$Res>
    implements _$SearchChangedCopyWith<$Res> {
  __$SearchChangedCopyWithImpl(this._self, this._then);

  final _SearchChanged _self;
  final $Res Function(_SearchChanged) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_SearchChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _NextPageRequested implements TripEvent {
  const _NextPageRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NextPageRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TripEvent.nextPageRequested()';
}


}




/// @nodoc


class _DriverLocationUpdated implements TripEvent {
  const _DriverLocationUpdated(this.latitude, this.longitude, {this.etaToPickupSeconds, this.distanceToPickupMeters, this.routeToPickupPolyline});
  

 final  double latitude;
 final  double longitude;
 final  int? etaToPickupSeconds;
 final  int? distanceToPickupMeters;
 final  String? routeToPickupPolyline;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverLocationUpdatedCopyWith<_DriverLocationUpdated> get copyWith => __$DriverLocationUpdatedCopyWithImpl<_DriverLocationUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverLocationUpdated&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.etaToPickupSeconds, etaToPickupSeconds) || other.etaToPickupSeconds == etaToPickupSeconds)&&(identical(other.distanceToPickupMeters, distanceToPickupMeters) || other.distanceToPickupMeters == distanceToPickupMeters)&&(identical(other.routeToPickupPolyline, routeToPickupPolyline) || other.routeToPickupPolyline == routeToPickupPolyline));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,etaToPickupSeconds,distanceToPickupMeters,routeToPickupPolyline);

@override
String toString() {
  return 'TripEvent.driverLocationUpdated(latitude: $latitude, longitude: $longitude, etaToPickupSeconds: $etaToPickupSeconds, distanceToPickupMeters: $distanceToPickupMeters, routeToPickupPolyline: $routeToPickupPolyline)';
}


}

/// @nodoc
abstract mixin class _$DriverLocationUpdatedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$DriverLocationUpdatedCopyWith(_DriverLocationUpdated value, $Res Function(_DriverLocationUpdated) _then) = __$DriverLocationUpdatedCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, int? etaToPickupSeconds, int? distanceToPickupMeters, String? routeToPickupPolyline
});




}
/// @nodoc
class __$DriverLocationUpdatedCopyWithImpl<$Res>
    implements _$DriverLocationUpdatedCopyWith<$Res> {
  __$DriverLocationUpdatedCopyWithImpl(this._self, this._then);

  final _DriverLocationUpdated _self;
  final $Res Function(_DriverLocationUpdated) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? etaToPickupSeconds = freezed,Object? distanceToPickupMeters = freezed,Object? routeToPickupPolyline = freezed,}) {
  return _then(_DriverLocationUpdated(
null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,etaToPickupSeconds: freezed == etaToPickupSeconds ? _self.etaToPickupSeconds : etaToPickupSeconds // ignore: cast_nullable_to_non_nullable
as int?,distanceToPickupMeters: freezed == distanceToPickupMeters ? _self.distanceToPickupMeters : distanceToPickupMeters // ignore: cast_nullable_to_non_nullable
as int?,routeToPickupPolyline: freezed == routeToPickupPolyline ? _self.routeToPickupPolyline : routeToPickupPolyline // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _LoadReceipt implements TripEvent {
  const _LoadReceipt(this.tripId);
  

 final  String tripId;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadReceiptCopyWith<_LoadReceipt> get copyWith => __$LoadReceiptCopyWithImpl<_LoadReceipt>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadReceipt&&(identical(other.tripId, tripId) || other.tripId == tripId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId);

@override
String toString() {
  return 'TripEvent.loadReceipt(tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class _$LoadReceiptCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$LoadReceiptCopyWith(_LoadReceipt value, $Res Function(_LoadReceipt) _then) = __$LoadReceiptCopyWithImpl;
@useResult
$Res call({
 String tripId
});




}
/// @nodoc
class __$LoadReceiptCopyWithImpl<$Res>
    implements _$LoadReceiptCopyWith<$Res> {
  __$LoadReceiptCopyWithImpl(this._self, this._then);

  final _LoadReceipt _self;
  final $Res Function(_LoadReceipt) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,}) {
  return _then(_LoadReceipt(
null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadInvoice implements TripEvent {
  const _LoadInvoice(this.tripId);
  

 final  String tripId;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadInvoiceCopyWith<_LoadInvoice> get copyWith => __$LoadInvoiceCopyWithImpl<_LoadInvoice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadInvoice&&(identical(other.tripId, tripId) || other.tripId == tripId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId);

@override
String toString() {
  return 'TripEvent.loadInvoice(tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class _$LoadInvoiceCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$LoadInvoiceCopyWith(_LoadInvoice value, $Res Function(_LoadInvoice) _then) = __$LoadInvoiceCopyWithImpl;
@useResult
$Res call({
 String tripId
});




}
/// @nodoc
class __$LoadInvoiceCopyWithImpl<$Res>
    implements _$LoadInvoiceCopyWith<$Res> {
  __$LoadInvoiceCopyWithImpl(this._self, this._then);

  final _LoadInvoice _self;
  final $Res Function(_LoadInvoice) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,}) {
  return _then(_LoadInvoice(
null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadInvoicePdf implements TripEvent {
  const _LoadInvoicePdf({required this.tripId, required this.languageCode});
  

 final  String tripId;
 final  String languageCode;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadInvoicePdfCopyWith<_LoadInvoicePdf> get copyWith => __$LoadInvoicePdfCopyWithImpl<_LoadInvoicePdf>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadInvoicePdf&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,languageCode);

@override
String toString() {
  return 'TripEvent.loadInvoicePdf(tripId: $tripId, languageCode: $languageCode)';
}


}

/// @nodoc
abstract mixin class _$LoadInvoicePdfCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$LoadInvoicePdfCopyWith(_LoadInvoicePdf value, $Res Function(_LoadInvoicePdf) _then) = __$LoadInvoicePdfCopyWithImpl;
@useResult
$Res call({
 String tripId, String languageCode
});




}
/// @nodoc
class __$LoadInvoicePdfCopyWithImpl<$Res>
    implements _$LoadInvoicePdfCopyWith<$Res> {
  __$LoadInvoicePdfCopyWithImpl(this._self, this._then);

  final _LoadInvoicePdf _self;
  final $Res Function(_LoadInvoicePdf) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? languageCode = null,}) {
  return _then(_LoadInvoicePdf(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ScheduledTimeUpdateRequested implements TripEvent {
  const _ScheduledTimeUpdateRequested(this.scheduledAtUtc);
  

 final  DateTime? scheduledAtUtc;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduledTimeUpdateRequestedCopyWith<_ScheduledTimeUpdateRequested> get copyWith => __$ScheduledTimeUpdateRequestedCopyWithImpl<_ScheduledTimeUpdateRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduledTimeUpdateRequested&&(identical(other.scheduledAtUtc, scheduledAtUtc) || other.scheduledAtUtc == scheduledAtUtc));
}


@override
int get hashCode => Object.hash(runtimeType,scheduledAtUtc);

@override
String toString() {
  return 'TripEvent.scheduledTimeUpdateRequested(scheduledAtUtc: $scheduledAtUtc)';
}


}

/// @nodoc
abstract mixin class _$ScheduledTimeUpdateRequestedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$ScheduledTimeUpdateRequestedCopyWith(_ScheduledTimeUpdateRequested value, $Res Function(_ScheduledTimeUpdateRequested) _then) = __$ScheduledTimeUpdateRequestedCopyWithImpl;
@useResult
$Res call({
 DateTime? scheduledAtUtc
});




}
/// @nodoc
class __$ScheduledTimeUpdateRequestedCopyWithImpl<$Res>
    implements _$ScheduledTimeUpdateRequestedCopyWith<$Res> {
  __$ScheduledTimeUpdateRequestedCopyWithImpl(this._self, this._then);

  final _ScheduledTimeUpdateRequested _self;
  final $Res Function(_ScheduledTimeUpdateRequested) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? scheduledAtUtc = freezed,}) {
  return _then(_ScheduledTimeUpdateRequested(
freezed == scheduledAtUtc ? _self.scheduledAtUtc : scheduledAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class _EditPreviewRequested implements TripEvent {
  const _EditPreviewRequested({final  List<TripStopEntity>? stops, this.passengerCount}): _stops = stops;
  

 final  List<TripStopEntity>? _stops;
 List<TripStopEntity>? get stops {
  final value = _stops;
  if (value == null) return null;
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  int? passengerCount;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditPreviewRequestedCopyWith<_EditPreviewRequested> get copyWith => __$EditPreviewRequestedCopyWithImpl<_EditPreviewRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditPreviewRequested&&const DeepCollectionEquality().equals(other._stops, _stops)&&(identical(other.passengerCount, passengerCount) || other.passengerCount == passengerCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_stops),passengerCount);

@override
String toString() {
  return 'TripEvent.editPreviewRequested(stops: $stops, passengerCount: $passengerCount)';
}


}

/// @nodoc
abstract mixin class _$EditPreviewRequestedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$EditPreviewRequestedCopyWith(_EditPreviewRequested value, $Res Function(_EditPreviewRequested) _then) = __$EditPreviewRequestedCopyWithImpl;
@useResult
$Res call({
 List<TripStopEntity>? stops, int? passengerCount
});




}
/// @nodoc
class __$EditPreviewRequestedCopyWithImpl<$Res>
    implements _$EditPreviewRequestedCopyWith<$Res> {
  __$EditPreviewRequestedCopyWithImpl(this._self, this._then);

  final _EditPreviewRequested _self;
  final $Res Function(_EditPreviewRequested) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stops = freezed,Object? passengerCount = freezed,}) {
  return _then(_EditPreviewRequested(
stops: freezed == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripStopEntity>?,passengerCount: freezed == passengerCount ? _self.passengerCount : passengerCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _EditApplyRequested implements TripEvent {
  const _EditApplyRequested({final  List<TripStopEntity>? stops, this.passengerCount, required this.expectedDelta, this.previewToken}): _stops = stops;
  

 final  List<TripStopEntity>? _stops;
 List<TripStopEntity>? get stops {
  final value = _stops;
  if (value == null) return null;
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  int? passengerCount;
 final  double expectedDelta;
 final  String? previewToken;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditApplyRequestedCopyWith<_EditApplyRequested> get copyWith => __$EditApplyRequestedCopyWithImpl<_EditApplyRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditApplyRequested&&const DeepCollectionEquality().equals(other._stops, _stops)&&(identical(other.passengerCount, passengerCount) || other.passengerCount == passengerCount)&&(identical(other.expectedDelta, expectedDelta) || other.expectedDelta == expectedDelta)&&(identical(other.previewToken, previewToken) || other.previewToken == previewToken));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_stops),passengerCount,expectedDelta,previewToken);

@override
String toString() {
  return 'TripEvent.editApplyRequested(stops: $stops, passengerCount: $passengerCount, expectedDelta: $expectedDelta, previewToken: $previewToken)';
}


}

/// @nodoc
abstract mixin class _$EditApplyRequestedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$EditApplyRequestedCopyWith(_EditApplyRequested value, $Res Function(_EditApplyRequested) _then) = __$EditApplyRequestedCopyWithImpl;
@useResult
$Res call({
 List<TripStopEntity>? stops, int? passengerCount, double expectedDelta, String? previewToken
});




}
/// @nodoc
class __$EditApplyRequestedCopyWithImpl<$Res>
    implements _$EditApplyRequestedCopyWith<$Res> {
  __$EditApplyRequestedCopyWithImpl(this._self, this._then);

  final _EditApplyRequested _self;
  final $Res Function(_EditApplyRequested) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stops = freezed,Object? passengerCount = freezed,Object? expectedDelta = null,Object? previewToken = freezed,}) {
  return _then(_EditApplyRequested(
stops: freezed == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripStopEntity>?,passengerCount: freezed == passengerCount ? _self.passengerCount : passengerCount // ignore: cast_nullable_to_non_nullable
as int?,expectedDelta: null == expectedDelta ? _self.expectedDelta : expectedDelta // ignore: cast_nullable_to_non_nullable
as double,previewToken: freezed == previewToken ? _self.previewToken : previewToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _EditAppliedReceived implements TripEvent {
  const _EditAppliedReceived({required this.newFare, required this.currency, required this.delta});
  

 final  double newFare;
 final  String currency;
 final  double delta;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditAppliedReceivedCopyWith<_EditAppliedReceived> get copyWith => __$EditAppliedReceivedCopyWithImpl<_EditAppliedReceived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditAppliedReceived&&(identical(other.newFare, newFare) || other.newFare == newFare)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.delta, delta) || other.delta == delta));
}


@override
int get hashCode => Object.hash(runtimeType,newFare,currency,delta);

@override
String toString() {
  return 'TripEvent.editAppliedReceived(newFare: $newFare, currency: $currency, delta: $delta)';
}


}

/// @nodoc
abstract mixin class _$EditAppliedReceivedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$EditAppliedReceivedCopyWith(_EditAppliedReceived value, $Res Function(_EditAppliedReceived) _then) = __$EditAppliedReceivedCopyWithImpl;
@useResult
$Res call({
 double newFare, String currency, double delta
});




}
/// @nodoc
class __$EditAppliedReceivedCopyWithImpl<$Res>
    implements _$EditAppliedReceivedCopyWith<$Res> {
  __$EditAppliedReceivedCopyWithImpl(this._self, this._then);

  final _EditAppliedReceived _self;
  final $Res Function(_EditAppliedReceived) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? newFare = null,Object? currency = null,Object? delta = null,}) {
  return _then(_EditAppliedReceived(
newFare: null == newFare ? _self.newFare : newFare // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class _EditStatusReset implements TripEvent {
  const _EditStatusReset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditStatusReset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TripEvent.editStatusReset()';
}


}




/// @nodoc


class _EditSettlementAcknowledged implements TripEvent {
  const _EditSettlementAcknowledged();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditSettlementAcknowledged);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TripEvent.editSettlementAcknowledged()';
}


}




/// @nodoc


class _BagCountUpdateRequested implements TripEvent {
  const _BagCountUpdateRequested(this.count);
  

 final  int count;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BagCountUpdateRequestedCopyWith<_BagCountUpdateRequested> get copyWith => __$BagCountUpdateRequestedCopyWithImpl<_BagCountUpdateRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BagCountUpdateRequested&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,count);

@override
String toString() {
  return 'TripEvent.bagCountUpdateRequested(count: $count)';
}


}

/// @nodoc
abstract mixin class _$BagCountUpdateRequestedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$BagCountUpdateRequestedCopyWith(_BagCountUpdateRequested value, $Res Function(_BagCountUpdateRequested) _then) = __$BagCountUpdateRequestedCopyWithImpl;
@useResult
$Res call({
 int count
});




}
/// @nodoc
class __$BagCountUpdateRequestedCopyWithImpl<$Res>
    implements _$BagCountUpdateRequestedCopyWith<$Res> {
  __$BagCountUpdateRequestedCopyWithImpl(this._self, this._then);

  final _BagCountUpdateRequested _self;
  final $Res Function(_BagCountUpdateRequested) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? count = null,}) {
  return _then(_BagCountUpdateRequested(
null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _NoDriverPostponeRequested implements TripEvent {
  const _NoDriverPostponeRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoDriverPostponeRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TripEvent.noDriverPostponeRequested()';
}


}




/// @nodoc


class _NoDriverCancelRequested implements TripEvent {
  const _NoDriverCancelRequested({this.note});
  

 final  String? note;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoDriverCancelRequestedCopyWith<_NoDriverCancelRequested> get copyWith => __$NoDriverCancelRequestedCopyWithImpl<_NoDriverCancelRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoDriverCancelRequested&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,note);

@override
String toString() {
  return 'TripEvent.noDriverCancelRequested(note: $note)';
}


}

/// @nodoc
abstract mixin class _$NoDriverCancelRequestedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$NoDriverCancelRequestedCopyWith(_NoDriverCancelRequested value, $Res Function(_NoDriverCancelRequested) _then) = __$NoDriverCancelRequestedCopyWithImpl;
@useResult
$Res call({
 String? note
});




}
/// @nodoc
class __$NoDriverCancelRequestedCopyWithImpl<$Res>
    implements _$NoDriverCancelRequestedCopyWith<$Res> {
  __$NoDriverCancelRequestedCopyWithImpl(this._self, this._then);

  final _NoDriverCancelRequested _self;
  final $Res Function(_NoDriverCancelRequested) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? note = freezed,}) {
  return _then(_NoDriverCancelRequested(
note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$TripState {

// Active trip
 BlocStatus<TripEntity> get tripStatus; BlocStatus<void> get cancelStatus; BlocStatus<void> get passengerNoteStatus; BlocStatus<TripCompensationClaimEntity> get compensationClaimStatus; bool get isPolling; String? get activeTripId; DriverLocationEntity? get activeDriverLocation;// Trip history
 BlocStatus<List<TripSummaryEntity>> get historyStatus; List<TripSummaryEntity> get trips; int get currentPage; bool get hasMore; bool get isLoadingMore; String get searchQuery;// Receipt / Invoice (per-section loading)
 BlocStatus<TripReceiptEntity> get receiptStatus; BlocStatus<TripInvoiceEntity> get invoiceStatus; BlocStatus<Uint8List> get invoicePdfStatus;// Pre-trip edit operations
 BlocStatus<void> get tripEditStatus;// Mid-trip re-pricing edit (preview → confirm → apply/settle)
 BlocStatus<TripEditPreviewEntity> get editPreviewStatus; BlocStatus<TripEditApplyResultEntity> get editApplyStatus;/// Set once an edit is actually settled — including the PaymentSheet path, which only
/// commits at the Stripe webhook. Widgets listen for this to confirm the amount.
 TripEditSettlementEntity? get editSettlement;// "No driver found" postpone action
 BlocStatus<void> get postponeStatus;
/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripStateCopyWith<TripState> get copyWith => _$TripStateCopyWithImpl<TripState>(this as TripState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripState&&(identical(other.tripStatus, tripStatus) || other.tripStatus == tripStatus)&&(identical(other.cancelStatus, cancelStatus) || other.cancelStatus == cancelStatus)&&(identical(other.passengerNoteStatus, passengerNoteStatus) || other.passengerNoteStatus == passengerNoteStatus)&&(identical(other.compensationClaimStatus, compensationClaimStatus) || other.compensationClaimStatus == compensationClaimStatus)&&(identical(other.isPolling, isPolling) || other.isPolling == isPolling)&&(identical(other.activeTripId, activeTripId) || other.activeTripId == activeTripId)&&(identical(other.activeDriverLocation, activeDriverLocation) || other.activeDriverLocation == activeDriverLocation)&&(identical(other.historyStatus, historyStatus) || other.historyStatus == historyStatus)&&const DeepCollectionEquality().equals(other.trips, trips)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.receiptStatus, receiptStatus) || other.receiptStatus == receiptStatus)&&(identical(other.invoiceStatus, invoiceStatus) || other.invoiceStatus == invoiceStatus)&&(identical(other.invoicePdfStatus, invoicePdfStatus) || other.invoicePdfStatus == invoicePdfStatus)&&(identical(other.tripEditStatus, tripEditStatus) || other.tripEditStatus == tripEditStatus)&&(identical(other.editPreviewStatus, editPreviewStatus) || other.editPreviewStatus == editPreviewStatus)&&(identical(other.editApplyStatus, editApplyStatus) || other.editApplyStatus == editApplyStatus)&&(identical(other.editSettlement, editSettlement) || other.editSettlement == editSettlement)&&(identical(other.postponeStatus, postponeStatus) || other.postponeStatus == postponeStatus));
}


@override
int get hashCode => Object.hashAll([runtimeType,tripStatus,cancelStatus,passengerNoteStatus,compensationClaimStatus,isPolling,activeTripId,activeDriverLocation,historyStatus,const DeepCollectionEquality().hash(trips),currentPage,hasMore,isLoadingMore,searchQuery,receiptStatus,invoiceStatus,invoicePdfStatus,tripEditStatus,editPreviewStatus,editApplyStatus,editSettlement,postponeStatus]);

@override
String toString() {
  return 'TripState(tripStatus: $tripStatus, cancelStatus: $cancelStatus, passengerNoteStatus: $passengerNoteStatus, compensationClaimStatus: $compensationClaimStatus, isPolling: $isPolling, activeTripId: $activeTripId, activeDriverLocation: $activeDriverLocation, historyStatus: $historyStatus, trips: $trips, currentPage: $currentPage, hasMore: $hasMore, isLoadingMore: $isLoadingMore, searchQuery: $searchQuery, receiptStatus: $receiptStatus, invoiceStatus: $invoiceStatus, invoicePdfStatus: $invoicePdfStatus, tripEditStatus: $tripEditStatus, editPreviewStatus: $editPreviewStatus, editApplyStatus: $editApplyStatus, editSettlement: $editSettlement, postponeStatus: $postponeStatus)';
}


}

/// @nodoc
abstract mixin class $TripStateCopyWith<$Res>  {
  factory $TripStateCopyWith(TripState value, $Res Function(TripState) _then) = _$TripStateCopyWithImpl;
@useResult
$Res call({
 BlocStatus<TripEntity> tripStatus, BlocStatus<void> cancelStatus, BlocStatus<void> passengerNoteStatus, BlocStatus<TripCompensationClaimEntity> compensationClaimStatus, bool isPolling, String? activeTripId, DriverLocationEntity? activeDriverLocation, BlocStatus<List<TripSummaryEntity>> historyStatus, List<TripSummaryEntity> trips, int currentPage, bool hasMore, bool isLoadingMore, String searchQuery, BlocStatus<TripReceiptEntity> receiptStatus, BlocStatus<TripInvoiceEntity> invoiceStatus, BlocStatus<Uint8List> invoicePdfStatus, BlocStatus<void> tripEditStatus, BlocStatus<TripEditPreviewEntity> editPreviewStatus, BlocStatus<TripEditApplyResultEntity> editApplyStatus, TripEditSettlementEntity? editSettlement, BlocStatus<void> postponeStatus
});


$BlocStatusCopyWith<TripEntity, $Res> get tripStatus;$BlocStatusCopyWith<void, $Res> get cancelStatus;$BlocStatusCopyWith<void, $Res> get passengerNoteStatus;$BlocStatusCopyWith<TripCompensationClaimEntity, $Res> get compensationClaimStatus;$DriverLocationEntityCopyWith<$Res>? get activeDriverLocation;$BlocStatusCopyWith<List<TripSummaryEntity>, $Res> get historyStatus;$BlocStatusCopyWith<TripReceiptEntity, $Res> get receiptStatus;$BlocStatusCopyWith<TripInvoiceEntity, $Res> get invoiceStatus;$BlocStatusCopyWith<Uint8List, $Res> get invoicePdfStatus;$BlocStatusCopyWith<void, $Res> get tripEditStatus;$BlocStatusCopyWith<TripEditPreviewEntity, $Res> get editPreviewStatus;$BlocStatusCopyWith<TripEditApplyResultEntity, $Res> get editApplyStatus;$BlocStatusCopyWith<void, $Res> get postponeStatus;

}
/// @nodoc
class _$TripStateCopyWithImpl<$Res>
    implements $TripStateCopyWith<$Res> {
  _$TripStateCopyWithImpl(this._self, this._then);

  final TripState _self;
  final $Res Function(TripState) _then;

/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripStatus = null,Object? cancelStatus = null,Object? passengerNoteStatus = null,Object? compensationClaimStatus = null,Object? isPolling = null,Object? activeTripId = freezed,Object? activeDriverLocation = freezed,Object? historyStatus = null,Object? trips = null,Object? currentPage = null,Object? hasMore = null,Object? isLoadingMore = null,Object? searchQuery = null,Object? receiptStatus = null,Object? invoiceStatus = null,Object? invoicePdfStatus = null,Object? tripEditStatus = null,Object? editPreviewStatus = null,Object? editApplyStatus = null,Object? editSettlement = freezed,Object? postponeStatus = null,}) {
  return _then(_self.copyWith(
tripStatus: null == tripStatus ? _self.tripStatus : tripStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<TripEntity>,cancelStatus: null == cancelStatus ? _self.cancelStatus : cancelStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,passengerNoteStatus: null == passengerNoteStatus ? _self.passengerNoteStatus : passengerNoteStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,compensationClaimStatus: null == compensationClaimStatus ? _self.compensationClaimStatus : compensationClaimStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<TripCompensationClaimEntity>,isPolling: null == isPolling ? _self.isPolling : isPolling // ignore: cast_nullable_to_non_nullable
as bool,activeTripId: freezed == activeTripId ? _self.activeTripId : activeTripId // ignore: cast_nullable_to_non_nullable
as String?,activeDriverLocation: freezed == activeDriverLocation ? _self.activeDriverLocation : activeDriverLocation // ignore: cast_nullable_to_non_nullable
as DriverLocationEntity?,historyStatus: null == historyStatus ? _self.historyStatus : historyStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<TripSummaryEntity>>,trips: null == trips ? _self.trips : trips // ignore: cast_nullable_to_non_nullable
as List<TripSummaryEntity>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,receiptStatus: null == receiptStatus ? _self.receiptStatus : receiptStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<TripReceiptEntity>,invoiceStatus: null == invoiceStatus ? _self.invoiceStatus : invoiceStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<TripInvoiceEntity>,invoicePdfStatus: null == invoicePdfStatus ? _self.invoicePdfStatus : invoicePdfStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<Uint8List>,tripEditStatus: null == tripEditStatus ? _self.tripEditStatus : tripEditStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,editPreviewStatus: null == editPreviewStatus ? _self.editPreviewStatus : editPreviewStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<TripEditPreviewEntity>,editApplyStatus: null == editApplyStatus ? _self.editApplyStatus : editApplyStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<TripEditApplyResultEntity>,editSettlement: freezed == editSettlement ? _self.editSettlement : editSettlement // ignore: cast_nullable_to_non_nullable
as TripEditSettlementEntity?,postponeStatus: null == postponeStatus ? _self.postponeStatus : postponeStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,
  ));
}
/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<TripEntity, $Res> get tripStatus {
  
  return $BlocStatusCopyWith<TripEntity, $Res>(_self.tripStatus, (value) {
    return _then(_self.copyWith(tripStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get cancelStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.cancelStatus, (value) {
    return _then(_self.copyWith(cancelStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get passengerNoteStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.passengerNoteStatus, (value) {
    return _then(_self.copyWith(passengerNoteStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<TripCompensationClaimEntity, $Res> get compensationClaimStatus {
  
  return $BlocStatusCopyWith<TripCompensationClaimEntity, $Res>(_self.compensationClaimStatus, (value) {
    return _then(_self.copyWith(compensationClaimStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DriverLocationEntityCopyWith<$Res>? get activeDriverLocation {
    if (_self.activeDriverLocation == null) {
    return null;
  }

  return $DriverLocationEntityCopyWith<$Res>(_self.activeDriverLocation!, (value) {
    return _then(_self.copyWith(activeDriverLocation: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<TripSummaryEntity>, $Res> get historyStatus {
  
  return $BlocStatusCopyWith<List<TripSummaryEntity>, $Res>(_self.historyStatus, (value) {
    return _then(_self.copyWith(historyStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<TripReceiptEntity, $Res> get receiptStatus {
  
  return $BlocStatusCopyWith<TripReceiptEntity, $Res>(_self.receiptStatus, (value) {
    return _then(_self.copyWith(receiptStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<TripInvoiceEntity, $Res> get invoiceStatus {
  
  return $BlocStatusCopyWith<TripInvoiceEntity, $Res>(_self.invoiceStatus, (value) {
    return _then(_self.copyWith(invoiceStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<Uint8List, $Res> get invoicePdfStatus {
  
  return $BlocStatusCopyWith<Uint8List, $Res>(_self.invoicePdfStatus, (value) {
    return _then(_self.copyWith(invoicePdfStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get tripEditStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.tripEditStatus, (value) {
    return _then(_self.copyWith(tripEditStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<TripEditPreviewEntity, $Res> get editPreviewStatus {
  
  return $BlocStatusCopyWith<TripEditPreviewEntity, $Res>(_self.editPreviewStatus, (value) {
    return _then(_self.copyWith(editPreviewStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<TripEditApplyResultEntity, $Res> get editApplyStatus {
  
  return $BlocStatusCopyWith<TripEditApplyResultEntity, $Res>(_self.editApplyStatus, (value) {
    return _then(_self.copyWith(editApplyStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get postponeStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.postponeStatus, (value) {
    return _then(_self.copyWith(postponeStatus: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripState].
extension TripStatePatterns on TripState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripState value)  $default,){
final _that = this;
switch (_that) {
case _TripState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripState value)?  $default,){
final _that = this;
switch (_that) {
case _TripState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlocStatus<TripEntity> tripStatus,  BlocStatus<void> cancelStatus,  BlocStatus<void> passengerNoteStatus,  BlocStatus<TripCompensationClaimEntity> compensationClaimStatus,  bool isPolling,  String? activeTripId,  DriverLocationEntity? activeDriverLocation,  BlocStatus<List<TripSummaryEntity>> historyStatus,  List<TripSummaryEntity> trips,  int currentPage,  bool hasMore,  bool isLoadingMore,  String searchQuery,  BlocStatus<TripReceiptEntity> receiptStatus,  BlocStatus<TripInvoiceEntity> invoiceStatus,  BlocStatus<Uint8List> invoicePdfStatus,  BlocStatus<void> tripEditStatus,  BlocStatus<TripEditPreviewEntity> editPreviewStatus,  BlocStatus<TripEditApplyResultEntity> editApplyStatus,  TripEditSettlementEntity? editSettlement,  BlocStatus<void> postponeStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripState() when $default != null:
return $default(_that.tripStatus,_that.cancelStatus,_that.passengerNoteStatus,_that.compensationClaimStatus,_that.isPolling,_that.activeTripId,_that.activeDriverLocation,_that.historyStatus,_that.trips,_that.currentPage,_that.hasMore,_that.isLoadingMore,_that.searchQuery,_that.receiptStatus,_that.invoiceStatus,_that.invoicePdfStatus,_that.tripEditStatus,_that.editPreviewStatus,_that.editApplyStatus,_that.editSettlement,_that.postponeStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlocStatus<TripEntity> tripStatus,  BlocStatus<void> cancelStatus,  BlocStatus<void> passengerNoteStatus,  BlocStatus<TripCompensationClaimEntity> compensationClaimStatus,  bool isPolling,  String? activeTripId,  DriverLocationEntity? activeDriverLocation,  BlocStatus<List<TripSummaryEntity>> historyStatus,  List<TripSummaryEntity> trips,  int currentPage,  bool hasMore,  bool isLoadingMore,  String searchQuery,  BlocStatus<TripReceiptEntity> receiptStatus,  BlocStatus<TripInvoiceEntity> invoiceStatus,  BlocStatus<Uint8List> invoicePdfStatus,  BlocStatus<void> tripEditStatus,  BlocStatus<TripEditPreviewEntity> editPreviewStatus,  BlocStatus<TripEditApplyResultEntity> editApplyStatus,  TripEditSettlementEntity? editSettlement,  BlocStatus<void> postponeStatus)  $default,) {final _that = this;
switch (_that) {
case _TripState():
return $default(_that.tripStatus,_that.cancelStatus,_that.passengerNoteStatus,_that.compensationClaimStatus,_that.isPolling,_that.activeTripId,_that.activeDriverLocation,_that.historyStatus,_that.trips,_that.currentPage,_that.hasMore,_that.isLoadingMore,_that.searchQuery,_that.receiptStatus,_that.invoiceStatus,_that.invoicePdfStatus,_that.tripEditStatus,_that.editPreviewStatus,_that.editApplyStatus,_that.editSettlement,_that.postponeStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlocStatus<TripEntity> tripStatus,  BlocStatus<void> cancelStatus,  BlocStatus<void> passengerNoteStatus,  BlocStatus<TripCompensationClaimEntity> compensationClaimStatus,  bool isPolling,  String? activeTripId,  DriverLocationEntity? activeDriverLocation,  BlocStatus<List<TripSummaryEntity>> historyStatus,  List<TripSummaryEntity> trips,  int currentPage,  bool hasMore,  bool isLoadingMore,  String searchQuery,  BlocStatus<TripReceiptEntity> receiptStatus,  BlocStatus<TripInvoiceEntity> invoiceStatus,  BlocStatus<Uint8List> invoicePdfStatus,  BlocStatus<void> tripEditStatus,  BlocStatus<TripEditPreviewEntity> editPreviewStatus,  BlocStatus<TripEditApplyResultEntity> editApplyStatus,  TripEditSettlementEntity? editSettlement,  BlocStatus<void> postponeStatus)?  $default,) {final _that = this;
switch (_that) {
case _TripState() when $default != null:
return $default(_that.tripStatus,_that.cancelStatus,_that.passengerNoteStatus,_that.compensationClaimStatus,_that.isPolling,_that.activeTripId,_that.activeDriverLocation,_that.historyStatus,_that.trips,_that.currentPage,_that.hasMore,_that.isLoadingMore,_that.searchQuery,_that.receiptStatus,_that.invoiceStatus,_that.invoicePdfStatus,_that.tripEditStatus,_that.editPreviewStatus,_that.editApplyStatus,_that.editSettlement,_that.postponeStatus);case _:
  return null;

}
}

}

/// @nodoc


class _TripState implements TripState {
  const _TripState({this.tripStatus = const BlocStatus<TripEntity>.initial(), this.cancelStatus = const BlocStatus<void>.initial(), this.passengerNoteStatus = const BlocStatus<void>.initial(), this.compensationClaimStatus = const BlocStatus<TripCompensationClaimEntity>.initial(), this.isPolling = false, this.activeTripId, this.activeDriverLocation, this.historyStatus = const BlocStatus<List<TripSummaryEntity>>.initial(), final  List<TripSummaryEntity> trips = const [], this.currentPage = 1, this.hasMore = true, this.isLoadingMore = false, this.searchQuery = '', this.receiptStatus = const BlocStatus<TripReceiptEntity>.initial(), this.invoiceStatus = const BlocStatus<TripInvoiceEntity>.initial(), this.invoicePdfStatus = const BlocStatus<Uint8List>.initial(), this.tripEditStatus = const BlocStatus<void>.initial(), this.editPreviewStatus = const BlocStatus<TripEditPreviewEntity>.initial(), this.editApplyStatus = const BlocStatus<TripEditApplyResultEntity>.initial(), this.editSettlement, this.postponeStatus = const BlocStatus<void>.initial()}): _trips = trips;
  

// Active trip
@override@JsonKey() final  BlocStatus<TripEntity> tripStatus;
@override@JsonKey() final  BlocStatus<void> cancelStatus;
@override@JsonKey() final  BlocStatus<void> passengerNoteStatus;
@override@JsonKey() final  BlocStatus<TripCompensationClaimEntity> compensationClaimStatus;
@override@JsonKey() final  bool isPolling;
@override final  String? activeTripId;
@override final  DriverLocationEntity? activeDriverLocation;
// Trip history
@override@JsonKey() final  BlocStatus<List<TripSummaryEntity>> historyStatus;
 final  List<TripSummaryEntity> _trips;
@override@JsonKey() List<TripSummaryEntity> get trips {
  if (_trips is EqualUnmodifiableListView) return _trips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trips);
}

@override@JsonKey() final  int currentPage;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  String searchQuery;
// Receipt / Invoice (per-section loading)
@override@JsonKey() final  BlocStatus<TripReceiptEntity> receiptStatus;
@override@JsonKey() final  BlocStatus<TripInvoiceEntity> invoiceStatus;
@override@JsonKey() final  BlocStatus<Uint8List> invoicePdfStatus;
// Pre-trip edit operations
@override@JsonKey() final  BlocStatus<void> tripEditStatus;
// Mid-trip re-pricing edit (preview → confirm → apply/settle)
@override@JsonKey() final  BlocStatus<TripEditPreviewEntity> editPreviewStatus;
@override@JsonKey() final  BlocStatus<TripEditApplyResultEntity> editApplyStatus;
/// Set once an edit is actually settled — including the PaymentSheet path, which only
/// commits at the Stripe webhook. Widgets listen for this to confirm the amount.
@override final  TripEditSettlementEntity? editSettlement;
// "No driver found" postpone action
@override@JsonKey() final  BlocStatus<void> postponeStatus;

/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripStateCopyWith<_TripState> get copyWith => __$TripStateCopyWithImpl<_TripState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripState&&(identical(other.tripStatus, tripStatus) || other.tripStatus == tripStatus)&&(identical(other.cancelStatus, cancelStatus) || other.cancelStatus == cancelStatus)&&(identical(other.passengerNoteStatus, passengerNoteStatus) || other.passengerNoteStatus == passengerNoteStatus)&&(identical(other.compensationClaimStatus, compensationClaimStatus) || other.compensationClaimStatus == compensationClaimStatus)&&(identical(other.isPolling, isPolling) || other.isPolling == isPolling)&&(identical(other.activeTripId, activeTripId) || other.activeTripId == activeTripId)&&(identical(other.activeDriverLocation, activeDriverLocation) || other.activeDriverLocation == activeDriverLocation)&&(identical(other.historyStatus, historyStatus) || other.historyStatus == historyStatus)&&const DeepCollectionEquality().equals(other._trips, _trips)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.receiptStatus, receiptStatus) || other.receiptStatus == receiptStatus)&&(identical(other.invoiceStatus, invoiceStatus) || other.invoiceStatus == invoiceStatus)&&(identical(other.invoicePdfStatus, invoicePdfStatus) || other.invoicePdfStatus == invoicePdfStatus)&&(identical(other.tripEditStatus, tripEditStatus) || other.tripEditStatus == tripEditStatus)&&(identical(other.editPreviewStatus, editPreviewStatus) || other.editPreviewStatus == editPreviewStatus)&&(identical(other.editApplyStatus, editApplyStatus) || other.editApplyStatus == editApplyStatus)&&(identical(other.editSettlement, editSettlement) || other.editSettlement == editSettlement)&&(identical(other.postponeStatus, postponeStatus) || other.postponeStatus == postponeStatus));
}


@override
int get hashCode => Object.hashAll([runtimeType,tripStatus,cancelStatus,passengerNoteStatus,compensationClaimStatus,isPolling,activeTripId,activeDriverLocation,historyStatus,const DeepCollectionEquality().hash(_trips),currentPage,hasMore,isLoadingMore,searchQuery,receiptStatus,invoiceStatus,invoicePdfStatus,tripEditStatus,editPreviewStatus,editApplyStatus,editSettlement,postponeStatus]);

@override
String toString() {
  return 'TripState(tripStatus: $tripStatus, cancelStatus: $cancelStatus, passengerNoteStatus: $passengerNoteStatus, compensationClaimStatus: $compensationClaimStatus, isPolling: $isPolling, activeTripId: $activeTripId, activeDriverLocation: $activeDriverLocation, historyStatus: $historyStatus, trips: $trips, currentPage: $currentPage, hasMore: $hasMore, isLoadingMore: $isLoadingMore, searchQuery: $searchQuery, receiptStatus: $receiptStatus, invoiceStatus: $invoiceStatus, invoicePdfStatus: $invoicePdfStatus, tripEditStatus: $tripEditStatus, editPreviewStatus: $editPreviewStatus, editApplyStatus: $editApplyStatus, editSettlement: $editSettlement, postponeStatus: $postponeStatus)';
}


}

/// @nodoc
abstract mixin class _$TripStateCopyWith<$Res> implements $TripStateCopyWith<$Res> {
  factory _$TripStateCopyWith(_TripState value, $Res Function(_TripState) _then) = __$TripStateCopyWithImpl;
@override @useResult
$Res call({
 BlocStatus<TripEntity> tripStatus, BlocStatus<void> cancelStatus, BlocStatus<void> passengerNoteStatus, BlocStatus<TripCompensationClaimEntity> compensationClaimStatus, bool isPolling, String? activeTripId, DriverLocationEntity? activeDriverLocation, BlocStatus<List<TripSummaryEntity>> historyStatus, List<TripSummaryEntity> trips, int currentPage, bool hasMore, bool isLoadingMore, String searchQuery, BlocStatus<TripReceiptEntity> receiptStatus, BlocStatus<TripInvoiceEntity> invoiceStatus, BlocStatus<Uint8List> invoicePdfStatus, BlocStatus<void> tripEditStatus, BlocStatus<TripEditPreviewEntity> editPreviewStatus, BlocStatus<TripEditApplyResultEntity> editApplyStatus, TripEditSettlementEntity? editSettlement, BlocStatus<void> postponeStatus
});


@override $BlocStatusCopyWith<TripEntity, $Res> get tripStatus;@override $BlocStatusCopyWith<void, $Res> get cancelStatus;@override $BlocStatusCopyWith<void, $Res> get passengerNoteStatus;@override $BlocStatusCopyWith<TripCompensationClaimEntity, $Res> get compensationClaimStatus;@override $DriverLocationEntityCopyWith<$Res>? get activeDriverLocation;@override $BlocStatusCopyWith<List<TripSummaryEntity>, $Res> get historyStatus;@override $BlocStatusCopyWith<TripReceiptEntity, $Res> get receiptStatus;@override $BlocStatusCopyWith<TripInvoiceEntity, $Res> get invoiceStatus;@override $BlocStatusCopyWith<Uint8List, $Res> get invoicePdfStatus;@override $BlocStatusCopyWith<void, $Res> get tripEditStatus;@override $BlocStatusCopyWith<TripEditPreviewEntity, $Res> get editPreviewStatus;@override $BlocStatusCopyWith<TripEditApplyResultEntity, $Res> get editApplyStatus;@override $BlocStatusCopyWith<void, $Res> get postponeStatus;

}
/// @nodoc
class __$TripStateCopyWithImpl<$Res>
    implements _$TripStateCopyWith<$Res> {
  __$TripStateCopyWithImpl(this._self, this._then);

  final _TripState _self;
  final $Res Function(_TripState) _then;

/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripStatus = null,Object? cancelStatus = null,Object? passengerNoteStatus = null,Object? compensationClaimStatus = null,Object? isPolling = null,Object? activeTripId = freezed,Object? activeDriverLocation = freezed,Object? historyStatus = null,Object? trips = null,Object? currentPage = null,Object? hasMore = null,Object? isLoadingMore = null,Object? searchQuery = null,Object? receiptStatus = null,Object? invoiceStatus = null,Object? invoicePdfStatus = null,Object? tripEditStatus = null,Object? editPreviewStatus = null,Object? editApplyStatus = null,Object? editSettlement = freezed,Object? postponeStatus = null,}) {
  return _then(_TripState(
tripStatus: null == tripStatus ? _self.tripStatus : tripStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<TripEntity>,cancelStatus: null == cancelStatus ? _self.cancelStatus : cancelStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,passengerNoteStatus: null == passengerNoteStatus ? _self.passengerNoteStatus : passengerNoteStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,compensationClaimStatus: null == compensationClaimStatus ? _self.compensationClaimStatus : compensationClaimStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<TripCompensationClaimEntity>,isPolling: null == isPolling ? _self.isPolling : isPolling // ignore: cast_nullable_to_non_nullable
as bool,activeTripId: freezed == activeTripId ? _self.activeTripId : activeTripId // ignore: cast_nullable_to_non_nullable
as String?,activeDriverLocation: freezed == activeDriverLocation ? _self.activeDriverLocation : activeDriverLocation // ignore: cast_nullable_to_non_nullable
as DriverLocationEntity?,historyStatus: null == historyStatus ? _self.historyStatus : historyStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<TripSummaryEntity>>,trips: null == trips ? _self._trips : trips // ignore: cast_nullable_to_non_nullable
as List<TripSummaryEntity>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,receiptStatus: null == receiptStatus ? _self.receiptStatus : receiptStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<TripReceiptEntity>,invoiceStatus: null == invoiceStatus ? _self.invoiceStatus : invoiceStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<TripInvoiceEntity>,invoicePdfStatus: null == invoicePdfStatus ? _self.invoicePdfStatus : invoicePdfStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<Uint8List>,tripEditStatus: null == tripEditStatus ? _self.tripEditStatus : tripEditStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,editPreviewStatus: null == editPreviewStatus ? _self.editPreviewStatus : editPreviewStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<TripEditPreviewEntity>,editApplyStatus: null == editApplyStatus ? _self.editApplyStatus : editApplyStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<TripEditApplyResultEntity>,editSettlement: freezed == editSettlement ? _self.editSettlement : editSettlement // ignore: cast_nullable_to_non_nullable
as TripEditSettlementEntity?,postponeStatus: null == postponeStatus ? _self.postponeStatus : postponeStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,
  ));
}

/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<TripEntity, $Res> get tripStatus {
  
  return $BlocStatusCopyWith<TripEntity, $Res>(_self.tripStatus, (value) {
    return _then(_self.copyWith(tripStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get cancelStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.cancelStatus, (value) {
    return _then(_self.copyWith(cancelStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get passengerNoteStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.passengerNoteStatus, (value) {
    return _then(_self.copyWith(passengerNoteStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<TripCompensationClaimEntity, $Res> get compensationClaimStatus {
  
  return $BlocStatusCopyWith<TripCompensationClaimEntity, $Res>(_self.compensationClaimStatus, (value) {
    return _then(_self.copyWith(compensationClaimStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DriverLocationEntityCopyWith<$Res>? get activeDriverLocation {
    if (_self.activeDriverLocation == null) {
    return null;
  }

  return $DriverLocationEntityCopyWith<$Res>(_self.activeDriverLocation!, (value) {
    return _then(_self.copyWith(activeDriverLocation: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<TripSummaryEntity>, $Res> get historyStatus {
  
  return $BlocStatusCopyWith<List<TripSummaryEntity>, $Res>(_self.historyStatus, (value) {
    return _then(_self.copyWith(historyStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<TripReceiptEntity, $Res> get receiptStatus {
  
  return $BlocStatusCopyWith<TripReceiptEntity, $Res>(_self.receiptStatus, (value) {
    return _then(_self.copyWith(receiptStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<TripInvoiceEntity, $Res> get invoiceStatus {
  
  return $BlocStatusCopyWith<TripInvoiceEntity, $Res>(_self.invoiceStatus, (value) {
    return _then(_self.copyWith(invoiceStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<Uint8List, $Res> get invoicePdfStatus {
  
  return $BlocStatusCopyWith<Uint8List, $Res>(_self.invoicePdfStatus, (value) {
    return _then(_self.copyWith(invoicePdfStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get tripEditStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.tripEditStatus, (value) {
    return _then(_self.copyWith(tripEditStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<TripEditPreviewEntity, $Res> get editPreviewStatus {
  
  return $BlocStatusCopyWith<TripEditPreviewEntity, $Res>(_self.editPreviewStatus, (value) {
    return _then(_self.copyWith(editPreviewStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<TripEditApplyResultEntity, $Res> get editApplyStatus {
  
  return $BlocStatusCopyWith<TripEditApplyResultEntity, $Res>(_self.editApplyStatus, (value) {
    return _then(_self.copyWith(editApplyStatus: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get postponeStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.postponeStatus, (value) {
    return _then(_self.copyWith(postponeStatus: value));
  });
}
}

// dart format on
