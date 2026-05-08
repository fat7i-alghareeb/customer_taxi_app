// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent()';
}


}

/// @nodoc
class $ProfileEventCopyWith<$Res>  {
$ProfileEventCopyWith(ProfileEvent _, $Res Function(ProfileEvent) __);
}


/// Adds pattern-matching-related methods to [ProfileEvent].
extension ProfileEventPatterns on ProfileEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _NameSaved value)?  nameSaved,TResult Function( _PhotoSelected value)?  photoSelected,TResult Function( _SaveRequested value)?  saveRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _NameSaved() when nameSaved != null:
return nameSaved(_that);case _PhotoSelected() when photoSelected != null:
return photoSelected(_that);case _SaveRequested() when saveRequested != null:
return saveRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _NameSaved value)  nameSaved,required TResult Function( _PhotoSelected value)  photoSelected,required TResult Function( _SaveRequested value)  saveRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _NameSaved():
return nameSaved(_that);case _PhotoSelected():
return photoSelected(_that);case _SaveRequested():
return saveRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _NameSaved value)?  nameSaved,TResult? Function( _PhotoSelected value)?  photoSelected,TResult? Function( _SaveRequested value)?  saveRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _NameSaved() when nameSaved != null:
return nameSaved(_that);case _PhotoSelected() when photoSelected != null:
return photoSelected(_that);case _SaveRequested() when saveRequested != null:
return saveRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String name)?  nameSaved,TResult Function( File photo)?  photoSelected,TResult Function()?  saveRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _NameSaved() when nameSaved != null:
return nameSaved(_that.name);case _PhotoSelected() when photoSelected != null:
return photoSelected(_that.photo);case _SaveRequested() when saveRequested != null:
return saveRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String name)  nameSaved,required TResult Function( File photo)  photoSelected,required TResult Function()  saveRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _NameSaved():
return nameSaved(_that.name);case _PhotoSelected():
return photoSelected(_that.photo);case _SaveRequested():
return saveRequested();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String name)?  nameSaved,TResult? Function( File photo)?  photoSelected,TResult? Function()?  saveRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _NameSaved() when nameSaved != null:
return nameSaved(_that.name);case _PhotoSelected() when photoSelected != null:
return photoSelected(_that.photo);case _SaveRequested() when saveRequested != null:
return saveRequested();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements ProfileEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.started()';
}


}




/// @nodoc


class _NameSaved implements ProfileEvent {
  const _NameSaved(this.name);
  

 final  String name;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NameSavedCopyWith<_NameSaved> get copyWith => __$NameSavedCopyWithImpl<_NameSaved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NameSaved&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'ProfileEvent.nameSaved(name: $name)';
}


}

/// @nodoc
abstract mixin class _$NameSavedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory _$NameSavedCopyWith(_NameSaved value, $Res Function(_NameSaved) _then) = __$NameSavedCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class __$NameSavedCopyWithImpl<$Res>
    implements _$NameSavedCopyWith<$Res> {
  __$NameSavedCopyWithImpl(this._self, this._then);

  final _NameSaved _self;
  final $Res Function(_NameSaved) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(_NameSaved(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PhotoSelected implements ProfileEvent {
  const _PhotoSelected(this.photo);
  

 final  File photo;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhotoSelectedCopyWith<_PhotoSelected> get copyWith => __$PhotoSelectedCopyWithImpl<_PhotoSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhotoSelected&&(identical(other.photo, photo) || other.photo == photo));
}


@override
int get hashCode => Object.hash(runtimeType,photo);

@override
String toString() {
  return 'ProfileEvent.photoSelected(photo: $photo)';
}


}

/// @nodoc
abstract mixin class _$PhotoSelectedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory _$PhotoSelectedCopyWith(_PhotoSelected value, $Res Function(_PhotoSelected) _then) = __$PhotoSelectedCopyWithImpl;
@useResult
$Res call({
 File photo
});




}
/// @nodoc
class __$PhotoSelectedCopyWithImpl<$Res>
    implements _$PhotoSelectedCopyWith<$Res> {
  __$PhotoSelectedCopyWithImpl(this._self, this._then);

  final _PhotoSelected _self;
  final $Res Function(_PhotoSelected) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? photo = null,}) {
  return _then(_PhotoSelected(
null == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as File,
  ));
}


}

/// @nodoc


class _SaveRequested implements ProfileEvent {
  const _SaveRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.saveRequested()';
}


}




/// @nodoc
mixin _$ProfileState {

 BlocStatus<ProfileEntity> get loadStatus; BlocStatus<ProfileEntity> get saveStatus; ProfileEntity? get currentUser; String get pendingName; File? get pendingPhoto;
/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileStateCopyWith<ProfileState> get copyWith => _$ProfileStateCopyWithImpl<ProfileState>(this as ProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus)&&(identical(other.currentUser, currentUser) || other.currentUser == currentUser)&&(identical(other.pendingName, pendingName) || other.pendingName == pendingName)&&(identical(other.pendingPhoto, pendingPhoto) || other.pendingPhoto == pendingPhoto));
}


@override
int get hashCode => Object.hash(runtimeType,loadStatus,saveStatus,currentUser,pendingName,pendingPhoto);

@override
String toString() {
  return 'ProfileState(loadStatus: $loadStatus, saveStatus: $saveStatus, currentUser: $currentUser, pendingName: $pendingName, pendingPhoto: $pendingPhoto)';
}


}

/// @nodoc
abstract mixin class $ProfileStateCopyWith<$Res>  {
  factory $ProfileStateCopyWith(ProfileState value, $Res Function(ProfileState) _then) = _$ProfileStateCopyWithImpl;
@useResult
$Res call({
 BlocStatus<ProfileEntity> loadStatus, BlocStatus<ProfileEntity> saveStatus, ProfileEntity? currentUser, String pendingName, File? pendingPhoto
});


$BlocStatusCopyWith<ProfileEntity, $Res> get loadStatus;$BlocStatusCopyWith<ProfileEntity, $Res> get saveStatus;$ProfileEntityCopyWith<$Res>? get currentUser;

}
/// @nodoc
class _$ProfileStateCopyWithImpl<$Res>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._self, this._then);

  final ProfileState _self;
  final $Res Function(ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loadStatus = null,Object? saveStatus = null,Object? currentUser = freezed,Object? pendingName = null,Object? pendingPhoto = freezed,}) {
  return _then(_self.copyWith(
loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<ProfileEntity>,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<ProfileEntity>,currentUser: freezed == currentUser ? _self.currentUser : currentUser // ignore: cast_nullable_to_non_nullable
as ProfileEntity?,pendingName: null == pendingName ? _self.pendingName : pendingName // ignore: cast_nullable_to_non_nullable
as String,pendingPhoto: freezed == pendingPhoto ? _self.pendingPhoto : pendingPhoto // ignore: cast_nullable_to_non_nullable
as File?,
  ));
}
/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<ProfileEntity, $Res> get loadStatus {
  
  return $BlocStatusCopyWith<ProfileEntity, $Res>(_self.loadStatus, (value) {
    return _then(_self.copyWith(loadStatus: value));
  });
}/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<ProfileEntity, $Res> get saveStatus {
  
  return $BlocStatusCopyWith<ProfileEntity, $Res>(_self.saveStatus, (value) {
    return _then(_self.copyWith(saveStatus: value));
  });
}/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileEntityCopyWith<$Res>? get currentUser {
    if (_self.currentUser == null) {
    return null;
  }

  return $ProfileEntityCopyWith<$Res>(_self.currentUser!, (value) {
    return _then(_self.copyWith(currentUser: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileState].
extension ProfileStatePatterns on ProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileState value)  $default,){
final _that = this;
switch (_that) {
case _ProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlocStatus<ProfileEntity> loadStatus,  BlocStatus<ProfileEntity> saveStatus,  ProfileEntity? currentUser,  String pendingName,  File? pendingPhoto)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.loadStatus,_that.saveStatus,_that.currentUser,_that.pendingName,_that.pendingPhoto);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlocStatus<ProfileEntity> loadStatus,  BlocStatus<ProfileEntity> saveStatus,  ProfileEntity? currentUser,  String pendingName,  File? pendingPhoto)  $default,) {final _that = this;
switch (_that) {
case _ProfileState():
return $default(_that.loadStatus,_that.saveStatus,_that.currentUser,_that.pendingName,_that.pendingPhoto);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlocStatus<ProfileEntity> loadStatus,  BlocStatus<ProfileEntity> saveStatus,  ProfileEntity? currentUser,  String pendingName,  File? pendingPhoto)?  $default,) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.loadStatus,_that.saveStatus,_that.currentUser,_that.pendingName,_that.pendingPhoto);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileState implements ProfileState {
  const _ProfileState({this.loadStatus = const BlocStatus<ProfileEntity>.initial(), this.saveStatus = const BlocStatus<ProfileEntity>.initial(), this.currentUser, this.pendingName = '', this.pendingPhoto});
  

@override@JsonKey() final  BlocStatus<ProfileEntity> loadStatus;
@override@JsonKey() final  BlocStatus<ProfileEntity> saveStatus;
@override final  ProfileEntity? currentUser;
@override@JsonKey() final  String pendingName;
@override final  File? pendingPhoto;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileStateCopyWith<_ProfileState> get copyWith => __$ProfileStateCopyWithImpl<_ProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileState&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus)&&(identical(other.currentUser, currentUser) || other.currentUser == currentUser)&&(identical(other.pendingName, pendingName) || other.pendingName == pendingName)&&(identical(other.pendingPhoto, pendingPhoto) || other.pendingPhoto == pendingPhoto));
}


@override
int get hashCode => Object.hash(runtimeType,loadStatus,saveStatus,currentUser,pendingName,pendingPhoto);

@override
String toString() {
  return 'ProfileState(loadStatus: $loadStatus, saveStatus: $saveStatus, currentUser: $currentUser, pendingName: $pendingName, pendingPhoto: $pendingPhoto)';
}


}

/// @nodoc
abstract mixin class _$ProfileStateCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory _$ProfileStateCopyWith(_ProfileState value, $Res Function(_ProfileState) _then) = __$ProfileStateCopyWithImpl;
@override @useResult
$Res call({
 BlocStatus<ProfileEntity> loadStatus, BlocStatus<ProfileEntity> saveStatus, ProfileEntity? currentUser, String pendingName, File? pendingPhoto
});


@override $BlocStatusCopyWith<ProfileEntity, $Res> get loadStatus;@override $BlocStatusCopyWith<ProfileEntity, $Res> get saveStatus;@override $ProfileEntityCopyWith<$Res>? get currentUser;

}
/// @nodoc
class __$ProfileStateCopyWithImpl<$Res>
    implements _$ProfileStateCopyWith<$Res> {
  __$ProfileStateCopyWithImpl(this._self, this._then);

  final _ProfileState _self;
  final $Res Function(_ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loadStatus = null,Object? saveStatus = null,Object? currentUser = freezed,Object? pendingName = null,Object? pendingPhoto = freezed,}) {
  return _then(_ProfileState(
loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<ProfileEntity>,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<ProfileEntity>,currentUser: freezed == currentUser ? _self.currentUser : currentUser // ignore: cast_nullable_to_non_nullable
as ProfileEntity?,pendingName: null == pendingName ? _self.pendingName : pendingName // ignore: cast_nullable_to_non_nullable
as String,pendingPhoto: freezed == pendingPhoto ? _self.pendingPhoto : pendingPhoto // ignore: cast_nullable_to_non_nullable
as File?,
  ));
}

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<ProfileEntity, $Res> get loadStatus {
  
  return $BlocStatusCopyWith<ProfileEntity, $Res>(_self.loadStatus, (value) {
    return _then(_self.copyWith(loadStatus: value));
  });
}/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<ProfileEntity, $Res> get saveStatus {
  
  return $BlocStatusCopyWith<ProfileEntity, $Res>(_self.saveStatus, (value) {
    return _then(_self.copyWith(saveStatus: value));
  });
}/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileEntityCopyWith<$Res>? get currentUser {
    if (_self.currentUser == null) {
    return null;
  }

  return $ProfileEntityCopyWith<$Res>(_self.currentUser!, (value) {
    return _then(_self.copyWith(currentUser: value));
  });
}
}

// dart format on
