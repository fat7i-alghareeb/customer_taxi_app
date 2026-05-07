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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _PollingTick value)?  pollingTick,TResult Function( _CancelRequested value)?  cancelRequested,TResult Function( _StopPolling value)?  stopPolling,TResult Function( _HistoryStarted value)?  historyStarted,TResult Function( _NextPageRequested value)?  nextPageRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _PollingTick() when pollingTick != null:
return pollingTick(_that);case _CancelRequested() when cancelRequested != null:
return cancelRequested(_that);case _StopPolling() when stopPolling != null:
return stopPolling(_that);case _HistoryStarted() when historyStarted != null:
return historyStarted(_that);case _NextPageRequested() when nextPageRequested != null:
return nextPageRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _PollingTick value)  pollingTick,required TResult Function( _CancelRequested value)  cancelRequested,required TResult Function( _StopPolling value)  stopPolling,required TResult Function( _HistoryStarted value)  historyStarted,required TResult Function( _NextPageRequested value)  nextPageRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _PollingTick():
return pollingTick(_that);case _CancelRequested():
return cancelRequested(_that);case _StopPolling():
return stopPolling(_that);case _HistoryStarted():
return historyStarted(_that);case _NextPageRequested():
return nextPageRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _PollingTick value)?  pollingTick,TResult? Function( _CancelRequested value)?  cancelRequested,TResult? Function( _StopPolling value)?  stopPolling,TResult? Function( _HistoryStarted value)?  historyStarted,TResult? Function( _NextPageRequested value)?  nextPageRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _PollingTick() when pollingTick != null:
return pollingTick(_that);case _CancelRequested() when cancelRequested != null:
return cancelRequested(_that);case _StopPolling() when stopPolling != null:
return stopPolling(_that);case _HistoryStarted() when historyStarted != null:
return historyStarted(_that);case _NextPageRequested() when nextPageRequested != null:
return nextPageRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String tripId)?  started,TResult Function()?  pollingTick,TResult Function()?  cancelRequested,TResult Function()?  stopPolling,TResult Function()?  historyStarted,TResult Function()?  nextPageRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.tripId);case _PollingTick() when pollingTick != null:
return pollingTick();case _CancelRequested() when cancelRequested != null:
return cancelRequested();case _StopPolling() when stopPolling != null:
return stopPolling();case _HistoryStarted() when historyStarted != null:
return historyStarted();case _NextPageRequested() when nextPageRequested != null:
return nextPageRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String tripId)  started,required TResult Function()  pollingTick,required TResult Function()  cancelRequested,required TResult Function()  stopPolling,required TResult Function()  historyStarted,required TResult Function()  nextPageRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started(_that.tripId);case _PollingTick():
return pollingTick();case _CancelRequested():
return cancelRequested();case _StopPolling():
return stopPolling();case _HistoryStarted():
return historyStarted();case _NextPageRequested():
return nextPageRequested();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String tripId)?  started,TResult? Function()?  pollingTick,TResult? Function()?  cancelRequested,TResult? Function()?  stopPolling,TResult? Function()?  historyStarted,TResult? Function()?  nextPageRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.tripId);case _PollingTick() when pollingTick != null:
return pollingTick();case _CancelRequested() when cancelRequested != null:
return cancelRequested();case _StopPolling() when stopPolling != null:
return stopPolling();case _HistoryStarted() when historyStarted != null:
return historyStarted();case _NextPageRequested() when nextPageRequested != null:
return nextPageRequested();case _:
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
  const _CancelRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CancelRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TripEvent.cancelRequested()';
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
mixin _$TripState {

// Active trip
 BlocStatus<TripEntity> get tripStatus; BlocStatus<void> get cancelStatus; bool get isPolling; String? get activeTripId;// Trip history
 BlocStatus<List<TripSummaryEntity>> get historyStatus; List<TripSummaryEntity> get trips; int get currentPage; bool get hasMore;
/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripStateCopyWith<TripState> get copyWith => _$TripStateCopyWithImpl<TripState>(this as TripState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripState&&(identical(other.tripStatus, tripStatus) || other.tripStatus == tripStatus)&&(identical(other.cancelStatus, cancelStatus) || other.cancelStatus == cancelStatus)&&(identical(other.isPolling, isPolling) || other.isPolling == isPolling)&&(identical(other.activeTripId, activeTripId) || other.activeTripId == activeTripId)&&(identical(other.historyStatus, historyStatus) || other.historyStatus == historyStatus)&&const DeepCollectionEquality().equals(other.trips, trips)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,tripStatus,cancelStatus,isPolling,activeTripId,historyStatus,const DeepCollectionEquality().hash(trips),currentPage,hasMore);

@override
String toString() {
  return 'TripState(tripStatus: $tripStatus, cancelStatus: $cancelStatus, isPolling: $isPolling, activeTripId: $activeTripId, historyStatus: $historyStatus, trips: $trips, currentPage: $currentPage, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $TripStateCopyWith<$Res>  {
  factory $TripStateCopyWith(TripState value, $Res Function(TripState) _then) = _$TripStateCopyWithImpl;
@useResult
$Res call({
 BlocStatus<TripEntity> tripStatus, BlocStatus<void> cancelStatus, bool isPolling, String? activeTripId, BlocStatus<List<TripSummaryEntity>> historyStatus, List<TripSummaryEntity> trips, int currentPage, bool hasMore
});


$BlocStatusCopyWith<TripEntity, $Res> get tripStatus;$BlocStatusCopyWith<void, $Res> get cancelStatus;$BlocStatusCopyWith<List<TripSummaryEntity>, $Res> get historyStatus;

}
/// @nodoc
class _$TripStateCopyWithImpl<$Res>
    implements $TripStateCopyWith<$Res> {
  _$TripStateCopyWithImpl(this._self, this._then);

  final TripState _self;
  final $Res Function(TripState) _then;

/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripStatus = null,Object? cancelStatus = null,Object? isPolling = null,Object? activeTripId = freezed,Object? historyStatus = null,Object? trips = null,Object? currentPage = null,Object? hasMore = null,}) {
  return _then(_self.copyWith(
tripStatus: null == tripStatus ? _self.tripStatus : tripStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<TripEntity>,cancelStatus: null == cancelStatus ? _self.cancelStatus : cancelStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,isPolling: null == isPolling ? _self.isPolling : isPolling // ignore: cast_nullable_to_non_nullable
as bool,activeTripId: freezed == activeTripId ? _self.activeTripId : activeTripId // ignore: cast_nullable_to_non_nullable
as String?,historyStatus: null == historyStatus ? _self.historyStatus : historyStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<TripSummaryEntity>>,trips: null == trips ? _self.trips : trips // ignore: cast_nullable_to_non_nullable
as List<TripSummaryEntity>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
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
$BlocStatusCopyWith<List<TripSummaryEntity>, $Res> get historyStatus {
  
  return $BlocStatusCopyWith<List<TripSummaryEntity>, $Res>(_self.historyStatus, (value) {
    return _then(_self.copyWith(historyStatus: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlocStatus<TripEntity> tripStatus,  BlocStatus<void> cancelStatus,  bool isPolling,  String? activeTripId,  BlocStatus<List<TripSummaryEntity>> historyStatus,  List<TripSummaryEntity> trips,  int currentPage,  bool hasMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripState() when $default != null:
return $default(_that.tripStatus,_that.cancelStatus,_that.isPolling,_that.activeTripId,_that.historyStatus,_that.trips,_that.currentPage,_that.hasMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlocStatus<TripEntity> tripStatus,  BlocStatus<void> cancelStatus,  bool isPolling,  String? activeTripId,  BlocStatus<List<TripSummaryEntity>> historyStatus,  List<TripSummaryEntity> trips,  int currentPage,  bool hasMore)  $default,) {final _that = this;
switch (_that) {
case _TripState():
return $default(_that.tripStatus,_that.cancelStatus,_that.isPolling,_that.activeTripId,_that.historyStatus,_that.trips,_that.currentPage,_that.hasMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlocStatus<TripEntity> tripStatus,  BlocStatus<void> cancelStatus,  bool isPolling,  String? activeTripId,  BlocStatus<List<TripSummaryEntity>> historyStatus,  List<TripSummaryEntity> trips,  int currentPage,  bool hasMore)?  $default,) {final _that = this;
switch (_that) {
case _TripState() when $default != null:
return $default(_that.tripStatus,_that.cancelStatus,_that.isPolling,_that.activeTripId,_that.historyStatus,_that.trips,_that.currentPage,_that.hasMore);case _:
  return null;

}
}

}

/// @nodoc


class _TripState implements TripState {
  const _TripState({this.tripStatus = const BlocStatus<TripEntity>.initial(), this.cancelStatus = const BlocStatus<void>.initial(), this.isPolling = false, this.activeTripId, this.historyStatus = const BlocStatus<List<TripSummaryEntity>>.initial(), final  List<TripSummaryEntity> trips = const [], this.currentPage = 1, this.hasMore = true}): _trips = trips;
  

// Active trip
@override@JsonKey() final  BlocStatus<TripEntity> tripStatus;
@override@JsonKey() final  BlocStatus<void> cancelStatus;
@override@JsonKey() final  bool isPolling;
@override final  String? activeTripId;
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

/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripStateCopyWith<_TripState> get copyWith => __$TripStateCopyWithImpl<_TripState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripState&&(identical(other.tripStatus, tripStatus) || other.tripStatus == tripStatus)&&(identical(other.cancelStatus, cancelStatus) || other.cancelStatus == cancelStatus)&&(identical(other.isPolling, isPolling) || other.isPolling == isPolling)&&(identical(other.activeTripId, activeTripId) || other.activeTripId == activeTripId)&&(identical(other.historyStatus, historyStatus) || other.historyStatus == historyStatus)&&const DeepCollectionEquality().equals(other._trips, _trips)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,tripStatus,cancelStatus,isPolling,activeTripId,historyStatus,const DeepCollectionEquality().hash(_trips),currentPage,hasMore);

@override
String toString() {
  return 'TripState(tripStatus: $tripStatus, cancelStatus: $cancelStatus, isPolling: $isPolling, activeTripId: $activeTripId, historyStatus: $historyStatus, trips: $trips, currentPage: $currentPage, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class _$TripStateCopyWith<$Res> implements $TripStateCopyWith<$Res> {
  factory _$TripStateCopyWith(_TripState value, $Res Function(_TripState) _then) = __$TripStateCopyWithImpl;
@override @useResult
$Res call({
 BlocStatus<TripEntity> tripStatus, BlocStatus<void> cancelStatus, bool isPolling, String? activeTripId, BlocStatus<List<TripSummaryEntity>> historyStatus, List<TripSummaryEntity> trips, int currentPage, bool hasMore
});


@override $BlocStatusCopyWith<TripEntity, $Res> get tripStatus;@override $BlocStatusCopyWith<void, $Res> get cancelStatus;@override $BlocStatusCopyWith<List<TripSummaryEntity>, $Res> get historyStatus;

}
/// @nodoc
class __$TripStateCopyWithImpl<$Res>
    implements _$TripStateCopyWith<$Res> {
  __$TripStateCopyWithImpl(this._self, this._then);

  final _TripState _self;
  final $Res Function(_TripState) _then;

/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripStatus = null,Object? cancelStatus = null,Object? isPolling = null,Object? activeTripId = freezed,Object? historyStatus = null,Object? trips = null,Object? currentPage = null,Object? hasMore = null,}) {
  return _then(_TripState(
tripStatus: null == tripStatus ? _self.tripStatus : tripStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<TripEntity>,cancelStatus: null == cancelStatus ? _self.cancelStatus : cancelStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,isPolling: null == isPolling ? _self.isPolling : isPolling // ignore: cast_nullable_to_non_nullable
as bool,activeTripId: freezed == activeTripId ? _self.activeTripId : activeTripId // ignore: cast_nullable_to_non_nullable
as String?,historyStatus: null == historyStatus ? _self.historyStatus : historyStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<TripSummaryEntity>>,trips: null == trips ? _self._trips : trips // ignore: cast_nullable_to_non_nullable
as List<TripSummaryEntity>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
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
$BlocStatusCopyWith<List<TripSummaryEntity>, $Res> get historyStatus {
  
  return $BlocStatusCopyWith<List<TripSummaryEntity>, $Res>(_self.historyStatus, (value) {
    return _then(_self.copyWith(historyStatus: value));
  });
}
}

// dart format on
