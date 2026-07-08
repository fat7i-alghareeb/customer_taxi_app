// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaymentEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentEvent()';
}


}

/// @nodoc
class $PaymentEventCopyWith<$Res>  {
$PaymentEventCopyWith(PaymentEvent _, $Res Function(PaymentEvent) __);
}


/// Adds pattern-matching-related methods to [PaymentEvent].
extension PaymentEventPatterns on PaymentEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _BalanceRefreshed value)?  balanceRefreshed,TResult Function( _TransactionsRequested value)?  transactionsRequested,TResult Function( _MethodsRefreshed value)?  methodsRefreshed,TResult Function( _TopUpSubmitted value)?  topUpSubmitted,TResult Function( _AddCardRequested value)?  addCardRequested,TResult Function( _DefaultMethodSelected value)?  defaultMethodSelected,TResult Function( _MethodDeleted value)?  methodDeleted,TResult Function( _TransientStatusReset value)?  transientStatusReset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _BalanceRefreshed() when balanceRefreshed != null:
return balanceRefreshed(_that);case _TransactionsRequested() when transactionsRequested != null:
return transactionsRequested(_that);case _MethodsRefreshed() when methodsRefreshed != null:
return methodsRefreshed(_that);case _TopUpSubmitted() when topUpSubmitted != null:
return topUpSubmitted(_that);case _AddCardRequested() when addCardRequested != null:
return addCardRequested(_that);case _DefaultMethodSelected() when defaultMethodSelected != null:
return defaultMethodSelected(_that);case _MethodDeleted() when methodDeleted != null:
return methodDeleted(_that);case _TransientStatusReset() when transientStatusReset != null:
return transientStatusReset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _BalanceRefreshed value)  balanceRefreshed,required TResult Function( _TransactionsRequested value)  transactionsRequested,required TResult Function( _MethodsRefreshed value)  methodsRefreshed,required TResult Function( _TopUpSubmitted value)  topUpSubmitted,required TResult Function( _AddCardRequested value)  addCardRequested,required TResult Function( _DefaultMethodSelected value)  defaultMethodSelected,required TResult Function( _MethodDeleted value)  methodDeleted,required TResult Function( _TransientStatusReset value)  transientStatusReset,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _BalanceRefreshed():
return balanceRefreshed(_that);case _TransactionsRequested():
return transactionsRequested(_that);case _MethodsRefreshed():
return methodsRefreshed(_that);case _TopUpSubmitted():
return topUpSubmitted(_that);case _AddCardRequested():
return addCardRequested(_that);case _DefaultMethodSelected():
return defaultMethodSelected(_that);case _MethodDeleted():
return methodDeleted(_that);case _TransientStatusReset():
return transientStatusReset(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _BalanceRefreshed value)?  balanceRefreshed,TResult? Function( _TransactionsRequested value)?  transactionsRequested,TResult? Function( _MethodsRefreshed value)?  methodsRefreshed,TResult? Function( _TopUpSubmitted value)?  topUpSubmitted,TResult? Function( _AddCardRequested value)?  addCardRequested,TResult? Function( _DefaultMethodSelected value)?  defaultMethodSelected,TResult? Function( _MethodDeleted value)?  methodDeleted,TResult? Function( _TransientStatusReset value)?  transientStatusReset,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _BalanceRefreshed() when balanceRefreshed != null:
return balanceRefreshed(_that);case _TransactionsRequested() when transactionsRequested != null:
return transactionsRequested(_that);case _MethodsRefreshed() when methodsRefreshed != null:
return methodsRefreshed(_that);case _TopUpSubmitted() when topUpSubmitted != null:
return topUpSubmitted(_that);case _AddCardRequested() when addCardRequested != null:
return addCardRequested(_that);case _DefaultMethodSelected() when defaultMethodSelected != null:
return defaultMethodSelected(_that);case _MethodDeleted() when methodDeleted != null:
return methodDeleted(_that);case _TransientStatusReset() when transientStatusReset != null:
return transientStatusReset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  balanceRefreshed,TResult Function()?  transactionsRequested,TResult Function()?  methodsRefreshed,TResult Function( double amount)?  topUpSubmitted,TResult Function( bool setAsDefault)?  addCardRequested,TResult Function( String id)?  defaultMethodSelected,TResult Function( String id)?  methodDeleted,TResult Function()?  transientStatusReset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _BalanceRefreshed() when balanceRefreshed != null:
return balanceRefreshed();case _TransactionsRequested() when transactionsRequested != null:
return transactionsRequested();case _MethodsRefreshed() when methodsRefreshed != null:
return methodsRefreshed();case _TopUpSubmitted() when topUpSubmitted != null:
return topUpSubmitted(_that.amount);case _AddCardRequested() when addCardRequested != null:
return addCardRequested(_that.setAsDefault);case _DefaultMethodSelected() when defaultMethodSelected != null:
return defaultMethodSelected(_that.id);case _MethodDeleted() when methodDeleted != null:
return methodDeleted(_that.id);case _TransientStatusReset() when transientStatusReset != null:
return transientStatusReset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  balanceRefreshed,required TResult Function()  transactionsRequested,required TResult Function()  methodsRefreshed,required TResult Function( double amount)  topUpSubmitted,required TResult Function( bool setAsDefault)  addCardRequested,required TResult Function( String id)  defaultMethodSelected,required TResult Function( String id)  methodDeleted,required TResult Function()  transientStatusReset,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _BalanceRefreshed():
return balanceRefreshed();case _TransactionsRequested():
return transactionsRequested();case _MethodsRefreshed():
return methodsRefreshed();case _TopUpSubmitted():
return topUpSubmitted(_that.amount);case _AddCardRequested():
return addCardRequested(_that.setAsDefault);case _DefaultMethodSelected():
return defaultMethodSelected(_that.id);case _MethodDeleted():
return methodDeleted(_that.id);case _TransientStatusReset():
return transientStatusReset();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  balanceRefreshed,TResult? Function()?  transactionsRequested,TResult? Function()?  methodsRefreshed,TResult? Function( double amount)?  topUpSubmitted,TResult? Function( bool setAsDefault)?  addCardRequested,TResult? Function( String id)?  defaultMethodSelected,TResult? Function( String id)?  methodDeleted,TResult? Function()?  transientStatusReset,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _BalanceRefreshed() when balanceRefreshed != null:
return balanceRefreshed();case _TransactionsRequested() when transactionsRequested != null:
return transactionsRequested();case _MethodsRefreshed() when methodsRefreshed != null:
return methodsRefreshed();case _TopUpSubmitted() when topUpSubmitted != null:
return topUpSubmitted(_that.amount);case _AddCardRequested() when addCardRequested != null:
return addCardRequested(_that.setAsDefault);case _DefaultMethodSelected() when defaultMethodSelected != null:
return defaultMethodSelected(_that.id);case _MethodDeleted() when methodDeleted != null:
return methodDeleted(_that.id);case _TransientStatusReset() when transientStatusReset != null:
return transientStatusReset();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements PaymentEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentEvent.started()';
}


}




/// @nodoc


class _BalanceRefreshed implements PaymentEvent {
  const _BalanceRefreshed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BalanceRefreshed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentEvent.balanceRefreshed()';
}


}




/// @nodoc


class _TransactionsRequested implements PaymentEvent {
  const _TransactionsRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionsRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentEvent.transactionsRequested()';
}


}




/// @nodoc


class _MethodsRefreshed implements PaymentEvent {
  const _MethodsRefreshed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MethodsRefreshed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentEvent.methodsRefreshed()';
}


}




/// @nodoc


class _TopUpSubmitted implements PaymentEvent {
  const _TopUpSubmitted(this.amount);
  

 final  double amount;

/// Create a copy of PaymentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopUpSubmittedCopyWith<_TopUpSubmitted> get copyWith => __$TopUpSubmittedCopyWithImpl<_TopUpSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopUpSubmitted&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,amount);

@override
String toString() {
  return 'PaymentEvent.topUpSubmitted(amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$TopUpSubmittedCopyWith<$Res> implements $PaymentEventCopyWith<$Res> {
  factory _$TopUpSubmittedCopyWith(_TopUpSubmitted value, $Res Function(_TopUpSubmitted) _then) = __$TopUpSubmittedCopyWithImpl;
@useResult
$Res call({
 double amount
});




}
/// @nodoc
class __$TopUpSubmittedCopyWithImpl<$Res>
    implements _$TopUpSubmittedCopyWith<$Res> {
  __$TopUpSubmittedCopyWithImpl(this._self, this._then);

  final _TopUpSubmitted _self;
  final $Res Function(_TopUpSubmitted) _then;

/// Create a copy of PaymentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? amount = null,}) {
  return _then(_TopUpSubmitted(
null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class _AddCardRequested implements PaymentEvent {
  const _AddCardRequested({this.setAsDefault = false});
  

@JsonKey() final  bool setAsDefault;

/// Create a copy of PaymentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddCardRequestedCopyWith<_AddCardRequested> get copyWith => __$AddCardRequestedCopyWithImpl<_AddCardRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddCardRequested&&(identical(other.setAsDefault, setAsDefault) || other.setAsDefault == setAsDefault));
}


@override
int get hashCode => Object.hash(runtimeType,setAsDefault);

@override
String toString() {
  return 'PaymentEvent.addCardRequested(setAsDefault: $setAsDefault)';
}


}

/// @nodoc
abstract mixin class _$AddCardRequestedCopyWith<$Res> implements $PaymentEventCopyWith<$Res> {
  factory _$AddCardRequestedCopyWith(_AddCardRequested value, $Res Function(_AddCardRequested) _then) = __$AddCardRequestedCopyWithImpl;
@useResult
$Res call({
 bool setAsDefault
});




}
/// @nodoc
class __$AddCardRequestedCopyWithImpl<$Res>
    implements _$AddCardRequestedCopyWith<$Res> {
  __$AddCardRequestedCopyWithImpl(this._self, this._then);

  final _AddCardRequested _self;
  final $Res Function(_AddCardRequested) _then;

/// Create a copy of PaymentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? setAsDefault = null,}) {
  return _then(_AddCardRequested(
setAsDefault: null == setAsDefault ? _self.setAsDefault : setAsDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _DefaultMethodSelected implements PaymentEvent {
  const _DefaultMethodSelected(this.id);
  

 final  String id;

/// Create a copy of PaymentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DefaultMethodSelectedCopyWith<_DefaultMethodSelected> get copyWith => __$DefaultMethodSelectedCopyWithImpl<_DefaultMethodSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DefaultMethodSelected&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'PaymentEvent.defaultMethodSelected(id: $id)';
}


}

/// @nodoc
abstract mixin class _$DefaultMethodSelectedCopyWith<$Res> implements $PaymentEventCopyWith<$Res> {
  factory _$DefaultMethodSelectedCopyWith(_DefaultMethodSelected value, $Res Function(_DefaultMethodSelected) _then) = __$DefaultMethodSelectedCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class __$DefaultMethodSelectedCopyWithImpl<$Res>
    implements _$DefaultMethodSelectedCopyWith<$Res> {
  __$DefaultMethodSelectedCopyWithImpl(this._self, this._then);

  final _DefaultMethodSelected _self;
  final $Res Function(_DefaultMethodSelected) _then;

/// Create a copy of PaymentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_DefaultMethodSelected(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _MethodDeleted implements PaymentEvent {
  const _MethodDeleted(this.id);
  

 final  String id;

/// Create a copy of PaymentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MethodDeletedCopyWith<_MethodDeleted> get copyWith => __$MethodDeletedCopyWithImpl<_MethodDeleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MethodDeleted&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'PaymentEvent.methodDeleted(id: $id)';
}


}

/// @nodoc
abstract mixin class _$MethodDeletedCopyWith<$Res> implements $PaymentEventCopyWith<$Res> {
  factory _$MethodDeletedCopyWith(_MethodDeleted value, $Res Function(_MethodDeleted) _then) = __$MethodDeletedCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class __$MethodDeletedCopyWithImpl<$Res>
    implements _$MethodDeletedCopyWith<$Res> {
  __$MethodDeletedCopyWithImpl(this._self, this._then);

  final _MethodDeleted _self;
  final $Res Function(_MethodDeleted) _then;

/// Create a copy of PaymentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_MethodDeleted(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _TransientStatusReset implements PaymentEvent {
  const _TransientStatusReset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransientStatusReset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentEvent.transientStatusReset()';
}


}




/// @nodoc
mixin _$PaymentState {

 BlocStatus<WalletBalanceEntity> get balanceStatus; BlocStatus<WalletTransactionsPage> get transactionsStatus; BlocStatus<List<PaymentMethodEntity>> get methodsStatus; BlocStatus<void> get topUpStatus; BlocStatus<void> get addCardStatus; BlocStatus<void> get actionStatus;
/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentStateCopyWith<PaymentState> get copyWith => _$PaymentStateCopyWithImpl<PaymentState>(this as PaymentState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentState&&(identical(other.balanceStatus, balanceStatus) || other.balanceStatus == balanceStatus)&&(identical(other.transactionsStatus, transactionsStatus) || other.transactionsStatus == transactionsStatus)&&(identical(other.methodsStatus, methodsStatus) || other.methodsStatus == methodsStatus)&&(identical(other.topUpStatus, topUpStatus) || other.topUpStatus == topUpStatus)&&(identical(other.addCardStatus, addCardStatus) || other.addCardStatus == addCardStatus)&&(identical(other.actionStatus, actionStatus) || other.actionStatus == actionStatus));
}


@override
int get hashCode => Object.hash(runtimeType,balanceStatus,transactionsStatus,methodsStatus,topUpStatus,addCardStatus,actionStatus);

@override
String toString() {
  return 'PaymentState(balanceStatus: $balanceStatus, transactionsStatus: $transactionsStatus, methodsStatus: $methodsStatus, topUpStatus: $topUpStatus, addCardStatus: $addCardStatus, actionStatus: $actionStatus)';
}


}

/// @nodoc
abstract mixin class $PaymentStateCopyWith<$Res>  {
  factory $PaymentStateCopyWith(PaymentState value, $Res Function(PaymentState) _then) = _$PaymentStateCopyWithImpl;
@useResult
$Res call({
 BlocStatus<WalletBalanceEntity> balanceStatus, BlocStatus<WalletTransactionsPage> transactionsStatus, BlocStatus<List<PaymentMethodEntity>> methodsStatus, BlocStatus<void> topUpStatus, BlocStatus<void> addCardStatus, BlocStatus<void> actionStatus
});


$BlocStatusCopyWith<WalletBalanceEntity, $Res> get balanceStatus;$BlocStatusCopyWith<WalletTransactionsPage, $Res> get transactionsStatus;$BlocStatusCopyWith<List<PaymentMethodEntity>, $Res> get methodsStatus;$BlocStatusCopyWith<void, $Res> get topUpStatus;$BlocStatusCopyWith<void, $Res> get addCardStatus;$BlocStatusCopyWith<void, $Res> get actionStatus;

}
/// @nodoc
class _$PaymentStateCopyWithImpl<$Res>
    implements $PaymentStateCopyWith<$Res> {
  _$PaymentStateCopyWithImpl(this._self, this._then);

  final PaymentState _self;
  final $Res Function(PaymentState) _then;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? balanceStatus = null,Object? transactionsStatus = null,Object? methodsStatus = null,Object? topUpStatus = null,Object? addCardStatus = null,Object? actionStatus = null,}) {
  return _then(_self.copyWith(
balanceStatus: null == balanceStatus ? _self.balanceStatus : balanceStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<WalletBalanceEntity>,transactionsStatus: null == transactionsStatus ? _self.transactionsStatus : transactionsStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<WalletTransactionsPage>,methodsStatus: null == methodsStatus ? _self.methodsStatus : methodsStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<PaymentMethodEntity>>,topUpStatus: null == topUpStatus ? _self.topUpStatus : topUpStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,addCardStatus: null == addCardStatus ? _self.addCardStatus : addCardStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,
  ));
}
/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<WalletBalanceEntity, $Res> get balanceStatus {
  
  return $BlocStatusCopyWith<WalletBalanceEntity, $Res>(_self.balanceStatus, (value) {
    return _then(_self.copyWith(balanceStatus: value));
  });
}/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<WalletTransactionsPage, $Res> get transactionsStatus {
  
  return $BlocStatusCopyWith<WalletTransactionsPage, $Res>(_self.transactionsStatus, (value) {
    return _then(_self.copyWith(transactionsStatus: value));
  });
}/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<PaymentMethodEntity>, $Res> get methodsStatus {
  
  return $BlocStatusCopyWith<List<PaymentMethodEntity>, $Res>(_self.methodsStatus, (value) {
    return _then(_self.copyWith(methodsStatus: value));
  });
}/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get topUpStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.topUpStatus, (value) {
    return _then(_self.copyWith(topUpStatus: value));
  });
}/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get addCardStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.addCardStatus, (value) {
    return _then(_self.copyWith(addCardStatus: value));
  });
}/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get actionStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.actionStatus, (value) {
    return _then(_self.copyWith(actionStatus: value));
  });
}
}


/// Adds pattern-matching-related methods to [PaymentState].
extension PaymentStatePatterns on PaymentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentState value)  $default,){
final _that = this;
switch (_that) {
case _PaymentState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentState value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlocStatus<WalletBalanceEntity> balanceStatus,  BlocStatus<WalletTransactionsPage> transactionsStatus,  BlocStatus<List<PaymentMethodEntity>> methodsStatus,  BlocStatus<void> topUpStatus,  BlocStatus<void> addCardStatus,  BlocStatus<void> actionStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentState() when $default != null:
return $default(_that.balanceStatus,_that.transactionsStatus,_that.methodsStatus,_that.topUpStatus,_that.addCardStatus,_that.actionStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlocStatus<WalletBalanceEntity> balanceStatus,  BlocStatus<WalletTransactionsPage> transactionsStatus,  BlocStatus<List<PaymentMethodEntity>> methodsStatus,  BlocStatus<void> topUpStatus,  BlocStatus<void> addCardStatus,  BlocStatus<void> actionStatus)  $default,) {final _that = this;
switch (_that) {
case _PaymentState():
return $default(_that.balanceStatus,_that.transactionsStatus,_that.methodsStatus,_that.topUpStatus,_that.addCardStatus,_that.actionStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlocStatus<WalletBalanceEntity> balanceStatus,  BlocStatus<WalletTransactionsPage> transactionsStatus,  BlocStatus<List<PaymentMethodEntity>> methodsStatus,  BlocStatus<void> topUpStatus,  BlocStatus<void> addCardStatus,  BlocStatus<void> actionStatus)?  $default,) {final _that = this;
switch (_that) {
case _PaymentState() when $default != null:
return $default(_that.balanceStatus,_that.transactionsStatus,_that.methodsStatus,_that.topUpStatus,_that.addCardStatus,_that.actionStatus);case _:
  return null;

}
}

}

/// @nodoc


class _PaymentState implements PaymentState {
  const _PaymentState({this.balanceStatus = const BlocStatus<WalletBalanceEntity>.initial(), this.transactionsStatus = const BlocStatus<WalletTransactionsPage>.initial(), this.methodsStatus = const BlocStatus<List<PaymentMethodEntity>>.initial(), this.topUpStatus = const BlocStatus<void>.initial(), this.addCardStatus = const BlocStatus<void>.initial(), this.actionStatus = const BlocStatus<void>.initial()});
  

@override@JsonKey() final  BlocStatus<WalletBalanceEntity> balanceStatus;
@override@JsonKey() final  BlocStatus<WalletTransactionsPage> transactionsStatus;
@override@JsonKey() final  BlocStatus<List<PaymentMethodEntity>> methodsStatus;
@override@JsonKey() final  BlocStatus<void> topUpStatus;
@override@JsonKey() final  BlocStatus<void> addCardStatus;
@override@JsonKey() final  BlocStatus<void> actionStatus;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentStateCopyWith<_PaymentState> get copyWith => __$PaymentStateCopyWithImpl<_PaymentState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentState&&(identical(other.balanceStatus, balanceStatus) || other.balanceStatus == balanceStatus)&&(identical(other.transactionsStatus, transactionsStatus) || other.transactionsStatus == transactionsStatus)&&(identical(other.methodsStatus, methodsStatus) || other.methodsStatus == methodsStatus)&&(identical(other.topUpStatus, topUpStatus) || other.topUpStatus == topUpStatus)&&(identical(other.addCardStatus, addCardStatus) || other.addCardStatus == addCardStatus)&&(identical(other.actionStatus, actionStatus) || other.actionStatus == actionStatus));
}


@override
int get hashCode => Object.hash(runtimeType,balanceStatus,transactionsStatus,methodsStatus,topUpStatus,addCardStatus,actionStatus);

@override
String toString() {
  return 'PaymentState(balanceStatus: $balanceStatus, transactionsStatus: $transactionsStatus, methodsStatus: $methodsStatus, topUpStatus: $topUpStatus, addCardStatus: $addCardStatus, actionStatus: $actionStatus)';
}


}

/// @nodoc
abstract mixin class _$PaymentStateCopyWith<$Res> implements $PaymentStateCopyWith<$Res> {
  factory _$PaymentStateCopyWith(_PaymentState value, $Res Function(_PaymentState) _then) = __$PaymentStateCopyWithImpl;
@override @useResult
$Res call({
 BlocStatus<WalletBalanceEntity> balanceStatus, BlocStatus<WalletTransactionsPage> transactionsStatus, BlocStatus<List<PaymentMethodEntity>> methodsStatus, BlocStatus<void> topUpStatus, BlocStatus<void> addCardStatus, BlocStatus<void> actionStatus
});


@override $BlocStatusCopyWith<WalletBalanceEntity, $Res> get balanceStatus;@override $BlocStatusCopyWith<WalletTransactionsPage, $Res> get transactionsStatus;@override $BlocStatusCopyWith<List<PaymentMethodEntity>, $Res> get methodsStatus;@override $BlocStatusCopyWith<void, $Res> get topUpStatus;@override $BlocStatusCopyWith<void, $Res> get addCardStatus;@override $BlocStatusCopyWith<void, $Res> get actionStatus;

}
/// @nodoc
class __$PaymentStateCopyWithImpl<$Res>
    implements _$PaymentStateCopyWith<$Res> {
  __$PaymentStateCopyWithImpl(this._self, this._then);

  final _PaymentState _self;
  final $Res Function(_PaymentState) _then;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? balanceStatus = null,Object? transactionsStatus = null,Object? methodsStatus = null,Object? topUpStatus = null,Object? addCardStatus = null,Object? actionStatus = null,}) {
  return _then(_PaymentState(
balanceStatus: null == balanceStatus ? _self.balanceStatus : balanceStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<WalletBalanceEntity>,transactionsStatus: null == transactionsStatus ? _self.transactionsStatus : transactionsStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<WalletTransactionsPage>,methodsStatus: null == methodsStatus ? _self.methodsStatus : methodsStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<PaymentMethodEntity>>,topUpStatus: null == topUpStatus ? _self.topUpStatus : topUpStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,addCardStatus: null == addCardStatus ? _self.addCardStatus : addCardStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,
  ));
}

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<WalletBalanceEntity, $Res> get balanceStatus {
  
  return $BlocStatusCopyWith<WalletBalanceEntity, $Res>(_self.balanceStatus, (value) {
    return _then(_self.copyWith(balanceStatus: value));
  });
}/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<WalletTransactionsPage, $Res> get transactionsStatus {
  
  return $BlocStatusCopyWith<WalletTransactionsPage, $Res>(_self.transactionsStatus, (value) {
    return _then(_self.copyWith(transactionsStatus: value));
  });
}/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<PaymentMethodEntity>, $Res> get methodsStatus {
  
  return $BlocStatusCopyWith<List<PaymentMethodEntity>, $Res>(_self.methodsStatus, (value) {
    return _then(_self.copyWith(methodsStatus: value));
  });
}/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get topUpStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.topUpStatus, (value) {
    return _then(_self.copyWith(topUpStatus: value));
  });
}/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get addCardStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.addCardStatus, (value) {
    return _then(_self.copyWith(addCardStatus: value));
  });
}/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get actionStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.actionStatus, (value) {
    return _then(_self.copyWith(actionStatus: value));
  });
}
}

// dart format on
