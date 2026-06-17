// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEntity {

 String get id; String? get name; String get phone; String? get profilePhotoUrl; String? get homeAddressLabel; double? get homeAddressLatitude; double? get homeAddressLongitude;
/// Create a copy of ProfileEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileEntityCopyWith<ProfileEntity> get copyWith => _$ProfileEntityCopyWithImpl<ProfileEntity>(this as ProfileEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.profilePhotoUrl, profilePhotoUrl) || other.profilePhotoUrl == profilePhotoUrl)&&(identical(other.homeAddressLabel, homeAddressLabel) || other.homeAddressLabel == homeAddressLabel)&&(identical(other.homeAddressLatitude, homeAddressLatitude) || other.homeAddressLatitude == homeAddressLatitude)&&(identical(other.homeAddressLongitude, homeAddressLongitude) || other.homeAddressLongitude == homeAddressLongitude));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,phone,profilePhotoUrl,homeAddressLabel,homeAddressLatitude,homeAddressLongitude);

@override
String toString() {
  return 'ProfileEntity(id: $id, name: $name, phone: $phone, profilePhotoUrl: $profilePhotoUrl, homeAddressLabel: $homeAddressLabel, homeAddressLatitude: $homeAddressLatitude, homeAddressLongitude: $homeAddressLongitude)';
}


}

/// @nodoc
abstract mixin class $ProfileEntityCopyWith<$Res>  {
  factory $ProfileEntityCopyWith(ProfileEntity value, $Res Function(ProfileEntity) _then) = _$ProfileEntityCopyWithImpl;
@useResult
$Res call({
 String id, String? name, String phone, String? profilePhotoUrl, String? homeAddressLabel, double? homeAddressLatitude, double? homeAddressLongitude
});




}
/// @nodoc
class _$ProfileEntityCopyWithImpl<$Res>
    implements $ProfileEntityCopyWith<$Res> {
  _$ProfileEntityCopyWithImpl(this._self, this._then);

  final ProfileEntity _self;
  final $Res Function(ProfileEntity) _then;

/// Create a copy of ProfileEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? phone = null,Object? profilePhotoUrl = freezed,Object? homeAddressLabel = freezed,Object? homeAddressLatitude = freezed,Object? homeAddressLongitude = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,profilePhotoUrl: freezed == profilePhotoUrl ? _self.profilePhotoUrl : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,homeAddressLabel: freezed == homeAddressLabel ? _self.homeAddressLabel : homeAddressLabel // ignore: cast_nullable_to_non_nullable
as String?,homeAddressLatitude: freezed == homeAddressLatitude ? _self.homeAddressLatitude : homeAddressLatitude // ignore: cast_nullable_to_non_nullable
as double?,homeAddressLongitude: freezed == homeAddressLongitude ? _self.homeAddressLongitude : homeAddressLongitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileEntity].
extension ProfileEntityPatterns on ProfileEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProfileEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? name,  String phone,  String? profilePhotoUrl,  String? homeAddressLabel,  double? homeAddressLatitude,  double? homeAddressLongitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileEntity() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.profilePhotoUrl,_that.homeAddressLabel,_that.homeAddressLatitude,_that.homeAddressLongitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? name,  String phone,  String? profilePhotoUrl,  String? homeAddressLabel,  double? homeAddressLatitude,  double? homeAddressLongitude)  $default,) {final _that = this;
switch (_that) {
case _ProfileEntity():
return $default(_that.id,_that.name,_that.phone,_that.profilePhotoUrl,_that.homeAddressLabel,_that.homeAddressLatitude,_that.homeAddressLongitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? name,  String phone,  String? profilePhotoUrl,  String? homeAddressLabel,  double? homeAddressLatitude,  double? homeAddressLongitude)?  $default,) {final _that = this;
switch (_that) {
case _ProfileEntity() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.profilePhotoUrl,_that.homeAddressLabel,_that.homeAddressLatitude,_that.homeAddressLongitude);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileEntity implements ProfileEntity {
  const _ProfileEntity({required this.id, this.name, required this.phone, this.profilePhotoUrl, this.homeAddressLabel, this.homeAddressLatitude, this.homeAddressLongitude});
  

@override final  String id;
@override final  String? name;
@override final  String phone;
@override final  String? profilePhotoUrl;
@override final  String? homeAddressLabel;
@override final  double? homeAddressLatitude;
@override final  double? homeAddressLongitude;

/// Create a copy of ProfileEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileEntityCopyWith<_ProfileEntity> get copyWith => __$ProfileEntityCopyWithImpl<_ProfileEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.profilePhotoUrl, profilePhotoUrl) || other.profilePhotoUrl == profilePhotoUrl)&&(identical(other.homeAddressLabel, homeAddressLabel) || other.homeAddressLabel == homeAddressLabel)&&(identical(other.homeAddressLatitude, homeAddressLatitude) || other.homeAddressLatitude == homeAddressLatitude)&&(identical(other.homeAddressLongitude, homeAddressLongitude) || other.homeAddressLongitude == homeAddressLongitude));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,phone,profilePhotoUrl,homeAddressLabel,homeAddressLatitude,homeAddressLongitude);

@override
String toString() {
  return 'ProfileEntity(id: $id, name: $name, phone: $phone, profilePhotoUrl: $profilePhotoUrl, homeAddressLabel: $homeAddressLabel, homeAddressLatitude: $homeAddressLatitude, homeAddressLongitude: $homeAddressLongitude)';
}


}

/// @nodoc
abstract mixin class _$ProfileEntityCopyWith<$Res> implements $ProfileEntityCopyWith<$Res> {
  factory _$ProfileEntityCopyWith(_ProfileEntity value, $Res Function(_ProfileEntity) _then) = __$ProfileEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String? name, String phone, String? profilePhotoUrl, String? homeAddressLabel, double? homeAddressLatitude, double? homeAddressLongitude
});




}
/// @nodoc
class __$ProfileEntityCopyWithImpl<$Res>
    implements _$ProfileEntityCopyWith<$Res> {
  __$ProfileEntityCopyWithImpl(this._self, this._then);

  final _ProfileEntity _self;
  final $Res Function(_ProfileEntity) _then;

/// Create a copy of ProfileEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? phone = null,Object? profilePhotoUrl = freezed,Object? homeAddressLabel = freezed,Object? homeAddressLatitude = freezed,Object? homeAddressLongitude = freezed,}) {
  return _then(_ProfileEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,profilePhotoUrl: freezed == profilePhotoUrl ? _self.profilePhotoUrl : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,homeAddressLabel: freezed == homeAddressLabel ? _self.homeAddressLabel : homeAddressLabel // ignore: cast_nullable_to_non_nullable
as String?,homeAddressLatitude: freezed == homeAddressLatitude ? _self.homeAddressLatitude : homeAddressLatitude // ignore: cast_nullable_to_non_nullable
as double?,homeAddressLongitude: freezed == homeAddressLongitude ? _self.homeAddressLongitude : homeAddressLongitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
