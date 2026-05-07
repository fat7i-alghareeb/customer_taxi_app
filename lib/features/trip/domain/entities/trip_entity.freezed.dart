// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TripEntity {

 String get id; String get referenceCode; TripStatus get status; double get quotedFare; String get currencyCode; DateTime get createdAtUtc; DateTime? get scheduledAtUtc; List<TripStopEntity> get stops;
/// Create a copy of TripEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripEntityCopyWith<TripEntity> get copyWith => _$TripEntityCopyWithImpl<TripEntity>(this as TripEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.referenceCode, referenceCode) || other.referenceCode == referenceCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.quotedFare, quotedFare) || other.quotedFare == quotedFare)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.scheduledAtUtc, scheduledAtUtc) || other.scheduledAtUtc == scheduledAtUtc)&&const DeepCollectionEquality().equals(other.stops, stops));
}


@override
int get hashCode => Object.hash(runtimeType,id,referenceCode,status,quotedFare,currencyCode,createdAtUtc,scheduledAtUtc,const DeepCollectionEquality().hash(stops));

@override
String toString() {
  return 'TripEntity(id: $id, referenceCode: $referenceCode, status: $status, quotedFare: $quotedFare, currencyCode: $currencyCode, createdAtUtc: $createdAtUtc, scheduledAtUtc: $scheduledAtUtc, stops: $stops)';
}


}

/// @nodoc
abstract mixin class $TripEntityCopyWith<$Res>  {
  factory $TripEntityCopyWith(TripEntity value, $Res Function(TripEntity) _then) = _$TripEntityCopyWithImpl;
@useResult
$Res call({
 String id, String referenceCode, TripStatus status, double quotedFare, String currencyCode, DateTime createdAtUtc, DateTime? scheduledAtUtc, List<TripStopEntity> stops
});




}
/// @nodoc
class _$TripEntityCopyWithImpl<$Res>
    implements $TripEntityCopyWith<$Res> {
  _$TripEntityCopyWithImpl(this._self, this._then);

  final TripEntity _self;
  final $Res Function(TripEntity) _then;

/// Create a copy of TripEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? referenceCode = null,Object? status = null,Object? quotedFare = null,Object? currencyCode = null,Object? createdAtUtc = null,Object? scheduledAtUtc = freezed,Object? stops = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referenceCode: null == referenceCode ? _self.referenceCode : referenceCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripStatus,quotedFare: null == quotedFare ? _self.quotedFare : quotedFare // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledAtUtc: freezed == scheduledAtUtc ? _self.scheduledAtUtc : scheduledAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,stops: null == stops ? _self.stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripStopEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [TripEntity].
extension TripEntityPatterns on TripEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripEntity value)  $default,){
final _that = this;
switch (_that) {
case _TripEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TripEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String referenceCode,  TripStatus status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopEntity> stops)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripEntity() when $default != null:
return $default(_that.id,_that.referenceCode,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String referenceCode,  TripStatus status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopEntity> stops)  $default,) {final _that = this;
switch (_that) {
case _TripEntity():
return $default(_that.id,_that.referenceCode,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String referenceCode,  TripStatus status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopEntity> stops)?  $default,) {final _that = this;
switch (_that) {
case _TripEntity() when $default != null:
return $default(_that.id,_that.referenceCode,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops);case _:
  return null;

}
}

}

/// @nodoc


class _TripEntity implements TripEntity {
  const _TripEntity({required this.id, required this.referenceCode, required this.status, required this.quotedFare, required this.currencyCode, required this.createdAtUtc, this.scheduledAtUtc, final  List<TripStopEntity> stops = const []}): _stops = stops;
  

@override final  String id;
@override final  String referenceCode;
@override final  TripStatus status;
@override final  double quotedFare;
@override final  String currencyCode;
@override final  DateTime createdAtUtc;
@override final  DateTime? scheduledAtUtc;
 final  List<TripStopEntity> _stops;
@override@JsonKey() List<TripStopEntity> get stops {
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stops);
}


/// Create a copy of TripEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripEntityCopyWith<_TripEntity> get copyWith => __$TripEntityCopyWithImpl<_TripEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.referenceCode, referenceCode) || other.referenceCode == referenceCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.quotedFare, quotedFare) || other.quotedFare == quotedFare)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.scheduledAtUtc, scheduledAtUtc) || other.scheduledAtUtc == scheduledAtUtc)&&const DeepCollectionEquality().equals(other._stops, _stops));
}


@override
int get hashCode => Object.hash(runtimeType,id,referenceCode,status,quotedFare,currencyCode,createdAtUtc,scheduledAtUtc,const DeepCollectionEquality().hash(_stops));

@override
String toString() {
  return 'TripEntity(id: $id, referenceCode: $referenceCode, status: $status, quotedFare: $quotedFare, currencyCode: $currencyCode, createdAtUtc: $createdAtUtc, scheduledAtUtc: $scheduledAtUtc, stops: $stops)';
}


}

/// @nodoc
abstract mixin class _$TripEntityCopyWith<$Res> implements $TripEntityCopyWith<$Res> {
  factory _$TripEntityCopyWith(_TripEntity value, $Res Function(_TripEntity) _then) = __$TripEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String referenceCode, TripStatus status, double quotedFare, String currencyCode, DateTime createdAtUtc, DateTime? scheduledAtUtc, List<TripStopEntity> stops
});




}
/// @nodoc
class __$TripEntityCopyWithImpl<$Res>
    implements _$TripEntityCopyWith<$Res> {
  __$TripEntityCopyWithImpl(this._self, this._then);

  final _TripEntity _self;
  final $Res Function(_TripEntity) _then;

/// Create a copy of TripEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? referenceCode = null,Object? status = null,Object? quotedFare = null,Object? currencyCode = null,Object? createdAtUtc = null,Object? scheduledAtUtc = freezed,Object? stops = null,}) {
  return _then(_TripEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referenceCode: null == referenceCode ? _self.referenceCode : referenceCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripStatus,quotedFare: null == quotedFare ? _self.quotedFare : quotedFare // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledAtUtc: freezed == scheduledAtUtc ? _self.scheduledAtUtc : scheduledAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,stops: null == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripStopEntity>,
  ));
}


}

/// @nodoc
mixin _$TripStopEntity {

 double get latitude; double get longitude;
/// Create a copy of TripStopEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripStopEntityCopyWith<TripStopEntity> get copyWith => _$TripStopEntityCopyWithImpl<TripStopEntity>(this as TripStopEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripStopEntity&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'TripStopEntity(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $TripStopEntityCopyWith<$Res>  {
  factory $TripStopEntityCopyWith(TripStopEntity value, $Res Function(TripStopEntity) _then) = _$TripStopEntityCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude
});




}
/// @nodoc
class _$TripStopEntityCopyWithImpl<$Res>
    implements $TripStopEntityCopyWith<$Res> {
  _$TripStopEntityCopyWithImpl(this._self, this._then);

  final TripStopEntity _self;
  final $Res Function(TripStopEntity) _then;

/// Create a copy of TripStopEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TripStopEntity].
extension TripStopEntityPatterns on TripStopEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripStopEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripStopEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripStopEntity value)  $default,){
final _that = this;
switch (_that) {
case _TripStopEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripStopEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TripStopEntity() when $default != null:
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
case _TripStopEntity() when $default != null:
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
case _TripStopEntity():
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
case _TripStopEntity() when $default != null:
return $default(_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc


class _TripStopEntity implements TripStopEntity {
  const _TripStopEntity({required this.latitude, required this.longitude});
  

@override final  double latitude;
@override final  double longitude;

/// Create a copy of TripStopEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripStopEntityCopyWith<_TripStopEntity> get copyWith => __$TripStopEntityCopyWithImpl<_TripStopEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripStopEntity&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'TripStopEntity(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$TripStopEntityCopyWith<$Res> implements $TripStopEntityCopyWith<$Res> {
  factory _$TripStopEntityCopyWith(_TripStopEntity value, $Res Function(_TripStopEntity) _then) = __$TripStopEntityCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude
});




}
/// @nodoc
class __$TripStopEntityCopyWithImpl<$Res>
    implements _$TripStopEntityCopyWith<$Res> {
  __$TripStopEntityCopyWithImpl(this._self, this._then);

  final _TripStopEntity _self;
  final $Res Function(_TripStopEntity) _then;

/// Create a copy of TripStopEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_TripStopEntity(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$TripSummaryEntity {

 String get id; String get referenceCode; TripStatus get status; double get quotedFare; String get currencyCode; DateTime get createdAtUtc; DateTime? get scheduledAtUtc; List<TripStopEntity> get stops;
/// Create a copy of TripSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripSummaryEntityCopyWith<TripSummaryEntity> get copyWith => _$TripSummaryEntityCopyWithImpl<TripSummaryEntity>(this as TripSummaryEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripSummaryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.referenceCode, referenceCode) || other.referenceCode == referenceCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.quotedFare, quotedFare) || other.quotedFare == quotedFare)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.scheduledAtUtc, scheduledAtUtc) || other.scheduledAtUtc == scheduledAtUtc)&&const DeepCollectionEquality().equals(other.stops, stops));
}


@override
int get hashCode => Object.hash(runtimeType,id,referenceCode,status,quotedFare,currencyCode,createdAtUtc,scheduledAtUtc,const DeepCollectionEquality().hash(stops));

@override
String toString() {
  return 'TripSummaryEntity(id: $id, referenceCode: $referenceCode, status: $status, quotedFare: $quotedFare, currencyCode: $currencyCode, createdAtUtc: $createdAtUtc, scheduledAtUtc: $scheduledAtUtc, stops: $stops)';
}


}

/// @nodoc
abstract mixin class $TripSummaryEntityCopyWith<$Res>  {
  factory $TripSummaryEntityCopyWith(TripSummaryEntity value, $Res Function(TripSummaryEntity) _then) = _$TripSummaryEntityCopyWithImpl;
@useResult
$Res call({
 String id, String referenceCode, TripStatus status, double quotedFare, String currencyCode, DateTime createdAtUtc, DateTime? scheduledAtUtc, List<TripStopEntity> stops
});




}
/// @nodoc
class _$TripSummaryEntityCopyWithImpl<$Res>
    implements $TripSummaryEntityCopyWith<$Res> {
  _$TripSummaryEntityCopyWithImpl(this._self, this._then);

  final TripSummaryEntity _self;
  final $Res Function(TripSummaryEntity) _then;

/// Create a copy of TripSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? referenceCode = null,Object? status = null,Object? quotedFare = null,Object? currencyCode = null,Object? createdAtUtc = null,Object? scheduledAtUtc = freezed,Object? stops = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referenceCode: null == referenceCode ? _self.referenceCode : referenceCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripStatus,quotedFare: null == quotedFare ? _self.quotedFare : quotedFare // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledAtUtc: freezed == scheduledAtUtc ? _self.scheduledAtUtc : scheduledAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,stops: null == stops ? _self.stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripStopEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [TripSummaryEntity].
extension TripSummaryEntityPatterns on TripSummaryEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripSummaryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripSummaryEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripSummaryEntity value)  $default,){
final _that = this;
switch (_that) {
case _TripSummaryEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripSummaryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TripSummaryEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String referenceCode,  TripStatus status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopEntity> stops)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripSummaryEntity() when $default != null:
return $default(_that.id,_that.referenceCode,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String referenceCode,  TripStatus status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopEntity> stops)  $default,) {final _that = this;
switch (_that) {
case _TripSummaryEntity():
return $default(_that.id,_that.referenceCode,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String referenceCode,  TripStatus status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopEntity> stops)?  $default,) {final _that = this;
switch (_that) {
case _TripSummaryEntity() when $default != null:
return $default(_that.id,_that.referenceCode,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops);case _:
  return null;

}
}

}

/// @nodoc


class _TripSummaryEntity implements TripSummaryEntity {
  const _TripSummaryEntity({required this.id, required this.referenceCode, required this.status, required this.quotedFare, required this.currencyCode, required this.createdAtUtc, this.scheduledAtUtc, final  List<TripStopEntity> stops = const []}): _stops = stops;
  

@override final  String id;
@override final  String referenceCode;
@override final  TripStatus status;
@override final  double quotedFare;
@override final  String currencyCode;
@override final  DateTime createdAtUtc;
@override final  DateTime? scheduledAtUtc;
 final  List<TripStopEntity> _stops;
@override@JsonKey() List<TripStopEntity> get stops {
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stops);
}


/// Create a copy of TripSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripSummaryEntityCopyWith<_TripSummaryEntity> get copyWith => __$TripSummaryEntityCopyWithImpl<_TripSummaryEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripSummaryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.referenceCode, referenceCode) || other.referenceCode == referenceCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.quotedFare, quotedFare) || other.quotedFare == quotedFare)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.scheduledAtUtc, scheduledAtUtc) || other.scheduledAtUtc == scheduledAtUtc)&&const DeepCollectionEquality().equals(other._stops, _stops));
}


@override
int get hashCode => Object.hash(runtimeType,id,referenceCode,status,quotedFare,currencyCode,createdAtUtc,scheduledAtUtc,const DeepCollectionEquality().hash(_stops));

@override
String toString() {
  return 'TripSummaryEntity(id: $id, referenceCode: $referenceCode, status: $status, quotedFare: $quotedFare, currencyCode: $currencyCode, createdAtUtc: $createdAtUtc, scheduledAtUtc: $scheduledAtUtc, stops: $stops)';
}


}

/// @nodoc
abstract mixin class _$TripSummaryEntityCopyWith<$Res> implements $TripSummaryEntityCopyWith<$Res> {
  factory _$TripSummaryEntityCopyWith(_TripSummaryEntity value, $Res Function(_TripSummaryEntity) _then) = __$TripSummaryEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String referenceCode, TripStatus status, double quotedFare, String currencyCode, DateTime createdAtUtc, DateTime? scheduledAtUtc, List<TripStopEntity> stops
});




}
/// @nodoc
class __$TripSummaryEntityCopyWithImpl<$Res>
    implements _$TripSummaryEntityCopyWith<$Res> {
  __$TripSummaryEntityCopyWithImpl(this._self, this._then);

  final _TripSummaryEntity _self;
  final $Res Function(_TripSummaryEntity) _then;

/// Create a copy of TripSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? referenceCode = null,Object? status = null,Object? quotedFare = null,Object? currencyCode = null,Object? createdAtUtc = null,Object? scheduledAtUtc = freezed,Object? stops = null,}) {
  return _then(_TripSummaryEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referenceCode: null == referenceCode ? _self.referenceCode : referenceCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripStatus,quotedFare: null == quotedFare ? _self.quotedFare : quotedFare // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledAtUtc: freezed == scheduledAtUtc ? _self.scheduledAtUtc : scheduledAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,stops: null == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripStopEntity>,
  ));
}


}

// dart format on
