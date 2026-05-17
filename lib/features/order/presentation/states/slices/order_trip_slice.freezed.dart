// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_trip_slice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderTripSlice {

 BlocStatus<OrderTripRouteEntity> get routeState; BlocStatus<List<OrderTripCarOptionEntity>> get carOptionsState; BlocStatus<OrderTripRouteEntity> get prefetchedRouteState; BlocStatus<List<OrderTripCarOptionEntity>> get prefetchedCarOptionsState; List<OrderLocationEntity> get prefetchedStops; String? get selectedCarTypeId; String? get selectedQuoteId;
/// Create a copy of OrderTripSlice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderTripSliceCopyWith<OrderTripSlice> get copyWith => _$OrderTripSliceCopyWithImpl<OrderTripSlice>(this as OrderTripSlice, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderTripSlice&&(identical(other.routeState, routeState) || other.routeState == routeState)&&(identical(other.carOptionsState, carOptionsState) || other.carOptionsState == carOptionsState)&&(identical(other.prefetchedRouteState, prefetchedRouteState) || other.prefetchedRouteState == prefetchedRouteState)&&(identical(other.prefetchedCarOptionsState, prefetchedCarOptionsState) || other.prefetchedCarOptionsState == prefetchedCarOptionsState)&&const DeepCollectionEquality().equals(other.prefetchedStops, prefetchedStops)&&(identical(other.selectedCarTypeId, selectedCarTypeId) || other.selectedCarTypeId == selectedCarTypeId)&&(identical(other.selectedQuoteId, selectedQuoteId) || other.selectedQuoteId == selectedQuoteId));
}


@override
int get hashCode => Object.hash(runtimeType,routeState,carOptionsState,prefetchedRouteState,prefetchedCarOptionsState,const DeepCollectionEquality().hash(prefetchedStops),selectedCarTypeId,selectedQuoteId);

@override
String toString() {
  return 'OrderTripSlice(routeState: $routeState, carOptionsState: $carOptionsState, prefetchedRouteState: $prefetchedRouteState, prefetchedCarOptionsState: $prefetchedCarOptionsState, prefetchedStops: $prefetchedStops, selectedCarTypeId: $selectedCarTypeId, selectedQuoteId: $selectedQuoteId)';
}


}

/// @nodoc
abstract mixin class $OrderTripSliceCopyWith<$Res>  {
  factory $OrderTripSliceCopyWith(OrderTripSlice value, $Res Function(OrderTripSlice) _then) = _$OrderTripSliceCopyWithImpl;
@useResult
$Res call({
 BlocStatus<OrderTripRouteEntity> routeState, BlocStatus<List<OrderTripCarOptionEntity>> carOptionsState, BlocStatus<OrderTripRouteEntity> prefetchedRouteState, BlocStatus<List<OrderTripCarOptionEntity>> prefetchedCarOptionsState, List<OrderLocationEntity> prefetchedStops, String? selectedCarTypeId, String? selectedQuoteId
});


$BlocStatusCopyWith<OrderTripRouteEntity, $Res> get routeState;$BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res> get carOptionsState;$BlocStatusCopyWith<OrderTripRouteEntity, $Res> get prefetchedRouteState;$BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res> get prefetchedCarOptionsState;

}
/// @nodoc
class _$OrderTripSliceCopyWithImpl<$Res>
    implements $OrderTripSliceCopyWith<$Res> {
  _$OrderTripSliceCopyWithImpl(this._self, this._then);

  final OrderTripSlice _self;
  final $Res Function(OrderTripSlice) _then;

/// Create a copy of OrderTripSlice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? routeState = null,Object? carOptionsState = null,Object? prefetchedRouteState = null,Object? prefetchedCarOptionsState = null,Object? prefetchedStops = null,Object? selectedCarTypeId = freezed,Object? selectedQuoteId = freezed,}) {
  return _then(_self.copyWith(
routeState: null == routeState ? _self.routeState : routeState // ignore: cast_nullable_to_non_nullable
as BlocStatus<OrderTripRouteEntity>,carOptionsState: null == carOptionsState ? _self.carOptionsState : carOptionsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<OrderTripCarOptionEntity>>,prefetchedRouteState: null == prefetchedRouteState ? _self.prefetchedRouteState : prefetchedRouteState // ignore: cast_nullable_to_non_nullable
as BlocStatus<OrderTripRouteEntity>,prefetchedCarOptionsState: null == prefetchedCarOptionsState ? _self.prefetchedCarOptionsState : prefetchedCarOptionsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<OrderTripCarOptionEntity>>,prefetchedStops: null == prefetchedStops ? _self.prefetchedStops : prefetchedStops // ignore: cast_nullable_to_non_nullable
as List<OrderLocationEntity>,selectedCarTypeId: freezed == selectedCarTypeId ? _self.selectedCarTypeId : selectedCarTypeId // ignore: cast_nullable_to_non_nullable
as String?,selectedQuoteId: freezed == selectedQuoteId ? _self.selectedQuoteId : selectedQuoteId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of OrderTripSlice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<OrderTripRouteEntity, $Res> get routeState {
  
  return $BlocStatusCopyWith<OrderTripRouteEntity, $Res>(_self.routeState, (value) {
    return _then(_self.copyWith(routeState: value));
  });
}/// Create a copy of OrderTripSlice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res> get carOptionsState {
  
  return $BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res>(_self.carOptionsState, (value) {
    return _then(_self.copyWith(carOptionsState: value));
  });
}/// Create a copy of OrderTripSlice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<OrderTripRouteEntity, $Res> get prefetchedRouteState {
  
  return $BlocStatusCopyWith<OrderTripRouteEntity, $Res>(_self.prefetchedRouteState, (value) {
    return _then(_self.copyWith(prefetchedRouteState: value));
  });
}/// Create a copy of OrderTripSlice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res> get prefetchedCarOptionsState {
  
  return $BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res>(_self.prefetchedCarOptionsState, (value) {
    return _then(_self.copyWith(prefetchedCarOptionsState: value));
  });
}
}


/// Adds pattern-matching-related methods to [OrderTripSlice].
extension OrderTripSlicePatterns on OrderTripSlice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderTripSlice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderTripSlice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderTripSlice value)  $default,){
final _that = this;
switch (_that) {
case _OrderTripSlice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderTripSlice value)?  $default,){
final _that = this;
switch (_that) {
case _OrderTripSlice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlocStatus<OrderTripRouteEntity> routeState,  BlocStatus<List<OrderTripCarOptionEntity>> carOptionsState,  BlocStatus<OrderTripRouteEntity> prefetchedRouteState,  BlocStatus<List<OrderTripCarOptionEntity>> prefetchedCarOptionsState,  List<OrderLocationEntity> prefetchedStops,  String? selectedCarTypeId,  String? selectedQuoteId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderTripSlice() when $default != null:
return $default(_that.routeState,_that.carOptionsState,_that.prefetchedRouteState,_that.prefetchedCarOptionsState,_that.prefetchedStops,_that.selectedCarTypeId,_that.selectedQuoteId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlocStatus<OrderTripRouteEntity> routeState,  BlocStatus<List<OrderTripCarOptionEntity>> carOptionsState,  BlocStatus<OrderTripRouteEntity> prefetchedRouteState,  BlocStatus<List<OrderTripCarOptionEntity>> prefetchedCarOptionsState,  List<OrderLocationEntity> prefetchedStops,  String? selectedCarTypeId,  String? selectedQuoteId)  $default,) {final _that = this;
switch (_that) {
case _OrderTripSlice():
return $default(_that.routeState,_that.carOptionsState,_that.prefetchedRouteState,_that.prefetchedCarOptionsState,_that.prefetchedStops,_that.selectedCarTypeId,_that.selectedQuoteId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlocStatus<OrderTripRouteEntity> routeState,  BlocStatus<List<OrderTripCarOptionEntity>> carOptionsState,  BlocStatus<OrderTripRouteEntity> prefetchedRouteState,  BlocStatus<List<OrderTripCarOptionEntity>> prefetchedCarOptionsState,  List<OrderLocationEntity> prefetchedStops,  String? selectedCarTypeId,  String? selectedQuoteId)?  $default,) {final _that = this;
switch (_that) {
case _OrderTripSlice() when $default != null:
return $default(_that.routeState,_that.carOptionsState,_that.prefetchedRouteState,_that.prefetchedCarOptionsState,_that.prefetchedStops,_that.selectedCarTypeId,_that.selectedQuoteId);case _:
  return null;

}
}

}

/// @nodoc


class _OrderTripSlice implements OrderTripSlice {
  const _OrderTripSlice({this.routeState = const BlocStatus<OrderTripRouteEntity>.initial(), this.carOptionsState = const BlocStatus<List<OrderTripCarOptionEntity>>.initial(), this.prefetchedRouteState = const BlocStatus<OrderTripRouteEntity>.initial(), this.prefetchedCarOptionsState = const BlocStatus<List<OrderTripCarOptionEntity>>.initial(), final  List<OrderLocationEntity> prefetchedStops = const [], this.selectedCarTypeId, this.selectedQuoteId}): _prefetchedStops = prefetchedStops;
  

@override@JsonKey() final  BlocStatus<OrderTripRouteEntity> routeState;
@override@JsonKey() final  BlocStatus<List<OrderTripCarOptionEntity>> carOptionsState;
@override@JsonKey() final  BlocStatus<OrderTripRouteEntity> prefetchedRouteState;
@override@JsonKey() final  BlocStatus<List<OrderTripCarOptionEntity>> prefetchedCarOptionsState;
 final  List<OrderLocationEntity> _prefetchedStops;
@override@JsonKey() List<OrderLocationEntity> get prefetchedStops {
  if (_prefetchedStops is EqualUnmodifiableListView) return _prefetchedStops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prefetchedStops);
}

@override final  String? selectedCarTypeId;
@override final  String? selectedQuoteId;

/// Create a copy of OrderTripSlice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderTripSliceCopyWith<_OrderTripSlice> get copyWith => __$OrderTripSliceCopyWithImpl<_OrderTripSlice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderTripSlice&&(identical(other.routeState, routeState) || other.routeState == routeState)&&(identical(other.carOptionsState, carOptionsState) || other.carOptionsState == carOptionsState)&&(identical(other.prefetchedRouteState, prefetchedRouteState) || other.prefetchedRouteState == prefetchedRouteState)&&(identical(other.prefetchedCarOptionsState, prefetchedCarOptionsState) || other.prefetchedCarOptionsState == prefetchedCarOptionsState)&&const DeepCollectionEquality().equals(other._prefetchedStops, _prefetchedStops)&&(identical(other.selectedCarTypeId, selectedCarTypeId) || other.selectedCarTypeId == selectedCarTypeId)&&(identical(other.selectedQuoteId, selectedQuoteId) || other.selectedQuoteId == selectedQuoteId));
}


@override
int get hashCode => Object.hash(runtimeType,routeState,carOptionsState,prefetchedRouteState,prefetchedCarOptionsState,const DeepCollectionEquality().hash(_prefetchedStops),selectedCarTypeId,selectedQuoteId);

@override
String toString() {
  return 'OrderTripSlice(routeState: $routeState, carOptionsState: $carOptionsState, prefetchedRouteState: $prefetchedRouteState, prefetchedCarOptionsState: $prefetchedCarOptionsState, prefetchedStops: $prefetchedStops, selectedCarTypeId: $selectedCarTypeId, selectedQuoteId: $selectedQuoteId)';
}


}

/// @nodoc
abstract mixin class _$OrderTripSliceCopyWith<$Res> implements $OrderTripSliceCopyWith<$Res> {
  factory _$OrderTripSliceCopyWith(_OrderTripSlice value, $Res Function(_OrderTripSlice) _then) = __$OrderTripSliceCopyWithImpl;
@override @useResult
$Res call({
 BlocStatus<OrderTripRouteEntity> routeState, BlocStatus<List<OrderTripCarOptionEntity>> carOptionsState, BlocStatus<OrderTripRouteEntity> prefetchedRouteState, BlocStatus<List<OrderTripCarOptionEntity>> prefetchedCarOptionsState, List<OrderLocationEntity> prefetchedStops, String? selectedCarTypeId, String? selectedQuoteId
});


@override $BlocStatusCopyWith<OrderTripRouteEntity, $Res> get routeState;@override $BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res> get carOptionsState;@override $BlocStatusCopyWith<OrderTripRouteEntity, $Res> get prefetchedRouteState;@override $BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res> get prefetchedCarOptionsState;

}
/// @nodoc
class __$OrderTripSliceCopyWithImpl<$Res>
    implements _$OrderTripSliceCopyWith<$Res> {
  __$OrderTripSliceCopyWithImpl(this._self, this._then);

  final _OrderTripSlice _self;
  final $Res Function(_OrderTripSlice) _then;

/// Create a copy of OrderTripSlice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? routeState = null,Object? carOptionsState = null,Object? prefetchedRouteState = null,Object? prefetchedCarOptionsState = null,Object? prefetchedStops = null,Object? selectedCarTypeId = freezed,Object? selectedQuoteId = freezed,}) {
  return _then(_OrderTripSlice(
routeState: null == routeState ? _self.routeState : routeState // ignore: cast_nullable_to_non_nullable
as BlocStatus<OrderTripRouteEntity>,carOptionsState: null == carOptionsState ? _self.carOptionsState : carOptionsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<OrderTripCarOptionEntity>>,prefetchedRouteState: null == prefetchedRouteState ? _self.prefetchedRouteState : prefetchedRouteState // ignore: cast_nullable_to_non_nullable
as BlocStatus<OrderTripRouteEntity>,prefetchedCarOptionsState: null == prefetchedCarOptionsState ? _self.prefetchedCarOptionsState : prefetchedCarOptionsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<OrderTripCarOptionEntity>>,prefetchedStops: null == prefetchedStops ? _self._prefetchedStops : prefetchedStops // ignore: cast_nullable_to_non_nullable
as List<OrderLocationEntity>,selectedCarTypeId: freezed == selectedCarTypeId ? _self.selectedCarTypeId : selectedCarTypeId // ignore: cast_nullable_to_non_nullable
as String?,selectedQuoteId: freezed == selectedQuoteId ? _self.selectedQuoteId : selectedQuoteId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of OrderTripSlice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<OrderTripRouteEntity, $Res> get routeState {
  
  return $BlocStatusCopyWith<OrderTripRouteEntity, $Res>(_self.routeState, (value) {
    return _then(_self.copyWith(routeState: value));
  });
}/// Create a copy of OrderTripSlice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res> get carOptionsState {
  
  return $BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res>(_self.carOptionsState, (value) {
    return _then(_self.copyWith(carOptionsState: value));
  });
}/// Create a copy of OrderTripSlice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<OrderTripRouteEntity, $Res> get prefetchedRouteState {
  
  return $BlocStatusCopyWith<OrderTripRouteEntity, $Res>(_self.prefetchedRouteState, (value) {
    return _then(_self.copyWith(prefetchedRouteState: value));
  });
}/// Create a copy of OrderTripSlice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res> get prefetchedCarOptionsState {
  
  return $BlocStatusCopyWith<List<OrderTripCarOptionEntity>, $Res>(_self.prefetchedCarOptionsState, (value) {
    return _then(_self.copyWith(prefetchedCarOptionsState: value));
  });
}
}

// dart format on
