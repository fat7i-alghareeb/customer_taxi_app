// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_trip_stop_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderTripStopModel {

 double get latitude; double get longitude;
/// Create a copy of OrderTripStopModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderTripStopModelCopyWith<OrderTripStopModel> get copyWith => _$OrderTripStopModelCopyWithImpl<OrderTripStopModel>(this as OrderTripStopModel, _$identity);

  /// Serializes this OrderTripStopModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderTripStopModel&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'OrderTripStopModel(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $OrderTripStopModelCopyWith<$Res>  {
  factory $OrderTripStopModelCopyWith(OrderTripStopModel value, $Res Function(OrderTripStopModel) _then) = _$OrderTripStopModelCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude
});




}
/// @nodoc
class _$OrderTripStopModelCopyWithImpl<$Res>
    implements $OrderTripStopModelCopyWith<$Res> {
  _$OrderTripStopModelCopyWithImpl(this._self, this._then);

  final OrderTripStopModel _self;
  final $Res Function(OrderTripStopModel) _then;

/// Create a copy of OrderTripStopModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderTripStopModel].
extension OrderTripStopModelPatterns on OrderTripStopModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderTripStopModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderTripStopModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderTripStopModel value)  $default,){
final _that = this;
switch (_that) {
case _OrderTripStopModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderTripStopModel value)?  $default,){
final _that = this;
switch (_that) {
case _OrderTripStopModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderTripStopModel() when $default != null:
return $default(_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude)  $default,) {final _that = this;
switch (_that) {
case _OrderTripStopModel():
return $default(_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude)?  $default,) {final _that = this;
switch (_that) {
case _OrderTripStopModel() when $default != null:
return $default(_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderTripStopModel implements OrderTripStopModel {
  const _OrderTripStopModel({required this.latitude, required this.longitude});
  factory _OrderTripStopModel.fromJson(Map<String, dynamic> json) => _$OrderTripStopModelFromJson(json);

@override final  double latitude;
@override final  double longitude;

/// Create a copy of OrderTripStopModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderTripStopModelCopyWith<_OrderTripStopModel> get copyWith => __$OrderTripStopModelCopyWithImpl<_OrderTripStopModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderTripStopModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderTripStopModel&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'OrderTripStopModel(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$OrderTripStopModelCopyWith<$Res> implements $OrderTripStopModelCopyWith<$Res> {
  factory _$OrderTripStopModelCopyWith(_OrderTripStopModel value, $Res Function(_OrderTripStopModel) _then) = __$OrderTripStopModelCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude
});




}
/// @nodoc
class __$OrderTripStopModelCopyWithImpl<$Res>
    implements _$OrderTripStopModelCopyWith<$Res> {
  __$OrderTripStopModelCopyWithImpl(this._self, this._then);

  final _OrderTripStopModel _self;
  final $Res Function(_OrderTripStopModel) _then;

/// Create a copy of OrderTripStopModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_OrderTripStopModel(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
