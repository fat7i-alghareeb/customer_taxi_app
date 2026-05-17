// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_trip_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderTripResponseModel {

 String get id; String get referenceCode; String get passengerId; String? get driverId; String get vehicleTypeId; String get status; double get quotedFare; String get currencyCode; DateTime get createdAtUtc; DateTime? get scheduledAtUtc; List<OrderTripStopModel> get stops; OrderStripePaymentModel? get stripePayment;
/// Create a copy of OrderTripResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderTripResponseModelCopyWith<OrderTripResponseModel> get copyWith => _$OrderTripResponseModelCopyWithImpl<OrderTripResponseModel>(this as OrderTripResponseModel, _$identity);

  /// Serializes this OrderTripResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderTripResponseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.referenceCode, referenceCode) || other.referenceCode == referenceCode)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.vehicleTypeId, vehicleTypeId) || other.vehicleTypeId == vehicleTypeId)&&(identical(other.status, status) || other.status == status)&&(identical(other.quotedFare, quotedFare) || other.quotedFare == quotedFare)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.scheduledAtUtc, scheduledAtUtc) || other.scheduledAtUtc == scheduledAtUtc)&&const DeepCollectionEquality().equals(other.stops, stops)&&(identical(other.stripePayment, stripePayment) || other.stripePayment == stripePayment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,referenceCode,passengerId,driverId,vehicleTypeId,status,quotedFare,currencyCode,createdAtUtc,scheduledAtUtc,const DeepCollectionEquality().hash(stops),stripePayment);

@override
String toString() {
  return 'OrderTripResponseModel(id: $id, referenceCode: $referenceCode, passengerId: $passengerId, driverId: $driverId, vehicleTypeId: $vehicleTypeId, status: $status, quotedFare: $quotedFare, currencyCode: $currencyCode, createdAtUtc: $createdAtUtc, scheduledAtUtc: $scheduledAtUtc, stops: $stops, stripePayment: $stripePayment)';
}


}

/// @nodoc
abstract mixin class $OrderTripResponseModelCopyWith<$Res>  {
  factory $OrderTripResponseModelCopyWith(OrderTripResponseModel value, $Res Function(OrderTripResponseModel) _then) = _$OrderTripResponseModelCopyWithImpl;
@useResult
$Res call({
 String id, String referenceCode, String passengerId, String? driverId, String vehicleTypeId, String status, double quotedFare, String currencyCode, DateTime createdAtUtc, DateTime? scheduledAtUtc, List<OrderTripStopModel> stops, OrderStripePaymentModel? stripePayment
});


$OrderStripePaymentModelCopyWith<$Res>? get stripePayment;

}
/// @nodoc
class _$OrderTripResponseModelCopyWithImpl<$Res>
    implements $OrderTripResponseModelCopyWith<$Res> {
  _$OrderTripResponseModelCopyWithImpl(this._self, this._then);

  final OrderTripResponseModel _self;
  final $Res Function(OrderTripResponseModel) _then;

/// Create a copy of OrderTripResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? referenceCode = null,Object? passengerId = null,Object? driverId = freezed,Object? vehicleTypeId = null,Object? status = null,Object? quotedFare = null,Object? currencyCode = null,Object? createdAtUtc = null,Object? scheduledAtUtc = freezed,Object? stops = null,Object? stripePayment = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referenceCode: null == referenceCode ? _self.referenceCode : referenceCode // ignore: cast_nullable_to_non_nullable
as String,passengerId: null == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String,driverId: freezed == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String?,vehicleTypeId: null == vehicleTypeId ? _self.vehicleTypeId : vehicleTypeId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,quotedFare: null == quotedFare ? _self.quotedFare : quotedFare // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledAtUtc: freezed == scheduledAtUtc ? _self.scheduledAtUtc : scheduledAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,stops: null == stops ? _self.stops : stops // ignore: cast_nullable_to_non_nullable
as List<OrderTripStopModel>,stripePayment: freezed == stripePayment ? _self.stripePayment : stripePayment // ignore: cast_nullable_to_non_nullable
as OrderStripePaymentModel?,
  ));
}
/// Create a copy of OrderTripResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderStripePaymentModelCopyWith<$Res>? get stripePayment {
    if (_self.stripePayment == null) {
    return null;
  }

  return $OrderStripePaymentModelCopyWith<$Res>(_self.stripePayment!, (value) {
    return _then(_self.copyWith(stripePayment: value));
  });
}
}


/// Adds pattern-matching-related methods to [OrderTripResponseModel].
extension OrderTripResponseModelPatterns on OrderTripResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderTripResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderTripResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderTripResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _OrderTripResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderTripResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _OrderTripResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String referenceCode,  String passengerId,  String? driverId,  String vehicleTypeId,  String status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<OrderTripStopModel> stops,  OrderStripePaymentModel? stripePayment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderTripResponseModel() when $default != null:
return $default(_that.id,_that.referenceCode,_that.passengerId,_that.driverId,_that.vehicleTypeId,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops,_that.stripePayment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String referenceCode,  String passengerId,  String? driverId,  String vehicleTypeId,  String status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<OrderTripStopModel> stops,  OrderStripePaymentModel? stripePayment)  $default,) {final _that = this;
switch (_that) {
case _OrderTripResponseModel():
return $default(_that.id,_that.referenceCode,_that.passengerId,_that.driverId,_that.vehicleTypeId,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops,_that.stripePayment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String referenceCode,  String passengerId,  String? driverId,  String vehicleTypeId,  String status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<OrderTripStopModel> stops,  OrderStripePaymentModel? stripePayment)?  $default,) {final _that = this;
switch (_that) {
case _OrderTripResponseModel() when $default != null:
return $default(_that.id,_that.referenceCode,_that.passengerId,_that.driverId,_that.vehicleTypeId,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops,_that.stripePayment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderTripResponseModel extends OrderTripResponseModel {
  const _OrderTripResponseModel({required this.id, required this.referenceCode, required this.passengerId, this.driverId, required this.vehicleTypeId, required this.status, required this.quotedFare, required this.currencyCode, required this.createdAtUtc, this.scheduledAtUtc, required final  List<OrderTripStopModel> stops, this.stripePayment}): _stops = stops,super._();
  factory _OrderTripResponseModel.fromJson(Map<String, dynamic> json) => _$OrderTripResponseModelFromJson(json);

@override final  String id;
@override final  String referenceCode;
@override final  String passengerId;
@override final  String? driverId;
@override final  String vehicleTypeId;
@override final  String status;
@override final  double quotedFare;
@override final  String currencyCode;
@override final  DateTime createdAtUtc;
@override final  DateTime? scheduledAtUtc;
 final  List<OrderTripStopModel> _stops;
@override List<OrderTripStopModel> get stops {
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stops);
}

@override final  OrderStripePaymentModel? stripePayment;

/// Create a copy of OrderTripResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderTripResponseModelCopyWith<_OrderTripResponseModel> get copyWith => __$OrderTripResponseModelCopyWithImpl<_OrderTripResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderTripResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderTripResponseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.referenceCode, referenceCode) || other.referenceCode == referenceCode)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.vehicleTypeId, vehicleTypeId) || other.vehicleTypeId == vehicleTypeId)&&(identical(other.status, status) || other.status == status)&&(identical(other.quotedFare, quotedFare) || other.quotedFare == quotedFare)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.scheduledAtUtc, scheduledAtUtc) || other.scheduledAtUtc == scheduledAtUtc)&&const DeepCollectionEquality().equals(other._stops, _stops)&&(identical(other.stripePayment, stripePayment) || other.stripePayment == stripePayment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,referenceCode,passengerId,driverId,vehicleTypeId,status,quotedFare,currencyCode,createdAtUtc,scheduledAtUtc,const DeepCollectionEquality().hash(_stops),stripePayment);

@override
String toString() {
  return 'OrderTripResponseModel(id: $id, referenceCode: $referenceCode, passengerId: $passengerId, driverId: $driverId, vehicleTypeId: $vehicleTypeId, status: $status, quotedFare: $quotedFare, currencyCode: $currencyCode, createdAtUtc: $createdAtUtc, scheduledAtUtc: $scheduledAtUtc, stops: $stops, stripePayment: $stripePayment)';
}


}

/// @nodoc
abstract mixin class _$OrderTripResponseModelCopyWith<$Res> implements $OrderTripResponseModelCopyWith<$Res> {
  factory _$OrderTripResponseModelCopyWith(_OrderTripResponseModel value, $Res Function(_OrderTripResponseModel) _then) = __$OrderTripResponseModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String referenceCode, String passengerId, String? driverId, String vehicleTypeId, String status, double quotedFare, String currencyCode, DateTime createdAtUtc, DateTime? scheduledAtUtc, List<OrderTripStopModel> stops, OrderStripePaymentModel? stripePayment
});


@override $OrderStripePaymentModelCopyWith<$Res>? get stripePayment;

}
/// @nodoc
class __$OrderTripResponseModelCopyWithImpl<$Res>
    implements _$OrderTripResponseModelCopyWith<$Res> {
  __$OrderTripResponseModelCopyWithImpl(this._self, this._then);

  final _OrderTripResponseModel _self;
  final $Res Function(_OrderTripResponseModel) _then;

/// Create a copy of OrderTripResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? referenceCode = null,Object? passengerId = null,Object? driverId = freezed,Object? vehicleTypeId = null,Object? status = null,Object? quotedFare = null,Object? currencyCode = null,Object? createdAtUtc = null,Object? scheduledAtUtc = freezed,Object? stops = null,Object? stripePayment = freezed,}) {
  return _then(_OrderTripResponseModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referenceCode: null == referenceCode ? _self.referenceCode : referenceCode // ignore: cast_nullable_to_non_nullable
as String,passengerId: null == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String,driverId: freezed == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String?,vehicleTypeId: null == vehicleTypeId ? _self.vehicleTypeId : vehicleTypeId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,quotedFare: null == quotedFare ? _self.quotedFare : quotedFare // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledAtUtc: freezed == scheduledAtUtc ? _self.scheduledAtUtc : scheduledAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,stops: null == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<OrderTripStopModel>,stripePayment: freezed == stripePayment ? _self.stripePayment : stripePayment // ignore: cast_nullable_to_non_nullable
as OrderStripePaymentModel?,
  ));
}

/// Create a copy of OrderTripResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderStripePaymentModelCopyWith<$Res>? get stripePayment {
    if (_self.stripePayment == null) {
    return null;
  }

  return $OrderStripePaymentModelCopyWith<$Res>(_self.stripePayment!, (value) {
    return _then(_self.copyWith(stripePayment: value));
  });
}
}

// dart format on
