// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_stripe_payment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderStripePaymentModel {

 String get paymentIntentId; String get clientSecret; String get publishableKey;
/// Create a copy of OrderStripePaymentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderStripePaymentModelCopyWith<OrderStripePaymentModel> get copyWith => _$OrderStripePaymentModelCopyWithImpl<OrderStripePaymentModel>(this as OrderStripePaymentModel, _$identity);

  /// Serializes this OrderStripePaymentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderStripePaymentModel&&(identical(other.paymentIntentId, paymentIntentId) || other.paymentIntentId == paymentIntentId)&&(identical(other.clientSecret, clientSecret) || other.clientSecret == clientSecret)&&(identical(other.publishableKey, publishableKey) || other.publishableKey == publishableKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentIntentId,clientSecret,publishableKey);

@override
String toString() {
  return 'OrderStripePaymentModel(paymentIntentId: $paymentIntentId, clientSecret: $clientSecret, publishableKey: $publishableKey)';
}


}

/// @nodoc
abstract mixin class $OrderStripePaymentModelCopyWith<$Res>  {
  factory $OrderStripePaymentModelCopyWith(OrderStripePaymentModel value, $Res Function(OrderStripePaymentModel) _then) = _$OrderStripePaymentModelCopyWithImpl;
@useResult
$Res call({
 String paymentIntentId, String clientSecret, String publishableKey
});




}
/// @nodoc
class _$OrderStripePaymentModelCopyWithImpl<$Res>
    implements $OrderStripePaymentModelCopyWith<$Res> {
  _$OrderStripePaymentModelCopyWithImpl(this._self, this._then);

  final OrderStripePaymentModel _self;
  final $Res Function(OrderStripePaymentModel) _then;

/// Create a copy of OrderStripePaymentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentIntentId = null,Object? clientSecret = null,Object? publishableKey = null,}) {
  return _then(_self.copyWith(
paymentIntentId: null == paymentIntentId ? _self.paymentIntentId : paymentIntentId // ignore: cast_nullable_to_non_nullable
as String,clientSecret: null == clientSecret ? _self.clientSecret : clientSecret // ignore: cast_nullable_to_non_nullable
as String,publishableKey: null == publishableKey ? _self.publishableKey : publishableKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderStripePaymentModel].
extension OrderStripePaymentModelPatterns on OrderStripePaymentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderStripePaymentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderStripePaymentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderStripePaymentModel value)  $default,){
final _that = this;
switch (_that) {
case _OrderStripePaymentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderStripePaymentModel value)?  $default,){
final _that = this;
switch (_that) {
case _OrderStripePaymentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String paymentIntentId,  String clientSecret,  String publishableKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderStripePaymentModel() when $default != null:
return $default(_that.paymentIntentId,_that.clientSecret,_that.publishableKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String paymentIntentId,  String clientSecret,  String publishableKey)  $default,) {final _that = this;
switch (_that) {
case _OrderStripePaymentModel():
return $default(_that.paymentIntentId,_that.clientSecret,_that.publishableKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String paymentIntentId,  String clientSecret,  String publishableKey)?  $default,) {final _that = this;
switch (_that) {
case _OrderStripePaymentModel() when $default != null:
return $default(_that.paymentIntentId,_that.clientSecret,_that.publishableKey);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderStripePaymentModel implements OrderStripePaymentModel {
  const _OrderStripePaymentModel({required this.paymentIntentId, required this.clientSecret, required this.publishableKey});
  factory _OrderStripePaymentModel.fromJson(Map<String, dynamic> json) => _$OrderStripePaymentModelFromJson(json);

@override final  String paymentIntentId;
@override final  String clientSecret;
@override final  String publishableKey;

/// Create a copy of OrderStripePaymentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderStripePaymentModelCopyWith<_OrderStripePaymentModel> get copyWith => __$OrderStripePaymentModelCopyWithImpl<_OrderStripePaymentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderStripePaymentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderStripePaymentModel&&(identical(other.paymentIntentId, paymentIntentId) || other.paymentIntentId == paymentIntentId)&&(identical(other.clientSecret, clientSecret) || other.clientSecret == clientSecret)&&(identical(other.publishableKey, publishableKey) || other.publishableKey == publishableKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentIntentId,clientSecret,publishableKey);

@override
String toString() {
  return 'OrderStripePaymentModel(paymentIntentId: $paymentIntentId, clientSecret: $clientSecret, publishableKey: $publishableKey)';
}


}

/// @nodoc
abstract mixin class _$OrderStripePaymentModelCopyWith<$Res> implements $OrderStripePaymentModelCopyWith<$Res> {
  factory _$OrderStripePaymentModelCopyWith(_OrderStripePaymentModel value, $Res Function(_OrderStripePaymentModel) _then) = __$OrderStripePaymentModelCopyWithImpl;
@override @useResult
$Res call({
 String paymentIntentId, String clientSecret, String publishableKey
});




}
/// @nodoc
class __$OrderStripePaymentModelCopyWithImpl<$Res>
    implements _$OrderStripePaymentModelCopyWith<$Res> {
  __$OrderStripePaymentModelCopyWithImpl(this._self, this._then);

  final _OrderStripePaymentModel _self;
  final $Res Function(_OrderStripePaymentModel) _then;

/// Create a copy of OrderStripePaymentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentIntentId = null,Object? clientSecret = null,Object? publishableKey = null,}) {
  return _then(_OrderStripePaymentModel(
paymentIntentId: null == paymentIntentId ? _self.paymentIntentId : paymentIntentId // ignore: cast_nullable_to_non_nullable
as String,clientSecret: null == clientSecret ? _self.clientSecret : clientSecret // ignore: cast_nullable_to_non_nullable
as String,publishableKey: null == publishableKey ? _self.publishableKey : publishableKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
