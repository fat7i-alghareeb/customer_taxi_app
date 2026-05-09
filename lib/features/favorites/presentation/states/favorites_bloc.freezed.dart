// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FavoritesEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoritesEvent()';
}


}

/// @nodoc
class $FavoritesEventCopyWith<$Res>  {
$FavoritesEventCopyWith(FavoritesEvent _, $Res Function(FavoritesEvent) __);
}


/// Adds pattern-matching-related methods to [FavoritesEvent].
extension FavoritesEventPatterns on FavoritesEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _LocationAdded value)?  locationAdded,TResult Function( _LocationRemoved value)?  locationRemoved,TResult Function( _PinToggled value)?  pinToggled,TResult Function( _SearchRequested value)?  searchRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LocationAdded() when locationAdded != null:
return locationAdded(_that);case _LocationRemoved() when locationRemoved != null:
return locationRemoved(_that);case _PinToggled() when pinToggled != null:
return pinToggled(_that);case _SearchRequested() when searchRequested != null:
return searchRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _LocationAdded value)  locationAdded,required TResult Function( _LocationRemoved value)  locationRemoved,required TResult Function( _PinToggled value)  pinToggled,required TResult Function( _SearchRequested value)  searchRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _LocationAdded():
return locationAdded(_that);case _LocationRemoved():
return locationRemoved(_that);case _PinToggled():
return pinToggled(_that);case _SearchRequested():
return searchRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _LocationAdded value)?  locationAdded,TResult? Function( _LocationRemoved value)?  locationRemoved,TResult? Function( _PinToggled value)?  pinToggled,TResult? Function( _SearchRequested value)?  searchRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LocationAdded() when locationAdded != null:
return locationAdded(_that);case _LocationRemoved() when locationRemoved != null:
return locationRemoved(_that);case _PinToggled() when pinToggled != null:
return pinToggled(_that);case _SearchRequested() when searchRequested != null:
return searchRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( OrderLocationEntity location)?  locationAdded,TResult Function( String identityKey)?  locationRemoved,TResult Function( OrderLocationEntity location)?  pinToggled,TResult Function( String query)?  searchRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _LocationAdded() when locationAdded != null:
return locationAdded(_that.location);case _LocationRemoved() when locationRemoved != null:
return locationRemoved(_that.identityKey);case _PinToggled() when pinToggled != null:
return pinToggled(_that.location);case _SearchRequested() when searchRequested != null:
return searchRequested(_that.query);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( OrderLocationEntity location)  locationAdded,required TResult Function( String identityKey)  locationRemoved,required TResult Function( OrderLocationEntity location)  pinToggled,required TResult Function( String query)  searchRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _LocationAdded():
return locationAdded(_that.location);case _LocationRemoved():
return locationRemoved(_that.identityKey);case _PinToggled():
return pinToggled(_that.location);case _SearchRequested():
return searchRequested(_that.query);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( OrderLocationEntity location)?  locationAdded,TResult? Function( String identityKey)?  locationRemoved,TResult? Function( OrderLocationEntity location)?  pinToggled,TResult? Function( String query)?  searchRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _LocationAdded() when locationAdded != null:
return locationAdded(_that.location);case _LocationRemoved() when locationRemoved != null:
return locationRemoved(_that.identityKey);case _PinToggled() when pinToggled != null:
return pinToggled(_that.location);case _SearchRequested() when searchRequested != null:
return searchRequested(_that.query);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements FavoritesEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoritesEvent.started()';
}


}




/// @nodoc


class _LocationAdded implements FavoritesEvent {
  const _LocationAdded(this.location);
  

 final  OrderLocationEntity location;

/// Create a copy of FavoritesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationAddedCopyWith<_LocationAdded> get copyWith => __$LocationAddedCopyWithImpl<_LocationAdded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationAdded&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,location);

@override
String toString() {
  return 'FavoritesEvent.locationAdded(location: $location)';
}


}

/// @nodoc
abstract mixin class _$LocationAddedCopyWith<$Res> implements $FavoritesEventCopyWith<$Res> {
  factory _$LocationAddedCopyWith(_LocationAdded value, $Res Function(_LocationAdded) _then) = __$LocationAddedCopyWithImpl;
@useResult
$Res call({
 OrderLocationEntity location
});




}
/// @nodoc
class __$LocationAddedCopyWithImpl<$Res>
    implements _$LocationAddedCopyWith<$Res> {
  __$LocationAddedCopyWithImpl(this._self, this._then);

  final _LocationAdded _self;
  final $Res Function(_LocationAdded) _then;

/// Create a copy of FavoritesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? location = null,}) {
  return _then(_LocationAdded(
null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as OrderLocationEntity,
  ));
}


}

/// @nodoc


class _LocationRemoved implements FavoritesEvent {
  const _LocationRemoved(this.identityKey);
  

 final  String identityKey;

/// Create a copy of FavoritesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationRemovedCopyWith<_LocationRemoved> get copyWith => __$LocationRemovedCopyWithImpl<_LocationRemoved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationRemoved&&(identical(other.identityKey, identityKey) || other.identityKey == identityKey));
}


@override
int get hashCode => Object.hash(runtimeType,identityKey);

@override
String toString() {
  return 'FavoritesEvent.locationRemoved(identityKey: $identityKey)';
}


}

/// @nodoc
abstract mixin class _$LocationRemovedCopyWith<$Res> implements $FavoritesEventCopyWith<$Res> {
  factory _$LocationRemovedCopyWith(_LocationRemoved value, $Res Function(_LocationRemoved) _then) = __$LocationRemovedCopyWithImpl;
@useResult
$Res call({
 String identityKey
});




}
/// @nodoc
class __$LocationRemovedCopyWithImpl<$Res>
    implements _$LocationRemovedCopyWith<$Res> {
  __$LocationRemovedCopyWithImpl(this._self, this._then);

  final _LocationRemoved _self;
  final $Res Function(_LocationRemoved) _then;

/// Create a copy of FavoritesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? identityKey = null,}) {
  return _then(_LocationRemoved(
null == identityKey ? _self.identityKey : identityKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PinToggled implements FavoritesEvent {
  const _PinToggled(this.location);
  

 final  OrderLocationEntity location;

/// Create a copy of FavoritesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PinToggledCopyWith<_PinToggled> get copyWith => __$PinToggledCopyWithImpl<_PinToggled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PinToggled&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,location);

@override
String toString() {
  return 'FavoritesEvent.pinToggled(location: $location)';
}


}

/// @nodoc
abstract mixin class _$PinToggledCopyWith<$Res> implements $FavoritesEventCopyWith<$Res> {
  factory _$PinToggledCopyWith(_PinToggled value, $Res Function(_PinToggled) _then) = __$PinToggledCopyWithImpl;
@useResult
$Res call({
 OrderLocationEntity location
});




}
/// @nodoc
class __$PinToggledCopyWithImpl<$Res>
    implements _$PinToggledCopyWith<$Res> {
  __$PinToggledCopyWithImpl(this._self, this._then);

  final _PinToggled _self;
  final $Res Function(_PinToggled) _then;

/// Create a copy of FavoritesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? location = null,}) {
  return _then(_PinToggled(
null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as OrderLocationEntity,
  ));
}


}

/// @nodoc


class _SearchRequested implements FavoritesEvent {
  const _SearchRequested(this.query);
  

 final  String query;

/// Create a copy of FavoritesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchRequestedCopyWith<_SearchRequested> get copyWith => __$SearchRequestedCopyWithImpl<_SearchRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchRequested&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'FavoritesEvent.searchRequested(query: $query)';
}


}

/// @nodoc
abstract mixin class _$SearchRequestedCopyWith<$Res> implements $FavoritesEventCopyWith<$Res> {
  factory _$SearchRequestedCopyWith(_SearchRequested value, $Res Function(_SearchRequested) _then) = __$SearchRequestedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$SearchRequestedCopyWithImpl<$Res>
    implements _$SearchRequestedCopyWith<$Res> {
  __$SearchRequestedCopyWithImpl(this._self, this._then);

  final _SearchRequested _self;
  final $Res Function(_SearchRequested) _then;

/// Create a copy of FavoritesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_SearchRequested(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$FavoritesState {

 BlocStatus get loadStatus; BlocStatus get actionStatus; BlocStatus get searchStatus; List<OrderSavedLocationEntity> get locations; List<OrderLocationEntity> get searchResults;
/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoritesStateCopyWith<FavoritesState> get copyWith => _$FavoritesStateCopyWithImpl<FavoritesState>(this as FavoritesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesState&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.actionStatus, actionStatus) || other.actionStatus == actionStatus)&&(identical(other.searchStatus, searchStatus) || other.searchStatus == searchStatus)&&const DeepCollectionEquality().equals(other.locations, locations)&&const DeepCollectionEquality().equals(other.searchResults, searchResults));
}


@override
int get hashCode => Object.hash(runtimeType,loadStatus,actionStatus,searchStatus,const DeepCollectionEquality().hash(locations),const DeepCollectionEquality().hash(searchResults));

@override
String toString() {
  return 'FavoritesState(loadStatus: $loadStatus, actionStatus: $actionStatus, searchStatus: $searchStatus, locations: $locations, searchResults: $searchResults)';
}


}

/// @nodoc
abstract mixin class $FavoritesStateCopyWith<$Res>  {
  factory $FavoritesStateCopyWith(FavoritesState value, $Res Function(FavoritesState) _then) = _$FavoritesStateCopyWithImpl;
@useResult
$Res call({
 BlocStatus loadStatus, BlocStatus actionStatus, BlocStatus searchStatus, List<OrderSavedLocationEntity> locations, List<OrderLocationEntity> searchResults
});


$BlocStatusCopyWith<dynamic, $Res> get loadStatus;$BlocStatusCopyWith<dynamic, $Res> get actionStatus;$BlocStatusCopyWith<dynamic, $Res> get searchStatus;

}
/// @nodoc
class _$FavoritesStateCopyWithImpl<$Res>
    implements $FavoritesStateCopyWith<$Res> {
  _$FavoritesStateCopyWithImpl(this._self, this._then);

  final FavoritesState _self;
  final $Res Function(FavoritesState) _then;

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loadStatus = null,Object? actionStatus = null,Object? searchStatus = null,Object? locations = null,Object? searchResults = null,}) {
  return _then(_self.copyWith(
loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus,searchStatus: null == searchStatus ? _self.searchStatus : searchStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus,locations: null == locations ? _self.locations : locations // ignore: cast_nullable_to_non_nullable
as List<OrderSavedLocationEntity>,searchResults: null == searchResults ? _self.searchResults : searchResults // ignore: cast_nullable_to_non_nullable
as List<OrderLocationEntity>,
  ));
}
/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<dynamic, $Res> get loadStatus {
  
  return $BlocStatusCopyWith<dynamic, $Res>(_self.loadStatus, (value) {
    return _then(_self.copyWith(loadStatus: value));
  });
}/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<dynamic, $Res> get actionStatus {
  
  return $BlocStatusCopyWith<dynamic, $Res>(_self.actionStatus, (value) {
    return _then(_self.copyWith(actionStatus: value));
  });
}/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<dynamic, $Res> get searchStatus {
  
  return $BlocStatusCopyWith<dynamic, $Res>(_self.searchStatus, (value) {
    return _then(_self.copyWith(searchStatus: value));
  });
}
}


/// Adds pattern-matching-related methods to [FavoritesState].
extension FavoritesStatePatterns on FavoritesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoritesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoritesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoritesState value)  $default,){
final _that = this;
switch (_that) {
case _FavoritesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoritesState value)?  $default,){
final _that = this;
switch (_that) {
case _FavoritesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlocStatus loadStatus,  BlocStatus actionStatus,  BlocStatus searchStatus,  List<OrderSavedLocationEntity> locations,  List<OrderLocationEntity> searchResults)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoritesState() when $default != null:
return $default(_that.loadStatus,_that.actionStatus,_that.searchStatus,_that.locations,_that.searchResults);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlocStatus loadStatus,  BlocStatus actionStatus,  BlocStatus searchStatus,  List<OrderSavedLocationEntity> locations,  List<OrderLocationEntity> searchResults)  $default,) {final _that = this;
switch (_that) {
case _FavoritesState():
return $default(_that.loadStatus,_that.actionStatus,_that.searchStatus,_that.locations,_that.searchResults);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlocStatus loadStatus,  BlocStatus actionStatus,  BlocStatus searchStatus,  List<OrderSavedLocationEntity> locations,  List<OrderLocationEntity> searchResults)?  $default,) {final _that = this;
switch (_that) {
case _FavoritesState() when $default != null:
return $default(_that.loadStatus,_that.actionStatus,_that.searchStatus,_that.locations,_that.searchResults);case _:
  return null;

}
}

}

/// @nodoc


class _FavoritesState implements FavoritesState {
  const _FavoritesState({this.loadStatus = const BlocStatus.initial(), this.actionStatus = const BlocStatus.initial(), this.searchStatus = const BlocStatus.initial(), final  List<OrderSavedLocationEntity> locations = const [], final  List<OrderLocationEntity> searchResults = const []}): _locations = locations,_searchResults = searchResults;
  

@override@JsonKey() final  BlocStatus loadStatus;
@override@JsonKey() final  BlocStatus actionStatus;
@override@JsonKey() final  BlocStatus searchStatus;
 final  List<OrderSavedLocationEntity> _locations;
@override@JsonKey() List<OrderSavedLocationEntity> get locations {
  if (_locations is EqualUnmodifiableListView) return _locations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_locations);
}

 final  List<OrderLocationEntity> _searchResults;
@override@JsonKey() List<OrderLocationEntity> get searchResults {
  if (_searchResults is EqualUnmodifiableListView) return _searchResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_searchResults);
}


/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoritesStateCopyWith<_FavoritesState> get copyWith => __$FavoritesStateCopyWithImpl<_FavoritesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoritesState&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.actionStatus, actionStatus) || other.actionStatus == actionStatus)&&(identical(other.searchStatus, searchStatus) || other.searchStatus == searchStatus)&&const DeepCollectionEquality().equals(other._locations, _locations)&&const DeepCollectionEquality().equals(other._searchResults, _searchResults));
}


@override
int get hashCode => Object.hash(runtimeType,loadStatus,actionStatus,searchStatus,const DeepCollectionEquality().hash(_locations),const DeepCollectionEquality().hash(_searchResults));

@override
String toString() {
  return 'FavoritesState(loadStatus: $loadStatus, actionStatus: $actionStatus, searchStatus: $searchStatus, locations: $locations, searchResults: $searchResults)';
}


}

/// @nodoc
abstract mixin class _$FavoritesStateCopyWith<$Res> implements $FavoritesStateCopyWith<$Res> {
  factory _$FavoritesStateCopyWith(_FavoritesState value, $Res Function(_FavoritesState) _then) = __$FavoritesStateCopyWithImpl;
@override @useResult
$Res call({
 BlocStatus loadStatus, BlocStatus actionStatus, BlocStatus searchStatus, List<OrderSavedLocationEntity> locations, List<OrderLocationEntity> searchResults
});


@override $BlocStatusCopyWith<dynamic, $Res> get loadStatus;@override $BlocStatusCopyWith<dynamic, $Res> get actionStatus;@override $BlocStatusCopyWith<dynamic, $Res> get searchStatus;

}
/// @nodoc
class __$FavoritesStateCopyWithImpl<$Res>
    implements _$FavoritesStateCopyWith<$Res> {
  __$FavoritesStateCopyWithImpl(this._self, this._then);

  final _FavoritesState _self;
  final $Res Function(_FavoritesState) _then;

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loadStatus = null,Object? actionStatus = null,Object? searchStatus = null,Object? locations = null,Object? searchResults = null,}) {
  return _then(_FavoritesState(
loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus,searchStatus: null == searchStatus ? _self.searchStatus : searchStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus,locations: null == locations ? _self._locations : locations // ignore: cast_nullable_to_non_nullable
as List<OrderSavedLocationEntity>,searchResults: null == searchResults ? _self._searchResults : searchResults // ignore: cast_nullable_to_non_nullable
as List<OrderLocationEntity>,
  ));
}

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<dynamic, $Res> get loadStatus {
  
  return $BlocStatusCopyWith<dynamic, $Res>(_self.loadStatus, (value) {
    return _then(_self.copyWith(loadStatus: value));
  });
}/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<dynamic, $Res> get actionStatus {
  
  return $BlocStatusCopyWith<dynamic, $Res>(_self.actionStatus, (value) {
    return _then(_self.copyWith(actionStatus: value));
  });
}/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<dynamic, $Res> get searchStatus {
  
  return $BlocStatusCopyWith<dynamic, $Res>(_self.searchStatus, (value) {
    return _then(_self.copyWith(searchStatus: value));
  });
}
}

// dart format on
