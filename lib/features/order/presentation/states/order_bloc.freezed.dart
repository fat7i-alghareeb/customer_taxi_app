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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _GetAllRequested value)?  getAllRequested,TResult Function( _OrderNowPressed value)?  orderNowPressed,TResult Function( _CollapseRequested value)?  collapseRequested,TResult Function( _MapPickCancelled value)?  mapPickCancelled,TResult Function( _SetOnMapPressed value)?  setOnMapPressed,TResult Function( _MapCameraTargetUpdated value)?  mapCameraTargetUpdated,TResult Function( _ConfirmMapPointPressed value)?  confirmMapPointPressed,TResult Function( _FromQueryChanged value)?  fromQueryChanged,TResult Function( _ToQueryChanged value)?  toQueryChanged,TResult Function( _FromLocationCleared value)?  fromLocationCleared,TResult Function( _ToLocationCleared value)?  toLocationCleared,TResult Function( _FromSuggestionSelected value)?  fromSuggestionSelected,TResult Function( _ToSuggestionSelected value)?  toSuggestionSelected,TResult Function( _ConfirmOrderPressed value)?  confirmOrderPressed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _GetAllRequested() when getAllRequested != null:
return getAllRequested(_that);case _OrderNowPressed() when orderNowPressed != null:
return orderNowPressed(_that);case _CollapseRequested() when collapseRequested != null:
return collapseRequested(_that);case _MapPickCancelled() when mapPickCancelled != null:
return mapPickCancelled(_that);case _SetOnMapPressed() when setOnMapPressed != null:
return setOnMapPressed(_that);case _MapCameraTargetUpdated() when mapCameraTargetUpdated != null:
return mapCameraTargetUpdated(_that);case _ConfirmMapPointPressed() when confirmMapPointPressed != null:
return confirmMapPointPressed(_that);case _FromQueryChanged() when fromQueryChanged != null:
return fromQueryChanged(_that);case _ToQueryChanged() when toQueryChanged != null:
return toQueryChanged(_that);case _FromLocationCleared() when fromLocationCleared != null:
return fromLocationCleared(_that);case _ToLocationCleared() when toLocationCleared != null:
return toLocationCleared(_that);case _FromSuggestionSelected() when fromSuggestionSelected != null:
return fromSuggestionSelected(_that);case _ToSuggestionSelected() when toSuggestionSelected != null:
return toSuggestionSelected(_that);case _ConfirmOrderPressed() when confirmOrderPressed != null:
return confirmOrderPressed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _GetAllRequested value)  getAllRequested,required TResult Function( _OrderNowPressed value)  orderNowPressed,required TResult Function( _CollapseRequested value)  collapseRequested,required TResult Function( _MapPickCancelled value)  mapPickCancelled,required TResult Function( _SetOnMapPressed value)  setOnMapPressed,required TResult Function( _MapCameraTargetUpdated value)  mapCameraTargetUpdated,required TResult Function( _ConfirmMapPointPressed value)  confirmMapPointPressed,required TResult Function( _FromQueryChanged value)  fromQueryChanged,required TResult Function( _ToQueryChanged value)  toQueryChanged,required TResult Function( _FromLocationCleared value)  fromLocationCleared,required TResult Function( _ToLocationCleared value)  toLocationCleared,required TResult Function( _FromSuggestionSelected value)  fromSuggestionSelected,required TResult Function( _ToSuggestionSelected value)  toSuggestionSelected,required TResult Function( _ConfirmOrderPressed value)  confirmOrderPressed,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _GetAllRequested():
return getAllRequested(_that);case _OrderNowPressed():
return orderNowPressed(_that);case _CollapseRequested():
return collapseRequested(_that);case _MapPickCancelled():
return mapPickCancelled(_that);case _SetOnMapPressed():
return setOnMapPressed(_that);case _MapCameraTargetUpdated():
return mapCameraTargetUpdated(_that);case _ConfirmMapPointPressed():
return confirmMapPointPressed(_that);case _FromQueryChanged():
return fromQueryChanged(_that);case _ToQueryChanged():
return toQueryChanged(_that);case _FromLocationCleared():
return fromLocationCleared(_that);case _ToLocationCleared():
return toLocationCleared(_that);case _FromSuggestionSelected():
return fromSuggestionSelected(_that);case _ToSuggestionSelected():
return toSuggestionSelected(_that);case _ConfirmOrderPressed():
return confirmOrderPressed(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _GetAllRequested value)?  getAllRequested,TResult? Function( _OrderNowPressed value)?  orderNowPressed,TResult? Function( _CollapseRequested value)?  collapseRequested,TResult? Function( _MapPickCancelled value)?  mapPickCancelled,TResult? Function( _SetOnMapPressed value)?  setOnMapPressed,TResult? Function( _MapCameraTargetUpdated value)?  mapCameraTargetUpdated,TResult? Function( _ConfirmMapPointPressed value)?  confirmMapPointPressed,TResult? Function( _FromQueryChanged value)?  fromQueryChanged,TResult? Function( _ToQueryChanged value)?  toQueryChanged,TResult? Function( _FromLocationCleared value)?  fromLocationCleared,TResult? Function( _ToLocationCleared value)?  toLocationCleared,TResult? Function( _FromSuggestionSelected value)?  fromSuggestionSelected,TResult? Function( _ToSuggestionSelected value)?  toSuggestionSelected,TResult? Function( _ConfirmOrderPressed value)?  confirmOrderPressed,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _GetAllRequested() when getAllRequested != null:
return getAllRequested(_that);case _OrderNowPressed() when orderNowPressed != null:
return orderNowPressed(_that);case _CollapseRequested() when collapseRequested != null:
return collapseRequested(_that);case _MapPickCancelled() when mapPickCancelled != null:
return mapPickCancelled(_that);case _SetOnMapPressed() when setOnMapPressed != null:
return setOnMapPressed(_that);case _MapCameraTargetUpdated() when mapCameraTargetUpdated != null:
return mapCameraTargetUpdated(_that);case _ConfirmMapPointPressed() when confirmMapPointPressed != null:
return confirmMapPointPressed(_that);case _FromQueryChanged() when fromQueryChanged != null:
return fromQueryChanged(_that);case _ToQueryChanged() when toQueryChanged != null:
return toQueryChanged(_that);case _FromLocationCleared() when fromLocationCleared != null:
return fromLocationCleared(_that);case _ToLocationCleared() when toLocationCleared != null:
return toLocationCleared(_that);case _FromSuggestionSelected() when fromSuggestionSelected != null:
return fromSuggestionSelected(_that);case _ToSuggestionSelected() when toSuggestionSelected != null:
return toSuggestionSelected(_that);case _ConfirmOrderPressed() when confirmOrderPressed != null:
return confirmOrderPressed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  getAllRequested,TResult Function()?  orderNowPressed,TResult Function()?  collapseRequested,TResult Function()?  mapPickCancelled,TResult Function( OrderLocationTarget target)?  setOnMapPressed,TResult Function( double latitude,  double longitude,  double zoom)?  mapCameraTargetUpdated,TResult Function()?  confirmMapPointPressed,TResult Function( String query)?  fromQueryChanged,TResult Function( String query)?  toQueryChanged,TResult Function()?  fromLocationCleared,TResult Function()?  toLocationCleared,TResult Function( OrderLocationEntity location)?  fromSuggestionSelected,TResult Function( OrderLocationEntity location)?  toSuggestionSelected,TResult Function()?  confirmOrderPressed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _GetAllRequested() when getAllRequested != null:
return getAllRequested();case _OrderNowPressed() when orderNowPressed != null:
return orderNowPressed();case _CollapseRequested() when collapseRequested != null:
return collapseRequested();case _MapPickCancelled() when mapPickCancelled != null:
return mapPickCancelled();case _SetOnMapPressed() when setOnMapPressed != null:
return setOnMapPressed(_that.target);case _MapCameraTargetUpdated() when mapCameraTargetUpdated != null:
return mapCameraTargetUpdated(_that.latitude,_that.longitude,_that.zoom);case _ConfirmMapPointPressed() when confirmMapPointPressed != null:
return confirmMapPointPressed();case _FromQueryChanged() when fromQueryChanged != null:
return fromQueryChanged(_that.query);case _ToQueryChanged() when toQueryChanged != null:
return toQueryChanged(_that.query);case _FromLocationCleared() when fromLocationCleared != null:
return fromLocationCleared();case _ToLocationCleared() when toLocationCleared != null:
return toLocationCleared();case _FromSuggestionSelected() when fromSuggestionSelected != null:
return fromSuggestionSelected(_that.location);case _ToSuggestionSelected() when toSuggestionSelected != null:
return toSuggestionSelected(_that.location);case _ConfirmOrderPressed() when confirmOrderPressed != null:
return confirmOrderPressed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  getAllRequested,required TResult Function()  orderNowPressed,required TResult Function()  collapseRequested,required TResult Function()  mapPickCancelled,required TResult Function( OrderLocationTarget target)  setOnMapPressed,required TResult Function( double latitude,  double longitude,  double zoom)  mapCameraTargetUpdated,required TResult Function()  confirmMapPointPressed,required TResult Function( String query)  fromQueryChanged,required TResult Function( String query)  toQueryChanged,required TResult Function()  fromLocationCleared,required TResult Function()  toLocationCleared,required TResult Function( OrderLocationEntity location)  fromSuggestionSelected,required TResult Function( OrderLocationEntity location)  toSuggestionSelected,required TResult Function()  confirmOrderPressed,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _GetAllRequested():
return getAllRequested();case _OrderNowPressed():
return orderNowPressed();case _CollapseRequested():
return collapseRequested();case _MapPickCancelled():
return mapPickCancelled();case _SetOnMapPressed():
return setOnMapPressed(_that.target);case _MapCameraTargetUpdated():
return mapCameraTargetUpdated(_that.latitude,_that.longitude,_that.zoom);case _ConfirmMapPointPressed():
return confirmMapPointPressed();case _FromQueryChanged():
return fromQueryChanged(_that.query);case _ToQueryChanged():
return toQueryChanged(_that.query);case _FromLocationCleared():
return fromLocationCleared();case _ToLocationCleared():
return toLocationCleared();case _FromSuggestionSelected():
return fromSuggestionSelected(_that.location);case _ToSuggestionSelected():
return toSuggestionSelected(_that.location);case _ConfirmOrderPressed():
return confirmOrderPressed();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  getAllRequested,TResult? Function()?  orderNowPressed,TResult? Function()?  collapseRequested,TResult? Function()?  mapPickCancelled,TResult? Function( OrderLocationTarget target)?  setOnMapPressed,TResult? Function( double latitude,  double longitude,  double zoom)?  mapCameraTargetUpdated,TResult? Function()?  confirmMapPointPressed,TResult? Function( String query)?  fromQueryChanged,TResult? Function( String query)?  toQueryChanged,TResult? Function()?  fromLocationCleared,TResult? Function()?  toLocationCleared,TResult? Function( OrderLocationEntity location)?  fromSuggestionSelected,TResult? Function( OrderLocationEntity location)?  toSuggestionSelected,TResult? Function()?  confirmOrderPressed,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _GetAllRequested() when getAllRequested != null:
return getAllRequested();case _OrderNowPressed() when orderNowPressed != null:
return orderNowPressed();case _CollapseRequested() when collapseRequested != null:
return collapseRequested();case _MapPickCancelled() when mapPickCancelled != null:
return mapPickCancelled();case _SetOnMapPressed() when setOnMapPressed != null:
return setOnMapPressed(_that.target);case _MapCameraTargetUpdated() when mapCameraTargetUpdated != null:
return mapCameraTargetUpdated(_that.latitude,_that.longitude,_that.zoom);case _ConfirmMapPointPressed() when confirmMapPointPressed != null:
return confirmMapPointPressed();case _FromQueryChanged() when fromQueryChanged != null:
return fromQueryChanged(_that.query);case _ToQueryChanged() when toQueryChanged != null:
return toQueryChanged(_that.query);case _FromLocationCleared() when fromLocationCleared != null:
return fromLocationCleared();case _ToLocationCleared() when toLocationCleared != null:
return toLocationCleared();case _FromSuggestionSelected() when fromSuggestionSelected != null:
return fromSuggestionSelected(_that.location);case _ToSuggestionSelected() when toSuggestionSelected != null:
return toSuggestionSelected(_that.location);case _ConfirmOrderPressed() when confirmOrderPressed != null:
return confirmOrderPressed();case _:
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


class _SetOnMapPressed implements OrderEvent {
  const _SetOnMapPressed(this.target);
  

 final  OrderLocationTarget target;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetOnMapPressedCopyWith<_SetOnMapPressed> get copyWith => __$SetOnMapPressedCopyWithImpl<_SetOnMapPressed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetOnMapPressed&&(identical(other.target, target) || other.target == target));
}


@override
int get hashCode => Object.hash(runtimeType,target);

@override
String toString() {
  return 'OrderEvent.setOnMapPressed(target: $target)';
}


}

/// @nodoc
abstract mixin class _$SetOnMapPressedCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$SetOnMapPressedCopyWith(_SetOnMapPressed value, $Res Function(_SetOnMapPressed) _then) = __$SetOnMapPressedCopyWithImpl;
@useResult
$Res call({
 OrderLocationTarget target
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
@pragma('vm:prefer-inline') $Res call({Object? target = null,}) {
  return _then(_SetOnMapPressed(
null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as OrderLocationTarget,
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


class _FromQueryChanged implements OrderEvent {
  const _FromQueryChanged(this.query);
  

 final  String query;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FromQueryChangedCopyWith<_FromQueryChanged> get copyWith => __$FromQueryChangedCopyWithImpl<_FromQueryChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FromQueryChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'OrderEvent.fromQueryChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class _$FromQueryChangedCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$FromQueryChangedCopyWith(_FromQueryChanged value, $Res Function(_FromQueryChanged) _then) = __$FromQueryChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$FromQueryChangedCopyWithImpl<$Res>
    implements _$FromQueryChangedCopyWith<$Res> {
  __$FromQueryChangedCopyWithImpl(this._self, this._then);

  final _FromQueryChanged _self;
  final $Res Function(_FromQueryChanged) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_FromQueryChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ToQueryChanged implements OrderEvent {
  const _ToQueryChanged(this.query);
  

 final  String query;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToQueryChangedCopyWith<_ToQueryChanged> get copyWith => __$ToQueryChangedCopyWithImpl<_ToQueryChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToQueryChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'OrderEvent.toQueryChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class _$ToQueryChangedCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$ToQueryChangedCopyWith(_ToQueryChanged value, $Res Function(_ToQueryChanged) _then) = __$ToQueryChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$ToQueryChangedCopyWithImpl<$Res>
    implements _$ToQueryChangedCopyWith<$Res> {
  __$ToQueryChangedCopyWithImpl(this._self, this._then);

  final _ToQueryChanged _self;
  final $Res Function(_ToQueryChanged) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_ToQueryChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _FromLocationCleared implements OrderEvent {
  const _FromLocationCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FromLocationCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent.fromLocationCleared()';
}


}




/// @nodoc


class _ToLocationCleared implements OrderEvent {
  const _ToLocationCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToLocationCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent.toLocationCleared()';
}


}




/// @nodoc


class _FromSuggestionSelected implements OrderEvent {
  const _FromSuggestionSelected(this.location);
  

 final  OrderLocationEntity location;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FromSuggestionSelectedCopyWith<_FromSuggestionSelected> get copyWith => __$FromSuggestionSelectedCopyWithImpl<_FromSuggestionSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FromSuggestionSelected&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,location);

@override
String toString() {
  return 'OrderEvent.fromSuggestionSelected(location: $location)';
}


}

/// @nodoc
abstract mixin class _$FromSuggestionSelectedCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$FromSuggestionSelectedCopyWith(_FromSuggestionSelected value, $Res Function(_FromSuggestionSelected) _then) = __$FromSuggestionSelectedCopyWithImpl;
@useResult
$Res call({
 OrderLocationEntity location
});




}
/// @nodoc
class __$FromSuggestionSelectedCopyWithImpl<$Res>
    implements _$FromSuggestionSelectedCopyWith<$Res> {
  __$FromSuggestionSelectedCopyWithImpl(this._self, this._then);

  final _FromSuggestionSelected _self;
  final $Res Function(_FromSuggestionSelected) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? location = null,}) {
  return _then(_FromSuggestionSelected(
null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as OrderLocationEntity,
  ));
}


}

/// @nodoc


class _ToSuggestionSelected implements OrderEvent {
  const _ToSuggestionSelected(this.location);
  

 final  OrderLocationEntity location;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToSuggestionSelectedCopyWith<_ToSuggestionSelected> get copyWith => __$ToSuggestionSelectedCopyWithImpl<_ToSuggestionSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToSuggestionSelected&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,location);

@override
String toString() {
  return 'OrderEvent.toSuggestionSelected(location: $location)';
}


}

/// @nodoc
abstract mixin class _$ToSuggestionSelectedCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$ToSuggestionSelectedCopyWith(_ToSuggestionSelected value, $Res Function(_ToSuggestionSelected) _then) = __$ToSuggestionSelectedCopyWithImpl;
@useResult
$Res call({
 OrderLocationEntity location
});




}
/// @nodoc
class __$ToSuggestionSelectedCopyWithImpl<$Res>
    implements _$ToSuggestionSelectedCopyWith<$Res> {
  __$ToSuggestionSelectedCopyWithImpl(this._self, this._then);

  final _ToSuggestionSelected _self;
  final $Res Function(_ToSuggestionSelected) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? location = null,}) {
  return _then(_ToSuggestionSelected(
null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as OrderLocationEntity,
  ));
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
mixin _$OrderState {

 BlocStatus<List<OrderEntity>> get getAllState; OrderSheetMode get sheetMode; OrderLocationTarget get mapPickingTarget; double get mapCameraLatitude; double get mapCameraLongitude; double get mapCameraZoom; BlocStatus<OrderLocationEntity> get fromLocationState; BlocStatus<OrderLocationEntity> get toLocationState; BlocStatus<List<OrderLocationEntity>> get fromSuggestionsState; BlocStatus<List<OrderLocationEntity>> get toSuggestionsState;
/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderStateCopyWith<OrderState> get copyWith => _$OrderStateCopyWithImpl<OrderState>(this as OrderState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderState&&(identical(other.getAllState, getAllState) || other.getAllState == getAllState)&&(identical(other.sheetMode, sheetMode) || other.sheetMode == sheetMode)&&(identical(other.mapPickingTarget, mapPickingTarget) || other.mapPickingTarget == mapPickingTarget)&&(identical(other.mapCameraLatitude, mapCameraLatitude) || other.mapCameraLatitude == mapCameraLatitude)&&(identical(other.mapCameraLongitude, mapCameraLongitude) || other.mapCameraLongitude == mapCameraLongitude)&&(identical(other.mapCameraZoom, mapCameraZoom) || other.mapCameraZoom == mapCameraZoom)&&(identical(other.fromLocationState, fromLocationState) || other.fromLocationState == fromLocationState)&&(identical(other.toLocationState, toLocationState) || other.toLocationState == toLocationState)&&(identical(other.fromSuggestionsState, fromSuggestionsState) || other.fromSuggestionsState == fromSuggestionsState)&&(identical(other.toSuggestionsState, toSuggestionsState) || other.toSuggestionsState == toSuggestionsState));
}


@override
int get hashCode => Object.hash(runtimeType,getAllState,sheetMode,mapPickingTarget,mapCameraLatitude,mapCameraLongitude,mapCameraZoom,fromLocationState,toLocationState,fromSuggestionsState,toSuggestionsState);

@override
String toString() {
  return 'OrderState(getAllState: $getAllState, sheetMode: $sheetMode, mapPickingTarget: $mapPickingTarget, mapCameraLatitude: $mapCameraLatitude, mapCameraLongitude: $mapCameraLongitude, mapCameraZoom: $mapCameraZoom, fromLocationState: $fromLocationState, toLocationState: $toLocationState, fromSuggestionsState: $fromSuggestionsState, toSuggestionsState: $toSuggestionsState)';
}


}

/// @nodoc
abstract mixin class $OrderStateCopyWith<$Res>  {
  factory $OrderStateCopyWith(OrderState value, $Res Function(OrderState) _then) = _$OrderStateCopyWithImpl;
@useResult
$Res call({
 BlocStatus<List<OrderEntity>> getAllState, OrderSheetMode sheetMode, OrderLocationTarget mapPickingTarget, double mapCameraLatitude, double mapCameraLongitude, double mapCameraZoom, BlocStatus<OrderLocationEntity> fromLocationState, BlocStatus<OrderLocationEntity> toLocationState, BlocStatus<List<OrderLocationEntity>> fromSuggestionsState, BlocStatus<List<OrderLocationEntity>> toSuggestionsState
});


$BlocStatusCopyWith<List<OrderEntity>, $Res> get getAllState;$BlocStatusCopyWith<OrderLocationEntity, $Res> get fromLocationState;$BlocStatusCopyWith<OrderLocationEntity, $Res> get toLocationState;$BlocStatusCopyWith<List<OrderLocationEntity>, $Res> get fromSuggestionsState;$BlocStatusCopyWith<List<OrderLocationEntity>, $Res> get toSuggestionsState;

}
/// @nodoc
class _$OrderStateCopyWithImpl<$Res>
    implements $OrderStateCopyWith<$Res> {
  _$OrderStateCopyWithImpl(this._self, this._then);

  final OrderState _self;
  final $Res Function(OrderState) _then;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? getAllState = null,Object? sheetMode = null,Object? mapPickingTarget = null,Object? mapCameraLatitude = null,Object? mapCameraLongitude = null,Object? mapCameraZoom = null,Object? fromLocationState = null,Object? toLocationState = null,Object? fromSuggestionsState = null,Object? toSuggestionsState = null,}) {
  return _then(_self.copyWith(
getAllState: null == getAllState ? _self.getAllState : getAllState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<OrderEntity>>,sheetMode: null == sheetMode ? _self.sheetMode : sheetMode // ignore: cast_nullable_to_non_nullable
as OrderSheetMode,mapPickingTarget: null == mapPickingTarget ? _self.mapPickingTarget : mapPickingTarget // ignore: cast_nullable_to_non_nullable
as OrderLocationTarget,mapCameraLatitude: null == mapCameraLatitude ? _self.mapCameraLatitude : mapCameraLatitude // ignore: cast_nullable_to_non_nullable
as double,mapCameraLongitude: null == mapCameraLongitude ? _self.mapCameraLongitude : mapCameraLongitude // ignore: cast_nullable_to_non_nullable
as double,mapCameraZoom: null == mapCameraZoom ? _self.mapCameraZoom : mapCameraZoom // ignore: cast_nullable_to_non_nullable
as double,fromLocationState: null == fromLocationState ? _self.fromLocationState : fromLocationState // ignore: cast_nullable_to_non_nullable
as BlocStatus<OrderLocationEntity>,toLocationState: null == toLocationState ? _self.toLocationState : toLocationState // ignore: cast_nullable_to_non_nullable
as BlocStatus<OrderLocationEntity>,fromSuggestionsState: null == fromSuggestionsState ? _self.fromSuggestionsState : fromSuggestionsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<OrderLocationEntity>>,toSuggestionsState: null == toSuggestionsState ? _self.toSuggestionsState : toSuggestionsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<OrderLocationEntity>>,
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
$BlocStatusCopyWith<OrderLocationEntity, $Res> get fromLocationState {
  
  return $BlocStatusCopyWith<OrderLocationEntity, $Res>(_self.fromLocationState, (value) {
    return _then(_self.copyWith(fromLocationState: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<OrderLocationEntity, $Res> get toLocationState {
  
  return $BlocStatusCopyWith<OrderLocationEntity, $Res>(_self.toLocationState, (value) {
    return _then(_self.copyWith(toLocationState: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<OrderLocationEntity>, $Res> get fromSuggestionsState {
  
  return $BlocStatusCopyWith<List<OrderLocationEntity>, $Res>(_self.fromSuggestionsState, (value) {
    return _then(_self.copyWith(fromSuggestionsState: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<OrderLocationEntity>, $Res> get toSuggestionsState {
  
  return $BlocStatusCopyWith<List<OrderLocationEntity>, $Res>(_self.toSuggestionsState, (value) {
    return _then(_self.copyWith(toSuggestionsState: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlocStatus<List<OrderEntity>> getAllState,  OrderSheetMode sheetMode,  OrderLocationTarget mapPickingTarget,  double mapCameraLatitude,  double mapCameraLongitude,  double mapCameraZoom,  BlocStatus<OrderLocationEntity> fromLocationState,  BlocStatus<OrderLocationEntity> toLocationState,  BlocStatus<List<OrderLocationEntity>> fromSuggestionsState,  BlocStatus<List<OrderLocationEntity>> toSuggestionsState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderState() when $default != null:
return $default(_that.getAllState,_that.sheetMode,_that.mapPickingTarget,_that.mapCameraLatitude,_that.mapCameraLongitude,_that.mapCameraZoom,_that.fromLocationState,_that.toLocationState,_that.fromSuggestionsState,_that.toSuggestionsState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlocStatus<List<OrderEntity>> getAllState,  OrderSheetMode sheetMode,  OrderLocationTarget mapPickingTarget,  double mapCameraLatitude,  double mapCameraLongitude,  double mapCameraZoom,  BlocStatus<OrderLocationEntity> fromLocationState,  BlocStatus<OrderLocationEntity> toLocationState,  BlocStatus<List<OrderLocationEntity>> fromSuggestionsState,  BlocStatus<List<OrderLocationEntity>> toSuggestionsState)  $default,) {final _that = this;
switch (_that) {
case _OrderState():
return $default(_that.getAllState,_that.sheetMode,_that.mapPickingTarget,_that.mapCameraLatitude,_that.mapCameraLongitude,_that.mapCameraZoom,_that.fromLocationState,_that.toLocationState,_that.fromSuggestionsState,_that.toSuggestionsState);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlocStatus<List<OrderEntity>> getAllState,  OrderSheetMode sheetMode,  OrderLocationTarget mapPickingTarget,  double mapCameraLatitude,  double mapCameraLongitude,  double mapCameraZoom,  BlocStatus<OrderLocationEntity> fromLocationState,  BlocStatus<OrderLocationEntity> toLocationState,  BlocStatus<List<OrderLocationEntity>> fromSuggestionsState,  BlocStatus<List<OrderLocationEntity>> toSuggestionsState)?  $default,) {final _that = this;
switch (_that) {
case _OrderState() when $default != null:
return $default(_that.getAllState,_that.sheetMode,_that.mapPickingTarget,_that.mapCameraLatitude,_that.mapCameraLongitude,_that.mapCameraZoom,_that.fromLocationState,_that.toLocationState,_that.fromSuggestionsState,_that.toSuggestionsState);case _:
  return null;

}
}

}

/// @nodoc


class _OrderState implements OrderState {
  const _OrderState({this.getAllState = const BlocStatus<List<OrderEntity>>.initial(), this.sheetMode = OrderSheetMode.collapsed, this.mapPickingTarget = OrderLocationTarget.from, this.mapCameraLatitude = MapConfig.defaultLat, this.mapCameraLongitude = MapConfig.defaultLng, this.mapCameraZoom = MapConfig.initialZoom, this.fromLocationState = const BlocStatus<OrderLocationEntity>.initial(), this.toLocationState = const BlocStatus<OrderLocationEntity>.initial(), this.fromSuggestionsState = const BlocStatus<List<OrderLocationEntity>>.initial(), this.toSuggestionsState = const BlocStatus<List<OrderLocationEntity>>.initial()});
  

@override@JsonKey() final  BlocStatus<List<OrderEntity>> getAllState;
@override@JsonKey() final  OrderSheetMode sheetMode;
@override@JsonKey() final  OrderLocationTarget mapPickingTarget;
@override@JsonKey() final  double mapCameraLatitude;
@override@JsonKey() final  double mapCameraLongitude;
@override@JsonKey() final  double mapCameraZoom;
@override@JsonKey() final  BlocStatus<OrderLocationEntity> fromLocationState;
@override@JsonKey() final  BlocStatus<OrderLocationEntity> toLocationState;
@override@JsonKey() final  BlocStatus<List<OrderLocationEntity>> fromSuggestionsState;
@override@JsonKey() final  BlocStatus<List<OrderLocationEntity>> toSuggestionsState;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderStateCopyWith<_OrderState> get copyWith => __$OrderStateCopyWithImpl<_OrderState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderState&&(identical(other.getAllState, getAllState) || other.getAllState == getAllState)&&(identical(other.sheetMode, sheetMode) || other.sheetMode == sheetMode)&&(identical(other.mapPickingTarget, mapPickingTarget) || other.mapPickingTarget == mapPickingTarget)&&(identical(other.mapCameraLatitude, mapCameraLatitude) || other.mapCameraLatitude == mapCameraLatitude)&&(identical(other.mapCameraLongitude, mapCameraLongitude) || other.mapCameraLongitude == mapCameraLongitude)&&(identical(other.mapCameraZoom, mapCameraZoom) || other.mapCameraZoom == mapCameraZoom)&&(identical(other.fromLocationState, fromLocationState) || other.fromLocationState == fromLocationState)&&(identical(other.toLocationState, toLocationState) || other.toLocationState == toLocationState)&&(identical(other.fromSuggestionsState, fromSuggestionsState) || other.fromSuggestionsState == fromSuggestionsState)&&(identical(other.toSuggestionsState, toSuggestionsState) || other.toSuggestionsState == toSuggestionsState));
}


@override
int get hashCode => Object.hash(runtimeType,getAllState,sheetMode,mapPickingTarget,mapCameraLatitude,mapCameraLongitude,mapCameraZoom,fromLocationState,toLocationState,fromSuggestionsState,toSuggestionsState);

@override
String toString() {
  return 'OrderState(getAllState: $getAllState, sheetMode: $sheetMode, mapPickingTarget: $mapPickingTarget, mapCameraLatitude: $mapCameraLatitude, mapCameraLongitude: $mapCameraLongitude, mapCameraZoom: $mapCameraZoom, fromLocationState: $fromLocationState, toLocationState: $toLocationState, fromSuggestionsState: $fromSuggestionsState, toSuggestionsState: $toSuggestionsState)';
}


}

/// @nodoc
abstract mixin class _$OrderStateCopyWith<$Res> implements $OrderStateCopyWith<$Res> {
  factory _$OrderStateCopyWith(_OrderState value, $Res Function(_OrderState) _then) = __$OrderStateCopyWithImpl;
@override @useResult
$Res call({
 BlocStatus<List<OrderEntity>> getAllState, OrderSheetMode sheetMode, OrderLocationTarget mapPickingTarget, double mapCameraLatitude, double mapCameraLongitude, double mapCameraZoom, BlocStatus<OrderLocationEntity> fromLocationState, BlocStatus<OrderLocationEntity> toLocationState, BlocStatus<List<OrderLocationEntity>> fromSuggestionsState, BlocStatus<List<OrderLocationEntity>> toSuggestionsState
});


@override $BlocStatusCopyWith<List<OrderEntity>, $Res> get getAllState;@override $BlocStatusCopyWith<OrderLocationEntity, $Res> get fromLocationState;@override $BlocStatusCopyWith<OrderLocationEntity, $Res> get toLocationState;@override $BlocStatusCopyWith<List<OrderLocationEntity>, $Res> get fromSuggestionsState;@override $BlocStatusCopyWith<List<OrderLocationEntity>, $Res> get toSuggestionsState;

}
/// @nodoc
class __$OrderStateCopyWithImpl<$Res>
    implements _$OrderStateCopyWith<$Res> {
  __$OrderStateCopyWithImpl(this._self, this._then);

  final _OrderState _self;
  final $Res Function(_OrderState) _then;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? getAllState = null,Object? sheetMode = null,Object? mapPickingTarget = null,Object? mapCameraLatitude = null,Object? mapCameraLongitude = null,Object? mapCameraZoom = null,Object? fromLocationState = null,Object? toLocationState = null,Object? fromSuggestionsState = null,Object? toSuggestionsState = null,}) {
  return _then(_OrderState(
getAllState: null == getAllState ? _self.getAllState : getAllState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<OrderEntity>>,sheetMode: null == sheetMode ? _self.sheetMode : sheetMode // ignore: cast_nullable_to_non_nullable
as OrderSheetMode,mapPickingTarget: null == mapPickingTarget ? _self.mapPickingTarget : mapPickingTarget // ignore: cast_nullable_to_non_nullable
as OrderLocationTarget,mapCameraLatitude: null == mapCameraLatitude ? _self.mapCameraLatitude : mapCameraLatitude // ignore: cast_nullable_to_non_nullable
as double,mapCameraLongitude: null == mapCameraLongitude ? _self.mapCameraLongitude : mapCameraLongitude // ignore: cast_nullable_to_non_nullable
as double,mapCameraZoom: null == mapCameraZoom ? _self.mapCameraZoom : mapCameraZoom // ignore: cast_nullable_to_non_nullable
as double,fromLocationState: null == fromLocationState ? _self.fromLocationState : fromLocationState // ignore: cast_nullable_to_non_nullable
as BlocStatus<OrderLocationEntity>,toLocationState: null == toLocationState ? _self.toLocationState : toLocationState // ignore: cast_nullable_to_non_nullable
as BlocStatus<OrderLocationEntity>,fromSuggestionsState: null == fromSuggestionsState ? _self.fromSuggestionsState : fromSuggestionsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<OrderLocationEntity>>,toSuggestionsState: null == toSuggestionsState ? _self.toSuggestionsState : toSuggestionsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<OrderLocationEntity>>,
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
$BlocStatusCopyWith<OrderLocationEntity, $Res> get fromLocationState {
  
  return $BlocStatusCopyWith<OrderLocationEntity, $Res>(_self.fromLocationState, (value) {
    return _then(_self.copyWith(fromLocationState: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<OrderLocationEntity, $Res> get toLocationState {
  
  return $BlocStatusCopyWith<OrderLocationEntity, $Res>(_self.toLocationState, (value) {
    return _then(_self.copyWith(toLocationState: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<OrderLocationEntity>, $Res> get fromSuggestionsState {
  
  return $BlocStatusCopyWith<List<OrderLocationEntity>, $Res>(_self.fromSuggestionsState, (value) {
    return _then(_self.copyWith(fromSuggestionsState: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<OrderLocationEntity>, $Res> get toSuggestionsState {
  
  return $BlocStatusCopyWith<List<OrderLocationEntity>, $Res>(_self.toSuggestionsState, (value) {
    return _then(_self.copyWith(toSuggestionsState: value));
  });
}
}

// dart format on
