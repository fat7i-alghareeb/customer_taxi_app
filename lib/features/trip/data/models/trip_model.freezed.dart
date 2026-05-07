// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripModel {

 String get id; String get referenceCode; String get status; double get quotedFare; String get currencyCode; DateTime get createdAtUtc; DateTime? get scheduledAtUtc; List<TripStopModel> get stops;
/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripModelCopyWith<TripModel> get copyWith => _$TripModelCopyWithImpl<TripModel>(this as TripModel, _$identity);

  /// Serializes this TripModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripModel&&(identical(other.id, id) || other.id == id)&&(identical(other.referenceCode, referenceCode) || other.referenceCode == referenceCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.quotedFare, quotedFare) || other.quotedFare == quotedFare)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.scheduledAtUtc, scheduledAtUtc) || other.scheduledAtUtc == scheduledAtUtc)&&const DeepCollectionEquality().equals(other.stops, stops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,referenceCode,status,quotedFare,currencyCode,createdAtUtc,scheduledAtUtc,const DeepCollectionEquality().hash(stops));

@override
String toString() {
  return 'TripModel(id: $id, referenceCode: $referenceCode, status: $status, quotedFare: $quotedFare, currencyCode: $currencyCode, createdAtUtc: $createdAtUtc, scheduledAtUtc: $scheduledAtUtc, stops: $stops)';
}


}

/// @nodoc
abstract mixin class $TripModelCopyWith<$Res>  {
  factory $TripModelCopyWith(TripModel value, $Res Function(TripModel) _then) = _$TripModelCopyWithImpl;
@useResult
$Res call({
 String id, String referenceCode, String status, double quotedFare, String currencyCode, DateTime createdAtUtc, DateTime? scheduledAtUtc, List<TripStopModel> stops
});




}
/// @nodoc
class _$TripModelCopyWithImpl<$Res>
    implements $TripModelCopyWith<$Res> {
  _$TripModelCopyWithImpl(this._self, this._then);

  final TripModel _self;
  final $Res Function(TripModel) _then;

/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? referenceCode = null,Object? status = null,Object? quotedFare = null,Object? currencyCode = null,Object? createdAtUtc = null,Object? scheduledAtUtc = freezed,Object? stops = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referenceCode: null == referenceCode ? _self.referenceCode : referenceCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,quotedFare: null == quotedFare ? _self.quotedFare : quotedFare // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledAtUtc: freezed == scheduledAtUtc ? _self.scheduledAtUtc : scheduledAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,stops: null == stops ? _self.stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripStopModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [TripModel].
extension TripModelPatterns on TripModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripModel value)  $default,){
final _that = this;
switch (_that) {
case _TripModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripModel value)?  $default,){
final _that = this;
switch (_that) {
case _TripModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String referenceCode,  String status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopModel> stops)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String referenceCode,  String status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopModel> stops)  $default,) {final _that = this;
switch (_that) {
case _TripModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String referenceCode,  String status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopModel> stops)?  $default,) {final _that = this;
switch (_that) {
case _TripModel() when $default != null:
return $default(_that.id,_that.referenceCode,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripModel implements TripModel {
  const _TripModel({required this.id, required this.referenceCode, required this.status, required this.quotedFare, required this.currencyCode, required this.createdAtUtc, this.scheduledAtUtc, final  List<TripStopModel> stops = const []}): _stops = stops;
  factory _TripModel.fromJson(Map<String, dynamic> json) => _$TripModelFromJson(json);

@override final  String id;
@override final  String referenceCode;
@override final  String status;
@override final  double quotedFare;
@override final  String currencyCode;
@override final  DateTime createdAtUtc;
@override final  DateTime? scheduledAtUtc;
 final  List<TripStopModel> _stops;
@override@JsonKey() List<TripStopModel> get stops {
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stops);
}


/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripModelCopyWith<_TripModel> get copyWith => __$TripModelCopyWithImpl<_TripModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripModel&&(identical(other.id, id) || other.id == id)&&(identical(other.referenceCode, referenceCode) || other.referenceCode == referenceCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.quotedFare, quotedFare) || other.quotedFare == quotedFare)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.scheduledAtUtc, scheduledAtUtc) || other.scheduledAtUtc == scheduledAtUtc)&&const DeepCollectionEquality().equals(other._stops, _stops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,referenceCode,status,quotedFare,currencyCode,createdAtUtc,scheduledAtUtc,const DeepCollectionEquality().hash(_stops));

@override
String toString() {
  return 'TripModel(id: $id, referenceCode: $referenceCode, status: $status, quotedFare: $quotedFare, currencyCode: $currencyCode, createdAtUtc: $createdAtUtc, scheduledAtUtc: $scheduledAtUtc, stops: $stops)';
}


}

/// @nodoc
abstract mixin class _$TripModelCopyWith<$Res> implements $TripModelCopyWith<$Res> {
  factory _$TripModelCopyWith(_TripModel value, $Res Function(_TripModel) _then) = __$TripModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String referenceCode, String status, double quotedFare, String currencyCode, DateTime createdAtUtc, DateTime? scheduledAtUtc, List<TripStopModel> stops
});




}
/// @nodoc
class __$TripModelCopyWithImpl<$Res>
    implements _$TripModelCopyWith<$Res> {
  __$TripModelCopyWithImpl(this._self, this._then);

  final _TripModel _self;
  final $Res Function(_TripModel) _then;

/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? referenceCode = null,Object? status = null,Object? quotedFare = null,Object? currencyCode = null,Object? createdAtUtc = null,Object? scheduledAtUtc = freezed,Object? stops = null,}) {
  return _then(_TripModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referenceCode: null == referenceCode ? _self.referenceCode : referenceCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,quotedFare: null == quotedFare ? _self.quotedFare : quotedFare // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledAtUtc: freezed == scheduledAtUtc ? _self.scheduledAtUtc : scheduledAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,stops: null == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripStopModel>,
  ));
}


}


/// @nodoc
mixin _$TripStopModel {

 double get latitude; double get longitude;
/// Create a copy of TripStopModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripStopModelCopyWith<TripStopModel> get copyWith => _$TripStopModelCopyWithImpl<TripStopModel>(this as TripStopModel, _$identity);

  /// Serializes this TripStopModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripStopModel&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'TripStopModel(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $TripStopModelCopyWith<$Res>  {
  factory $TripStopModelCopyWith(TripStopModel value, $Res Function(TripStopModel) _then) = _$TripStopModelCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude
});




}
/// @nodoc
class _$TripStopModelCopyWithImpl<$Res>
    implements $TripStopModelCopyWith<$Res> {
  _$TripStopModelCopyWithImpl(this._self, this._then);

  final TripStopModel _self;
  final $Res Function(TripStopModel) _then;

/// Create a copy of TripStopModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TripStopModel].
extension TripStopModelPatterns on TripStopModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripStopModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripStopModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripStopModel value)  $default,){
final _that = this;
switch (_that) {
case _TripStopModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripStopModel value)?  $default,){
final _that = this;
switch (_that) {
case _TripStopModel() when $default != null:
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
case _TripStopModel() when $default != null:
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
case _TripStopModel():
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
case _TripStopModel() when $default != null:
return $default(_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripStopModel implements TripStopModel {
  const _TripStopModel({required this.latitude, required this.longitude});
  factory _TripStopModel.fromJson(Map<String, dynamic> json) => _$TripStopModelFromJson(json);

@override final  double latitude;
@override final  double longitude;

/// Create a copy of TripStopModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripStopModelCopyWith<_TripStopModel> get copyWith => __$TripStopModelCopyWithImpl<_TripStopModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripStopModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripStopModel&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'TripStopModel(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$TripStopModelCopyWith<$Res> implements $TripStopModelCopyWith<$Res> {
  factory _$TripStopModelCopyWith(_TripStopModel value, $Res Function(_TripStopModel) _then) = __$TripStopModelCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude
});




}
/// @nodoc
class __$TripStopModelCopyWithImpl<$Res>
    implements _$TripStopModelCopyWith<$Res> {
  __$TripStopModelCopyWithImpl(this._self, this._then);

  final _TripStopModel _self;
  final $Res Function(_TripStopModel) _then;

/// Create a copy of TripStopModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_TripStopModel(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$TripSummaryModel {

 String get id; String get referenceCode; String get status; double get quotedFare; String get currencyCode; DateTime get createdAtUtc; DateTime? get scheduledAtUtc; List<TripStopModel> get stops;
/// Create a copy of TripSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripSummaryModelCopyWith<TripSummaryModel> get copyWith => _$TripSummaryModelCopyWithImpl<TripSummaryModel>(this as TripSummaryModel, _$identity);

  /// Serializes this TripSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripSummaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.referenceCode, referenceCode) || other.referenceCode == referenceCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.quotedFare, quotedFare) || other.quotedFare == quotedFare)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.scheduledAtUtc, scheduledAtUtc) || other.scheduledAtUtc == scheduledAtUtc)&&const DeepCollectionEquality().equals(other.stops, stops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,referenceCode,status,quotedFare,currencyCode,createdAtUtc,scheduledAtUtc,const DeepCollectionEquality().hash(stops));

@override
String toString() {
  return 'TripSummaryModel(id: $id, referenceCode: $referenceCode, status: $status, quotedFare: $quotedFare, currencyCode: $currencyCode, createdAtUtc: $createdAtUtc, scheduledAtUtc: $scheduledAtUtc, stops: $stops)';
}


}

/// @nodoc
abstract mixin class $TripSummaryModelCopyWith<$Res>  {
  factory $TripSummaryModelCopyWith(TripSummaryModel value, $Res Function(TripSummaryModel) _then) = _$TripSummaryModelCopyWithImpl;
@useResult
$Res call({
 String id, String referenceCode, String status, double quotedFare, String currencyCode, DateTime createdAtUtc, DateTime? scheduledAtUtc, List<TripStopModel> stops
});




}
/// @nodoc
class _$TripSummaryModelCopyWithImpl<$Res>
    implements $TripSummaryModelCopyWith<$Res> {
  _$TripSummaryModelCopyWithImpl(this._self, this._then);

  final TripSummaryModel _self;
  final $Res Function(TripSummaryModel) _then;

/// Create a copy of TripSummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? referenceCode = null,Object? status = null,Object? quotedFare = null,Object? currencyCode = null,Object? createdAtUtc = null,Object? scheduledAtUtc = freezed,Object? stops = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referenceCode: null == referenceCode ? _self.referenceCode : referenceCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,quotedFare: null == quotedFare ? _self.quotedFare : quotedFare // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledAtUtc: freezed == scheduledAtUtc ? _self.scheduledAtUtc : scheduledAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,stops: null == stops ? _self.stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripStopModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [TripSummaryModel].
extension TripSummaryModelPatterns on TripSummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripSummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _TripSummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _TripSummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String referenceCode,  String status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopModel> stops)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripSummaryModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String referenceCode,  String status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopModel> stops)  $default,) {final _that = this;
switch (_that) {
case _TripSummaryModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String referenceCode,  String status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopModel> stops)?  $default,) {final _that = this;
switch (_that) {
case _TripSummaryModel() when $default != null:
return $default(_that.id,_that.referenceCode,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripSummaryModel implements TripSummaryModel {
  const _TripSummaryModel({required this.id, required this.referenceCode, required this.status, required this.quotedFare, required this.currencyCode, required this.createdAtUtc, this.scheduledAtUtc, final  List<TripStopModel> stops = const []}): _stops = stops;
  factory _TripSummaryModel.fromJson(Map<String, dynamic> json) => _$TripSummaryModelFromJson(json);

@override final  String id;
@override final  String referenceCode;
@override final  String status;
@override final  double quotedFare;
@override final  String currencyCode;
@override final  DateTime createdAtUtc;
@override final  DateTime? scheduledAtUtc;
 final  List<TripStopModel> _stops;
@override@JsonKey() List<TripStopModel> get stops {
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stops);
}


/// Create a copy of TripSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripSummaryModelCopyWith<_TripSummaryModel> get copyWith => __$TripSummaryModelCopyWithImpl<_TripSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripSummaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.referenceCode, referenceCode) || other.referenceCode == referenceCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.quotedFare, quotedFare) || other.quotedFare == quotedFare)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.scheduledAtUtc, scheduledAtUtc) || other.scheduledAtUtc == scheduledAtUtc)&&const DeepCollectionEquality().equals(other._stops, _stops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,referenceCode,status,quotedFare,currencyCode,createdAtUtc,scheduledAtUtc,const DeepCollectionEquality().hash(_stops));

@override
String toString() {
  return 'TripSummaryModel(id: $id, referenceCode: $referenceCode, status: $status, quotedFare: $quotedFare, currencyCode: $currencyCode, createdAtUtc: $createdAtUtc, scheduledAtUtc: $scheduledAtUtc, stops: $stops)';
}


}

/// @nodoc
abstract mixin class _$TripSummaryModelCopyWith<$Res> implements $TripSummaryModelCopyWith<$Res> {
  factory _$TripSummaryModelCopyWith(_TripSummaryModel value, $Res Function(_TripSummaryModel) _then) = __$TripSummaryModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String referenceCode, String status, double quotedFare, String currencyCode, DateTime createdAtUtc, DateTime? scheduledAtUtc, List<TripStopModel> stops
});




}
/// @nodoc
class __$TripSummaryModelCopyWithImpl<$Res>
    implements _$TripSummaryModelCopyWith<$Res> {
  __$TripSummaryModelCopyWithImpl(this._self, this._then);

  final _TripSummaryModel _self;
  final $Res Function(_TripSummaryModel) _then;

/// Create a copy of TripSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? referenceCode = null,Object? status = null,Object? quotedFare = null,Object? currencyCode = null,Object? createdAtUtc = null,Object? scheduledAtUtc = freezed,Object? stops = null,}) {
  return _then(_TripSummaryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referenceCode: null == referenceCode ? _self.referenceCode : referenceCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,quotedFare: null == quotedFare ? _self.quotedFare : quotedFare // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledAtUtc: freezed == scheduledAtUtc ? _self.scheduledAtUtc : scheduledAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,stops: null == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripStopModel>,
  ));
}


}

// dart format on
