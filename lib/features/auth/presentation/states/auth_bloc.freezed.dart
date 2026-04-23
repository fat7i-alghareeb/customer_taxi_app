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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _LoginRequested value)?  loginRequested,TResult Function( _SendOtpRequested value)?  sendOtpRequested,TResult Function( _VerifyOtpRequested value)?  verifyOtpRequested,TResult Function( _ResetRequested value)?  resetRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LoginRequested() when loginRequested != null:
return loginRequested(_that);case _SendOtpRequested() when sendOtpRequested != null:
return sendOtpRequested(_that);case _VerifyOtpRequested() when verifyOtpRequested != null:
return verifyOtpRequested(_that);case _ResetRequested() when resetRequested != null:
return resetRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _LoginRequested value)  loginRequested,required TResult Function( _SendOtpRequested value)  sendOtpRequested,required TResult Function( _VerifyOtpRequested value)  verifyOtpRequested,required TResult Function( _ResetRequested value)  resetRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _LoginRequested():
return loginRequested(_that);case _SendOtpRequested():
return sendOtpRequested(_that);case _VerifyOtpRequested():
return verifyOtpRequested(_that);case _ResetRequested():
return resetRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _LoginRequested value)?  loginRequested,TResult? Function( _SendOtpRequested value)?  sendOtpRequested,TResult? Function( _VerifyOtpRequested value)?  verifyOtpRequested,TResult? Function( _ResetRequested value)?  resetRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LoginRequested() when loginRequested != null:
return loginRequested(_that);case _SendOtpRequested() when sendOtpRequested != null:
return sendOtpRequested(_that);case _VerifyOtpRequested() when verifyOtpRequested != null:
return verifyOtpRequested(_that);case _ResetRequested() when resetRequested != null:
return resetRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  loginRequested,TResult Function( String phone)?  sendOtpRequested,TResult Function( String otp)?  verifyOtpRequested,TResult Function()?  resetRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _LoginRequested() when loginRequested != null:
return loginRequested();case _SendOtpRequested() when sendOtpRequested != null:
return sendOtpRequested(_that.phone);case _VerifyOtpRequested() when verifyOtpRequested != null:
return verifyOtpRequested(_that.otp);case _ResetRequested() when resetRequested != null:
return resetRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  loginRequested,required TResult Function( String phone)  sendOtpRequested,required TResult Function( String otp)  verifyOtpRequested,required TResult Function()  resetRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _LoginRequested():
return loginRequested();case _SendOtpRequested():
return sendOtpRequested(_that.phone);case _VerifyOtpRequested():
return verifyOtpRequested(_that.otp);case _ResetRequested():
return resetRequested();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  loginRequested,TResult? Function( String phone)?  sendOtpRequested,TResult? Function( String otp)?  verifyOtpRequested,TResult? Function()?  resetRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _LoginRequested() when loginRequested != null:
return loginRequested();case _SendOtpRequested() when sendOtpRequested != null:
return sendOtpRequested(_that.phone);case _VerifyOtpRequested() when verifyOtpRequested != null:
return verifyOtpRequested(_that.otp);case _ResetRequested() when resetRequested != null:
return resetRequested();case _:
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


class _LoginRequested implements AuthEvent {
  const _LoginRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.loginRequested()';
}


}




/// @nodoc


class _SendOtpRequested implements AuthEvent {
  const _SendOtpRequested(this.phone);
  

 final  String phone;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendOtpRequestedCopyWith<_SendOtpRequested> get copyWith => __$SendOtpRequestedCopyWithImpl<_SendOtpRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendOtpRequested&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode => Object.hash(runtimeType,phone);

@override
String toString() {
  return 'AuthEvent.sendOtpRequested(phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$SendOtpRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$SendOtpRequestedCopyWith(_SendOtpRequested value, $Res Function(_SendOtpRequested) _then) = __$SendOtpRequestedCopyWithImpl;
@useResult
$Res call({
 String phone
});




}
/// @nodoc
class __$SendOtpRequestedCopyWithImpl<$Res>
    implements _$SendOtpRequestedCopyWith<$Res> {
  __$SendOtpRequestedCopyWithImpl(this._self, this._then);

  final _SendOtpRequested _self;
  final $Res Function(_SendOtpRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phone = null,}) {
  return _then(_SendOtpRequested(
null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _VerifyOtpRequested implements AuthEvent {
  const _VerifyOtpRequested(this.otp);
  

 final  String otp;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyOtpRequestedCopyWith<_VerifyOtpRequested> get copyWith => __$VerifyOtpRequestedCopyWithImpl<_VerifyOtpRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyOtpRequested&&(identical(other.otp, otp) || other.otp == otp));
}


@override
int get hashCode => Object.hash(runtimeType,otp);

@override
String toString() {
  return 'AuthEvent.verifyOtpRequested(otp: $otp)';
}


}

/// @nodoc
abstract mixin class _$VerifyOtpRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$VerifyOtpRequestedCopyWith(_VerifyOtpRequested value, $Res Function(_VerifyOtpRequested) _then) = __$VerifyOtpRequestedCopyWithImpl;
@useResult
$Res call({
 String otp
});




}
/// @nodoc
class __$VerifyOtpRequestedCopyWithImpl<$Res>
    implements _$VerifyOtpRequestedCopyWith<$Res> {
  __$VerifyOtpRequestedCopyWithImpl(this._self, this._then);

  final _VerifyOtpRequested _self;
  final $Res Function(_VerifyOtpRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? otp = null,}) {
  return _then(_VerifyOtpRequested(
null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
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
mixin _$AuthState {

 BlocStatus<UserEntity> get loginStatus; BlocStatus<void> get phoneStatus; BlocStatus<void> get otpStatus; bool get isOtpSent;
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateCopyWith<AuthState> get copyWith => _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState&&(identical(other.loginStatus, loginStatus) || other.loginStatus == loginStatus)&&(identical(other.phoneStatus, phoneStatus) || other.phoneStatus == phoneStatus)&&(identical(other.otpStatus, otpStatus) || other.otpStatus == otpStatus)&&(identical(other.isOtpSent, isOtpSent) || other.isOtpSent == isOtpSent));
}


@override
int get hashCode => Object.hash(runtimeType,loginStatus,phoneStatus,otpStatus,isOtpSent);

@override
String toString() {
  return 'AuthState(loginStatus: $loginStatus, phoneStatus: $phoneStatus, otpStatus: $otpStatus, isOtpSent: $isOtpSent)';
}


}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res>  {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) = _$AuthStateCopyWithImpl;
@useResult
$Res call({
 BlocStatus<UserEntity> loginStatus, BlocStatus<void> phoneStatus, BlocStatus<void> otpStatus, bool isOtpSent
});


$BlocStatusCopyWith<UserEntity, $Res> get loginStatus;$BlocStatusCopyWith<void, $Res> get phoneStatus;$BlocStatusCopyWith<void, $Res> get otpStatus;

}
/// @nodoc
class _$AuthStateCopyWithImpl<$Res>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loginStatus = null,Object? phoneStatus = null,Object? otpStatus = null,Object? isOtpSent = null,}) {
  return _then(_self.copyWith(
loginStatus: null == loginStatus ? _self.loginStatus : loginStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<UserEntity>,phoneStatus: null == phoneStatus ? _self.phoneStatus : phoneStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,otpStatus: null == otpStatus ? _self.otpStatus : otpStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,isOtpSent: null == isOtpSent ? _self.isOtpSent : isOtpSent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<UserEntity, $Res> get loginStatus {
  
  return $BlocStatusCopyWith<UserEntity, $Res>(_self.loginStatus, (value) {
    return _then(_self.copyWith(loginStatus: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get phoneStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.phoneStatus, (value) {
    return _then(_self.copyWith(phoneStatus: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get otpStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.otpStatus, (value) {
    return _then(_self.copyWith(otpStatus: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlocStatus<UserEntity> loginStatus,  BlocStatus<void> phoneStatus,  BlocStatus<void> otpStatus,  bool isOtpSent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.loginStatus,_that.phoneStatus,_that.otpStatus,_that.isOtpSent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlocStatus<UserEntity> loginStatus,  BlocStatus<void> phoneStatus,  BlocStatus<void> otpStatus,  bool isOtpSent)  $default,) {final _that = this;
switch (_that) {
case _AuthState():
return $default(_that.loginStatus,_that.phoneStatus,_that.otpStatus,_that.isOtpSent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlocStatus<UserEntity> loginStatus,  BlocStatus<void> phoneStatus,  BlocStatus<void> otpStatus,  bool isOtpSent)?  $default,) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.loginStatus,_that.phoneStatus,_that.otpStatus,_that.isOtpSent);case _:
  return null;

}
}

}

/// @nodoc


class _AuthState implements AuthState {
  const _AuthState({this.loginStatus = const BlocStatus<UserEntity>.initial(), this.phoneStatus = const BlocStatus<void>.initial(), this.otpStatus = const BlocStatus<void>.initial(), this.isOtpSent = false});
  

@override@JsonKey() final  BlocStatus<UserEntity> loginStatus;
@override@JsonKey() final  BlocStatus<void> phoneStatus;
@override@JsonKey() final  BlocStatus<void> otpStatus;
@override@JsonKey() final  bool isOtpSent;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateCopyWith<_AuthState> get copyWith => __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthState&&(identical(other.loginStatus, loginStatus) || other.loginStatus == loginStatus)&&(identical(other.phoneStatus, phoneStatus) || other.phoneStatus == phoneStatus)&&(identical(other.otpStatus, otpStatus) || other.otpStatus == otpStatus)&&(identical(other.isOtpSent, isOtpSent) || other.isOtpSent == isOtpSent));
}


@override
int get hashCode => Object.hash(runtimeType,loginStatus,phoneStatus,otpStatus,isOtpSent);

@override
String toString() {
  return 'AuthState(loginStatus: $loginStatus, phoneStatus: $phoneStatus, otpStatus: $otpStatus, isOtpSent: $isOtpSent)';
}


}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(_AuthState value, $Res Function(_AuthState) _then) = __$AuthStateCopyWithImpl;
@override @useResult
$Res call({
 BlocStatus<UserEntity> loginStatus, BlocStatus<void> phoneStatus, BlocStatus<void> otpStatus, bool isOtpSent
});


@override $BlocStatusCopyWith<UserEntity, $Res> get loginStatus;@override $BlocStatusCopyWith<void, $Res> get phoneStatus;@override $BlocStatusCopyWith<void, $Res> get otpStatus;

}
/// @nodoc
class __$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loginStatus = null,Object? phoneStatus = null,Object? otpStatus = null,Object? isOtpSent = null,}) {
  return _then(_AuthState(
loginStatus: null == loginStatus ? _self.loginStatus : loginStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<UserEntity>,phoneStatus: null == phoneStatus ? _self.phoneStatus : phoneStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,otpStatus: null == otpStatus ? _self.otpStatus : otpStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,isOtpSent: null == isOtpSent ? _self.isOtpSent : isOtpSent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<UserEntity, $Res> get loginStatus {
  
  return $BlocStatusCopyWith<UserEntity, $Res>(_self.loginStatus, (value) {
    return _then(_self.copyWith(loginStatus: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get phoneStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.phoneStatus, (value) {
    return _then(_self.copyWith(phoneStatus: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get otpStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.otpStatus, (value) {
    return _then(_self.copyWith(otpStatus: value));
  });
}
}

// dart format on
