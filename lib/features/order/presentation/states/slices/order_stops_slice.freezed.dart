// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_stops_slice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderStopsSlice {

 List<OrderLocationEntity?> get list; List<String> get queries; List<BlocStatus<List<OrderSavedLocationEntity>>> get suggestionsState; BlocStatus<List<OrderSavedLocationEntity>> get savedState;
/// Create a copy of OrderStopsSlice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderStopsSliceCopyWith<OrderStopsSlice> get copyWith => _$OrderStopsSliceCopyWithImpl<OrderStopsSlice>(this as OrderStopsSlice, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderStopsSlice&&const DeepCollectionEquality().equals(other.list, list)&&const DeepCollectionEquality().equals(other.queries, queries)&&const DeepCollectionEquality().equals(other.suggestionsState, suggestionsState)&&(identical(other.savedState, savedState) || other.savedState == savedState));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(list),const DeepCollectionEquality().hash(queries),const DeepCollectionEquality().hash(suggestionsState),savedState);

@override
String toString() {
  return 'OrderStopsSlice(list: $list, queries: $queries, suggestionsState: $suggestionsState, savedState: $savedState)';
}


}

/// @nodoc
abstract mixin class $OrderStopsSliceCopyWith<$Res>  {
  factory $OrderStopsSliceCopyWith(OrderStopsSlice value, $Res Function(OrderStopsSlice) _then) = _$OrderStopsSliceCopyWithImpl;
@useResult
$Res call({
 List<OrderLocationEntity?> list, List<String> queries, List<BlocStatus<List<OrderSavedLocationEntity>>> suggestionsState, BlocStatus<List<OrderSavedLocationEntity>> savedState
});


$BlocStatusCopyWith<List<OrderSavedLocationEntity>, $Res> get savedState;

}
/// @nodoc
class _$OrderStopsSliceCopyWithImpl<$Res>
    implements $OrderStopsSliceCopyWith<$Res> {
  _$OrderStopsSliceCopyWithImpl(this._self, this._then);

  final OrderStopsSlice _self;
  final $Res Function(OrderStopsSlice) _then;

/// Create a copy of OrderStopsSlice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? list = null,Object? queries = null,Object? suggestionsState = null,Object? savedState = null,}) {
  return _then(_self.copyWith(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<OrderLocationEntity?>,queries: null == queries ? _self.queries : queries // ignore: cast_nullable_to_non_nullable
as List<String>,suggestionsState: null == suggestionsState ? _self.suggestionsState : suggestionsState // ignore: cast_nullable_to_non_nullable
as List<BlocStatus<List<OrderSavedLocationEntity>>>,savedState: null == savedState ? _self.savedState : savedState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<OrderSavedLocationEntity>>,
  ));
}
/// Create a copy of OrderStopsSlice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<OrderSavedLocationEntity>, $Res> get savedState {
  
  return $BlocStatusCopyWith<List<OrderSavedLocationEntity>, $Res>(_self.savedState, (value) {
    return _then(_self.copyWith(savedState: value));
  });
}
}


/// Adds pattern-matching-related methods to [OrderStopsSlice].
extension OrderStopsSlicePatterns on OrderStopsSlice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderStopsSlice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderStopsSlice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderStopsSlice value)  $default,){
final _that = this;
switch (_that) {
case _OrderStopsSlice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderStopsSlice value)?  $default,){
final _that = this;
switch (_that) {
case _OrderStopsSlice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<OrderLocationEntity?> list,  List<String> queries,  List<BlocStatus<List<OrderSavedLocationEntity>>> suggestionsState,  BlocStatus<List<OrderSavedLocationEntity>> savedState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderStopsSlice() when $default != null:
return $default(_that.list,_that.queries,_that.suggestionsState,_that.savedState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<OrderLocationEntity?> list,  List<String> queries,  List<BlocStatus<List<OrderSavedLocationEntity>>> suggestionsState,  BlocStatus<List<OrderSavedLocationEntity>> savedState)  $default,) {final _that = this;
switch (_that) {
case _OrderStopsSlice():
return $default(_that.list,_that.queries,_that.suggestionsState,_that.savedState);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<OrderLocationEntity?> list,  List<String> queries,  List<BlocStatus<List<OrderSavedLocationEntity>>> suggestionsState,  BlocStatus<List<OrderSavedLocationEntity>> savedState)?  $default,) {final _that = this;
switch (_that) {
case _OrderStopsSlice() when $default != null:
return $default(_that.list,_that.queries,_that.suggestionsState,_that.savedState);case _:
  return null;

}
}

}

/// @nodoc


class _OrderStopsSlice implements OrderStopsSlice {
  const _OrderStopsSlice({final  List<OrderLocationEntity?> list = const [null, null], final  List<String> queries = const ['', ''], final  List<BlocStatus<List<OrderSavedLocationEntity>>> suggestionsState = const [BlocStatus<List<OrderSavedLocationEntity>>.initial(), BlocStatus<List<OrderSavedLocationEntity>>.initial()], this.savedState = const BlocStatus<List<OrderSavedLocationEntity>>.initial()}): _list = list,_queries = queries,_suggestionsState = suggestionsState;
  

 final  List<OrderLocationEntity?> _list;
@override@JsonKey() List<OrderLocationEntity?> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}

 final  List<String> _queries;
@override@JsonKey() List<String> get queries {
  if (_queries is EqualUnmodifiableListView) return _queries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_queries);
}

 final  List<BlocStatus<List<OrderSavedLocationEntity>>> _suggestionsState;
@override@JsonKey() List<BlocStatus<List<OrderSavedLocationEntity>>> get suggestionsState {
  if (_suggestionsState is EqualUnmodifiableListView) return _suggestionsState;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestionsState);
}

@override@JsonKey() final  BlocStatus<List<OrderSavedLocationEntity>> savedState;

/// Create a copy of OrderStopsSlice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderStopsSliceCopyWith<_OrderStopsSlice> get copyWith => __$OrderStopsSliceCopyWithImpl<_OrderStopsSlice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderStopsSlice&&const DeepCollectionEquality().equals(other._list, _list)&&const DeepCollectionEquality().equals(other._queries, _queries)&&const DeepCollectionEquality().equals(other._suggestionsState, _suggestionsState)&&(identical(other.savedState, savedState) || other.savedState == savedState));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list),const DeepCollectionEquality().hash(_queries),const DeepCollectionEquality().hash(_suggestionsState),savedState);

@override
String toString() {
  return 'OrderStopsSlice(list: $list, queries: $queries, suggestionsState: $suggestionsState, savedState: $savedState)';
}


}

/// @nodoc
abstract mixin class _$OrderStopsSliceCopyWith<$Res> implements $OrderStopsSliceCopyWith<$Res> {
  factory _$OrderStopsSliceCopyWith(_OrderStopsSlice value, $Res Function(_OrderStopsSlice) _then) = __$OrderStopsSliceCopyWithImpl;
@override @useResult
$Res call({
 List<OrderLocationEntity?> list, List<String> queries, List<BlocStatus<List<OrderSavedLocationEntity>>> suggestionsState, BlocStatus<List<OrderSavedLocationEntity>> savedState
});


@override $BlocStatusCopyWith<List<OrderSavedLocationEntity>, $Res> get savedState;

}
/// @nodoc
class __$OrderStopsSliceCopyWithImpl<$Res>
    implements _$OrderStopsSliceCopyWith<$Res> {
  __$OrderStopsSliceCopyWithImpl(this._self, this._then);

  final _OrderStopsSlice _self;
  final $Res Function(_OrderStopsSlice) _then;

/// Create a copy of OrderStopsSlice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? list = null,Object? queries = null,Object? suggestionsState = null,Object? savedState = null,}) {
  return _then(_OrderStopsSlice(
list: null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<OrderLocationEntity?>,queries: null == queries ? _self._queries : queries // ignore: cast_nullable_to_non_nullable
as List<String>,suggestionsState: null == suggestionsState ? _self._suggestionsState : suggestionsState // ignore: cast_nullable_to_non_nullable
as List<BlocStatus<List<OrderSavedLocationEntity>>>,savedState: null == savedState ? _self.savedState : savedState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<OrderSavedLocationEntity>>,
  ));
}

/// Create a copy of OrderStopsSlice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<OrderSavedLocationEntity>, $Res> get savedState {
  
  return $BlocStatusCopyWith<List<OrderSavedLocationEntity>, $Res>(_self.savedState, (value) {
    return _then(_self.copyWith(savedState: value));
  });
}
}

// dart format on
