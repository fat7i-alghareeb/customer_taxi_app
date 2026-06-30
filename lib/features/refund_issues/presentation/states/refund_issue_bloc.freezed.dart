// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'refund_issue_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RefundIssueEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefundIssueEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RefundIssueEvent()';
}


}

/// @nodoc
class $RefundIssueEventCopyWith<$Res>  {
$RefundIssueEventCopyWith(RefundIssueEvent _, $Res Function(RefundIssueEvent) __);
}


/// Adds pattern-matching-related methods to [RefundIssueEvent].
extension RefundIssueEventPatterns on RefundIssueEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _ReasonSelected value)?  reasonSelected,TResult Function( _Submitted value)?  submitted,TResult Function( _ResetSubmission value)?  resetSubmission,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReasonSelected() when reasonSelected != null:
return reasonSelected(_that);case _Submitted() when submitted != null:
return submitted(_that);case _ResetSubmission() when resetSubmission != null:
return resetSubmission(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _ReasonSelected value)  reasonSelected,required TResult Function( _Submitted value)  submitted,required TResult Function( _ResetSubmission value)  resetSubmission,}){
final _that = this;
switch (_that) {
case _ReasonSelected():
return reasonSelected(_that);case _Submitted():
return submitted(_that);case _ResetSubmission():
return resetSubmission(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _ReasonSelected value)?  reasonSelected,TResult? Function( _Submitted value)?  submitted,TResult? Function( _ResetSubmission value)?  resetSubmission,}){
final _that = this;
switch (_that) {
case _ReasonSelected() when reasonSelected != null:
return reasonSelected(_that);case _Submitted() when submitted != null:
return submitted(_that);case _ResetSubmission() when resetSubmission != null:
return resetSubmission(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( RefundIssueRequestType type)?  reasonSelected,TResult Function( String tripId,  RefundIssueRequestType type,  String customerReason,  String? note)?  submitted,TResult Function()?  resetSubmission,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReasonSelected() when reasonSelected != null:
return reasonSelected(_that.type);case _Submitted() when submitted != null:
return submitted(_that.tripId,_that.type,_that.customerReason,_that.note);case _ResetSubmission() when resetSubmission != null:
return resetSubmission();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( RefundIssueRequestType type)  reasonSelected,required TResult Function( String tripId,  RefundIssueRequestType type,  String customerReason,  String? note)  submitted,required TResult Function()  resetSubmission,}) {final _that = this;
switch (_that) {
case _ReasonSelected():
return reasonSelected(_that.type);case _Submitted():
return submitted(_that.tripId,_that.type,_that.customerReason,_that.note);case _ResetSubmission():
return resetSubmission();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( RefundIssueRequestType type)?  reasonSelected,TResult? Function( String tripId,  RefundIssueRequestType type,  String customerReason,  String? note)?  submitted,TResult? Function()?  resetSubmission,}) {final _that = this;
switch (_that) {
case _ReasonSelected() when reasonSelected != null:
return reasonSelected(_that.type);case _Submitted() when submitted != null:
return submitted(_that.tripId,_that.type,_that.customerReason,_that.note);case _ResetSubmission() when resetSubmission != null:
return resetSubmission();case _:
  return null;

}
}

}

/// @nodoc


class _ReasonSelected implements RefundIssueEvent {
  const _ReasonSelected(this.type);
  

 final  RefundIssueRequestType type;

/// Create a copy of RefundIssueEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReasonSelectedCopyWith<_ReasonSelected> get copyWith => __$ReasonSelectedCopyWithImpl<_ReasonSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReasonSelected&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'RefundIssueEvent.reasonSelected(type: $type)';
}


}

/// @nodoc
abstract mixin class _$ReasonSelectedCopyWith<$Res> implements $RefundIssueEventCopyWith<$Res> {
  factory _$ReasonSelectedCopyWith(_ReasonSelected value, $Res Function(_ReasonSelected) _then) = __$ReasonSelectedCopyWithImpl;
@useResult
$Res call({
 RefundIssueRequestType type
});




}
/// @nodoc
class __$ReasonSelectedCopyWithImpl<$Res>
    implements _$ReasonSelectedCopyWith<$Res> {
  __$ReasonSelectedCopyWithImpl(this._self, this._then);

  final _ReasonSelected _self;
  final $Res Function(_ReasonSelected) _then;

/// Create a copy of RefundIssueEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(_ReasonSelected(
null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RefundIssueRequestType,
  ));
}


}

/// @nodoc


class _Submitted implements RefundIssueEvent {
  const _Submitted({required this.tripId, required this.type, required this.customerReason, this.note});
  

 final  String tripId;
 final  RefundIssueRequestType type;
 final  String customerReason;
 final  String? note;

/// Create a copy of RefundIssueEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmittedCopyWith<_Submitted> get copyWith => __$SubmittedCopyWithImpl<_Submitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Submitted&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.type, type) || other.type == type)&&(identical(other.customerReason, customerReason) || other.customerReason == customerReason)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,type,customerReason,note);

@override
String toString() {
  return 'RefundIssueEvent.submitted(tripId: $tripId, type: $type, customerReason: $customerReason, note: $note)';
}


}

/// @nodoc
abstract mixin class _$SubmittedCopyWith<$Res> implements $RefundIssueEventCopyWith<$Res> {
  factory _$SubmittedCopyWith(_Submitted value, $Res Function(_Submitted) _then) = __$SubmittedCopyWithImpl;
@useResult
$Res call({
 String tripId, RefundIssueRequestType type, String customerReason, String? note
});




}
/// @nodoc
class __$SubmittedCopyWithImpl<$Res>
    implements _$SubmittedCopyWith<$Res> {
  __$SubmittedCopyWithImpl(this._self, this._then);

  final _Submitted _self;
  final $Res Function(_Submitted) _then;

/// Create a copy of RefundIssueEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? type = null,Object? customerReason = null,Object? note = freezed,}) {
  return _then(_Submitted(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RefundIssueRequestType,customerReason: null == customerReason ? _self.customerReason : customerReason // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ResetSubmission implements RefundIssueEvent {
  const _ResetSubmission();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetSubmission);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RefundIssueEvent.resetSubmission()';
}


}




/// @nodoc
mixin _$RefundIssueState {

 RefundIssueRequestType get selectedType; BlocStatus<RefundIssueEntity> get submitStatus;
/// Create a copy of RefundIssueState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefundIssueStateCopyWith<RefundIssueState> get copyWith => _$RefundIssueStateCopyWithImpl<RefundIssueState>(this as RefundIssueState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefundIssueState&&(identical(other.selectedType, selectedType) || other.selectedType == selectedType)&&(identical(other.submitStatus, submitStatus) || other.submitStatus == submitStatus));
}


@override
int get hashCode => Object.hash(runtimeType,selectedType,submitStatus);

@override
String toString() {
  return 'RefundIssueState(selectedType: $selectedType, submitStatus: $submitStatus)';
}


}

/// @nodoc
abstract mixin class $RefundIssueStateCopyWith<$Res>  {
  factory $RefundIssueStateCopyWith(RefundIssueState value, $Res Function(RefundIssueState) _then) = _$RefundIssueStateCopyWithImpl;
@useResult
$Res call({
 RefundIssueRequestType selectedType, BlocStatus<RefundIssueEntity> submitStatus
});


$BlocStatusCopyWith<RefundIssueEntity, $Res> get submitStatus;

}
/// @nodoc
class _$RefundIssueStateCopyWithImpl<$Res>
    implements $RefundIssueStateCopyWith<$Res> {
  _$RefundIssueStateCopyWithImpl(this._self, this._then);

  final RefundIssueState _self;
  final $Res Function(RefundIssueState) _then;

/// Create a copy of RefundIssueState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedType = null,Object? submitStatus = null,}) {
  return _then(_self.copyWith(
selectedType: null == selectedType ? _self.selectedType : selectedType // ignore: cast_nullable_to_non_nullable
as RefundIssueRequestType,submitStatus: null == submitStatus ? _self.submitStatus : submitStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<RefundIssueEntity>,
  ));
}
/// Create a copy of RefundIssueState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<RefundIssueEntity, $Res> get submitStatus {
  
  return $BlocStatusCopyWith<RefundIssueEntity, $Res>(_self.submitStatus, (value) {
    return _then(_self.copyWith(submitStatus: value));
  });
}
}


/// Adds pattern-matching-related methods to [RefundIssueState].
extension RefundIssueStatePatterns on RefundIssueState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RefundIssueState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RefundIssueState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RefundIssueState value)  $default,){
final _that = this;
switch (_that) {
case _RefundIssueState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RefundIssueState value)?  $default,){
final _that = this;
switch (_that) {
case _RefundIssueState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RefundIssueRequestType selectedType,  BlocStatus<RefundIssueEntity> submitStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RefundIssueState() when $default != null:
return $default(_that.selectedType,_that.submitStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RefundIssueRequestType selectedType,  BlocStatus<RefundIssueEntity> submitStatus)  $default,) {final _that = this;
switch (_that) {
case _RefundIssueState():
return $default(_that.selectedType,_that.submitStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RefundIssueRequestType selectedType,  BlocStatus<RefundIssueEntity> submitStatus)?  $default,) {final _that = this;
switch (_that) {
case _RefundIssueState() when $default != null:
return $default(_that.selectedType,_that.submitStatus);case _:
  return null;

}
}

}

/// @nodoc


class _RefundIssueState implements RefundIssueState {
  const _RefundIssueState({this.selectedType = RefundIssueRequestType.refundTakingTooLong, this.submitStatus = const BlocStatus<RefundIssueEntity>.initial()});
  

@override@JsonKey() final  RefundIssueRequestType selectedType;
@override@JsonKey() final  BlocStatus<RefundIssueEntity> submitStatus;

/// Create a copy of RefundIssueState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefundIssueStateCopyWith<_RefundIssueState> get copyWith => __$RefundIssueStateCopyWithImpl<_RefundIssueState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefundIssueState&&(identical(other.selectedType, selectedType) || other.selectedType == selectedType)&&(identical(other.submitStatus, submitStatus) || other.submitStatus == submitStatus));
}


@override
int get hashCode => Object.hash(runtimeType,selectedType,submitStatus);

@override
String toString() {
  return 'RefundIssueState(selectedType: $selectedType, submitStatus: $submitStatus)';
}


}

/// @nodoc
abstract mixin class _$RefundIssueStateCopyWith<$Res> implements $RefundIssueStateCopyWith<$Res> {
  factory _$RefundIssueStateCopyWith(_RefundIssueState value, $Res Function(_RefundIssueState) _then) = __$RefundIssueStateCopyWithImpl;
@override @useResult
$Res call({
 RefundIssueRequestType selectedType, BlocStatus<RefundIssueEntity> submitStatus
});


@override $BlocStatusCopyWith<RefundIssueEntity, $Res> get submitStatus;

}
/// @nodoc
class __$RefundIssueStateCopyWithImpl<$Res>
    implements _$RefundIssueStateCopyWith<$Res> {
  __$RefundIssueStateCopyWithImpl(this._self, this._then);

  final _RefundIssueState _self;
  final $Res Function(_RefundIssueState) _then;

/// Create a copy of RefundIssueState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedType = null,Object? submitStatus = null,}) {
  return _then(_RefundIssueState(
selectedType: null == selectedType ? _self.selectedType : selectedType // ignore: cast_nullable_to_non_nullable
as RefundIssueRequestType,submitStatus: null == submitStatus ? _self.submitStatus : submitStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<RefundIssueEntity>,
  ));
}

/// Create a copy of RefundIssueState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<RefundIssueEntity, $Res> get submitStatus {
  
  return $BlocStatusCopyWith<RefundIssueEntity, $Res>(_self.submitStatus, (value) {
    return _then(_self.copyWith(submitStatus: value));
  });
}
}

// dart format on
