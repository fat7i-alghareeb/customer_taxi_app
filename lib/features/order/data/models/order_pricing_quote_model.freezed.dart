// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_pricing_quote_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderPricingQuoteModel {

 String get quoteId; String get vehicleTypeId; String? get vehicleTypeCode; String get vehicleTypeName; double get totalDistanceKm; double get totalDurationMin; double get finalFare; String get currencyCode; DateTime get validUntil;
/// Create a copy of OrderPricingQuoteModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderPricingQuoteModelCopyWith<OrderPricingQuoteModel> get copyWith => _$OrderPricingQuoteModelCopyWithImpl<OrderPricingQuoteModel>(this as OrderPricingQuoteModel, _$identity);

  /// Serializes this OrderPricingQuoteModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderPricingQuoteModel&&(identical(other.quoteId, quoteId) || other.quoteId == quoteId)&&(identical(other.vehicleTypeId, vehicleTypeId) || other.vehicleTypeId == vehicleTypeId)&&(identical(other.vehicleTypeCode, vehicleTypeCode) || other.vehicleTypeCode == vehicleTypeCode)&&(identical(other.vehicleTypeName, vehicleTypeName) || other.vehicleTypeName == vehicleTypeName)&&(identical(other.totalDistanceKm, totalDistanceKm) || other.totalDistanceKm == totalDistanceKm)&&(identical(other.totalDurationMin, totalDurationMin) || other.totalDurationMin == totalDurationMin)&&(identical(other.finalFare, finalFare) || other.finalFare == finalFare)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.validUntil, validUntil) || other.validUntil == validUntil));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,quoteId,vehicleTypeId,vehicleTypeCode,vehicleTypeName,totalDistanceKm,totalDurationMin,finalFare,currencyCode,validUntil);

@override
String toString() {
  return 'OrderPricingQuoteModel(quoteId: $quoteId, vehicleTypeId: $vehicleTypeId, vehicleTypeCode: $vehicleTypeCode, vehicleTypeName: $vehicleTypeName, totalDistanceKm: $totalDistanceKm, totalDurationMin: $totalDurationMin, finalFare: $finalFare, currencyCode: $currencyCode, validUntil: $validUntil)';
}


}

/// @nodoc
abstract mixin class $OrderPricingQuoteModelCopyWith<$Res>  {
  factory $OrderPricingQuoteModelCopyWith(OrderPricingQuoteModel value, $Res Function(OrderPricingQuoteModel) _then) = _$OrderPricingQuoteModelCopyWithImpl;
@useResult
$Res call({
 String quoteId, String vehicleTypeId, String? vehicleTypeCode, String vehicleTypeName, double totalDistanceKm, double totalDurationMin, double finalFare, String currencyCode, DateTime validUntil
});




}
/// @nodoc
class _$OrderPricingQuoteModelCopyWithImpl<$Res>
    implements $OrderPricingQuoteModelCopyWith<$Res> {
  _$OrderPricingQuoteModelCopyWithImpl(this._self, this._then);

  final OrderPricingQuoteModel _self;
  final $Res Function(OrderPricingQuoteModel) _then;

/// Create a copy of OrderPricingQuoteModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quoteId = null,Object? vehicleTypeId = null,Object? vehicleTypeCode = freezed,Object? vehicleTypeName = null,Object? totalDistanceKm = null,Object? totalDurationMin = null,Object? finalFare = null,Object? currencyCode = null,Object? validUntil = null,}) {
  return _then(_self.copyWith(
quoteId: null == quoteId ? _self.quoteId : quoteId // ignore: cast_nullable_to_non_nullable
as String,vehicleTypeId: null == vehicleTypeId ? _self.vehicleTypeId : vehicleTypeId // ignore: cast_nullable_to_non_nullable
as String,vehicleTypeCode: freezed == vehicleTypeCode ? _self.vehicleTypeCode : vehicleTypeCode // ignore: cast_nullable_to_non_nullable
as String?,vehicleTypeName: null == vehicleTypeName ? _self.vehicleTypeName : vehicleTypeName // ignore: cast_nullable_to_non_nullable
as String,totalDistanceKm: null == totalDistanceKm ? _self.totalDistanceKm : totalDistanceKm // ignore: cast_nullable_to_non_nullable
as double,totalDurationMin: null == totalDurationMin ? _self.totalDurationMin : totalDurationMin // ignore: cast_nullable_to_non_nullable
as double,finalFare: null == finalFare ? _self.finalFare : finalFare // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,validUntil: null == validUntil ? _self.validUntil : validUntil // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderPricingQuoteModel].
extension OrderPricingQuoteModelPatterns on OrderPricingQuoteModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderPricingQuoteModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderPricingQuoteModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderPricingQuoteModel value)  $default,){
final _that = this;
switch (_that) {
case _OrderPricingQuoteModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderPricingQuoteModel value)?  $default,){
final _that = this;
switch (_that) {
case _OrderPricingQuoteModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String quoteId,  String vehicleTypeId,  String? vehicleTypeCode,  String vehicleTypeName,  double totalDistanceKm,  double totalDurationMin,  double finalFare,  String currencyCode,  DateTime validUntil)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderPricingQuoteModel() when $default != null:
return $default(_that.quoteId,_that.vehicleTypeId,_that.vehicleTypeCode,_that.vehicleTypeName,_that.totalDistanceKm,_that.totalDurationMin,_that.finalFare,_that.currencyCode,_that.validUntil);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String quoteId,  String vehicleTypeId,  String? vehicleTypeCode,  String vehicleTypeName,  double totalDistanceKm,  double totalDurationMin,  double finalFare,  String currencyCode,  DateTime validUntil)  $default,) {final _that = this;
switch (_that) {
case _OrderPricingQuoteModel():
return $default(_that.quoteId,_that.vehicleTypeId,_that.vehicleTypeCode,_that.vehicleTypeName,_that.totalDistanceKm,_that.totalDurationMin,_that.finalFare,_that.currencyCode,_that.validUntil);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String quoteId,  String vehicleTypeId,  String? vehicleTypeCode,  String vehicleTypeName,  double totalDistanceKm,  double totalDurationMin,  double finalFare,  String currencyCode,  DateTime validUntil)?  $default,) {final _that = this;
switch (_that) {
case _OrderPricingQuoteModel() when $default != null:
return $default(_that.quoteId,_that.vehicleTypeId,_that.vehicleTypeCode,_that.vehicleTypeName,_that.totalDistanceKm,_that.totalDurationMin,_that.finalFare,_that.currencyCode,_that.validUntil);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderPricingQuoteModel implements OrderPricingQuoteModel {
  const _OrderPricingQuoteModel({required this.quoteId, required this.vehicleTypeId, this.vehicleTypeCode, required this.vehicleTypeName, required this.totalDistanceKm, required this.totalDurationMin, required this.finalFare, required this.currencyCode, required this.validUntil});
  factory _OrderPricingQuoteModel.fromJson(Map<String, dynamic> json) => _$OrderPricingQuoteModelFromJson(json);

@override final  String quoteId;
@override final  String vehicleTypeId;
@override final  String? vehicleTypeCode;
@override final  String vehicleTypeName;
@override final  double totalDistanceKm;
@override final  double totalDurationMin;
@override final  double finalFare;
@override final  String currencyCode;
@override final  DateTime validUntil;

/// Create a copy of OrderPricingQuoteModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderPricingQuoteModelCopyWith<_OrderPricingQuoteModel> get copyWith => __$OrderPricingQuoteModelCopyWithImpl<_OrderPricingQuoteModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderPricingQuoteModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderPricingQuoteModel&&(identical(other.quoteId, quoteId) || other.quoteId == quoteId)&&(identical(other.vehicleTypeId, vehicleTypeId) || other.vehicleTypeId == vehicleTypeId)&&(identical(other.vehicleTypeCode, vehicleTypeCode) || other.vehicleTypeCode == vehicleTypeCode)&&(identical(other.vehicleTypeName, vehicleTypeName) || other.vehicleTypeName == vehicleTypeName)&&(identical(other.totalDistanceKm, totalDistanceKm) || other.totalDistanceKm == totalDistanceKm)&&(identical(other.totalDurationMin, totalDurationMin) || other.totalDurationMin == totalDurationMin)&&(identical(other.finalFare, finalFare) || other.finalFare == finalFare)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.validUntil, validUntil) || other.validUntil == validUntil));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,quoteId,vehicleTypeId,vehicleTypeCode,vehicleTypeName,totalDistanceKm,totalDurationMin,finalFare,currencyCode,validUntil);

@override
String toString() {
  return 'OrderPricingQuoteModel(quoteId: $quoteId, vehicleTypeId: $vehicleTypeId, vehicleTypeCode: $vehicleTypeCode, vehicleTypeName: $vehicleTypeName, totalDistanceKm: $totalDistanceKm, totalDurationMin: $totalDurationMin, finalFare: $finalFare, currencyCode: $currencyCode, validUntil: $validUntil)';
}


}

/// @nodoc
abstract mixin class _$OrderPricingQuoteModelCopyWith<$Res> implements $OrderPricingQuoteModelCopyWith<$Res> {
  factory _$OrderPricingQuoteModelCopyWith(_OrderPricingQuoteModel value, $Res Function(_OrderPricingQuoteModel) _then) = __$OrderPricingQuoteModelCopyWithImpl;
@override @useResult
$Res call({
 String quoteId, String vehicleTypeId, String? vehicleTypeCode, String vehicleTypeName, double totalDistanceKm, double totalDurationMin, double finalFare, String currencyCode, DateTime validUntil
});




}
/// @nodoc
class __$OrderPricingQuoteModelCopyWithImpl<$Res>
    implements _$OrderPricingQuoteModelCopyWith<$Res> {
  __$OrderPricingQuoteModelCopyWithImpl(this._self, this._then);

  final _OrderPricingQuoteModel _self;
  final $Res Function(_OrderPricingQuoteModel) _then;

/// Create a copy of OrderPricingQuoteModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quoteId = null,Object? vehicleTypeId = null,Object? vehicleTypeCode = freezed,Object? vehicleTypeName = null,Object? totalDistanceKm = null,Object? totalDurationMin = null,Object? finalFare = null,Object? currencyCode = null,Object? validUntil = null,}) {
  return _then(_OrderPricingQuoteModel(
quoteId: null == quoteId ? _self.quoteId : quoteId // ignore: cast_nullable_to_non_nullable
as String,vehicleTypeId: null == vehicleTypeId ? _self.vehicleTypeId : vehicleTypeId // ignore: cast_nullable_to_non_nullable
as String,vehicleTypeCode: freezed == vehicleTypeCode ? _self.vehicleTypeCode : vehicleTypeCode // ignore: cast_nullable_to_non_nullable
as String?,vehicleTypeName: null == vehicleTypeName ? _self.vehicleTypeName : vehicleTypeName // ignore: cast_nullable_to_non_nullable
as String,totalDistanceKm: null == totalDistanceKm ? _self.totalDistanceKm : totalDistanceKm // ignore: cast_nullable_to_non_nullable
as double,totalDurationMin: null == totalDurationMin ? _self.totalDurationMin : totalDurationMin // ignore: cast_nullable_to_non_nullable
as double,finalFare: null == finalFare ? _self.finalFare : finalFare // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,validUntil: null == validUntil ? _self.validUntil : validUntil // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
