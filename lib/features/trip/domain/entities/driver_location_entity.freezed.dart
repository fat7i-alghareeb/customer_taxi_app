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

 double get latitude; double get longitude; double? get bearing;// Live driver-arrival estimate to the pickup (only while heading there).
 int? get etaToPickupSeconds; int? get distanceToPickupMeters;// Encoded road-following route from the driver to the pickup.
 String? get routeToPickupPolyline;
/// Create a copy of DriverLocationEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriverLocationEntityCopyWith<DriverLocationEntity> get copyWith => _$DriverLocationEntityCopyWithImpl<DriverLocationEntity>(this as DriverLocationEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverLocationEntity&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.bearing, bearing) || other.bearing == bearing)&&(identical(other.etaToPickupSeconds, etaToPickupSeconds) || other.etaToPickupSeconds == etaToPickupSeconds)&&(identical(other.distanceToPickupMeters, distanceToPickupMeters) || other.distanceToPickupMeters == distanceToPickupMeters)&&(identical(other.routeToPickupPolyline, routeToPickupPolyline) || other.routeToPickupPolyline == routeToPickupPolyline));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,bearing,etaToPickupSeconds,distanceToPickupMeters,routeToPickupPolyline);

@override
String toString() {
  return 'DriverLocationEntity(latitude: $latitude, longitude: $longitude, bearing: $bearing, etaToPickupSeconds: $etaToPickupSeconds, distanceToPickupMeters: $distanceToPickupMeters, routeToPickupPolyline: $routeToPickupPolyline)';
}


}

/// @nodoc
abstract mixin class $DriverLocationEntityCopyWith<$Res>  {
  factory $DriverLocationEntityCopyWith(DriverLocationEntity value, $Res Function(DriverLocationEntity) _then) = _$DriverLocationEntityCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, double? bearing, int? etaToPickupSeconds, int? distanceToPickupMeters, String? routeToPickupPolyline
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
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? bearing = freezed,Object? etaToPickupSeconds = freezed,Object? distanceToPickupMeters = freezed,Object? routeToPickupPolyline = freezed,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,bearing: freezed == bearing ? _self.bearing : bearing // ignore: cast_nullable_to_non_nullable
as double?,etaToPickupSeconds: freezed == etaToPickupSeconds ? _self.etaToPickupSeconds : etaToPickupSeconds // ignore: cast_nullable_to_non_nullable
as int?,distanceToPickupMeters: freezed == distanceToPickupMeters ? _self.distanceToPickupMeters : distanceToPickupMeters // ignore: cast_nullable_to_non_nullable
as int?,routeToPickupPolyline: freezed == routeToPickupPolyline ? _self.routeToPickupPolyline : routeToPickupPolyline // ignore: cast_nullable_to_non_nullable
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude,  double? bearing,  int? etaToPickupSeconds,  int? distanceToPickupMeters,  String? routeToPickupPolyline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriverLocationEntity() when $default != null:
return $default(_that.latitude,_that.longitude,_that.bearing,_that.etaToPickupSeconds,_that.distanceToPickupMeters,_that.routeToPickupPolyline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude,  double? bearing,  int? etaToPickupSeconds,  int? distanceToPickupMeters,  String? routeToPickupPolyline)  $default,) {final _that = this;
switch (_that) {
case _DriverLocationEntity():
return $default(_that.latitude,_that.longitude,_that.bearing,_that.etaToPickupSeconds,_that.distanceToPickupMeters,_that.routeToPickupPolyline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude,  double? bearing,  int? etaToPickupSeconds,  int? distanceToPickupMeters,  String? routeToPickupPolyline)?  $default,) {final _that = this;
switch (_that) {
case _DriverLocationEntity() when $default != null:
return $default(_that.latitude,_that.longitude,_that.bearing,_that.etaToPickupSeconds,_that.distanceToPickupMeters,_that.routeToPickupPolyline);case _:
  return null;

}
}

}

/// @nodoc


class _DriverLocationEntity implements DriverLocationEntity {
  const _DriverLocationEntity({required this.latitude, required this.longitude, this.bearing, this.etaToPickupSeconds, this.distanceToPickupMeters, this.routeToPickupPolyline});
  

@override final  double latitude;
@override final  double longitude;
@override final  double? bearing;
// Live driver-arrival estimate to the pickup (only while heading there).
@override final  int? etaToPickupSeconds;
@override final  int? distanceToPickupMeters;
// Encoded road-following route from the driver to the pickup.
@override final  String? routeToPickupPolyline;

/// Create a copy of DriverLocationEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverLocationEntityCopyWith<_DriverLocationEntity> get copyWith => __$DriverLocationEntityCopyWithImpl<_DriverLocationEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverLocationEntity&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.bearing, bearing) || other.bearing == bearing)&&(identical(other.etaToPickupSeconds, etaToPickupSeconds) || other.etaToPickupSeconds == etaToPickupSeconds)&&(identical(other.distanceToPickupMeters, distanceToPickupMeters) || other.distanceToPickupMeters == distanceToPickupMeters)&&(identical(other.routeToPickupPolyline, routeToPickupPolyline) || other.routeToPickupPolyline == routeToPickupPolyline));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,bearing,etaToPickupSeconds,distanceToPickupMeters,routeToPickupPolyline);

@override
String toString() {
  return 'DriverLocationEntity(latitude: $latitude, longitude: $longitude, bearing: $bearing, etaToPickupSeconds: $etaToPickupSeconds, distanceToPickupMeters: $distanceToPickupMeters, routeToPickupPolyline: $routeToPickupPolyline)';
}


}

/// @nodoc
abstract mixin class _$DriverLocationEntityCopyWith<$Res> implements $DriverLocationEntityCopyWith<$Res> {
  factory _$DriverLocationEntityCopyWith(_DriverLocationEntity value, $Res Function(_DriverLocationEntity) _then) = __$DriverLocationEntityCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude, double? bearing, int? etaToPickupSeconds, int? distanceToPickupMeters, String? routeToPickupPolyline
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
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? bearing = freezed,Object? etaToPickupSeconds = freezed,Object? distanceToPickupMeters = freezed,Object? routeToPickupPolyline = freezed,}) {
  return _then(_DriverLocationEntity(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,bearing: freezed == bearing ? _self.bearing : bearing // ignore: cast_nullable_to_non_nullable
as double?,etaToPickupSeconds: freezed == etaToPickupSeconds ? _self.etaToPickupSeconds : etaToPickupSeconds // ignore: cast_nullable_to_non_nullable
as int?,distanceToPickupMeters: freezed == distanceToPickupMeters ? _self.distanceToPickupMeters : distanceToPickupMeters // ignore: cast_nullable_to_non_nullable
as int?,routeToPickupPolyline: freezed == routeToPickupPolyline ? _self.routeToPickupPolyline : routeToPickupPolyline // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
