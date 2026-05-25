// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_location_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DriverLocationEntity {

 double get latitude; double get longitude; double? get bearing;
/// Create a copy of DriverLocationEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriverLocationEntityCopyWith<DriverLocationEntity> get copyWith => _$DriverLocationEntityCopyWithImpl<DriverLocationEntity>(this as DriverLocationEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverLocationEntity&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.bearing, bearing) || other.bearing == bearing));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,bearing);

@override
String toString() {
  return 'DriverLocationEntity(latitude: $latitude, longitude: $longitude, bearing: $bearing)';
}


}

/// @nodoc
abstract mixin class $DriverLocationEntityCopyWith<$Res>  {
  factory $DriverLocationEntityCopyWith(DriverLocationEntity value, $Res Function(DriverLocationEntity) _then) = _$DriverLocationEntityCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, double? bearing
});




}
/// @nodoc
class _$DriverLocationEntityCopyWithImpl<$Res>
    implements $DriverLocationEntityCopyWith<$Res> {
  _$DriverLocationEntityCopyWithImpl(this._self, this._then);

  final DriverLocationEntity _self;
  final $Res Function(DriverLocationEntity) _then;

/// Create a copy of DriverLocationEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? bearing = freezed,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,bearing: freezed == bearing ? _self.bearing : bearing // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [DriverLocationEntity].
extension DriverLocationEntityPatterns on DriverLocationEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriverLocationEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriverLocationEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriverLocationEntity value)  $default,){
final _that = this;
switch (_that) {
case _DriverLocationEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriverLocationEntity value)?  $default,){
final _that = this;
switch (_that) {
case _DriverLocationEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude,  double? bearing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriverLocationEntity() when $default != null:
return $default(_that.latitude,_that.longitude,_that.bearing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude,  double? bearing)  $default,) {final _that = this;
switch (_that) {
case _DriverLocationEntity():
return $default(_that.latitude,_that.longitude,_that.bearing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude,  double? bearing)?  $default,) {final _that = this;
switch (_that) {
case _DriverLocationEntity() when $default != null:
return $default(_that.latitude,_that.longitude,_that.bearing);case _:
  return null;

}
}

}

/// @nodoc


class _DriverLocationEntity implements DriverLocationEntity {
  const _DriverLocationEntity({required this.latitude, required this.longitude, this.bearing});
  

@override final  double latitude;
@override final  double longitude;
@override final  double? bearing;

/// Create a copy of DriverLocationEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverLocationEntityCopyWith<_DriverLocationEntity> get copyWith => __$DriverLocationEntityCopyWithImpl<_DriverLocationEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverLocationEntity&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.bearing, bearing) || other.bearing == bearing));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,bearing);

@override
String toString() {
  return 'DriverLocationEntity(latitude: $latitude, longitude: $longitude, bearing: $bearing)';
}


}

/// @nodoc
abstract mixin class _$DriverLocationEntityCopyWith<$Res> implements $DriverLocationEntityCopyWith<$Res> {
  factory _$DriverLocationEntityCopyWith(_DriverLocationEntity value, $Res Function(_DriverLocationEntity) _then) = __$DriverLocationEntityCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude, double? bearing
});




}
/// @nodoc
class __$DriverLocationEntityCopyWithImpl<$Res>
    implements _$DriverLocationEntityCopyWith<$Res> {
  __$DriverLocationEntityCopyWithImpl(this._self, this._then);

  final _DriverLocationEntity _self;
  final $Res Function(_DriverLocationEntity) _then;

/// Create a copy of DriverLocationEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? bearing = freezed,}) {
  return _then(_DriverLocationEntity(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,bearing: freezed == bearing ? _self.bearing : bearing // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
