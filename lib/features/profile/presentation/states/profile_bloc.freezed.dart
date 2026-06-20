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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _NameSaved value)?  nameSaved,TResult Function( _EmailSaved value)?  emailSaved,TResult Function( _PhotoSelected value)?  photoSelected,TResult Function( _HomeAddressSelected value)?  homeAddressSelected,TResult Function( _SaveRequested value)?  saveRequested,TResult Function( _DeleteAccountRequested value)?  deleteAccountRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _NameSaved() when nameSaved != null:
return nameSaved(_that);case _EmailSaved() when emailSaved != null:
return emailSaved(_that);case _PhotoSelected() when photoSelected != null:
return photoSelected(_that);case _HomeAddressSelected() when homeAddressSelected != null:
return homeAddressSelected(_that);case _SaveRequested() when saveRequested != null:
return saveRequested(_that);case _DeleteAccountRequested() when deleteAccountRequested != null:
return deleteAccountRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _NameSaved value)  nameSaved,required TResult Function( _EmailSaved value)  emailSaved,required TResult Function( _PhotoSelected value)  photoSelected,required TResult Function( _HomeAddressSelected value)  homeAddressSelected,required TResult Function( _SaveRequested value)  saveRequested,required TResult Function( _DeleteAccountRequested value)  deleteAccountRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _NameSaved():
return nameSaved(_that);case _EmailSaved():
return emailSaved(_that);case _PhotoSelected():
return photoSelected(_that);case _HomeAddressSelected():
return homeAddressSelected(_that);case _SaveRequested():
return saveRequested(_that);case _DeleteAccountRequested():
return deleteAccountRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _NameSaved value)?  nameSaved,TResult? Function( _EmailSaved value)?  emailSaved,TResult? Function( _PhotoSelected value)?  photoSelected,TResult? Function( _HomeAddressSelected value)?  homeAddressSelected,TResult? Function( _SaveRequested value)?  saveRequested,TResult? Function( _DeleteAccountRequested value)?  deleteAccountRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _NameSaved() when nameSaved != null:
return nameSaved(_that);case _EmailSaved() when emailSaved != null:
return emailSaved(_that);case _PhotoSelected() when photoSelected != null:
return photoSelected(_that);case _HomeAddressSelected() when homeAddressSelected != null:
return homeAddressSelected(_that);case _SaveRequested() when saveRequested != null:
return saveRequested(_that);case _DeleteAccountRequested() when deleteAccountRequested != null:
return deleteAccountRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String name)?  nameSaved,TResult Function( String email)?  emailSaved,TResult Function( File photo)?  photoSelected,TResult Function( String? label,  double? latitude,  double? longitude)?  homeAddressSelected,TResult Function()?  saveRequested,TResult Function()?  deleteAccountRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _NameSaved() when nameSaved != null:
return nameSaved(_that.name);case _EmailSaved() when emailSaved != null:
return emailSaved(_that.email);case _PhotoSelected() when photoSelected != null:
return photoSelected(_that.photo);case _HomeAddressSelected() when homeAddressSelected != null:
return homeAddressSelected(_that.label,_that.latitude,_that.longitude);case _SaveRequested() when saveRequested != null:
return saveRequested();case _DeleteAccountRequested() when deleteAccountRequested != null:
return deleteAccountRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String name)  nameSaved,required TResult Function( String email)  emailSaved,required TResult Function( File photo)  photoSelected,required TResult Function( String? label,  double? latitude,  double? longitude)  homeAddressSelected,required TResult Function()  saveRequested,required TResult Function()  deleteAccountRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _NameSaved():
return nameSaved(_that.name);case _EmailSaved():
return emailSaved(_that.email);case _PhotoSelected():
return photoSelected(_that.photo);case _HomeAddressSelected():
return homeAddressSelected(_that.label,_that.latitude,_that.longitude);case _SaveRequested():
return saveRequested();case _DeleteAccountRequested():
return deleteAccountRequested();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String name)?  nameSaved,TResult? Function( String email)?  emailSaved,TResult? Function( File photo)?  photoSelected,TResult? Function( String? label,  double? latitude,  double? longitude)?  homeAddressSelected,TResult? Function()?  saveRequested,TResult? Function()?  deleteAccountRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _NameSaved() when nameSaved != null:
return nameSaved(_that.name);case _EmailSaved() when emailSaved != null:
return emailSaved(_that.email);case _PhotoSelected() when photoSelected != null:
return photoSelected(_that.photo);case _HomeAddressSelected() when homeAddressSelected != null:
return homeAddressSelected(_that.label,_that.latitude,_that.longitude);case _SaveRequested() when saveRequested != null:
return saveRequested();case _DeleteAccountRequested() when deleteAccountRequested != null:
return deleteAccountRequested();case _:
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


class _EmailSaved implements ProfileEvent {
  const _EmailSaved(this.email);
  

 final  String email;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailSavedCopyWith<_EmailSaved> get copyWith => __$EmailSavedCopyWithImpl<_EmailSaved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailSaved&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'ProfileEvent.emailSaved(email: $email)';
}


}

/// @nodoc
abstract mixin class _$EmailSavedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory _$EmailSavedCopyWith(_EmailSaved value, $Res Function(_EmailSaved) _then) = __$EmailSavedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class __$EmailSavedCopyWithImpl<$Res>
    implements _$EmailSavedCopyWith<$Res> {
  __$EmailSavedCopyWithImpl(this._self, this._then);

  final _EmailSaved _self;
  final $Res Function(_EmailSaved) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_EmailSaved(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
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


class _HomeAddressSelected implements ProfileEvent {
  const _HomeAddressSelected({this.label, this.latitude, this.longitude});
  

 final  String? label;
 final  double? latitude;
 final  double? longitude;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeAddressSelectedCopyWith<_HomeAddressSelected> get copyWith => __$HomeAddressSelectedCopyWithImpl<_HomeAddressSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeAddressSelected&&(identical(other.label, label) || other.label == label)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode => Object.hash(runtimeType,label,latitude,longitude);

@override
String toString() {
  return 'ProfileEvent.homeAddressSelected(label: $label, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$HomeAddressSelectedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory _$HomeAddressSelectedCopyWith(_HomeAddressSelected value, $Res Function(_HomeAddressSelected) _then) = __$HomeAddressSelectedCopyWithImpl;
@useResult
$Res call({
 String? label, double? latitude, double? longitude
});




}
/// @nodoc
class __$HomeAddressSelectedCopyWithImpl<$Res>
    implements _$HomeAddressSelectedCopyWith<$Res> {
  __$HomeAddressSelectedCopyWithImpl(this._self, this._then);

  final _HomeAddressSelected _self;
  final $Res Function(_HomeAddressSelected) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? label = freezed,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(_HomeAddressSelected(
label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
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


class _DeleteAccountRequested implements ProfileEvent {
  const _DeleteAccountRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteAccountRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.deleteAccountRequested()';
}


}




/// @nodoc
mixin _$ProfileState {

 BlocStatus<ProfileEntity> get loadStatus; BlocStatus<ProfileEntity> get saveStatus; BlocStatus<void> get deleteAccountStatus; ProfileEntity? get currentUser; String get pendingName; String get pendingEmail; File? get pendingPhoto;// Pending home address selection. `homeAddressTouched` distinguishes "not
// changed" (keep current) from "cleared" (all values null → remove).
 bool get homeAddressTouched; String? get pendingHomeAddressLabel; double? get pendingHomeAddressLatitude; double? get pendingHomeAddressLongitude;
/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileStateCopyWith<ProfileState> get copyWith => _$ProfileStateCopyWithImpl<ProfileState>(this as ProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus)&&(identical(other.deleteAccountStatus, deleteAccountStatus) || other.deleteAccountStatus == deleteAccountStatus)&&(identical(other.currentUser, currentUser) || other.currentUser == currentUser)&&(identical(other.pendingName, pendingName) || other.pendingName == pendingName)&&(identical(other.pendingEmail, pendingEmail) || other.pendingEmail == pendingEmail)&&(identical(other.pendingPhoto, pendingPhoto) || other.pendingPhoto == pendingPhoto)&&(identical(other.homeAddressTouched, homeAddressTouched) || other.homeAddressTouched == homeAddressTouched)&&(identical(other.pendingHomeAddressLabel, pendingHomeAddressLabel) || other.pendingHomeAddressLabel == pendingHomeAddressLabel)&&(identical(other.pendingHomeAddressLatitude, pendingHomeAddressLatitude) || other.pendingHomeAddressLatitude == pendingHomeAddressLatitude)&&(identical(other.pendingHomeAddressLongitude, pendingHomeAddressLongitude) || other.pendingHomeAddressLongitude == pendingHomeAddressLongitude));
}


@override
int get hashCode => Object.hash(runtimeType,loadStatus,saveStatus,deleteAccountStatus,currentUser,pendingName,pendingEmail,pendingPhoto,homeAddressTouched,pendingHomeAddressLabel,pendingHomeAddressLatitude,pendingHomeAddressLongitude);

@override
String toString() {
  return 'ProfileState(loadStatus: $loadStatus, saveStatus: $saveStatus, deleteAccountStatus: $deleteAccountStatus, currentUser: $currentUser, pendingName: $pendingName, pendingEmail: $pendingEmail, pendingPhoto: $pendingPhoto, homeAddressTouched: $homeAddressTouched, pendingHomeAddressLabel: $pendingHomeAddressLabel, pendingHomeAddressLatitude: $pendingHomeAddressLatitude, pendingHomeAddressLongitude: $pendingHomeAddressLongitude)';
}


}

/// @nodoc
abstract mixin class $ProfileStateCopyWith<$Res>  {
  factory $ProfileStateCopyWith(ProfileState value, $Res Function(ProfileState) _then) = _$ProfileStateCopyWithImpl;
@useResult
$Res call({
 BlocStatus<ProfileEntity> loadStatus, BlocStatus<ProfileEntity> saveStatus, BlocStatus<void> deleteAccountStatus, ProfileEntity? currentUser, String pendingName, String pendingEmail, File? pendingPhoto, bool homeAddressTouched, String? pendingHomeAddressLabel, double? pendingHomeAddressLatitude, double? pendingHomeAddressLongitude
});


$BlocStatusCopyWith<ProfileEntity, $Res> get loadStatus;$BlocStatusCopyWith<ProfileEntity, $Res> get saveStatus;$BlocStatusCopyWith<void, $Res> get deleteAccountStatus;$ProfileEntityCopyWith<$Res>? get currentUser;

}
/// @nodoc
class _$ProfileStateCopyWithImpl<$Res>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._self, this._then);

  final ProfileState _self;
  final $Res Function(ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loadStatus = null,Object? saveStatus = null,Object? deleteAccountStatus = null,Object? currentUser = freezed,Object? pendingName = null,Object? pendingEmail = null,Object? pendingPhoto = freezed,Object? homeAddressTouched = null,Object? pendingHomeAddressLabel = freezed,Object? pendingHomeAddressLatitude = freezed,Object? pendingHomeAddressLongitude = freezed,}) {
  return _then(_self.copyWith(
loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<ProfileEntity>,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<ProfileEntity>,deleteAccountStatus: null == deleteAccountStatus ? _self.deleteAccountStatus : deleteAccountStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,currentUser: freezed == currentUser ? _self.currentUser : currentUser // ignore: cast_nullable_to_non_nullable
as ProfileEntity?,pendingName: null == pendingName ? _self.pendingName : pendingName // ignore: cast_nullable_to_non_nullable
as String,pendingEmail: null == pendingEmail ? _self.pendingEmail : pendingEmail // ignore: cast_nullable_to_non_nullable
as String,pendingPhoto: freezed == pendingPhoto ? _self.pendingPhoto : pendingPhoto // ignore: cast_nullable_to_non_nullable
as File?,homeAddressTouched: null == homeAddressTouched ? _self.homeAddressTouched : homeAddressTouched // ignore: cast_nullable_to_non_nullable
as bool,pendingHomeAddressLabel: freezed == pendingHomeAddressLabel ? _self.pendingHomeAddressLabel : pendingHomeAddressLabel // ignore: cast_nullable_to_non_nullable
as String?,pendingHomeAddressLatitude: freezed == pendingHomeAddressLatitude ? _self.pendingHomeAddressLatitude : pendingHomeAddressLatitude // ignore: cast_nullable_to_non_nullable
as double?,pendingHomeAddressLongitude: freezed == pendingHomeAddressLongitude ? _self.pendingHomeAddressLongitude : pendingHomeAddressLongitude // ignore: cast_nullable_to_non_nullable
as double?,
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
$BlocStatusCopyWith<void, $Res> get deleteAccountStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.deleteAccountStatus, (value) {
    return _then(_self.copyWith(deleteAccountStatus: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlocStatus<ProfileEntity> loadStatus,  BlocStatus<ProfileEntity> saveStatus,  BlocStatus<void> deleteAccountStatus,  ProfileEntity? currentUser,  String pendingName,  String pendingEmail,  File? pendingPhoto,  bool homeAddressTouched,  String? pendingHomeAddressLabel,  double? pendingHomeAddressLatitude,  double? pendingHomeAddressLongitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.loadStatus,_that.saveStatus,_that.deleteAccountStatus,_that.currentUser,_that.pendingName,_that.pendingEmail,_that.pendingPhoto,_that.homeAddressTouched,_that.pendingHomeAddressLabel,_that.pendingHomeAddressLatitude,_that.pendingHomeAddressLongitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlocStatus<ProfileEntity> loadStatus,  BlocStatus<ProfileEntity> saveStatus,  BlocStatus<void> deleteAccountStatus,  ProfileEntity? currentUser,  String pendingName,  String pendingEmail,  File? pendingPhoto,  bool homeAddressTouched,  String? pendingHomeAddressLabel,  double? pendingHomeAddressLatitude,  double? pendingHomeAddressLongitude)  $default,) {final _that = this;
switch (_that) {
case _ProfileState():
return $default(_that.loadStatus,_that.saveStatus,_that.deleteAccountStatus,_that.currentUser,_that.pendingName,_that.pendingEmail,_that.pendingPhoto,_that.homeAddressTouched,_that.pendingHomeAddressLabel,_that.pendingHomeAddressLatitude,_that.pendingHomeAddressLongitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlocStatus<ProfileEntity> loadStatus,  BlocStatus<ProfileEntity> saveStatus,  BlocStatus<void> deleteAccountStatus,  ProfileEntity? currentUser,  String pendingName,  String pendingEmail,  File? pendingPhoto,  bool homeAddressTouched,  String? pendingHomeAddressLabel,  double? pendingHomeAddressLatitude,  double? pendingHomeAddressLongitude)?  $default,) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.loadStatus,_that.saveStatus,_that.deleteAccountStatus,_that.currentUser,_that.pendingName,_that.pendingEmail,_that.pendingPhoto,_that.homeAddressTouched,_that.pendingHomeAddressLabel,_that.pendingHomeAddressLatitude,_that.pendingHomeAddressLongitude);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileState implements ProfileState {
  const _ProfileState({this.loadStatus = const BlocStatus<ProfileEntity>.initial(), this.saveStatus = const BlocStatus<ProfileEntity>.initial(), this.deleteAccountStatus = const BlocStatus<void>.initial(), this.currentUser, this.pendingName = '', this.pendingEmail = '', this.pendingPhoto, this.homeAddressTouched = false, this.pendingHomeAddressLabel, this.pendingHomeAddressLatitude, this.pendingHomeAddressLongitude});
  

@override@JsonKey() final  BlocStatus<ProfileEntity> loadStatus;
@override@JsonKey() final  BlocStatus<ProfileEntity> saveStatus;
@override@JsonKey() final  BlocStatus<void> deleteAccountStatus;
@override final  ProfileEntity? currentUser;
@override@JsonKey() final  String pendingName;
@override@JsonKey() final  String pendingEmail;
@override final  File? pendingPhoto;
// Pending home address selection. `homeAddressTouched` distinguishes "not
// changed" (keep current) from "cleared" (all values null → remove).
@override@JsonKey() final  bool homeAddressTouched;
@override final  String? pendingHomeAddressLabel;
@override final  double? pendingHomeAddressLatitude;
@override final  double? pendingHomeAddressLongitude;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileStateCopyWith<_ProfileState> get copyWith => __$ProfileStateCopyWithImpl<_ProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileState&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus)&&(identical(other.deleteAccountStatus, deleteAccountStatus) || other.deleteAccountStatus == deleteAccountStatus)&&(identical(other.currentUser, currentUser) || other.currentUser == currentUser)&&(identical(other.pendingName, pendingName) || other.pendingName == pendingName)&&(identical(other.pendingEmail, pendingEmail) || other.pendingEmail == pendingEmail)&&(identical(other.pendingPhoto, pendingPhoto) || other.pendingPhoto == pendingPhoto)&&(identical(other.homeAddressTouched, homeAddressTouched) || other.homeAddressTouched == homeAddressTouched)&&(identical(other.pendingHomeAddressLabel, pendingHomeAddressLabel) || other.pendingHomeAddressLabel == pendingHomeAddressLabel)&&(identical(other.pendingHomeAddressLatitude, pendingHomeAddressLatitude) || other.pendingHomeAddressLatitude == pendingHomeAddressLatitude)&&(identical(other.pendingHomeAddressLongitude, pendingHomeAddressLongitude) || other.pendingHomeAddressLongitude == pendingHomeAddressLongitude));
}


@override
int get hashCode => Object.hash(runtimeType,loadStatus,saveStatus,deleteAccountStatus,currentUser,pendingName,pendingEmail,pendingPhoto,homeAddressTouched,pendingHomeAddressLabel,pendingHomeAddressLatitude,pendingHomeAddressLongitude);

@override
String toString() {
  return 'ProfileState(loadStatus: $loadStatus, saveStatus: $saveStatus, deleteAccountStatus: $deleteAccountStatus, currentUser: $currentUser, pendingName: $pendingName, pendingEmail: $pendingEmail, pendingPhoto: $pendingPhoto, homeAddressTouched: $homeAddressTouched, pendingHomeAddressLabel: $pendingHomeAddressLabel, pendingHomeAddressLatitude: $pendingHomeAddressLatitude, pendingHomeAddressLongitude: $pendingHomeAddressLongitude)';
}


}

/// @nodoc
abstract mixin class _$ProfileStateCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory _$ProfileStateCopyWith(_ProfileState value, $Res Function(_ProfileState) _then) = __$ProfileStateCopyWithImpl;
@override @useResult
$Res call({
 BlocStatus<ProfileEntity> loadStatus, BlocStatus<ProfileEntity> saveStatus, BlocStatus<void> deleteAccountStatus, ProfileEntity? currentUser, String pendingName, String pendingEmail, File? pendingPhoto, bool homeAddressTouched, String? pendingHomeAddressLabel, double? pendingHomeAddressLatitude, double? pendingHomeAddressLongitude
});


@override $BlocStatusCopyWith<ProfileEntity, $Res> get loadStatus;@override $BlocStatusCopyWith<ProfileEntity, $Res> get saveStatus;@override $BlocStatusCopyWith<void, $Res> get deleteAccountStatus;@override $ProfileEntityCopyWith<$Res>? get currentUser;

}
/// @nodoc
class __$ProfileStateCopyWithImpl<$Res>
    implements _$ProfileStateCopyWith<$Res> {
  __$ProfileStateCopyWithImpl(this._self, this._then);

  final _ProfileState _self;
  final $Res Function(_ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loadStatus = null,Object? saveStatus = null,Object? deleteAccountStatus = null,Object? currentUser = freezed,Object? pendingName = null,Object? pendingEmail = null,Object? pendingPhoto = freezed,Object? homeAddressTouched = null,Object? pendingHomeAddressLabel = freezed,Object? pendingHomeAddressLatitude = freezed,Object? pendingHomeAddressLongitude = freezed,}) {
  return _then(_ProfileState(
loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<ProfileEntity>,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<ProfileEntity>,deleteAccountStatus: null == deleteAccountStatus ? _self.deleteAccountStatus : deleteAccountStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,currentUser: freezed == currentUser ? _self.currentUser : currentUser // ignore: cast_nullable_to_non_nullable
as ProfileEntity?,pendingName: null == pendingName ? _self.pendingName : pendingName // ignore: cast_nullable_to_non_nullable
as String,pendingEmail: null == pendingEmail ? _self.pendingEmail : pendingEmail // ignore: cast_nullable_to_non_nullable
as String,pendingPhoto: freezed == pendingPhoto ? _self.pendingPhoto : pendingPhoto // ignore: cast_nullable_to_non_nullable
as File?,homeAddressTouched: null == homeAddressTouched ? _self.homeAddressTouched : homeAddressTouched // ignore: cast_nullable_to_non_nullable
as bool,pendingHomeAddressLabel: freezed == pendingHomeAddressLabel ? _self.pendingHomeAddressLabel : pendingHomeAddressLabel // ignore: cast_nullable_to_non_nullable
as String?,pendingHomeAddressLatitude: freezed == pendingHomeAddressLatitude ? _self.pendingHomeAddressLatitude : pendingHomeAddressLatitude // ignore: cast_nullable_to_non_nullable
as double?,pendingHomeAddressLongitude: freezed == pendingHomeAddressLongitude ? _self.pendingHomeAddressLongitude : pendingHomeAddressLongitude // ignore: cast_nullable_to_non_nullable
as double?,
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
$BlocStatusCopyWith<void, $Res> get deleteAccountStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.deleteAccountStatus, (value) {
    return _then(_self.copyWith(deleteAccountStatus: value));
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
