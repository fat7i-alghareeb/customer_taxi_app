// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_map_slice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderMapSlice {

 double get latitude; double get longitude; double get zoom;
/// Create a copy of OrderMapSlice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderMapSliceCopyWith<OrderMapSlice> get copyWith => _$OrderMapSliceCopyWithImpl<OrderMapSlice>(this as OrderMapSlice, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderMapSlice&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.zoom, zoom) || other.zoom == zoom));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,zoom);

@override
String toString() {
  return 'OrderMapSlice(latitude: $latitude, longitude: $longitude, zoom: $zoom)';
}


}

/// @nodoc
abstract mixin class $OrderMapSliceCopyWith<$Res>  {
  factory $OrderMapSliceCopyWith(OrderMapSlice value, $Res Function(OrderMapSlice) _then) = _$OrderMapSliceCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, double zoom
});




}
/// @nodoc
class _$OrderMapSliceCopyWithImpl<$Res>
    implements $OrderMapSliceCopyWith<$Res> {
  _$OrderMapSliceCopyWithImpl(this._self, this._then);

  final OrderMapSlice _self;
  final $Res Function(OrderMapSlice) _then;

/// Create a copy of OrderMapSlice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? zoom = null,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,zoom: null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderMapSlice].
extension OrderMapSlicePatterns on OrderMapSlice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderMapSlice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderMapSlice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderMapSlice value)  $default,){
final _that = this;
switch (_that) {
case _OrderMapSlice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderMapSlice value)?  $default,){
final _that = this;
switch (_that) {
case _OrderMapSlice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude,  double zoom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderMapSlice() when $default != null:
return $default(_that.latitude,_that.longitude,_that.zoom);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude,  double zoom)  $default,) {final _that = this;
switch (_that) {
case _OrderMapSlice():
return $default(_that.latitude,_that.longitude,_that.zoom);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude,  double zoom)?  $default,) {final _that = this;
switch (_that) {
case _OrderMapSlice() when $default != null:
return $default(_that.latitude,_that.longitude,_that.zoom);case _:
  return null;

}
}

}

/// @nodoc


class _OrderMapSlice implements OrderMapSlice {
  const _OrderMapSlice({this.latitude = MapConfig.defaultLat, this.longitude = MapConfig.defaultLng, this.zoom = MapConfig.initialZoom});
  

@override@JsonKey() final  double latitude;
@override@JsonKey() final  double longitude;
@override@JsonKey() final  double zoom;

/// Create a copy of OrderMapSlice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderMapSliceCopyWith<_OrderMapSlice> get copyWith => __$OrderMapSliceCopyWithImpl<_OrderMapSlice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderMapSlice&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.zoom, zoom) || other.zoom == zoom));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,zoom);

@override
String toString() {
  return 'OrderMapSlice(latitude: $latitude, longitude: $longitude, zoom: $zoom)';
}


}

/// @nodoc
abstract mixin class _$OrderMapSliceCopyWith<$Res> implements $OrderMapSliceCopyWith<$Res> {
  factory _$OrderMapSliceCopyWith(_OrderMapSlice value, $Res Function(_OrderMapSlice) _then) = __$OrderMapSliceCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude, double zoom
});




}
/// @nodoc
class __$OrderMapSliceCopyWithImpl<$Res>
    implements _$OrderMapSliceCopyWith<$Res> {
  __$OrderMapSliceCopyWithImpl(this._self, this._then);

  final _OrderMapSlice _self;
  final $Res Function(_OrderMapSlice) _then;

/// Create a copy of OrderMapSlice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? zoom = null,}) {
  return _then(_OrderMapSlice(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,zoom: null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
