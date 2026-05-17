// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_sheet_slice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderSheetSlice {

 OrderSheetMode get mode; OrderExpandedStep get expandedStep; OrderLocationTarget get mapPickingTarget; int get activeStopIndex;
/// Create a copy of OrderSheetSlice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderSheetSliceCopyWith<OrderSheetSlice> get copyWith => _$OrderSheetSliceCopyWithImpl<OrderSheetSlice>(this as OrderSheetSlice, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderSheetSlice&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.expandedStep, expandedStep) || other.expandedStep == expandedStep)&&(identical(other.mapPickingTarget, mapPickingTarget) || other.mapPickingTarget == mapPickingTarget)&&(identical(other.activeStopIndex, activeStopIndex) || other.activeStopIndex == activeStopIndex));
}


@override
int get hashCode => Object.hash(runtimeType,mode,expandedStep,mapPickingTarget,activeStopIndex);

@override
String toString() {
  return 'OrderSheetSlice(mode: $mode, expandedStep: $expandedStep, mapPickingTarget: $mapPickingTarget, activeStopIndex: $activeStopIndex)';
}


}

/// @nodoc
abstract mixin class $OrderSheetSliceCopyWith<$Res>  {
  factory $OrderSheetSliceCopyWith(OrderSheetSlice value, $Res Function(OrderSheetSlice) _then) = _$OrderSheetSliceCopyWithImpl;
@useResult
$Res call({
 OrderSheetMode mode, OrderExpandedStep expandedStep, OrderLocationTarget mapPickingTarget, int activeStopIndex
});




}
/// @nodoc
class _$OrderSheetSliceCopyWithImpl<$Res>
    implements $OrderSheetSliceCopyWith<$Res> {
  _$OrderSheetSliceCopyWithImpl(this._self, this._then);

  final OrderSheetSlice _self;
  final $Res Function(OrderSheetSlice) _then;

/// Create a copy of OrderSheetSlice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? expandedStep = null,Object? mapPickingTarget = null,Object? activeStopIndex = null,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as OrderSheetMode,expandedStep: null == expandedStep ? _self.expandedStep : expandedStep // ignore: cast_nullable_to_non_nullable
as OrderExpandedStep,mapPickingTarget: null == mapPickingTarget ? _self.mapPickingTarget : mapPickingTarget // ignore: cast_nullable_to_non_nullable
as OrderLocationTarget,activeStopIndex: null == activeStopIndex ? _self.activeStopIndex : activeStopIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderSheetSlice].
extension OrderSheetSlicePatterns on OrderSheetSlice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderSheetSlice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderSheetSlice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderSheetSlice value)  $default,){
final _that = this;
switch (_that) {
case _OrderSheetSlice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderSheetSlice value)?  $default,){
final _that = this;
switch (_that) {
case _OrderSheetSlice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OrderSheetMode mode,  OrderExpandedStep expandedStep,  OrderLocationTarget mapPickingTarget,  int activeStopIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderSheetSlice() when $default != null:
return $default(_that.mode,_that.expandedStep,_that.mapPickingTarget,_that.activeStopIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OrderSheetMode mode,  OrderExpandedStep expandedStep,  OrderLocationTarget mapPickingTarget,  int activeStopIndex)  $default,) {final _that = this;
switch (_that) {
case _OrderSheetSlice():
return $default(_that.mode,_that.expandedStep,_that.mapPickingTarget,_that.activeStopIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OrderSheetMode mode,  OrderExpandedStep expandedStep,  OrderLocationTarget mapPickingTarget,  int activeStopIndex)?  $default,) {final _that = this;
switch (_that) {
case _OrderSheetSlice() when $default != null:
return $default(_that.mode,_that.expandedStep,_that.mapPickingTarget,_that.activeStopIndex);case _:
  return null;

}
}

}

/// @nodoc


class _OrderSheetSlice implements OrderSheetSlice {
  const _OrderSheetSlice({this.mode = OrderSheetMode.collapsed, this.expandedStep = OrderExpandedStep.locationEntry, this.mapPickingTarget = OrderLocationTarget.stop, this.activeStopIndex = 0});
  

@override@JsonKey() final  OrderSheetMode mode;
@override@JsonKey() final  OrderExpandedStep expandedStep;
@override@JsonKey() final  OrderLocationTarget mapPickingTarget;
@override@JsonKey() final  int activeStopIndex;

/// Create a copy of OrderSheetSlice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderSheetSliceCopyWith<_OrderSheetSlice> get copyWith => __$OrderSheetSliceCopyWithImpl<_OrderSheetSlice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderSheetSlice&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.expandedStep, expandedStep) || other.expandedStep == expandedStep)&&(identical(other.mapPickingTarget, mapPickingTarget) || other.mapPickingTarget == mapPickingTarget)&&(identical(other.activeStopIndex, activeStopIndex) || other.activeStopIndex == activeStopIndex));
}


@override
int get hashCode => Object.hash(runtimeType,mode,expandedStep,mapPickingTarget,activeStopIndex);

@override
String toString() {
  return 'OrderSheetSlice(mode: $mode, expandedStep: $expandedStep, mapPickingTarget: $mapPickingTarget, activeStopIndex: $activeStopIndex)';
}


}

/// @nodoc
abstract mixin class _$OrderSheetSliceCopyWith<$Res> implements $OrderSheetSliceCopyWith<$Res> {
  factory _$OrderSheetSliceCopyWith(_OrderSheetSlice value, $Res Function(_OrderSheetSlice) _then) = __$OrderSheetSliceCopyWithImpl;
@override @useResult
$Res call({
 OrderSheetMode mode, OrderExpandedStep expandedStep, OrderLocationTarget mapPickingTarget, int activeStopIndex
});




}
/// @nodoc
class __$OrderSheetSliceCopyWithImpl<$Res>
    implements _$OrderSheetSliceCopyWith<$Res> {
  __$OrderSheetSliceCopyWithImpl(this._self, this._then);

  final _OrderSheetSlice _self;
  final $Res Function(_OrderSheetSlice) _then;

/// Create a copy of OrderSheetSlice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? expandedStep = null,Object? mapPickingTarget = null,Object? activeStopIndex = null,}) {
  return _then(_OrderSheetSlice(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as OrderSheetMode,expandedStep: null == expandedStep ? _self.expandedStep : expandedStep // ignore: cast_nullable_to_non_nullable
as OrderExpandedStep,mapPickingTarget: null == mapPickingTarget ? _self.mapPickingTarget : mapPickingTarget // ignore: cast_nullable_to_non_nullable
as OrderLocationTarget,activeStopIndex: null == activeStopIndex ? _self.activeStopIndex : activeStopIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
