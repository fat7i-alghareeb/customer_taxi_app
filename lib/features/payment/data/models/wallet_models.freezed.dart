// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StripePaymentModel {

 String get paymentIntentId; String get clientSecret; String get publishableKey; String get customerId; String get ephemeralKeySecret;
/// Create a copy of StripePaymentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StripePaymentModelCopyWith<StripePaymentModel> get copyWith => _$StripePaymentModelCopyWithImpl<StripePaymentModel>(this as StripePaymentModel, _$identity);

  /// Serializes this StripePaymentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StripePaymentModel&&(identical(other.paymentIntentId, paymentIntentId) || other.paymentIntentId == paymentIntentId)&&(identical(other.clientSecret, clientSecret) || other.clientSecret == clientSecret)&&(identical(other.publishableKey, publishableKey) || other.publishableKey == publishableKey)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.ephemeralKeySecret, ephemeralKeySecret) || other.ephemeralKeySecret == ephemeralKeySecret));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentIntentId,clientSecret,publishableKey,customerId,ephemeralKeySecret);

@override
String toString() {
  return 'StripePaymentModel(paymentIntentId: $paymentIntentId, clientSecret: $clientSecret, publishableKey: $publishableKey, customerId: $customerId, ephemeralKeySecret: $ephemeralKeySecret)';
}


}

/// @nodoc
abstract mixin class $StripePaymentModelCopyWith<$Res>  {
  factory $StripePaymentModelCopyWith(StripePaymentModel value, $Res Function(StripePaymentModel) _then) = _$StripePaymentModelCopyWithImpl;
@useResult
$Res call({
 String paymentIntentId, String clientSecret, String publishableKey, String customerId, String ephemeralKeySecret
});




}
/// @nodoc
class _$StripePaymentModelCopyWithImpl<$Res>
    implements $StripePaymentModelCopyWith<$Res> {
  _$StripePaymentModelCopyWithImpl(this._self, this._then);

  final StripePaymentModel _self;
  final $Res Function(StripePaymentModel) _then;

/// Create a copy of StripePaymentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentIntentId = null,Object? clientSecret = null,Object? publishableKey = null,Object? customerId = null,Object? ephemeralKeySecret = null,}) {
  return _then(_self.copyWith(
paymentIntentId: null == paymentIntentId ? _self.paymentIntentId : paymentIntentId // ignore: cast_nullable_to_non_nullable
as String,clientSecret: null == clientSecret ? _self.clientSecret : clientSecret // ignore: cast_nullable_to_non_nullable
as String,publishableKey: null == publishableKey ? _self.publishableKey : publishableKey // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,ephemeralKeySecret: null == ephemeralKeySecret ? _self.ephemeralKeySecret : ephemeralKeySecret // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StripePaymentModel].
extension StripePaymentModelPatterns on StripePaymentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StripePaymentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StripePaymentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StripePaymentModel value)  $default,){
final _that = this;
switch (_that) {
case _StripePaymentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StripePaymentModel value)?  $default,){
final _that = this;
switch (_that) {
case _StripePaymentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String paymentIntentId,  String clientSecret,  String publishableKey,  String customerId,  String ephemeralKeySecret)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StripePaymentModel() when $default != null:
return $default(_that.paymentIntentId,_that.clientSecret,_that.publishableKey,_that.customerId,_that.ephemeralKeySecret);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String paymentIntentId,  String clientSecret,  String publishableKey,  String customerId,  String ephemeralKeySecret)  $default,) {final _that = this;
switch (_that) {
case _StripePaymentModel():
return $default(_that.paymentIntentId,_that.clientSecret,_that.publishableKey,_that.customerId,_that.ephemeralKeySecret);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String paymentIntentId,  String clientSecret,  String publishableKey,  String customerId,  String ephemeralKeySecret)?  $default,) {final _that = this;
switch (_that) {
case _StripePaymentModel() when $default != null:
return $default(_that.paymentIntentId,_that.clientSecret,_that.publishableKey,_that.customerId,_that.ephemeralKeySecret);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StripePaymentModel implements StripePaymentModel {
  const _StripePaymentModel({required this.paymentIntentId, required this.clientSecret, required this.publishableKey, required this.customerId, required this.ephemeralKeySecret});
  factory _StripePaymentModel.fromJson(Map<String, dynamic> json) => _$StripePaymentModelFromJson(json);

@override final  String paymentIntentId;
@override final  String clientSecret;
@override final  String publishableKey;
@override final  String customerId;
@override final  String ephemeralKeySecret;

/// Create a copy of StripePaymentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StripePaymentModelCopyWith<_StripePaymentModel> get copyWith => __$StripePaymentModelCopyWithImpl<_StripePaymentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StripePaymentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StripePaymentModel&&(identical(other.paymentIntentId, paymentIntentId) || other.paymentIntentId == paymentIntentId)&&(identical(other.clientSecret, clientSecret) || other.clientSecret == clientSecret)&&(identical(other.publishableKey, publishableKey) || other.publishableKey == publishableKey)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.ephemeralKeySecret, ephemeralKeySecret) || other.ephemeralKeySecret == ephemeralKeySecret));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentIntentId,clientSecret,publishableKey,customerId,ephemeralKeySecret);

@override
String toString() {
  return 'StripePaymentModel(paymentIntentId: $paymentIntentId, clientSecret: $clientSecret, publishableKey: $publishableKey, customerId: $customerId, ephemeralKeySecret: $ephemeralKeySecret)';
}


}

/// @nodoc
abstract mixin class _$StripePaymentModelCopyWith<$Res> implements $StripePaymentModelCopyWith<$Res> {
  factory _$StripePaymentModelCopyWith(_StripePaymentModel value, $Res Function(_StripePaymentModel) _then) = __$StripePaymentModelCopyWithImpl;
@override @useResult
$Res call({
 String paymentIntentId, String clientSecret, String publishableKey, String customerId, String ephemeralKeySecret
});




}
/// @nodoc
class __$StripePaymentModelCopyWithImpl<$Res>
    implements _$StripePaymentModelCopyWith<$Res> {
  __$StripePaymentModelCopyWithImpl(this._self, this._then);

  final _StripePaymentModel _self;
  final $Res Function(_StripePaymentModel) _then;

/// Create a copy of StripePaymentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentIntentId = null,Object? clientSecret = null,Object? publishableKey = null,Object? customerId = null,Object? ephemeralKeySecret = null,}) {
  return _then(_StripePaymentModel(
paymentIntentId: null == paymentIntentId ? _self.paymentIntentId : paymentIntentId // ignore: cast_nullable_to_non_nullable
as String,clientSecret: null == clientSecret ? _self.clientSecret : clientSecret // ignore: cast_nullable_to_non_nullable
as String,publishableKey: null == publishableKey ? _self.publishableKey : publishableKey // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,ephemeralKeySecret: null == ephemeralKeySecret ? _self.ephemeralKeySecret : ephemeralKeySecret // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WalletBalanceModel {

 double get balance; String get currencyCode;
/// Create a copy of WalletBalanceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletBalanceModelCopyWith<WalletBalanceModel> get copyWith => _$WalletBalanceModelCopyWithImpl<WalletBalanceModel>(this as WalletBalanceModel, _$identity);

  /// Serializes this WalletBalanceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletBalanceModel&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,balance,currencyCode);

@override
String toString() {
  return 'WalletBalanceModel(balance: $balance, currencyCode: $currencyCode)';
}


}

/// @nodoc
abstract mixin class $WalletBalanceModelCopyWith<$Res>  {
  factory $WalletBalanceModelCopyWith(WalletBalanceModel value, $Res Function(WalletBalanceModel) _then) = _$WalletBalanceModelCopyWithImpl;
@useResult
$Res call({
 double balance, String currencyCode
});




}
/// @nodoc
class _$WalletBalanceModelCopyWithImpl<$Res>
    implements $WalletBalanceModelCopyWith<$Res> {
  _$WalletBalanceModelCopyWithImpl(this._self, this._then);

  final WalletBalanceModel _self;
  final $Res Function(WalletBalanceModel) _then;

/// Create a copy of WalletBalanceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? balance = null,Object? currencyCode = null,}) {
  return _then(_self.copyWith(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WalletBalanceModel].
extension WalletBalanceModelPatterns on WalletBalanceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletBalanceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletBalanceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletBalanceModel value)  $default,){
final _that = this;
switch (_that) {
case _WalletBalanceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletBalanceModel value)?  $default,){
final _that = this;
switch (_that) {
case _WalletBalanceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double balance,  String currencyCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletBalanceModel() when $default != null:
return $default(_that.balance,_that.currencyCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double balance,  String currencyCode)  $default,) {final _that = this;
switch (_that) {
case _WalletBalanceModel():
return $default(_that.balance,_that.currencyCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double balance,  String currencyCode)?  $default,) {final _that = this;
switch (_that) {
case _WalletBalanceModel() when $default != null:
return $default(_that.balance,_that.currencyCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletBalanceModel implements WalletBalanceModel {
  const _WalletBalanceModel({required this.balance, required this.currencyCode});
  factory _WalletBalanceModel.fromJson(Map<String, dynamic> json) => _$WalletBalanceModelFromJson(json);

@override final  double balance;
@override final  String currencyCode;

/// Create a copy of WalletBalanceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletBalanceModelCopyWith<_WalletBalanceModel> get copyWith => __$WalletBalanceModelCopyWithImpl<_WalletBalanceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletBalanceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletBalanceModel&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,balance,currencyCode);

@override
String toString() {
  return 'WalletBalanceModel(balance: $balance, currencyCode: $currencyCode)';
}


}

/// @nodoc
abstract mixin class _$WalletBalanceModelCopyWith<$Res> implements $WalletBalanceModelCopyWith<$Res> {
  factory _$WalletBalanceModelCopyWith(_WalletBalanceModel value, $Res Function(_WalletBalanceModel) _then) = __$WalletBalanceModelCopyWithImpl;
@override @useResult
$Res call({
 double balance, String currencyCode
});




}
/// @nodoc
class __$WalletBalanceModelCopyWithImpl<$Res>
    implements _$WalletBalanceModelCopyWith<$Res> {
  __$WalletBalanceModelCopyWithImpl(this._self, this._then);

  final _WalletBalanceModel _self;
  final $Res Function(_WalletBalanceModel) _then;

/// Create a copy of WalletBalanceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? balance = null,Object? currencyCode = null,}) {
  return _then(_WalletBalanceModel(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WalletTopUpModel {

 double get amount; String get currencyCode; StripePaymentModel get stripePayment;
/// Create a copy of WalletTopUpModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletTopUpModelCopyWith<WalletTopUpModel> get copyWith => _$WalletTopUpModelCopyWithImpl<WalletTopUpModel>(this as WalletTopUpModel, _$identity);

  /// Serializes this WalletTopUpModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletTopUpModel&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.stripePayment, stripePayment) || other.stripePayment == stripePayment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,currencyCode,stripePayment);

@override
String toString() {
  return 'WalletTopUpModel(amount: $amount, currencyCode: $currencyCode, stripePayment: $stripePayment)';
}


}

/// @nodoc
abstract mixin class $WalletTopUpModelCopyWith<$Res>  {
  factory $WalletTopUpModelCopyWith(WalletTopUpModel value, $Res Function(WalletTopUpModel) _then) = _$WalletTopUpModelCopyWithImpl;
@useResult
$Res call({
 double amount, String currencyCode, StripePaymentModel stripePayment
});


$StripePaymentModelCopyWith<$Res> get stripePayment;

}
/// @nodoc
class _$WalletTopUpModelCopyWithImpl<$Res>
    implements $WalletTopUpModelCopyWith<$Res> {
  _$WalletTopUpModelCopyWithImpl(this._self, this._then);

  final WalletTopUpModel _self;
  final $Res Function(WalletTopUpModel) _then;

/// Create a copy of WalletTopUpModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? currencyCode = null,Object? stripePayment = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,stripePayment: null == stripePayment ? _self.stripePayment : stripePayment // ignore: cast_nullable_to_non_nullable
as StripePaymentModel,
  ));
}
/// Create a copy of WalletTopUpModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StripePaymentModelCopyWith<$Res> get stripePayment {
  
  return $StripePaymentModelCopyWith<$Res>(_self.stripePayment, (value) {
    return _then(_self.copyWith(stripePayment: value));
  });
}
}


/// Adds pattern-matching-related methods to [WalletTopUpModel].
extension WalletTopUpModelPatterns on WalletTopUpModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletTopUpModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletTopUpModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletTopUpModel value)  $default,){
final _that = this;
switch (_that) {
case _WalletTopUpModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletTopUpModel value)?  $default,){
final _that = this;
switch (_that) {
case _WalletTopUpModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double amount,  String currencyCode,  StripePaymentModel stripePayment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletTopUpModel() when $default != null:
return $default(_that.amount,_that.currencyCode,_that.stripePayment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double amount,  String currencyCode,  StripePaymentModel stripePayment)  $default,) {final _that = this;
switch (_that) {
case _WalletTopUpModel():
return $default(_that.amount,_that.currencyCode,_that.stripePayment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double amount,  String currencyCode,  StripePaymentModel stripePayment)?  $default,) {final _that = this;
switch (_that) {
case _WalletTopUpModel() when $default != null:
return $default(_that.amount,_that.currencyCode,_that.stripePayment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletTopUpModel implements WalletTopUpModel {
  const _WalletTopUpModel({required this.amount, required this.currencyCode, required this.stripePayment});
  factory _WalletTopUpModel.fromJson(Map<String, dynamic> json) => _$WalletTopUpModelFromJson(json);

@override final  double amount;
@override final  String currencyCode;
@override final  StripePaymentModel stripePayment;

/// Create a copy of WalletTopUpModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletTopUpModelCopyWith<_WalletTopUpModel> get copyWith => __$WalletTopUpModelCopyWithImpl<_WalletTopUpModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletTopUpModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletTopUpModel&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.stripePayment, stripePayment) || other.stripePayment == stripePayment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,currencyCode,stripePayment);

@override
String toString() {
  return 'WalletTopUpModel(amount: $amount, currencyCode: $currencyCode, stripePayment: $stripePayment)';
}


}

/// @nodoc
abstract mixin class _$WalletTopUpModelCopyWith<$Res> implements $WalletTopUpModelCopyWith<$Res> {
  factory _$WalletTopUpModelCopyWith(_WalletTopUpModel value, $Res Function(_WalletTopUpModel) _then) = __$WalletTopUpModelCopyWithImpl;
@override @useResult
$Res call({
 double amount, String currencyCode, StripePaymentModel stripePayment
});


@override $StripePaymentModelCopyWith<$Res> get stripePayment;

}
/// @nodoc
class __$WalletTopUpModelCopyWithImpl<$Res>
    implements _$WalletTopUpModelCopyWith<$Res> {
  __$WalletTopUpModelCopyWithImpl(this._self, this._then);

  final _WalletTopUpModel _self;
  final $Res Function(_WalletTopUpModel) _then;

/// Create a copy of WalletTopUpModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? currencyCode = null,Object? stripePayment = null,}) {
  return _then(_WalletTopUpModel(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,stripePayment: null == stripePayment ? _self.stripePayment : stripePayment // ignore: cast_nullable_to_non_nullable
as StripePaymentModel,
  ));
}

/// Create a copy of WalletTopUpModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StripePaymentModelCopyWith<$Res> get stripePayment {
  
  return $StripePaymentModelCopyWith<$Res>(_self.stripePayment, (value) {
    return _then(_self.copyWith(stripePayment: value));
  });
}
}


/// @nodoc
mixin _$WalletTransactionModel {

 String get id; String get type; String get direction; double get amount; String get currencyCode; double? get balanceAfter; String get status; String? get description; DateTime get createdAtUtc; DateTime? get completedAtUtc;
/// Create a copy of WalletTransactionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletTransactionModelCopyWith<WalletTransactionModel> get copyWith => _$WalletTransactionModelCopyWithImpl<WalletTransactionModel>(this as WalletTransactionModel, _$identity);

  /// Serializes this WalletTransactionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletTransactionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.balanceAfter, balanceAfter) || other.balanceAfter == balanceAfter)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.completedAtUtc, completedAtUtc) || other.completedAtUtc == completedAtUtc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,direction,amount,currencyCode,balanceAfter,status,description,createdAtUtc,completedAtUtc);

@override
String toString() {
  return 'WalletTransactionModel(id: $id, type: $type, direction: $direction, amount: $amount, currencyCode: $currencyCode, balanceAfter: $balanceAfter, status: $status, description: $description, createdAtUtc: $createdAtUtc, completedAtUtc: $completedAtUtc)';
}


}

/// @nodoc
abstract mixin class $WalletTransactionModelCopyWith<$Res>  {
  factory $WalletTransactionModelCopyWith(WalletTransactionModel value, $Res Function(WalletTransactionModel) _then) = _$WalletTransactionModelCopyWithImpl;
@useResult
$Res call({
 String id, String type, String direction, double amount, String currencyCode, double? balanceAfter, String status, String? description, DateTime createdAtUtc, DateTime? completedAtUtc
});




}
/// @nodoc
class _$WalletTransactionModelCopyWithImpl<$Res>
    implements $WalletTransactionModelCopyWith<$Res> {
  _$WalletTransactionModelCopyWithImpl(this._self, this._then);

  final WalletTransactionModel _self;
  final $Res Function(WalletTransactionModel) _then;

/// Create a copy of WalletTransactionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? direction = null,Object? amount = null,Object? currencyCode = null,Object? balanceAfter = freezed,Object? status = null,Object? description = freezed,Object? createdAtUtc = null,Object? completedAtUtc = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,balanceAfter: freezed == balanceAfter ? _self.balanceAfter : balanceAfter // ignore: cast_nullable_to_non_nullable
as double?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,completedAtUtc: freezed == completedAtUtc ? _self.completedAtUtc : completedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WalletTransactionModel].
extension WalletTransactionModelPatterns on WalletTransactionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletTransactionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletTransactionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletTransactionModel value)  $default,){
final _that = this;
switch (_that) {
case _WalletTransactionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletTransactionModel value)?  $default,){
final _that = this;
switch (_that) {
case _WalletTransactionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  String direction,  double amount,  String currencyCode,  double? balanceAfter,  String status,  String? description,  DateTime createdAtUtc,  DateTime? completedAtUtc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletTransactionModel() when $default != null:
return $default(_that.id,_that.type,_that.direction,_that.amount,_that.currencyCode,_that.balanceAfter,_that.status,_that.description,_that.createdAtUtc,_that.completedAtUtc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  String direction,  double amount,  String currencyCode,  double? balanceAfter,  String status,  String? description,  DateTime createdAtUtc,  DateTime? completedAtUtc)  $default,) {final _that = this;
switch (_that) {
case _WalletTransactionModel():
return $default(_that.id,_that.type,_that.direction,_that.amount,_that.currencyCode,_that.balanceAfter,_that.status,_that.description,_that.createdAtUtc,_that.completedAtUtc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  String direction,  double amount,  String currencyCode,  double? balanceAfter,  String status,  String? description,  DateTime createdAtUtc,  DateTime? completedAtUtc)?  $default,) {final _that = this;
switch (_that) {
case _WalletTransactionModel() when $default != null:
return $default(_that.id,_that.type,_that.direction,_that.amount,_that.currencyCode,_that.balanceAfter,_that.status,_that.description,_that.createdAtUtc,_that.completedAtUtc);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletTransactionModel implements WalletTransactionModel {
  const _WalletTransactionModel({required this.id, required this.type, required this.direction, required this.amount, required this.currencyCode, this.balanceAfter, required this.status, this.description, required this.createdAtUtc, this.completedAtUtc});
  factory _WalletTransactionModel.fromJson(Map<String, dynamic> json) => _$WalletTransactionModelFromJson(json);

@override final  String id;
@override final  String type;
@override final  String direction;
@override final  double amount;
@override final  String currencyCode;
@override final  double? balanceAfter;
@override final  String status;
@override final  String? description;
@override final  DateTime createdAtUtc;
@override final  DateTime? completedAtUtc;

/// Create a copy of WalletTransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletTransactionModelCopyWith<_WalletTransactionModel> get copyWith => __$WalletTransactionModelCopyWithImpl<_WalletTransactionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletTransactionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletTransactionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.balanceAfter, balanceAfter) || other.balanceAfter == balanceAfter)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.completedAtUtc, completedAtUtc) || other.completedAtUtc == completedAtUtc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,direction,amount,currencyCode,balanceAfter,status,description,createdAtUtc,completedAtUtc);

@override
String toString() {
  return 'WalletTransactionModel(id: $id, type: $type, direction: $direction, amount: $amount, currencyCode: $currencyCode, balanceAfter: $balanceAfter, status: $status, description: $description, createdAtUtc: $createdAtUtc, completedAtUtc: $completedAtUtc)';
}


}

/// @nodoc
abstract mixin class _$WalletTransactionModelCopyWith<$Res> implements $WalletTransactionModelCopyWith<$Res> {
  factory _$WalletTransactionModelCopyWith(_WalletTransactionModel value, $Res Function(_WalletTransactionModel) _then) = __$WalletTransactionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String direction, double amount, String currencyCode, double? balanceAfter, String status, String? description, DateTime createdAtUtc, DateTime? completedAtUtc
});




}
/// @nodoc
class __$WalletTransactionModelCopyWithImpl<$Res>
    implements _$WalletTransactionModelCopyWith<$Res> {
  __$WalletTransactionModelCopyWithImpl(this._self, this._then);

  final _WalletTransactionModel _self;
  final $Res Function(_WalletTransactionModel) _then;

/// Create a copy of WalletTransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? direction = null,Object? amount = null,Object? currencyCode = null,Object? balanceAfter = freezed,Object? status = null,Object? description = freezed,Object? createdAtUtc = null,Object? completedAtUtc = freezed,}) {
  return _then(_WalletTransactionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,balanceAfter: freezed == balanceAfter ? _self.balanceAfter : balanceAfter // ignore: cast_nullable_to_non_nullable
as double?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,completedAtUtc: freezed == completedAtUtc ? _self.completedAtUtc : completedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$WalletTransactionsPageModel {

 List<WalletTransactionModel> get items; int get totalCount; int get page; int get pageSize;
/// Create a copy of WalletTransactionsPageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletTransactionsPageModelCopyWith<WalletTransactionsPageModel> get copyWith => _$WalletTransactionsPageModelCopyWithImpl<WalletTransactionsPageModel>(this as WalletTransactionsPageModel, _$identity);

  /// Serializes this WalletTransactionsPageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletTransactionsPageModel&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),totalCount,page,pageSize);

@override
String toString() {
  return 'WalletTransactionsPageModel(items: $items, totalCount: $totalCount, page: $page, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class $WalletTransactionsPageModelCopyWith<$Res>  {
  factory $WalletTransactionsPageModelCopyWith(WalletTransactionsPageModel value, $Res Function(WalletTransactionsPageModel) _then) = _$WalletTransactionsPageModelCopyWithImpl;
@useResult
$Res call({
 List<WalletTransactionModel> items, int totalCount, int page, int pageSize
});




}
/// @nodoc
class _$WalletTransactionsPageModelCopyWithImpl<$Res>
    implements $WalletTransactionsPageModelCopyWith<$Res> {
  _$WalletTransactionsPageModelCopyWithImpl(this._self, this._then);

  final WalletTransactionsPageModel _self;
  final $Res Function(WalletTransactionsPageModel) _then;

/// Create a copy of WalletTransactionsPageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? totalCount = null,Object? page = null,Object? pageSize = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<WalletTransactionModel>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WalletTransactionsPageModel].
extension WalletTransactionsPageModelPatterns on WalletTransactionsPageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletTransactionsPageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletTransactionsPageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletTransactionsPageModel value)  $default,){
final _that = this;
switch (_that) {
case _WalletTransactionsPageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletTransactionsPageModel value)?  $default,){
final _that = this;
switch (_that) {
case _WalletTransactionsPageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<WalletTransactionModel> items,  int totalCount,  int page,  int pageSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletTransactionsPageModel() when $default != null:
return $default(_that.items,_that.totalCount,_that.page,_that.pageSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<WalletTransactionModel> items,  int totalCount,  int page,  int pageSize)  $default,) {final _that = this;
switch (_that) {
case _WalletTransactionsPageModel():
return $default(_that.items,_that.totalCount,_that.page,_that.pageSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<WalletTransactionModel> items,  int totalCount,  int page,  int pageSize)?  $default,) {final _that = this;
switch (_that) {
case _WalletTransactionsPageModel() when $default != null:
return $default(_that.items,_that.totalCount,_that.page,_that.pageSize);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletTransactionsPageModel implements WalletTransactionsPageModel {
  const _WalletTransactionsPageModel({final  List<WalletTransactionModel> items = const <WalletTransactionModel>[], this.totalCount = 0, this.page = 1, this.pageSize = 20}): _items = items;
  factory _WalletTransactionsPageModel.fromJson(Map<String, dynamic> json) => _$WalletTransactionsPageModelFromJson(json);

 final  List<WalletTransactionModel> _items;
@override@JsonKey() List<WalletTransactionModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int totalCount;
@override@JsonKey() final  int page;
@override@JsonKey() final  int pageSize;

/// Create a copy of WalletTransactionsPageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletTransactionsPageModelCopyWith<_WalletTransactionsPageModel> get copyWith => __$WalletTransactionsPageModelCopyWithImpl<_WalletTransactionsPageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletTransactionsPageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletTransactionsPageModel&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),totalCount,page,pageSize);

@override
String toString() {
  return 'WalletTransactionsPageModel(items: $items, totalCount: $totalCount, page: $page, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class _$WalletTransactionsPageModelCopyWith<$Res> implements $WalletTransactionsPageModelCopyWith<$Res> {
  factory _$WalletTransactionsPageModelCopyWith(_WalletTransactionsPageModel value, $Res Function(_WalletTransactionsPageModel) _then) = __$WalletTransactionsPageModelCopyWithImpl;
@override @useResult
$Res call({
 List<WalletTransactionModel> items, int totalCount, int page, int pageSize
});




}
/// @nodoc
class __$WalletTransactionsPageModelCopyWithImpl<$Res>
    implements _$WalletTransactionsPageModelCopyWith<$Res> {
  __$WalletTransactionsPageModelCopyWithImpl(this._self, this._then);

  final _WalletTransactionsPageModel _self;
  final $Res Function(_WalletTransactionsPageModel) _then;

/// Create a copy of WalletTransactionsPageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? totalCount = null,Object? page = null,Object? pageSize = null,}) {
  return _then(_WalletTransactionsPageModel(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<WalletTransactionModel>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
