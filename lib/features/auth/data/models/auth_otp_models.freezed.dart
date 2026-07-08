// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_otp_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OtpRequestResponseModel {

 String get otpRequestId; int get expiresInSeconds; int get resendAvailableInSeconds;
/// Create a copy of OtpRequestResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpRequestResponseModelCopyWith<OtpRequestResponseModel> get copyWith => _$OtpRequestResponseModelCopyWithImpl<OtpRequestResponseModel>(this as OtpRequestResponseModel, _$identity);

  /// Serializes this OtpRequestResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpRequestResponseModel&&(identical(other.otpRequestId, otpRequestId) || other.otpRequestId == otpRequestId)&&(identical(other.expiresInSeconds, expiresInSeconds) || other.expiresInSeconds == expiresInSeconds)&&(identical(other.resendAvailableInSeconds, resendAvailableInSeconds) || other.resendAvailableInSeconds == resendAvailableInSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,otpRequestId,expiresInSeconds,resendAvailableInSeconds);

@override
String toString() {
  return 'OtpRequestResponseModel(otpRequestId: $otpRequestId, expiresInSeconds: $expiresInSeconds, resendAvailableInSeconds: $resendAvailableInSeconds)';
}


}

/// @nodoc
abstract mixin class $OtpRequestResponseModelCopyWith<$Res>  {
  factory $OtpRequestResponseModelCopyWith(OtpRequestResponseModel value, $Res Function(OtpRequestResponseModel) _then) = _$OtpRequestResponseModelCopyWithImpl;
@useResult
$Res call({
 String otpRequestId, int expiresInSeconds, int resendAvailableInSeconds
});




}
/// @nodoc
class _$OtpRequestResponseModelCopyWithImpl<$Res>
    implements $OtpRequestResponseModelCopyWith<$Res> {
  _$OtpRequestResponseModelCopyWithImpl(this._self, this._then);

  final OtpRequestResponseModel _self;
  final $Res Function(OtpRequestResponseModel) _then;

/// Create a copy of OtpRequestResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? otpRequestId = null,Object? expiresInSeconds = null,Object? resendAvailableInSeconds = null,}) {
  return _then(_self.copyWith(
otpRequestId: null == otpRequestId ? _self.otpRequestId : otpRequestId // ignore: cast_nullable_to_non_nullable
as String,expiresInSeconds: null == expiresInSeconds ? _self.expiresInSeconds : expiresInSeconds // ignore: cast_nullable_to_non_nullable
as int,resendAvailableInSeconds: null == resendAvailableInSeconds ? _self.resendAvailableInSeconds : resendAvailableInSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OtpRequestResponseModel].
extension OtpRequestResponseModelPatterns on OtpRequestResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OtpRequestResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OtpRequestResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OtpRequestResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _OtpRequestResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OtpRequestResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _OtpRequestResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String otpRequestId,  int expiresInSeconds,  int resendAvailableInSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OtpRequestResponseModel() when $default != null:
return $default(_that.otpRequestId,_that.expiresInSeconds,_that.resendAvailableInSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String otpRequestId,  int expiresInSeconds,  int resendAvailableInSeconds)  $default,) {final _that = this;
switch (_that) {
case _OtpRequestResponseModel():
return $default(_that.otpRequestId,_that.expiresInSeconds,_that.resendAvailableInSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String otpRequestId,  int expiresInSeconds,  int resendAvailableInSeconds)?  $default,) {final _that = this;
switch (_that) {
case _OtpRequestResponseModel() when $default != null:
return $default(_that.otpRequestId,_that.expiresInSeconds,_that.resendAvailableInSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OtpRequestResponseModel implements OtpRequestResponseModel {
  const _OtpRequestResponseModel({required this.otpRequestId, required this.expiresInSeconds, required this.resendAvailableInSeconds});
  factory _OtpRequestResponseModel.fromJson(Map<String, dynamic> json) => _$OtpRequestResponseModelFromJson(json);

@override final  String otpRequestId;
@override final  int expiresInSeconds;
@override final  int resendAvailableInSeconds;

/// Create a copy of OtpRequestResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpRequestResponseModelCopyWith<_OtpRequestResponseModel> get copyWith => __$OtpRequestResponseModelCopyWithImpl<_OtpRequestResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OtpRequestResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpRequestResponseModel&&(identical(other.otpRequestId, otpRequestId) || other.otpRequestId == otpRequestId)&&(identical(other.expiresInSeconds, expiresInSeconds) || other.expiresInSeconds == expiresInSeconds)&&(identical(other.resendAvailableInSeconds, resendAvailableInSeconds) || other.resendAvailableInSeconds == resendAvailableInSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,otpRequestId,expiresInSeconds,resendAvailableInSeconds);

@override
String toString() {
  return 'OtpRequestResponseModel(otpRequestId: $otpRequestId, expiresInSeconds: $expiresInSeconds, resendAvailableInSeconds: $resendAvailableInSeconds)';
}


}

/// @nodoc
abstract mixin class _$OtpRequestResponseModelCopyWith<$Res> implements $OtpRequestResponseModelCopyWith<$Res> {
  factory _$OtpRequestResponseModelCopyWith(_OtpRequestResponseModel value, $Res Function(_OtpRequestResponseModel) _then) = __$OtpRequestResponseModelCopyWithImpl;
@override @useResult
$Res call({
 String otpRequestId, int expiresInSeconds, int resendAvailableInSeconds
});




}
/// @nodoc
class __$OtpRequestResponseModelCopyWithImpl<$Res>
    implements _$OtpRequestResponseModelCopyWith<$Res> {
  __$OtpRequestResponseModelCopyWithImpl(this._self, this._then);

  final _OtpRequestResponseModel _self;
  final $Res Function(_OtpRequestResponseModel) _then;

/// Create a copy of OtpRequestResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? otpRequestId = null,Object? expiresInSeconds = null,Object? resendAvailableInSeconds = null,}) {
  return _then(_OtpRequestResponseModel(
otpRequestId: null == otpRequestId ? _self.otpRequestId : otpRequestId // ignore: cast_nullable_to_non_nullable
as String,expiresInSeconds: null == expiresInSeconds ? _self.expiresInSeconds : expiresInSeconds // ignore: cast_nullable_to_non_nullable
as int,resendAvailableInSeconds: null == resendAvailableInSeconds ? _self.resendAvailableInSeconds : resendAvailableInSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RegistrationChallengeModel {

 String get registrationToken; String? get email; String? get name;
/// Create a copy of RegistrationChallengeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegistrationChallengeModelCopyWith<RegistrationChallengeModel> get copyWith => _$RegistrationChallengeModelCopyWithImpl<RegistrationChallengeModel>(this as RegistrationChallengeModel, _$identity);

  /// Serializes this RegistrationChallengeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationChallengeModel&&(identical(other.registrationToken, registrationToken) || other.registrationToken == registrationToken)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,registrationToken,email,name);

@override
String toString() {
  return 'RegistrationChallengeModel(registrationToken: $registrationToken, email: $email, name: $name)';
}


}

/// @nodoc
abstract mixin class $RegistrationChallengeModelCopyWith<$Res>  {
  factory $RegistrationChallengeModelCopyWith(RegistrationChallengeModel value, $Res Function(RegistrationChallengeModel) _then) = _$RegistrationChallengeModelCopyWithImpl;
@useResult
$Res call({
 String registrationToken, String? email, String? name
});




}
/// @nodoc
class _$RegistrationChallengeModelCopyWithImpl<$Res>
    implements $RegistrationChallengeModelCopyWith<$Res> {
  _$RegistrationChallengeModelCopyWithImpl(this._self, this._then);

  final RegistrationChallengeModel _self;
  final $Res Function(RegistrationChallengeModel) _then;

/// Create a copy of RegistrationChallengeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? registrationToken = null,Object? email = freezed,Object? name = freezed,}) {
  return _then(_self.copyWith(
registrationToken: null == registrationToken ? _self.registrationToken : registrationToken // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegistrationChallengeModel].
extension RegistrationChallengeModelPatterns on RegistrationChallengeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegistrationChallengeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegistrationChallengeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegistrationChallengeModel value)  $default,){
final _that = this;
switch (_that) {
case _RegistrationChallengeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegistrationChallengeModel value)?  $default,){
final _that = this;
switch (_that) {
case _RegistrationChallengeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String registrationToken,  String? email,  String? name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegistrationChallengeModel() when $default != null:
return $default(_that.registrationToken,_that.email,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String registrationToken,  String? email,  String? name)  $default,) {final _that = this;
switch (_that) {
case _RegistrationChallengeModel():
return $default(_that.registrationToken,_that.email,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String registrationToken,  String? email,  String? name)?  $default,) {final _that = this;
switch (_that) {
case _RegistrationChallengeModel() when $default != null:
return $default(_that.registrationToken,_that.email,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegistrationChallengeModel implements RegistrationChallengeModel {
  const _RegistrationChallengeModel({required this.registrationToken, this.email, this.name});
  factory _RegistrationChallengeModel.fromJson(Map<String, dynamic> json) => _$RegistrationChallengeModelFromJson(json);

@override final  String registrationToken;
@override final  String? email;
@override final  String? name;

/// Create a copy of RegistrationChallengeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegistrationChallengeModelCopyWith<_RegistrationChallengeModel> get copyWith => __$RegistrationChallengeModelCopyWithImpl<_RegistrationChallengeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegistrationChallengeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegistrationChallengeModel&&(identical(other.registrationToken, registrationToken) || other.registrationToken == registrationToken)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,registrationToken,email,name);

@override
String toString() {
  return 'RegistrationChallengeModel(registrationToken: $registrationToken, email: $email, name: $name)';
}


}

/// @nodoc
abstract mixin class _$RegistrationChallengeModelCopyWith<$Res> implements $RegistrationChallengeModelCopyWith<$Res> {
  factory _$RegistrationChallengeModelCopyWith(_RegistrationChallengeModel value, $Res Function(_RegistrationChallengeModel) _then) = __$RegistrationChallengeModelCopyWithImpl;
@override @useResult
$Res call({
 String registrationToken, String? email, String? name
});




}
/// @nodoc
class __$RegistrationChallengeModelCopyWithImpl<$Res>
    implements _$RegistrationChallengeModelCopyWith<$Res> {
  __$RegistrationChallengeModelCopyWithImpl(this._self, this._then);

  final _RegistrationChallengeModel _self;
  final $Res Function(_RegistrationChallengeModel) _then;

/// Create a copy of RegistrationChallengeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? registrationToken = null,Object? email = freezed,Object? name = freezed,}) {
  return _then(_RegistrationChallengeModel(
registrationToken: null == registrationToken ? _self.registrationToken : registrationToken // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AuthResultModel {

 AuthLoginResponseModel? get session; RegistrationChallengeModel? get registration;
/// Create a copy of AuthResultModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthResultModelCopyWith<AuthResultModel> get copyWith => _$AuthResultModelCopyWithImpl<AuthResultModel>(this as AuthResultModel, _$identity);

  /// Serializes this AuthResultModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthResultModel&&(identical(other.session, session) || other.session == session)&&(identical(other.registration, registration) || other.registration == registration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,session,registration);

@override
String toString() {
  return 'AuthResultModel(session: $session, registration: $registration)';
}


}

/// @nodoc
abstract mixin class $AuthResultModelCopyWith<$Res>  {
  factory $AuthResultModelCopyWith(AuthResultModel value, $Res Function(AuthResultModel) _then) = _$AuthResultModelCopyWithImpl;
@useResult
$Res call({
 AuthLoginResponseModel? session, RegistrationChallengeModel? registration
});


$AuthLoginResponseModelCopyWith<$Res>? get session;$RegistrationChallengeModelCopyWith<$Res>? get registration;

}
/// @nodoc
class _$AuthResultModelCopyWithImpl<$Res>
    implements $AuthResultModelCopyWith<$Res> {
  _$AuthResultModelCopyWithImpl(this._self, this._then);

  final AuthResultModel _self;
  final $Res Function(AuthResultModel) _then;

/// Create a copy of AuthResultModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? session = freezed,Object? registration = freezed,}) {
  return _then(_self.copyWith(
session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as AuthLoginResponseModel?,registration: freezed == registration ? _self.registration : registration // ignore: cast_nullable_to_non_nullable
as RegistrationChallengeModel?,
  ));
}
/// Create a copy of AuthResultModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthLoginResponseModelCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $AuthLoginResponseModelCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of AuthResultModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegistrationChallengeModelCopyWith<$Res>? get registration {
    if (_self.registration == null) {
    return null;
  }

  return $RegistrationChallengeModelCopyWith<$Res>(_self.registration!, (value) {
    return _then(_self.copyWith(registration: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthResultModel].
extension AuthResultModelPatterns on AuthResultModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthResultModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthResultModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthResultModel value)  $default,){
final _that = this;
switch (_that) {
case _AuthResultModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthResultModel value)?  $default,){
final _that = this;
switch (_that) {
case _AuthResultModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AuthLoginResponseModel? session,  RegistrationChallengeModel? registration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthResultModel() when $default != null:
return $default(_that.session,_that.registration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AuthLoginResponseModel? session,  RegistrationChallengeModel? registration)  $default,) {final _that = this;
switch (_that) {
case _AuthResultModel():
return $default(_that.session,_that.registration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AuthLoginResponseModel? session,  RegistrationChallengeModel? registration)?  $default,) {final _that = this;
switch (_that) {
case _AuthResultModel() when $default != null:
return $default(_that.session,_that.registration);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthResultModel implements AuthResultModel {
  const _AuthResultModel({this.session, this.registration});
  factory _AuthResultModel.fromJson(Map<String, dynamic> json) => _$AuthResultModelFromJson(json);

@override final  AuthLoginResponseModel? session;
@override final  RegistrationChallengeModel? registration;

/// Create a copy of AuthResultModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthResultModelCopyWith<_AuthResultModel> get copyWith => __$AuthResultModelCopyWithImpl<_AuthResultModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthResultModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthResultModel&&(identical(other.session, session) || other.session == session)&&(identical(other.registration, registration) || other.registration == registration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,session,registration);

@override
String toString() {
  return 'AuthResultModel(session: $session, registration: $registration)';
}


}

/// @nodoc
abstract mixin class _$AuthResultModelCopyWith<$Res> implements $AuthResultModelCopyWith<$Res> {
  factory _$AuthResultModelCopyWith(_AuthResultModel value, $Res Function(_AuthResultModel) _then) = __$AuthResultModelCopyWithImpl;
@override @useResult
$Res call({
 AuthLoginResponseModel? session, RegistrationChallengeModel? registration
});


@override $AuthLoginResponseModelCopyWith<$Res>? get session;@override $RegistrationChallengeModelCopyWith<$Res>? get registration;

}
/// @nodoc
class __$AuthResultModelCopyWithImpl<$Res>
    implements _$AuthResultModelCopyWith<$Res> {
  __$AuthResultModelCopyWithImpl(this._self, this._then);

  final _AuthResultModel _self;
  final $Res Function(_AuthResultModel) _then;

/// Create a copy of AuthResultModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? session = freezed,Object? registration = freezed,}) {
  return _then(_AuthResultModel(
session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as AuthLoginResponseModel?,registration: freezed == registration ? _self.registration : registration // ignore: cast_nullable_to_non_nullable
as RegistrationChallengeModel?,
  ));
}

/// Create a copy of AuthResultModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthLoginResponseModelCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $AuthLoginResponseModelCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of AuthResultModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegistrationChallengeModelCopyWith<$Res>? get registration {
    if (_self.registration == null) {
    return null;
  }

  return $RegistrationChallengeModelCopyWith<$Res>(_self.registration!, (value) {
    return _then(_self.copyWith(registration: value));
  });
}
}

// dart format on
