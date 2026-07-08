// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_method_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentMethodModel {

 String get id; String get cardBrand; String get lastFour; int get expiryMonth; int get expiryYear; String? get cardholderName; bool get isDefault;
/// Create a copy of PaymentMethodModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentMethodModelCopyWith<PaymentMethodModel> get copyWith => _$PaymentMethodModelCopyWithImpl<PaymentMethodModel>(this as PaymentMethodModel, _$identity);

  /// Serializes this PaymentMethodModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentMethodModel&&(identical(other.id, id) || other.id == id)&&(identical(other.cardBrand, cardBrand) || other.cardBrand == cardBrand)&&(identical(other.lastFour, lastFour) || other.lastFour == lastFour)&&(identical(other.expiryMonth, expiryMonth) || other.expiryMonth == expiryMonth)&&(identical(other.expiryYear, expiryYear) || other.expiryYear == expiryYear)&&(identical(other.cardholderName, cardholderName) || other.cardholderName == cardholderName)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,cardBrand,lastFour,expiryMonth,expiryYear,cardholderName,isDefault);

@override
String toString() {
  return 'PaymentMethodModel(id: $id, cardBrand: $cardBrand, lastFour: $lastFour, expiryMonth: $expiryMonth, expiryYear: $expiryYear, cardholderName: $cardholderName, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class $PaymentMethodModelCopyWith<$Res>  {
  factory $PaymentMethodModelCopyWith(PaymentMethodModel value, $Res Function(PaymentMethodModel) _then) = _$PaymentMethodModelCopyWithImpl;
@useResult
$Res call({
 String id, String cardBrand, String lastFour, int expiryMonth, int expiryYear, String? cardholderName, bool isDefault
});




}
/// @nodoc
class _$PaymentMethodModelCopyWithImpl<$Res>
    implements $PaymentMethodModelCopyWith<$Res> {
  _$PaymentMethodModelCopyWithImpl(this._self, this._then);

  final PaymentMethodModel _self;
  final $Res Function(PaymentMethodModel) _then;

/// Create a copy of PaymentMethodModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? cardBrand = null,Object? lastFour = null,Object? expiryMonth = null,Object? expiryYear = null,Object? cardholderName = freezed,Object? isDefault = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,cardBrand: null == cardBrand ? _self.cardBrand : cardBrand // ignore: cast_nullable_to_non_nullable
as String,lastFour: null == lastFour ? _self.lastFour : lastFour // ignore: cast_nullable_to_non_nullable
as String,expiryMonth: null == expiryMonth ? _self.expiryMonth : expiryMonth // ignore: cast_nullable_to_non_nullable
as int,expiryYear: null == expiryYear ? _self.expiryYear : expiryYear // ignore: cast_nullable_to_non_nullable
as int,cardholderName: freezed == cardholderName ? _self.cardholderName : cardholderName // ignore: cast_nullable_to_non_nullable
as String?,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentMethodModel].
extension PaymentMethodModelPatterns on PaymentMethodModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentMethodModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentMethodModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentMethodModel value)  $default,){
final _that = this;
switch (_that) {
case _PaymentMethodModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentMethodModel value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentMethodModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String cardBrand,  String lastFour,  int expiryMonth,  int expiryYear,  String? cardholderName,  bool isDefault)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentMethodModel() when $default != null:
return $default(_that.id,_that.cardBrand,_that.lastFour,_that.expiryMonth,_that.expiryYear,_that.cardholderName,_that.isDefault);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String cardBrand,  String lastFour,  int expiryMonth,  int expiryYear,  String? cardholderName,  bool isDefault)  $default,) {final _that = this;
switch (_that) {
case _PaymentMethodModel():
return $default(_that.id,_that.cardBrand,_that.lastFour,_that.expiryMonth,_that.expiryYear,_that.cardholderName,_that.isDefault);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String cardBrand,  String lastFour,  int expiryMonth,  int expiryYear,  String? cardholderName,  bool isDefault)?  $default,) {final _that = this;
switch (_that) {
case _PaymentMethodModel() when $default != null:
return $default(_that.id,_that.cardBrand,_that.lastFour,_that.expiryMonth,_that.expiryYear,_that.cardholderName,_that.isDefault);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentMethodModel implements PaymentMethodModel {
  const _PaymentMethodModel({required this.id, required this.cardBrand, required this.lastFour, required this.expiryMonth, required this.expiryYear, this.cardholderName, this.isDefault = false});
  factory _PaymentMethodModel.fromJson(Map<String, dynamic> json) => _$PaymentMethodModelFromJson(json);

@override final  String id;
@override final  String cardBrand;
@override final  String lastFour;
@override final  int expiryMonth;
@override final  int expiryYear;
@override final  String? cardholderName;
@override@JsonKey() final  bool isDefault;

/// Create a copy of PaymentMethodModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentMethodModelCopyWith<_PaymentMethodModel> get copyWith => __$PaymentMethodModelCopyWithImpl<_PaymentMethodModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentMethodModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentMethodModel&&(identical(other.id, id) || other.id == id)&&(identical(other.cardBrand, cardBrand) || other.cardBrand == cardBrand)&&(identical(other.lastFour, lastFour) || other.lastFour == lastFour)&&(identical(other.expiryMonth, expiryMonth) || other.expiryMonth == expiryMonth)&&(identical(other.expiryYear, expiryYear) || other.expiryYear == expiryYear)&&(identical(other.cardholderName, cardholderName) || other.cardholderName == cardholderName)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,cardBrand,lastFour,expiryMonth,expiryYear,cardholderName,isDefault);

@override
String toString() {
  return 'PaymentMethodModel(id: $id, cardBrand: $cardBrand, lastFour: $lastFour, expiryMonth: $expiryMonth, expiryYear: $expiryYear, cardholderName: $cardholderName, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class _$PaymentMethodModelCopyWith<$Res> implements $PaymentMethodModelCopyWith<$Res> {
  factory _$PaymentMethodModelCopyWith(_PaymentMethodModel value, $Res Function(_PaymentMethodModel) _then) = __$PaymentMethodModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String cardBrand, String lastFour, int expiryMonth, int expiryYear, String? cardholderName, bool isDefault
});




}
/// @nodoc
class __$PaymentMethodModelCopyWithImpl<$Res>
    implements _$PaymentMethodModelCopyWith<$Res> {
  __$PaymentMethodModelCopyWithImpl(this._self, this._then);

  final _PaymentMethodModel _self;
  final $Res Function(_PaymentMethodModel) _then;

/// Create a copy of PaymentMethodModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? cardBrand = null,Object? lastFour = null,Object? expiryMonth = null,Object? expiryYear = null,Object? cardholderName = freezed,Object? isDefault = null,}) {
  return _then(_PaymentMethodModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,cardBrand: null == cardBrand ? _self.cardBrand : cardBrand // ignore: cast_nullable_to_non_nullable
as String,lastFour: null == lastFour ? _self.lastFour : lastFour // ignore: cast_nullable_to_non_nullable
as String,expiryMonth: null == expiryMonth ? _self.expiryMonth : expiryMonth // ignore: cast_nullable_to_non_nullable
as int,expiryYear: null == expiryYear ? _self.expiryYear : expiryYear // ignore: cast_nullable_to_non_nullable
as int,cardholderName: freezed == cardholderName ? _self.cardholderName : cardholderName // ignore: cast_nullable_to_non_nullable
as String?,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PaymentMethodSetupModel {

 String get setupIntentId; String get clientSecret; String get publishableKey; String get customerId; String get ephemeralKeySecret;
/// Create a copy of PaymentMethodSetupModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentMethodSetupModelCopyWith<PaymentMethodSetupModel> get copyWith => _$PaymentMethodSetupModelCopyWithImpl<PaymentMethodSetupModel>(this as PaymentMethodSetupModel, _$identity);

  /// Serializes this PaymentMethodSetupModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentMethodSetupModel&&(identical(other.setupIntentId, setupIntentId) || other.setupIntentId == setupIntentId)&&(identical(other.clientSecret, clientSecret) || other.clientSecret == clientSecret)&&(identical(other.publishableKey, publishableKey) || other.publishableKey == publishableKey)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.ephemeralKeySecret, ephemeralKeySecret) || other.ephemeralKeySecret == ephemeralKeySecret));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,setupIntentId,clientSecret,publishableKey,customerId,ephemeralKeySecret);

@override
String toString() {
  return 'PaymentMethodSetupModel(setupIntentId: $setupIntentId, clientSecret: $clientSecret, publishableKey: $publishableKey, customerId: $customerId, ephemeralKeySecret: $ephemeralKeySecret)';
}


}

/// @nodoc
abstract mixin class $PaymentMethodSetupModelCopyWith<$Res>  {
  factory $PaymentMethodSetupModelCopyWith(PaymentMethodSetupModel value, $Res Function(PaymentMethodSetupModel) _then) = _$PaymentMethodSetupModelCopyWithImpl;
@useResult
$Res call({
 String setupIntentId, String clientSecret, String publishableKey, String customerId, String ephemeralKeySecret
});




}
/// @nodoc
class _$PaymentMethodSetupModelCopyWithImpl<$Res>
    implements $PaymentMethodSetupModelCopyWith<$Res> {
  _$PaymentMethodSetupModelCopyWithImpl(this._self, this._then);

  final PaymentMethodSetupModel _self;
  final $Res Function(PaymentMethodSetupModel) _then;

/// Create a copy of PaymentMethodSetupModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? setupIntentId = null,Object? clientSecret = null,Object? publishableKey = null,Object? customerId = null,Object? ephemeralKeySecret = null,}) {
  return _then(_self.copyWith(
setupIntentId: null == setupIntentId ? _self.setupIntentId : setupIntentId // ignore: cast_nullable_to_non_nullable
as String,clientSecret: null == clientSecret ? _self.clientSecret : clientSecret // ignore: cast_nullable_to_non_nullable
as String,publishableKey: null == publishableKey ? _self.publishableKey : publishableKey // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,ephemeralKeySecret: null == ephemeralKeySecret ? _self.ephemeralKeySecret : ephemeralKeySecret // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentMethodSetupModel].
extension PaymentMethodSetupModelPatterns on PaymentMethodSetupModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentMethodSetupModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentMethodSetupModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentMethodSetupModel value)  $default,){
final _that = this;
switch (_that) {
case _PaymentMethodSetupModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentMethodSetupModel value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentMethodSetupModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String setupIntentId,  String clientSecret,  String publishableKey,  String customerId,  String ephemeralKeySecret)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentMethodSetupModel() when $default != null:
return $default(_that.setupIntentId,_that.clientSecret,_that.publishableKey,_that.customerId,_that.ephemeralKeySecret);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String setupIntentId,  String clientSecret,  String publishableKey,  String customerId,  String ephemeralKeySecret)  $default,) {final _that = this;
switch (_that) {
case _PaymentMethodSetupModel():
return $default(_that.setupIntentId,_that.clientSecret,_that.publishableKey,_that.customerId,_that.ephemeralKeySecret);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String setupIntentId,  String clientSecret,  String publishableKey,  String customerId,  String ephemeralKeySecret)?  $default,) {final _that = this;
switch (_that) {
case _PaymentMethodSetupModel() when $default != null:
return $default(_that.setupIntentId,_that.clientSecret,_that.publishableKey,_that.customerId,_that.ephemeralKeySecret);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentMethodSetupModel implements PaymentMethodSetupModel {
  const _PaymentMethodSetupModel({required this.setupIntentId, required this.clientSecret, required this.publishableKey, required this.customerId, required this.ephemeralKeySecret});
  factory _PaymentMethodSetupModel.fromJson(Map<String, dynamic> json) => _$PaymentMethodSetupModelFromJson(json);

@override final  String setupIntentId;
@override final  String clientSecret;
@override final  String publishableKey;
@override final  String customerId;
@override final  String ephemeralKeySecret;

/// Create a copy of PaymentMethodSetupModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentMethodSetupModelCopyWith<_PaymentMethodSetupModel> get copyWith => __$PaymentMethodSetupModelCopyWithImpl<_PaymentMethodSetupModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentMethodSetupModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentMethodSetupModel&&(identical(other.setupIntentId, setupIntentId) || other.setupIntentId == setupIntentId)&&(identical(other.clientSecret, clientSecret) || other.clientSecret == clientSecret)&&(identical(other.publishableKey, publishableKey) || other.publishableKey == publishableKey)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.ephemeralKeySecret, ephemeralKeySecret) || other.ephemeralKeySecret == ephemeralKeySecret));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,setupIntentId,clientSecret,publishableKey,customerId,ephemeralKeySecret);

@override
String toString() {
  return 'PaymentMethodSetupModel(setupIntentId: $setupIntentId, clientSecret: $clientSecret, publishableKey: $publishableKey, customerId: $customerId, ephemeralKeySecret: $ephemeralKeySecret)';
}


}

/// @nodoc
abstract mixin class _$PaymentMethodSetupModelCopyWith<$Res> implements $PaymentMethodSetupModelCopyWith<$Res> {
  factory _$PaymentMethodSetupModelCopyWith(_PaymentMethodSetupModel value, $Res Function(_PaymentMethodSetupModel) _then) = __$PaymentMethodSetupModelCopyWithImpl;
@override @useResult
$Res call({
 String setupIntentId, String clientSecret, String publishableKey, String customerId, String ephemeralKeySecret
});




}
/// @nodoc
class __$PaymentMethodSetupModelCopyWithImpl<$Res>
    implements _$PaymentMethodSetupModelCopyWith<$Res> {
  __$PaymentMethodSetupModelCopyWithImpl(this._self, this._then);

  final _PaymentMethodSetupModel _self;
  final $Res Function(_PaymentMethodSetupModel) _then;

/// Create a copy of PaymentMethodSetupModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? setupIntentId = null,Object? clientSecret = null,Object? publishableKey = null,Object? customerId = null,Object? ephemeralKeySecret = null,}) {
  return _then(_PaymentMethodSetupModel(
setupIntentId: null == setupIntentId ? _self.setupIntentId : setupIntentId // ignore: cast_nullable_to_non_nullable
as String,clientSecret: null == clientSecret ? _self.clientSecret : clientSecret // ignore: cast_nullable_to_non_nullable
as String,publishableKey: null == publishableKey ? _self.publishableKey : publishableKey // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,ephemeralKeySecret: null == ephemeralKeySecret ? _self.ephemeralKeySecret : ephemeralKeySecret // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PaymentPreferenceModel {

 String? get preferredMethodType; List<String> get enabledMethodTypes;
/// Create a copy of PaymentPreferenceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentPreferenceModelCopyWith<PaymentPreferenceModel> get copyWith => _$PaymentPreferenceModelCopyWithImpl<PaymentPreferenceModel>(this as PaymentPreferenceModel, _$identity);

  /// Serializes this PaymentPreferenceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentPreferenceModel&&(identical(other.preferredMethodType, preferredMethodType) || other.preferredMethodType == preferredMethodType)&&const DeepCollectionEquality().equals(other.enabledMethodTypes, enabledMethodTypes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,preferredMethodType,const DeepCollectionEquality().hash(enabledMethodTypes));

@override
String toString() {
  return 'PaymentPreferenceModel(preferredMethodType: $preferredMethodType, enabledMethodTypes: $enabledMethodTypes)';
}


}

/// @nodoc
abstract mixin class $PaymentPreferenceModelCopyWith<$Res>  {
  factory $PaymentPreferenceModelCopyWith(PaymentPreferenceModel value, $Res Function(PaymentPreferenceModel) _then) = _$PaymentPreferenceModelCopyWithImpl;
@useResult
$Res call({
 String? preferredMethodType, List<String> enabledMethodTypes
});




}
/// @nodoc
class _$PaymentPreferenceModelCopyWithImpl<$Res>
    implements $PaymentPreferenceModelCopyWith<$Res> {
  _$PaymentPreferenceModelCopyWithImpl(this._self, this._then);

  final PaymentPreferenceModel _self;
  final $Res Function(PaymentPreferenceModel) _then;

/// Create a copy of PaymentPreferenceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? preferredMethodType = freezed,Object? enabledMethodTypes = null,}) {
  return _then(_self.copyWith(
preferredMethodType: freezed == preferredMethodType ? _self.preferredMethodType : preferredMethodType // ignore: cast_nullable_to_non_nullable
as String?,enabledMethodTypes: null == enabledMethodTypes ? _self.enabledMethodTypes : enabledMethodTypes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentPreferenceModel].
extension PaymentPreferenceModelPatterns on PaymentPreferenceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentPreferenceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentPreferenceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentPreferenceModel value)  $default,){
final _that = this;
switch (_that) {
case _PaymentPreferenceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentPreferenceModel value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentPreferenceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? preferredMethodType,  List<String> enabledMethodTypes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentPreferenceModel() when $default != null:
return $default(_that.preferredMethodType,_that.enabledMethodTypes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? preferredMethodType,  List<String> enabledMethodTypes)  $default,) {final _that = this;
switch (_that) {
case _PaymentPreferenceModel():
return $default(_that.preferredMethodType,_that.enabledMethodTypes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? preferredMethodType,  List<String> enabledMethodTypes)?  $default,) {final _that = this;
switch (_that) {
case _PaymentPreferenceModel() when $default != null:
return $default(_that.preferredMethodType,_that.enabledMethodTypes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentPreferenceModel implements PaymentPreferenceModel {
  const _PaymentPreferenceModel({this.preferredMethodType, final  List<String> enabledMethodTypes = const <String>[]}): _enabledMethodTypes = enabledMethodTypes;
  factory _PaymentPreferenceModel.fromJson(Map<String, dynamic> json) => _$PaymentPreferenceModelFromJson(json);

@override final  String? preferredMethodType;
 final  List<String> _enabledMethodTypes;
@override@JsonKey() List<String> get enabledMethodTypes {
  if (_enabledMethodTypes is EqualUnmodifiableListView) return _enabledMethodTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_enabledMethodTypes);
}


/// Create a copy of PaymentPreferenceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentPreferenceModelCopyWith<_PaymentPreferenceModel> get copyWith => __$PaymentPreferenceModelCopyWithImpl<_PaymentPreferenceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentPreferenceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentPreferenceModel&&(identical(other.preferredMethodType, preferredMethodType) || other.preferredMethodType == preferredMethodType)&&const DeepCollectionEquality().equals(other._enabledMethodTypes, _enabledMethodTypes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,preferredMethodType,const DeepCollectionEquality().hash(_enabledMethodTypes));

@override
String toString() {
  return 'PaymentPreferenceModel(preferredMethodType: $preferredMethodType, enabledMethodTypes: $enabledMethodTypes)';
}


}

/// @nodoc
abstract mixin class _$PaymentPreferenceModelCopyWith<$Res> implements $PaymentPreferenceModelCopyWith<$Res> {
  factory _$PaymentPreferenceModelCopyWith(_PaymentPreferenceModel value, $Res Function(_PaymentPreferenceModel) _then) = __$PaymentPreferenceModelCopyWithImpl;
@override @useResult
$Res call({
 String? preferredMethodType, List<String> enabledMethodTypes
});




}
/// @nodoc
class __$PaymentPreferenceModelCopyWithImpl<$Res>
    implements _$PaymentPreferenceModelCopyWith<$Res> {
  __$PaymentPreferenceModelCopyWithImpl(this._self, this._then);

  final _PaymentPreferenceModel _self;
  final $Res Function(_PaymentPreferenceModel) _then;

/// Create a copy of PaymentPreferenceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? preferredMethodType = freezed,Object? enabledMethodTypes = null,}) {
  return _then(_PaymentPreferenceModel(
preferredMethodType: freezed == preferredMethodType ? _self.preferredMethodType : preferredMethodType // ignore: cast_nullable_to_non_nullable
as String?,enabledMethodTypes: null == enabledMethodTypes ? _self._enabledMethodTypes : enabledMethodTypes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$AddPaymentMethodRequestModel {

 String get paymentMethodId; bool get setAsDefault;
/// Create a copy of AddPaymentMethodRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddPaymentMethodRequestModelCopyWith<AddPaymentMethodRequestModel> get copyWith => _$AddPaymentMethodRequestModelCopyWithImpl<AddPaymentMethodRequestModel>(this as AddPaymentMethodRequestModel, _$identity);

  /// Serializes this AddPaymentMethodRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddPaymentMethodRequestModel&&(identical(other.paymentMethodId, paymentMethodId) || other.paymentMethodId == paymentMethodId)&&(identical(other.setAsDefault, setAsDefault) || other.setAsDefault == setAsDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentMethodId,setAsDefault);

@override
String toString() {
  return 'AddPaymentMethodRequestModel(paymentMethodId: $paymentMethodId, setAsDefault: $setAsDefault)';
}


}

/// @nodoc
abstract mixin class $AddPaymentMethodRequestModelCopyWith<$Res>  {
  factory $AddPaymentMethodRequestModelCopyWith(AddPaymentMethodRequestModel value, $Res Function(AddPaymentMethodRequestModel) _then) = _$AddPaymentMethodRequestModelCopyWithImpl;
@useResult
$Res call({
 String paymentMethodId, bool setAsDefault
});




}
/// @nodoc
class _$AddPaymentMethodRequestModelCopyWithImpl<$Res>
    implements $AddPaymentMethodRequestModelCopyWith<$Res> {
  _$AddPaymentMethodRequestModelCopyWithImpl(this._self, this._then);

  final AddPaymentMethodRequestModel _self;
  final $Res Function(AddPaymentMethodRequestModel) _then;

/// Create a copy of AddPaymentMethodRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentMethodId = null,Object? setAsDefault = null,}) {
  return _then(_self.copyWith(
paymentMethodId: null == paymentMethodId ? _self.paymentMethodId : paymentMethodId // ignore: cast_nullable_to_non_nullable
as String,setAsDefault: null == setAsDefault ? _self.setAsDefault : setAsDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AddPaymentMethodRequestModel].
extension AddPaymentMethodRequestModelPatterns on AddPaymentMethodRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddPaymentMethodRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddPaymentMethodRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddPaymentMethodRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _AddPaymentMethodRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddPaymentMethodRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _AddPaymentMethodRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String paymentMethodId,  bool setAsDefault)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddPaymentMethodRequestModel() when $default != null:
return $default(_that.paymentMethodId,_that.setAsDefault);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String paymentMethodId,  bool setAsDefault)  $default,) {final _that = this;
switch (_that) {
case _AddPaymentMethodRequestModel():
return $default(_that.paymentMethodId,_that.setAsDefault);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String paymentMethodId,  bool setAsDefault)?  $default,) {final _that = this;
switch (_that) {
case _AddPaymentMethodRequestModel() when $default != null:
return $default(_that.paymentMethodId,_that.setAsDefault);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddPaymentMethodRequestModel implements AddPaymentMethodRequestModel {
  const _AddPaymentMethodRequestModel({required this.paymentMethodId, this.setAsDefault = false});
  factory _AddPaymentMethodRequestModel.fromJson(Map<String, dynamic> json) => _$AddPaymentMethodRequestModelFromJson(json);

@override final  String paymentMethodId;
@override@JsonKey() final  bool setAsDefault;

/// Create a copy of AddPaymentMethodRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddPaymentMethodRequestModelCopyWith<_AddPaymentMethodRequestModel> get copyWith => __$AddPaymentMethodRequestModelCopyWithImpl<_AddPaymentMethodRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddPaymentMethodRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddPaymentMethodRequestModel&&(identical(other.paymentMethodId, paymentMethodId) || other.paymentMethodId == paymentMethodId)&&(identical(other.setAsDefault, setAsDefault) || other.setAsDefault == setAsDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentMethodId,setAsDefault);

@override
String toString() {
  return 'AddPaymentMethodRequestModel(paymentMethodId: $paymentMethodId, setAsDefault: $setAsDefault)';
}


}

/// @nodoc
abstract mixin class _$AddPaymentMethodRequestModelCopyWith<$Res> implements $AddPaymentMethodRequestModelCopyWith<$Res> {
  factory _$AddPaymentMethodRequestModelCopyWith(_AddPaymentMethodRequestModel value, $Res Function(_AddPaymentMethodRequestModel) _then) = __$AddPaymentMethodRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String paymentMethodId, bool setAsDefault
});




}
/// @nodoc
class __$AddPaymentMethodRequestModelCopyWithImpl<$Res>
    implements _$AddPaymentMethodRequestModelCopyWith<$Res> {
  __$AddPaymentMethodRequestModelCopyWithImpl(this._self, this._then);

  final _AddPaymentMethodRequestModel _self;
  final $Res Function(_AddPaymentMethodRequestModel) _then;

/// Create a copy of AddPaymentMethodRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentMethodId = null,Object? setAsDefault = null,}) {
  return _then(_AddPaymentMethodRequestModel(
paymentMethodId: null == paymentMethodId ? _self.paymentMethodId : paymentMethodId // ignore: cast_nullable_to_non_nullable
as String,setAsDefault: null == setAsDefault ? _self.setAsDefault : setAsDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
