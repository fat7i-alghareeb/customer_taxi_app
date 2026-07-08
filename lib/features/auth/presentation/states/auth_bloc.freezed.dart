// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _IntroProceed value)?  introProceed,TResult Function( _ModeChanged value)?  modeChanged,TResult Function( _MethodSelected value)?  methodSelected,TResult Function( _PhoneSubmitted value)?  phoneSubmitted,TResult Function( _EmailSubmitted value)?  emailSubmitted,TResult Function( _OtpSubmitted value)?  otpSubmitted,TResult Function( _ResendRequested value)?  resendRequested,TResult Function( _GoogleRequested value)?  googleRequested,TResult Function( _RegistrationSubmitted value)?  registrationSubmitted,TResult Function( _BackRequested value)?  backRequested,TResult Function( _ResetRequested value)?  resetRequested,TResult Function( _Tick value)?  tick,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _IntroProceed() when introProceed != null:
return introProceed(_that);case _ModeChanged() when modeChanged != null:
return modeChanged(_that);case _MethodSelected() when methodSelected != null:
return methodSelected(_that);case _PhoneSubmitted() when phoneSubmitted != null:
return phoneSubmitted(_that);case _EmailSubmitted() when emailSubmitted != null:
return emailSubmitted(_that);case _OtpSubmitted() when otpSubmitted != null:
return otpSubmitted(_that);case _ResendRequested() when resendRequested != null:
return resendRequested(_that);case _GoogleRequested() when googleRequested != null:
return googleRequested(_that);case _RegistrationSubmitted() when registrationSubmitted != null:
return registrationSubmitted(_that);case _BackRequested() when backRequested != null:
return backRequested(_that);case _ResetRequested() when resetRequested != null:
return resetRequested(_that);case _Tick() when tick != null:
return tick(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _IntroProceed value)  introProceed,required TResult Function( _ModeChanged value)  modeChanged,required TResult Function( _MethodSelected value)  methodSelected,required TResult Function( _PhoneSubmitted value)  phoneSubmitted,required TResult Function( _EmailSubmitted value)  emailSubmitted,required TResult Function( _OtpSubmitted value)  otpSubmitted,required TResult Function( _ResendRequested value)  resendRequested,required TResult Function( _GoogleRequested value)  googleRequested,required TResult Function( _RegistrationSubmitted value)  registrationSubmitted,required TResult Function( _BackRequested value)  backRequested,required TResult Function( _ResetRequested value)  resetRequested,required TResult Function( _Tick value)  tick,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _IntroProceed():
return introProceed(_that);case _ModeChanged():
return modeChanged(_that);case _MethodSelected():
return methodSelected(_that);case _PhoneSubmitted():
return phoneSubmitted(_that);case _EmailSubmitted():
return emailSubmitted(_that);case _OtpSubmitted():
return otpSubmitted(_that);case _ResendRequested():
return resendRequested(_that);case _GoogleRequested():
return googleRequested(_that);case _RegistrationSubmitted():
return registrationSubmitted(_that);case _BackRequested():
return backRequested(_that);case _ResetRequested():
return resetRequested(_that);case _Tick():
return tick(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _IntroProceed value)?  introProceed,TResult? Function( _ModeChanged value)?  modeChanged,TResult? Function( _MethodSelected value)?  methodSelected,TResult? Function( _PhoneSubmitted value)?  phoneSubmitted,TResult? Function( _EmailSubmitted value)?  emailSubmitted,TResult? Function( _OtpSubmitted value)?  otpSubmitted,TResult? Function( _ResendRequested value)?  resendRequested,TResult? Function( _GoogleRequested value)?  googleRequested,TResult? Function( _RegistrationSubmitted value)?  registrationSubmitted,TResult? Function( _BackRequested value)?  backRequested,TResult? Function( _ResetRequested value)?  resetRequested,TResult? Function( _Tick value)?  tick,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _IntroProceed() when introProceed != null:
return introProceed(_that);case _ModeChanged() when modeChanged != null:
return modeChanged(_that);case _MethodSelected() when methodSelected != null:
return methodSelected(_that);case _PhoneSubmitted() when phoneSubmitted != null:
return phoneSubmitted(_that);case _EmailSubmitted() when emailSubmitted != null:
return emailSubmitted(_that);case _OtpSubmitted() when otpSubmitted != null:
return otpSubmitted(_that);case _ResendRequested() when resendRequested != null:
return resendRequested(_that);case _GoogleRequested() when googleRequested != null:
return googleRequested(_that);case _RegistrationSubmitted() when registrationSubmitted != null:
return registrationSubmitted(_that);case _BackRequested() when backRequested != null:
return backRequested(_that);case _ResetRequested() when resetRequested != null:
return resetRequested(_that);case _Tick() when tick != null:
return tick(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( AuthMode mode)?  introProceed,TResult Function( AuthMode mode)?  modeChanged,TResult Function( AuthMethod method)?  methodSelected,TResult Function( String phone)?  phoneSubmitted,TResult Function( String email)?  emailSubmitted,TResult Function( String code)?  otpSubmitted,TResult Function()?  resendRequested,TResult Function()?  googleRequested,TResult Function( String name,  String phone,  bool verifyNow)?  registrationSubmitted,TResult Function()?  backRequested,TResult Function()?  resetRequested,TResult Function()?  tick,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _IntroProceed() when introProceed != null:
return introProceed(_that.mode);case _ModeChanged() when modeChanged != null:
return modeChanged(_that.mode);case _MethodSelected() when methodSelected != null:
return methodSelected(_that.method);case _PhoneSubmitted() when phoneSubmitted != null:
return phoneSubmitted(_that.phone);case _EmailSubmitted() when emailSubmitted != null:
return emailSubmitted(_that.email);case _OtpSubmitted() when otpSubmitted != null:
return otpSubmitted(_that.code);case _ResendRequested() when resendRequested != null:
return resendRequested();case _GoogleRequested() when googleRequested != null:
return googleRequested();case _RegistrationSubmitted() when registrationSubmitted != null:
return registrationSubmitted(_that.name,_that.phone,_that.verifyNow);case _BackRequested() when backRequested != null:
return backRequested();case _ResetRequested() when resetRequested != null:
return resetRequested();case _Tick() when tick != null:
return tick();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( AuthMode mode)  introProceed,required TResult Function( AuthMode mode)  modeChanged,required TResult Function( AuthMethod method)  methodSelected,required TResult Function( String phone)  phoneSubmitted,required TResult Function( String email)  emailSubmitted,required TResult Function( String code)  otpSubmitted,required TResult Function()  resendRequested,required TResult Function()  googleRequested,required TResult Function( String name,  String phone,  bool verifyNow)  registrationSubmitted,required TResult Function()  backRequested,required TResult Function()  resetRequested,required TResult Function()  tick,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _IntroProceed():
return introProceed(_that.mode);case _ModeChanged():
return modeChanged(_that.mode);case _MethodSelected():
return methodSelected(_that.method);case _PhoneSubmitted():
return phoneSubmitted(_that.phone);case _EmailSubmitted():
return emailSubmitted(_that.email);case _OtpSubmitted():
return otpSubmitted(_that.code);case _ResendRequested():
return resendRequested();case _GoogleRequested():
return googleRequested();case _RegistrationSubmitted():
return registrationSubmitted(_that.name,_that.phone,_that.verifyNow);case _BackRequested():
return backRequested();case _ResetRequested():
return resetRequested();case _Tick():
return tick();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( AuthMode mode)?  introProceed,TResult? Function( AuthMode mode)?  modeChanged,TResult? Function( AuthMethod method)?  methodSelected,TResult? Function( String phone)?  phoneSubmitted,TResult? Function( String email)?  emailSubmitted,TResult? Function( String code)?  otpSubmitted,TResult? Function()?  resendRequested,TResult? Function()?  googleRequested,TResult? Function( String name,  String phone,  bool verifyNow)?  registrationSubmitted,TResult? Function()?  backRequested,TResult? Function()?  resetRequested,TResult? Function()?  tick,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _IntroProceed() when introProceed != null:
return introProceed(_that.mode);case _ModeChanged() when modeChanged != null:
return modeChanged(_that.mode);case _MethodSelected() when methodSelected != null:
return methodSelected(_that.method);case _PhoneSubmitted() when phoneSubmitted != null:
return phoneSubmitted(_that.phone);case _EmailSubmitted() when emailSubmitted != null:
return emailSubmitted(_that.email);case _OtpSubmitted() when otpSubmitted != null:
return otpSubmitted(_that.code);case _ResendRequested() when resendRequested != null:
return resendRequested();case _GoogleRequested() when googleRequested != null:
return googleRequested();case _RegistrationSubmitted() when registrationSubmitted != null:
return registrationSubmitted(_that.name,_that.phone,_that.verifyNow);case _BackRequested() when backRequested != null:
return backRequested();case _ResetRequested() when resetRequested != null:
return resetRequested();case _Tick() when tick != null:
return tick();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements AuthEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.started()';
}


}




/// @nodoc


class _IntroProceed implements AuthEvent {
  const _IntroProceed(this.mode);
  

 final  AuthMode mode;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntroProceedCopyWith<_IntroProceed> get copyWith => __$IntroProceedCopyWithImpl<_IntroProceed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntroProceed&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,mode);

@override
String toString() {
  return 'AuthEvent.introProceed(mode: $mode)';
}


}

/// @nodoc
abstract mixin class _$IntroProceedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$IntroProceedCopyWith(_IntroProceed value, $Res Function(_IntroProceed) _then) = __$IntroProceedCopyWithImpl;
@useResult
$Res call({
 AuthMode mode
});




}
/// @nodoc
class __$IntroProceedCopyWithImpl<$Res>
    implements _$IntroProceedCopyWith<$Res> {
  __$IntroProceedCopyWithImpl(this._self, this._then);

  final _IntroProceed _self;
  final $Res Function(_IntroProceed) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mode = null,}) {
  return _then(_IntroProceed(
null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AuthMode,
  ));
}


}

/// @nodoc


class _ModeChanged implements AuthEvent {
  const _ModeChanged(this.mode);
  

 final  AuthMode mode;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModeChangedCopyWith<_ModeChanged> get copyWith => __$ModeChangedCopyWithImpl<_ModeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModeChanged&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,mode);

@override
String toString() {
  return 'AuthEvent.modeChanged(mode: $mode)';
}


}

/// @nodoc
abstract mixin class _$ModeChangedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$ModeChangedCopyWith(_ModeChanged value, $Res Function(_ModeChanged) _then) = __$ModeChangedCopyWithImpl;
@useResult
$Res call({
 AuthMode mode
});




}
/// @nodoc
class __$ModeChangedCopyWithImpl<$Res>
    implements _$ModeChangedCopyWith<$Res> {
  __$ModeChangedCopyWithImpl(this._self, this._then);

  final _ModeChanged _self;
  final $Res Function(_ModeChanged) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mode = null,}) {
  return _then(_ModeChanged(
null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AuthMode,
  ));
}


}

/// @nodoc


class _MethodSelected implements AuthEvent {
  const _MethodSelected(this.method);
  

 final  AuthMethod method;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MethodSelectedCopyWith<_MethodSelected> get copyWith => __$MethodSelectedCopyWithImpl<_MethodSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MethodSelected&&(identical(other.method, method) || other.method == method));
}


@override
int get hashCode => Object.hash(runtimeType,method);

@override
String toString() {
  return 'AuthEvent.methodSelected(method: $method)';
}


}

/// @nodoc
abstract mixin class _$MethodSelectedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$MethodSelectedCopyWith(_MethodSelected value, $Res Function(_MethodSelected) _then) = __$MethodSelectedCopyWithImpl;
@useResult
$Res call({
 AuthMethod method
});




}
/// @nodoc
class __$MethodSelectedCopyWithImpl<$Res>
    implements _$MethodSelectedCopyWith<$Res> {
  __$MethodSelectedCopyWithImpl(this._self, this._then);

  final _MethodSelected _self;
  final $Res Function(_MethodSelected) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? method = null,}) {
  return _then(_MethodSelected(
null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as AuthMethod,
  ));
}


}

/// @nodoc


class _PhoneSubmitted implements AuthEvent {
  const _PhoneSubmitted(this.phone);
  

 final  String phone;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneSubmittedCopyWith<_PhoneSubmitted> get copyWith => __$PhoneSubmittedCopyWithImpl<_PhoneSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneSubmitted&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode => Object.hash(runtimeType,phone);

@override
String toString() {
  return 'AuthEvent.phoneSubmitted(phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$PhoneSubmittedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$PhoneSubmittedCopyWith(_PhoneSubmitted value, $Res Function(_PhoneSubmitted) _then) = __$PhoneSubmittedCopyWithImpl;
@useResult
$Res call({
 String phone
});




}
/// @nodoc
class __$PhoneSubmittedCopyWithImpl<$Res>
    implements _$PhoneSubmittedCopyWith<$Res> {
  __$PhoneSubmittedCopyWithImpl(this._self, this._then);

  final _PhoneSubmitted _self;
  final $Res Function(_PhoneSubmitted) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phone = null,}) {
  return _then(_PhoneSubmitted(
null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _EmailSubmitted implements AuthEvent {
  const _EmailSubmitted(this.email);
  

 final  String email;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailSubmittedCopyWith<_EmailSubmitted> get copyWith => __$EmailSubmittedCopyWithImpl<_EmailSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailSubmitted&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthEvent.emailSubmitted(email: $email)';
}


}

/// @nodoc
abstract mixin class _$EmailSubmittedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$EmailSubmittedCopyWith(_EmailSubmitted value, $Res Function(_EmailSubmitted) _then) = __$EmailSubmittedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class __$EmailSubmittedCopyWithImpl<$Res>
    implements _$EmailSubmittedCopyWith<$Res> {
  __$EmailSubmittedCopyWithImpl(this._self, this._then);

  final _EmailSubmitted _self;
  final $Res Function(_EmailSubmitted) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_EmailSubmitted(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _OtpSubmitted implements AuthEvent {
  const _OtpSubmitted(this.code);
  

 final  String code;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpSubmittedCopyWith<_OtpSubmitted> get copyWith => __$OtpSubmittedCopyWithImpl<_OtpSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpSubmitted&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,code);

@override
String toString() {
  return 'AuthEvent.otpSubmitted(code: $code)';
}


}

/// @nodoc
abstract mixin class _$OtpSubmittedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$OtpSubmittedCopyWith(_OtpSubmitted value, $Res Function(_OtpSubmitted) _then) = __$OtpSubmittedCopyWithImpl;
@useResult
$Res call({
 String code
});




}
/// @nodoc
class __$OtpSubmittedCopyWithImpl<$Res>
    implements _$OtpSubmittedCopyWith<$Res> {
  __$OtpSubmittedCopyWithImpl(this._self, this._then);

  final _OtpSubmitted _self;
  final $Res Function(_OtpSubmitted) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = null,}) {
  return _then(_OtpSubmitted(
null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ResendRequested implements AuthEvent {
  const _ResendRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResendRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.resendRequested()';
}


}




/// @nodoc


class _GoogleRequested implements AuthEvent {
  const _GoogleRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoogleRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.googleRequested()';
}


}




/// @nodoc


class _RegistrationSubmitted implements AuthEvent {
  const _RegistrationSubmitted({required this.name, required this.phone, required this.verifyNow});
  

 final  String name;
 final  String phone;
 final  bool verifyNow;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegistrationSubmittedCopyWith<_RegistrationSubmitted> get copyWith => __$RegistrationSubmittedCopyWithImpl<_RegistrationSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegistrationSubmitted&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.verifyNow, verifyNow) || other.verifyNow == verifyNow));
}


@override
int get hashCode => Object.hash(runtimeType,name,phone,verifyNow);

@override
String toString() {
  return 'AuthEvent.registrationSubmitted(name: $name, phone: $phone, verifyNow: $verifyNow)';
}


}

/// @nodoc
abstract mixin class _$RegistrationSubmittedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$RegistrationSubmittedCopyWith(_RegistrationSubmitted value, $Res Function(_RegistrationSubmitted) _then) = __$RegistrationSubmittedCopyWithImpl;
@useResult
$Res call({
 String name, String phone, bool verifyNow
});




}
/// @nodoc
class __$RegistrationSubmittedCopyWithImpl<$Res>
    implements _$RegistrationSubmittedCopyWith<$Res> {
  __$RegistrationSubmittedCopyWithImpl(this._self, this._then);

  final _RegistrationSubmitted _self;
  final $Res Function(_RegistrationSubmitted) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? phone = null,Object? verifyNow = null,}) {
  return _then(_RegistrationSubmitted(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,verifyNow: null == verifyNow ? _self.verifyNow : verifyNow // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _BackRequested implements AuthEvent {
  const _BackRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.backRequested()';
}


}




/// @nodoc


class _ResetRequested implements AuthEvent {
  const _ResetRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.resetRequested()';
}


}




/// @nodoc


class _Tick implements AuthEvent {
  const _Tick();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tick);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.tick()';
}


}




/// @nodoc
mixin _$AuthState {

 AuthMode get mode; AuthStep get step; AuthMethod? get method; OtpContext? get otpContext;/// OTP request / Google / registration submit progress.
 BlocStatus<void> get requestStatus;/// Final verify → authenticated session.
 BlocStatus<AuthSession> get sessionStatus; String? get otpRequestId; String? get pendingPhone; String? get pendingEmail; String? get registrationToken; String? get registrationEmail; String? get registrationName; int get resendSeconds;/// Set when a registration used "Verify now" so the screen routes to phone verify.
 bool get routeToPhoneVerification;
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateCopyWith<AuthState> get copyWith => _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.step, step) || other.step == step)&&(identical(other.method, method) || other.method == method)&&(identical(other.otpContext, otpContext) || other.otpContext == otpContext)&&(identical(other.requestStatus, requestStatus) || other.requestStatus == requestStatus)&&(identical(other.sessionStatus, sessionStatus) || other.sessionStatus == sessionStatus)&&(identical(other.otpRequestId, otpRequestId) || other.otpRequestId == otpRequestId)&&(identical(other.pendingPhone, pendingPhone) || other.pendingPhone == pendingPhone)&&(identical(other.pendingEmail, pendingEmail) || other.pendingEmail == pendingEmail)&&(identical(other.registrationToken, registrationToken) || other.registrationToken == registrationToken)&&(identical(other.registrationEmail, registrationEmail) || other.registrationEmail == registrationEmail)&&(identical(other.registrationName, registrationName) || other.registrationName == registrationName)&&(identical(other.resendSeconds, resendSeconds) || other.resendSeconds == resendSeconds)&&(identical(other.routeToPhoneVerification, routeToPhoneVerification) || other.routeToPhoneVerification == routeToPhoneVerification));
}


@override
int get hashCode => Object.hash(runtimeType,mode,step,method,otpContext,requestStatus,sessionStatus,otpRequestId,pendingPhone,pendingEmail,registrationToken,registrationEmail,registrationName,resendSeconds,routeToPhoneVerification);

@override
String toString() {
  return 'AuthState(mode: $mode, step: $step, method: $method, otpContext: $otpContext, requestStatus: $requestStatus, sessionStatus: $sessionStatus, otpRequestId: $otpRequestId, pendingPhone: $pendingPhone, pendingEmail: $pendingEmail, registrationToken: $registrationToken, registrationEmail: $registrationEmail, registrationName: $registrationName, resendSeconds: $resendSeconds, routeToPhoneVerification: $routeToPhoneVerification)';
}


}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res>  {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) = _$AuthStateCopyWithImpl;
@useResult
$Res call({
 AuthMode mode, AuthStep step, AuthMethod? method, OtpContext? otpContext, BlocStatus<void> requestStatus, BlocStatus<AuthSession> sessionStatus, String? otpRequestId, String? pendingPhone, String? pendingEmail, String? registrationToken, String? registrationEmail, String? registrationName, int resendSeconds, bool routeToPhoneVerification
});


$BlocStatusCopyWith<void, $Res> get requestStatus;$BlocStatusCopyWith<AuthSession, $Res> get sessionStatus;

}
/// @nodoc
class _$AuthStateCopyWithImpl<$Res>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? step = null,Object? method = freezed,Object? otpContext = freezed,Object? requestStatus = null,Object? sessionStatus = null,Object? otpRequestId = freezed,Object? pendingPhone = freezed,Object? pendingEmail = freezed,Object? registrationToken = freezed,Object? registrationEmail = freezed,Object? registrationName = freezed,Object? resendSeconds = null,Object? routeToPhoneVerification = null,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AuthMode,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as AuthStep,method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as AuthMethod?,otpContext: freezed == otpContext ? _self.otpContext : otpContext // ignore: cast_nullable_to_non_nullable
as OtpContext?,requestStatus: null == requestStatus ? _self.requestStatus : requestStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,sessionStatus: null == sessionStatus ? _self.sessionStatus : sessionStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<AuthSession>,otpRequestId: freezed == otpRequestId ? _self.otpRequestId : otpRequestId // ignore: cast_nullable_to_non_nullable
as String?,pendingPhone: freezed == pendingPhone ? _self.pendingPhone : pendingPhone // ignore: cast_nullable_to_non_nullable
as String?,pendingEmail: freezed == pendingEmail ? _self.pendingEmail : pendingEmail // ignore: cast_nullable_to_non_nullable
as String?,registrationToken: freezed == registrationToken ? _self.registrationToken : registrationToken // ignore: cast_nullable_to_non_nullable
as String?,registrationEmail: freezed == registrationEmail ? _self.registrationEmail : registrationEmail // ignore: cast_nullable_to_non_nullable
as String?,registrationName: freezed == registrationName ? _self.registrationName : registrationName // ignore: cast_nullable_to_non_nullable
as String?,resendSeconds: null == resendSeconds ? _self.resendSeconds : resendSeconds // ignore: cast_nullable_to_non_nullable
as int,routeToPhoneVerification: null == routeToPhoneVerification ? _self.routeToPhoneVerification : routeToPhoneVerification // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get requestStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.requestStatus, (value) {
    return _then(_self.copyWith(requestStatus: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<AuthSession, $Res> get sessionStatus {
  
  return $BlocStatusCopyWith<AuthSession, $Res>(_self.sessionStatus, (value) {
    return _then(_self.copyWith(sessionStatus: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthState value)  $default,){
final _that = this;
switch (_that) {
case _AuthState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthState value)?  $default,){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AuthMode mode,  AuthStep step,  AuthMethod? method,  OtpContext? otpContext,  BlocStatus<void> requestStatus,  BlocStatus<AuthSession> sessionStatus,  String? otpRequestId,  String? pendingPhone,  String? pendingEmail,  String? registrationToken,  String? registrationEmail,  String? registrationName,  int resendSeconds,  bool routeToPhoneVerification)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.mode,_that.step,_that.method,_that.otpContext,_that.requestStatus,_that.sessionStatus,_that.otpRequestId,_that.pendingPhone,_that.pendingEmail,_that.registrationToken,_that.registrationEmail,_that.registrationName,_that.resendSeconds,_that.routeToPhoneVerification);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AuthMode mode,  AuthStep step,  AuthMethod? method,  OtpContext? otpContext,  BlocStatus<void> requestStatus,  BlocStatus<AuthSession> sessionStatus,  String? otpRequestId,  String? pendingPhone,  String? pendingEmail,  String? registrationToken,  String? registrationEmail,  String? registrationName,  int resendSeconds,  bool routeToPhoneVerification)  $default,) {final _that = this;
switch (_that) {
case _AuthState():
return $default(_that.mode,_that.step,_that.method,_that.otpContext,_that.requestStatus,_that.sessionStatus,_that.otpRequestId,_that.pendingPhone,_that.pendingEmail,_that.registrationToken,_that.registrationEmail,_that.registrationName,_that.resendSeconds,_that.routeToPhoneVerification);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AuthMode mode,  AuthStep step,  AuthMethod? method,  OtpContext? otpContext,  BlocStatus<void> requestStatus,  BlocStatus<AuthSession> sessionStatus,  String? otpRequestId,  String? pendingPhone,  String? pendingEmail,  String? registrationToken,  String? registrationEmail,  String? registrationName,  int resendSeconds,  bool routeToPhoneVerification)?  $default,) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.mode,_that.step,_that.method,_that.otpContext,_that.requestStatus,_that.sessionStatus,_that.otpRequestId,_that.pendingPhone,_that.pendingEmail,_that.registrationToken,_that.registrationEmail,_that.registrationName,_that.resendSeconds,_that.routeToPhoneVerification);case _:
  return null;

}
}

}

/// @nodoc


class _AuthState implements AuthState {
  const _AuthState({this.mode = AuthMode.login, this.step = AuthStep.intro, this.method, this.otpContext, this.requestStatus = const BlocStatus<void>.initial(), this.sessionStatus = const BlocStatus<AuthSession>.initial(), this.otpRequestId, this.pendingPhone, this.pendingEmail, this.registrationToken, this.registrationEmail, this.registrationName, this.resendSeconds = 0, this.routeToPhoneVerification = false});
  

@override@JsonKey() final  AuthMode mode;
@override@JsonKey() final  AuthStep step;
@override final  AuthMethod? method;
@override final  OtpContext? otpContext;
/// OTP request / Google / registration submit progress.
@override@JsonKey() final  BlocStatus<void> requestStatus;
/// Final verify → authenticated session.
@override@JsonKey() final  BlocStatus<AuthSession> sessionStatus;
@override final  String? otpRequestId;
@override final  String? pendingPhone;
@override final  String? pendingEmail;
@override final  String? registrationToken;
@override final  String? registrationEmail;
@override final  String? registrationName;
@override@JsonKey() final  int resendSeconds;
/// Set when a registration used "Verify now" so the screen routes to phone verify.
@override@JsonKey() final  bool routeToPhoneVerification;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateCopyWith<_AuthState> get copyWith => __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthState&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.step, step) || other.step == step)&&(identical(other.method, method) || other.method == method)&&(identical(other.otpContext, otpContext) || other.otpContext == otpContext)&&(identical(other.requestStatus, requestStatus) || other.requestStatus == requestStatus)&&(identical(other.sessionStatus, sessionStatus) || other.sessionStatus == sessionStatus)&&(identical(other.otpRequestId, otpRequestId) || other.otpRequestId == otpRequestId)&&(identical(other.pendingPhone, pendingPhone) || other.pendingPhone == pendingPhone)&&(identical(other.pendingEmail, pendingEmail) || other.pendingEmail == pendingEmail)&&(identical(other.registrationToken, registrationToken) || other.registrationToken == registrationToken)&&(identical(other.registrationEmail, registrationEmail) || other.registrationEmail == registrationEmail)&&(identical(other.registrationName, registrationName) || other.registrationName == registrationName)&&(identical(other.resendSeconds, resendSeconds) || other.resendSeconds == resendSeconds)&&(identical(other.routeToPhoneVerification, routeToPhoneVerification) || other.routeToPhoneVerification == routeToPhoneVerification));
}


@override
int get hashCode => Object.hash(runtimeType,mode,step,method,otpContext,requestStatus,sessionStatus,otpRequestId,pendingPhone,pendingEmail,registrationToken,registrationEmail,registrationName,resendSeconds,routeToPhoneVerification);

@override
String toString() {
  return 'AuthState(mode: $mode, step: $step, method: $method, otpContext: $otpContext, requestStatus: $requestStatus, sessionStatus: $sessionStatus, otpRequestId: $otpRequestId, pendingPhone: $pendingPhone, pendingEmail: $pendingEmail, registrationToken: $registrationToken, registrationEmail: $registrationEmail, registrationName: $registrationName, resendSeconds: $resendSeconds, routeToPhoneVerification: $routeToPhoneVerification)';
}


}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(_AuthState value, $Res Function(_AuthState) _then) = __$AuthStateCopyWithImpl;
@override @useResult
$Res call({
 AuthMode mode, AuthStep step, AuthMethod? method, OtpContext? otpContext, BlocStatus<void> requestStatus, BlocStatus<AuthSession> sessionStatus, String? otpRequestId, String? pendingPhone, String? pendingEmail, String? registrationToken, String? registrationEmail, String? registrationName, int resendSeconds, bool routeToPhoneVerification
});


@override $BlocStatusCopyWith<void, $Res> get requestStatus;@override $BlocStatusCopyWith<AuthSession, $Res> get sessionStatus;

}
/// @nodoc
class __$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? step = null,Object? method = freezed,Object? otpContext = freezed,Object? requestStatus = null,Object? sessionStatus = null,Object? otpRequestId = freezed,Object? pendingPhone = freezed,Object? pendingEmail = freezed,Object? registrationToken = freezed,Object? registrationEmail = freezed,Object? registrationName = freezed,Object? resendSeconds = null,Object? routeToPhoneVerification = null,}) {
  return _then(_AuthState(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AuthMode,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as AuthStep,method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as AuthMethod?,otpContext: freezed == otpContext ? _self.otpContext : otpContext // ignore: cast_nullable_to_non_nullable
as OtpContext?,requestStatus: null == requestStatus ? _self.requestStatus : requestStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,sessionStatus: null == sessionStatus ? _self.sessionStatus : sessionStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<AuthSession>,otpRequestId: freezed == otpRequestId ? _self.otpRequestId : otpRequestId // ignore: cast_nullable_to_non_nullable
as String?,pendingPhone: freezed == pendingPhone ? _self.pendingPhone : pendingPhone // ignore: cast_nullable_to_non_nullable
as String?,pendingEmail: freezed == pendingEmail ? _self.pendingEmail : pendingEmail // ignore: cast_nullable_to_non_nullable
as String?,registrationToken: freezed == registrationToken ? _self.registrationToken : registrationToken // ignore: cast_nullable_to_non_nullable
as String?,registrationEmail: freezed == registrationEmail ? _self.registrationEmail : registrationEmail // ignore: cast_nullable_to_non_nullable
as String?,registrationName: freezed == registrationName ? _self.registrationName : registrationName // ignore: cast_nullable_to_non_nullable
as String?,resendSeconds: null == resendSeconds ? _self.resendSeconds : resendSeconds // ignore: cast_nullable_to_non_nullable
as int,routeToPhoneVerification: null == routeToPhoneVerification ? _self.routeToPhoneVerification : routeToPhoneVerification // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get requestStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.requestStatus, (value) {
    return _then(_self.copyWith(requestStatus: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<AuthSession, $Res> get sessionStatus {
  
  return $BlocStatusCopyWith<AuthSession, $Res>(_self.sessionStatus, (value) {
    return _then(_self.copyWith(sessionStatus: value));
  });
}
}

// dart format on
