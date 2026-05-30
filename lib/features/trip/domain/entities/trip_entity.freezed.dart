// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TripEntity {

 String get id; String get referenceCode; TripStatus get status; double get quotedFare; String get currencyCode; DateTime get createdAtUtc; DateTime? get scheduledAtUtc; List<TripStopEntity> get stops; String? get vehicleTypeName; double? get driverLat; double? get driverLng; DateTime? get etaToPickup; TripCancellationEntity? get cancellation; TripCompensationClaimEntity? get compensationClaim; TripWaitingSessionEntity? get activeWaitingSession; String? get encodedOverviewPolyline; List<TripRouteSegmentEntity> get routeSegments;
/// Create a copy of TripEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripEntityCopyWith<TripEntity> get copyWith => _$TripEntityCopyWithImpl<TripEntity>(this as TripEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.referenceCode, referenceCode) || other.referenceCode == referenceCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.quotedFare, quotedFare) || other.quotedFare == quotedFare)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.scheduledAtUtc, scheduledAtUtc) || other.scheduledAtUtc == scheduledAtUtc)&&const DeepCollectionEquality().equals(other.stops, stops)&&(identical(other.vehicleTypeName, vehicleTypeName) || other.vehicleTypeName == vehicleTypeName)&&(identical(other.driverLat, driverLat) || other.driverLat == driverLat)&&(identical(other.driverLng, driverLng) || other.driverLng == driverLng)&&(identical(other.etaToPickup, etaToPickup) || other.etaToPickup == etaToPickup)&&(identical(other.cancellation, cancellation) || other.cancellation == cancellation)&&(identical(other.compensationClaim, compensationClaim) || other.compensationClaim == compensationClaim)&&(identical(other.activeWaitingSession, activeWaitingSession) || other.activeWaitingSession == activeWaitingSession)&&(identical(other.encodedOverviewPolyline, encodedOverviewPolyline) || other.encodedOverviewPolyline == encodedOverviewPolyline)&&const DeepCollectionEquality().equals(other.routeSegments, routeSegments));
}


@override
int get hashCode => Object.hash(runtimeType,id,referenceCode,status,quotedFare,currencyCode,createdAtUtc,scheduledAtUtc,const DeepCollectionEquality().hash(stops),vehicleTypeName,driverLat,driverLng,etaToPickup,cancellation,compensationClaim,activeWaitingSession,encodedOverviewPolyline,const DeepCollectionEquality().hash(routeSegments));

@override
String toString() {
  return 'TripEntity(id: $id, referenceCode: $referenceCode, status: $status, quotedFare: $quotedFare, currencyCode: $currencyCode, createdAtUtc: $createdAtUtc, scheduledAtUtc: $scheduledAtUtc, stops: $stops, vehicleTypeName: $vehicleTypeName, driverLat: $driverLat, driverLng: $driverLng, etaToPickup: $etaToPickup, cancellation: $cancellation, compensationClaim: $compensationClaim, activeWaitingSession: $activeWaitingSession, encodedOverviewPolyline: $encodedOverviewPolyline, routeSegments: $routeSegments)';
}


}

/// @nodoc
abstract mixin class $TripEntityCopyWith<$Res>  {
  factory $TripEntityCopyWith(TripEntity value, $Res Function(TripEntity) _then) = _$TripEntityCopyWithImpl;
@useResult
$Res call({
 String id, String referenceCode, TripStatus status, double quotedFare, String currencyCode, DateTime createdAtUtc, DateTime? scheduledAtUtc, List<TripStopEntity> stops, String? vehicleTypeName, double? driverLat, double? driverLng, DateTime? etaToPickup, TripCancellationEntity? cancellation, TripCompensationClaimEntity? compensationClaim, TripWaitingSessionEntity? activeWaitingSession, String? encodedOverviewPolyline, List<TripRouteSegmentEntity> routeSegments
});


$TripCancellationEntityCopyWith<$Res>? get cancellation;$TripCompensationClaimEntityCopyWith<$Res>? get compensationClaim;$TripWaitingSessionEntityCopyWith<$Res>? get activeWaitingSession;

}
/// @nodoc
class _$TripEntityCopyWithImpl<$Res>
    implements $TripEntityCopyWith<$Res> {
  _$TripEntityCopyWithImpl(this._self, this._then);

  final TripEntity _self;
  final $Res Function(TripEntity) _then;

/// Create a copy of TripEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? referenceCode = null,Object? status = null,Object? quotedFare = null,Object? currencyCode = null,Object? createdAtUtc = null,Object? scheduledAtUtc = freezed,Object? stops = null,Object? vehicleTypeName = freezed,Object? driverLat = freezed,Object? driverLng = freezed,Object? etaToPickup = freezed,Object? cancellation = freezed,Object? compensationClaim = freezed,Object? activeWaitingSession = freezed,Object? encodedOverviewPolyline = freezed,Object? routeSegments = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referenceCode: null == referenceCode ? _self.referenceCode : referenceCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripStatus,quotedFare: null == quotedFare ? _self.quotedFare : quotedFare // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledAtUtc: freezed == scheduledAtUtc ? _self.scheduledAtUtc : scheduledAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,stops: null == stops ? _self.stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripStopEntity>,vehicleTypeName: freezed == vehicleTypeName ? _self.vehicleTypeName : vehicleTypeName // ignore: cast_nullable_to_non_nullable
as String?,driverLat: freezed == driverLat ? _self.driverLat : driverLat // ignore: cast_nullable_to_non_nullable
as double?,driverLng: freezed == driverLng ? _self.driverLng : driverLng // ignore: cast_nullable_to_non_nullable
as double?,etaToPickup: freezed == etaToPickup ? _self.etaToPickup : etaToPickup // ignore: cast_nullable_to_non_nullable
as DateTime?,cancellation: freezed == cancellation ? _self.cancellation : cancellation // ignore: cast_nullable_to_non_nullable
as TripCancellationEntity?,compensationClaim: freezed == compensationClaim ? _self.compensationClaim : compensationClaim // ignore: cast_nullable_to_non_nullable
as TripCompensationClaimEntity?,activeWaitingSession: freezed == activeWaitingSession ? _self.activeWaitingSession : activeWaitingSession // ignore: cast_nullable_to_non_nullable
as TripWaitingSessionEntity?,encodedOverviewPolyline: freezed == encodedOverviewPolyline ? _self.encodedOverviewPolyline : encodedOverviewPolyline // ignore: cast_nullable_to_non_nullable
as String?,routeSegments: null == routeSegments ? _self.routeSegments : routeSegments // ignore: cast_nullable_to_non_nullable
as List<TripRouteSegmentEntity>,
  ));
}
/// Create a copy of TripEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripCancellationEntityCopyWith<$Res>? get cancellation {
    if (_self.cancellation == null) {
    return null;
  }

  return $TripCancellationEntityCopyWith<$Res>(_self.cancellation!, (value) {
    return _then(_self.copyWith(cancellation: value));
  });
}/// Create a copy of TripEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripCompensationClaimEntityCopyWith<$Res>? get compensationClaim {
    if (_self.compensationClaim == null) {
    return null;
  }

  return $TripCompensationClaimEntityCopyWith<$Res>(_self.compensationClaim!, (value) {
    return _then(_self.copyWith(compensationClaim: value));
  });
}/// Create a copy of TripEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripWaitingSessionEntityCopyWith<$Res>? get activeWaitingSession {
    if (_self.activeWaitingSession == null) {
    return null;
  }

  return $TripWaitingSessionEntityCopyWith<$Res>(_self.activeWaitingSession!, (value) {
    return _then(_self.copyWith(activeWaitingSession: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripEntity].
extension TripEntityPatterns on TripEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripEntity value)  $default,){
final _that = this;
switch (_that) {
case _TripEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TripEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String referenceCode,  TripStatus status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopEntity> stops,  String? vehicleTypeName,  double? driverLat,  double? driverLng,  DateTime? etaToPickup,  TripCancellationEntity? cancellation,  TripCompensationClaimEntity? compensationClaim,  TripWaitingSessionEntity? activeWaitingSession,  String? encodedOverviewPolyline,  List<TripRouteSegmentEntity> routeSegments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripEntity() when $default != null:
return $default(_that.id,_that.referenceCode,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops,_that.vehicleTypeName,_that.driverLat,_that.driverLng,_that.etaToPickup,_that.cancellation,_that.compensationClaim,_that.activeWaitingSession,_that.encodedOverviewPolyline,_that.routeSegments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String referenceCode,  TripStatus status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopEntity> stops,  String? vehicleTypeName,  double? driverLat,  double? driverLng,  DateTime? etaToPickup,  TripCancellationEntity? cancellation,  TripCompensationClaimEntity? compensationClaim,  TripWaitingSessionEntity? activeWaitingSession,  String? encodedOverviewPolyline,  List<TripRouteSegmentEntity> routeSegments)  $default,) {final _that = this;
switch (_that) {
case _TripEntity():
return $default(_that.id,_that.referenceCode,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops,_that.vehicleTypeName,_that.driverLat,_that.driverLng,_that.etaToPickup,_that.cancellation,_that.compensationClaim,_that.activeWaitingSession,_that.encodedOverviewPolyline,_that.routeSegments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String referenceCode,  TripStatus status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopEntity> stops,  String? vehicleTypeName,  double? driverLat,  double? driverLng,  DateTime? etaToPickup,  TripCancellationEntity? cancellation,  TripCompensationClaimEntity? compensationClaim,  TripWaitingSessionEntity? activeWaitingSession,  String? encodedOverviewPolyline,  List<TripRouteSegmentEntity> routeSegments)?  $default,) {final _that = this;
switch (_that) {
case _TripEntity() when $default != null:
return $default(_that.id,_that.referenceCode,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops,_that.vehicleTypeName,_that.driverLat,_that.driverLng,_that.etaToPickup,_that.cancellation,_that.compensationClaim,_that.activeWaitingSession,_that.encodedOverviewPolyline,_that.routeSegments);case _:
  return null;

}
}

}

/// @nodoc


class _TripEntity implements TripEntity {
  const _TripEntity({required this.id, required this.referenceCode, required this.status, required this.quotedFare, required this.currencyCode, required this.createdAtUtc, this.scheduledAtUtc, final  List<TripStopEntity> stops = const [], this.vehicleTypeName, this.driverLat, this.driverLng, this.etaToPickup, this.cancellation, this.compensationClaim, this.activeWaitingSession, this.encodedOverviewPolyline, final  List<TripRouteSegmentEntity> routeSegments = const []}): _stops = stops,_routeSegments = routeSegments;
  

@override final  String id;
@override final  String referenceCode;
@override final  TripStatus status;
@override final  double quotedFare;
@override final  String currencyCode;
@override final  DateTime createdAtUtc;
@override final  DateTime? scheduledAtUtc;
 final  List<TripStopEntity> _stops;
@override@JsonKey() List<TripStopEntity> get stops {
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stops);
}

@override final  String? vehicleTypeName;
@override final  double? driverLat;
@override final  double? driverLng;
@override final  DateTime? etaToPickup;
@override final  TripCancellationEntity? cancellation;
@override final  TripCompensationClaimEntity? compensationClaim;
@override final  TripWaitingSessionEntity? activeWaitingSession;
@override final  String? encodedOverviewPolyline;
 final  List<TripRouteSegmentEntity> _routeSegments;
@override@JsonKey() List<TripRouteSegmentEntity> get routeSegments {
  if (_routeSegments is EqualUnmodifiableListView) return _routeSegments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_routeSegments);
}


/// Create a copy of TripEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripEntityCopyWith<_TripEntity> get copyWith => __$TripEntityCopyWithImpl<_TripEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.referenceCode, referenceCode) || other.referenceCode == referenceCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.quotedFare, quotedFare) || other.quotedFare == quotedFare)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.scheduledAtUtc, scheduledAtUtc) || other.scheduledAtUtc == scheduledAtUtc)&&const DeepCollectionEquality().equals(other._stops, _stops)&&(identical(other.vehicleTypeName, vehicleTypeName) || other.vehicleTypeName == vehicleTypeName)&&(identical(other.driverLat, driverLat) || other.driverLat == driverLat)&&(identical(other.driverLng, driverLng) || other.driverLng == driverLng)&&(identical(other.etaToPickup, etaToPickup) || other.etaToPickup == etaToPickup)&&(identical(other.cancellation, cancellation) || other.cancellation == cancellation)&&(identical(other.compensationClaim, compensationClaim) || other.compensationClaim == compensationClaim)&&(identical(other.activeWaitingSession, activeWaitingSession) || other.activeWaitingSession == activeWaitingSession)&&(identical(other.encodedOverviewPolyline, encodedOverviewPolyline) || other.encodedOverviewPolyline == encodedOverviewPolyline)&&const DeepCollectionEquality().equals(other._routeSegments, _routeSegments));
}


@override
int get hashCode => Object.hash(runtimeType,id,referenceCode,status,quotedFare,currencyCode,createdAtUtc,scheduledAtUtc,const DeepCollectionEquality().hash(_stops),vehicleTypeName,driverLat,driverLng,etaToPickup,cancellation,compensationClaim,activeWaitingSession,encodedOverviewPolyline,const DeepCollectionEquality().hash(_routeSegments));

@override
String toString() {
  return 'TripEntity(id: $id, referenceCode: $referenceCode, status: $status, quotedFare: $quotedFare, currencyCode: $currencyCode, createdAtUtc: $createdAtUtc, scheduledAtUtc: $scheduledAtUtc, stops: $stops, vehicleTypeName: $vehicleTypeName, driverLat: $driverLat, driverLng: $driverLng, etaToPickup: $etaToPickup, cancellation: $cancellation, compensationClaim: $compensationClaim, activeWaitingSession: $activeWaitingSession, encodedOverviewPolyline: $encodedOverviewPolyline, routeSegments: $routeSegments)';
}


}

/// @nodoc
abstract mixin class _$TripEntityCopyWith<$Res> implements $TripEntityCopyWith<$Res> {
  factory _$TripEntityCopyWith(_TripEntity value, $Res Function(_TripEntity) _then) = __$TripEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String referenceCode, TripStatus status, double quotedFare, String currencyCode, DateTime createdAtUtc, DateTime? scheduledAtUtc, List<TripStopEntity> stops, String? vehicleTypeName, double? driverLat, double? driverLng, DateTime? etaToPickup, TripCancellationEntity? cancellation, TripCompensationClaimEntity? compensationClaim, TripWaitingSessionEntity? activeWaitingSession, String? encodedOverviewPolyline, List<TripRouteSegmentEntity> routeSegments
});


@override $TripCancellationEntityCopyWith<$Res>? get cancellation;@override $TripCompensationClaimEntityCopyWith<$Res>? get compensationClaim;@override $TripWaitingSessionEntityCopyWith<$Res>? get activeWaitingSession;

}
/// @nodoc
class __$TripEntityCopyWithImpl<$Res>
    implements _$TripEntityCopyWith<$Res> {
  __$TripEntityCopyWithImpl(this._self, this._then);

  final _TripEntity _self;
  final $Res Function(_TripEntity) _then;

/// Create a copy of TripEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? referenceCode = null,Object? status = null,Object? quotedFare = null,Object? currencyCode = null,Object? createdAtUtc = null,Object? scheduledAtUtc = freezed,Object? stops = null,Object? vehicleTypeName = freezed,Object? driverLat = freezed,Object? driverLng = freezed,Object? etaToPickup = freezed,Object? cancellation = freezed,Object? compensationClaim = freezed,Object? activeWaitingSession = freezed,Object? encodedOverviewPolyline = freezed,Object? routeSegments = null,}) {
  return _then(_TripEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referenceCode: null == referenceCode ? _self.referenceCode : referenceCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripStatus,quotedFare: null == quotedFare ? _self.quotedFare : quotedFare // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledAtUtc: freezed == scheduledAtUtc ? _self.scheduledAtUtc : scheduledAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,stops: null == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripStopEntity>,vehicleTypeName: freezed == vehicleTypeName ? _self.vehicleTypeName : vehicleTypeName // ignore: cast_nullable_to_non_nullable
as String?,driverLat: freezed == driverLat ? _self.driverLat : driverLat // ignore: cast_nullable_to_non_nullable
as double?,driverLng: freezed == driverLng ? _self.driverLng : driverLng // ignore: cast_nullable_to_non_nullable
as double?,etaToPickup: freezed == etaToPickup ? _self.etaToPickup : etaToPickup // ignore: cast_nullable_to_non_nullable
as DateTime?,cancellation: freezed == cancellation ? _self.cancellation : cancellation // ignore: cast_nullable_to_non_nullable
as TripCancellationEntity?,compensationClaim: freezed == compensationClaim ? _self.compensationClaim : compensationClaim // ignore: cast_nullable_to_non_nullable
as TripCompensationClaimEntity?,activeWaitingSession: freezed == activeWaitingSession ? _self.activeWaitingSession : activeWaitingSession // ignore: cast_nullable_to_non_nullable
as TripWaitingSessionEntity?,encodedOverviewPolyline: freezed == encodedOverviewPolyline ? _self.encodedOverviewPolyline : encodedOverviewPolyline // ignore: cast_nullable_to_non_nullable
as String?,routeSegments: null == routeSegments ? _self._routeSegments : routeSegments // ignore: cast_nullable_to_non_nullable
as List<TripRouteSegmentEntity>,
  ));
}

/// Create a copy of TripEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripCancellationEntityCopyWith<$Res>? get cancellation {
    if (_self.cancellation == null) {
    return null;
  }

  return $TripCancellationEntityCopyWith<$Res>(_self.cancellation!, (value) {
    return _then(_self.copyWith(cancellation: value));
  });
}/// Create a copy of TripEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripCompensationClaimEntityCopyWith<$Res>? get compensationClaim {
    if (_self.compensationClaim == null) {
    return null;
  }

  return $TripCompensationClaimEntityCopyWith<$Res>(_self.compensationClaim!, (value) {
    return _then(_self.copyWith(compensationClaim: value));
  });
}/// Create a copy of TripEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripWaitingSessionEntityCopyWith<$Res>? get activeWaitingSession {
    if (_self.activeWaitingSession == null) {
    return null;
  }

  return $TripWaitingSessionEntityCopyWith<$Res>(_self.activeWaitingSession!, (value) {
    return _then(_self.copyWith(activeWaitingSession: value));
  });
}
}

/// @nodoc
mixin _$TripStopEntity {

 double get latitude; double get longitude;
/// Create a copy of TripStopEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripStopEntityCopyWith<TripStopEntity> get copyWith => _$TripStopEntityCopyWithImpl<TripStopEntity>(this as TripStopEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripStopEntity&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'TripStopEntity(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $TripStopEntityCopyWith<$Res>  {
  factory $TripStopEntityCopyWith(TripStopEntity value, $Res Function(TripStopEntity) _then) = _$TripStopEntityCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude
});




}
/// @nodoc
class _$TripStopEntityCopyWithImpl<$Res>
    implements $TripStopEntityCopyWith<$Res> {
  _$TripStopEntityCopyWithImpl(this._self, this._then);

  final TripStopEntity _self;
  final $Res Function(TripStopEntity) _then;

/// Create a copy of TripStopEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TripStopEntity].
extension TripStopEntityPatterns on TripStopEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripStopEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripStopEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripStopEntity value)  $default,){
final _that = this;
switch (_that) {
case _TripStopEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripStopEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TripStopEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripStopEntity() when $default != null:
return $default(_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude)  $default,) {final _that = this;
switch (_that) {
case _TripStopEntity():
return $default(_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude)?  $default,) {final _that = this;
switch (_that) {
case _TripStopEntity() when $default != null:
return $default(_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc


class _TripStopEntity implements TripStopEntity {
  const _TripStopEntity({required this.latitude, required this.longitude});
  

@override final  double latitude;
@override final  double longitude;

/// Create a copy of TripStopEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripStopEntityCopyWith<_TripStopEntity> get copyWith => __$TripStopEntityCopyWithImpl<_TripStopEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripStopEntity&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'TripStopEntity(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$TripStopEntityCopyWith<$Res> implements $TripStopEntityCopyWith<$Res> {
  factory _$TripStopEntityCopyWith(_TripStopEntity value, $Res Function(_TripStopEntity) _then) = __$TripStopEntityCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude
});




}
/// @nodoc
class __$TripStopEntityCopyWithImpl<$Res>
    implements _$TripStopEntityCopyWith<$Res> {
  __$TripStopEntityCopyWithImpl(this._self, this._then);

  final _TripStopEntity _self;
  final $Res Function(_TripStopEntity) _then;

/// Create a copy of TripStopEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_TripStopEntity(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$TripRouteSegmentEntity {

 int get distanceMeters; int get durationSeconds; String get encodedPolyline; double get startLatitude; double get startLongitude; double get endLatitude; double get endLongitude;
/// Create a copy of TripRouteSegmentEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripRouteSegmentEntityCopyWith<TripRouteSegmentEntity> get copyWith => _$TripRouteSegmentEntityCopyWithImpl<TripRouteSegmentEntity>(this as TripRouteSegmentEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripRouteSegmentEntity&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.encodedPolyline, encodedPolyline) || other.encodedPolyline == encodedPolyline)&&(identical(other.startLatitude, startLatitude) || other.startLatitude == startLatitude)&&(identical(other.startLongitude, startLongitude) || other.startLongitude == startLongitude)&&(identical(other.endLatitude, endLatitude) || other.endLatitude == endLatitude)&&(identical(other.endLongitude, endLongitude) || other.endLongitude == endLongitude));
}


@override
int get hashCode => Object.hash(runtimeType,distanceMeters,durationSeconds,encodedPolyline,startLatitude,startLongitude,endLatitude,endLongitude);

@override
String toString() {
  return 'TripRouteSegmentEntity(distanceMeters: $distanceMeters, durationSeconds: $durationSeconds, encodedPolyline: $encodedPolyline, startLatitude: $startLatitude, startLongitude: $startLongitude, endLatitude: $endLatitude, endLongitude: $endLongitude)';
}


}

/// @nodoc
abstract mixin class $TripRouteSegmentEntityCopyWith<$Res>  {
  factory $TripRouteSegmentEntityCopyWith(TripRouteSegmentEntity value, $Res Function(TripRouteSegmentEntity) _then) = _$TripRouteSegmentEntityCopyWithImpl;
@useResult
$Res call({
 int distanceMeters, int durationSeconds, String encodedPolyline, double startLatitude, double startLongitude, double endLatitude, double endLongitude
});




}
/// @nodoc
class _$TripRouteSegmentEntityCopyWithImpl<$Res>
    implements $TripRouteSegmentEntityCopyWith<$Res> {
  _$TripRouteSegmentEntityCopyWithImpl(this._self, this._then);

  final TripRouteSegmentEntity _self;
  final $Res Function(TripRouteSegmentEntity) _then;

/// Create a copy of TripRouteSegmentEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? distanceMeters = null,Object? durationSeconds = null,Object? encodedPolyline = null,Object? startLatitude = null,Object? startLongitude = null,Object? endLatitude = null,Object? endLongitude = null,}) {
  return _then(_self.copyWith(
distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,encodedPolyline: null == encodedPolyline ? _self.encodedPolyline : encodedPolyline // ignore: cast_nullable_to_non_nullable
as String,startLatitude: null == startLatitude ? _self.startLatitude : startLatitude // ignore: cast_nullable_to_non_nullable
as double,startLongitude: null == startLongitude ? _self.startLongitude : startLongitude // ignore: cast_nullable_to_non_nullable
as double,endLatitude: null == endLatitude ? _self.endLatitude : endLatitude // ignore: cast_nullable_to_non_nullable
as double,endLongitude: null == endLongitude ? _self.endLongitude : endLongitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TripRouteSegmentEntity].
extension TripRouteSegmentEntityPatterns on TripRouteSegmentEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripRouteSegmentEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripRouteSegmentEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripRouteSegmentEntity value)  $default,){
final _that = this;
switch (_that) {
case _TripRouteSegmentEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripRouteSegmentEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TripRouteSegmentEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int distanceMeters,  int durationSeconds,  String encodedPolyline,  double startLatitude,  double startLongitude,  double endLatitude,  double endLongitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripRouteSegmentEntity() when $default != null:
return $default(_that.distanceMeters,_that.durationSeconds,_that.encodedPolyline,_that.startLatitude,_that.startLongitude,_that.endLatitude,_that.endLongitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int distanceMeters,  int durationSeconds,  String encodedPolyline,  double startLatitude,  double startLongitude,  double endLatitude,  double endLongitude)  $default,) {final _that = this;
switch (_that) {
case _TripRouteSegmentEntity():
return $default(_that.distanceMeters,_that.durationSeconds,_that.encodedPolyline,_that.startLatitude,_that.startLongitude,_that.endLatitude,_that.endLongitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int distanceMeters,  int durationSeconds,  String encodedPolyline,  double startLatitude,  double startLongitude,  double endLatitude,  double endLongitude)?  $default,) {final _that = this;
switch (_that) {
case _TripRouteSegmentEntity() when $default != null:
return $default(_that.distanceMeters,_that.durationSeconds,_that.encodedPolyline,_that.startLatitude,_that.startLongitude,_that.endLatitude,_that.endLongitude);case _:
  return null;

}
}

}

/// @nodoc


class _TripRouteSegmentEntity implements TripRouteSegmentEntity {
  const _TripRouteSegmentEntity({required this.distanceMeters, required this.durationSeconds, required this.encodedPolyline, required this.startLatitude, required this.startLongitude, required this.endLatitude, required this.endLongitude});
  

@override final  int distanceMeters;
@override final  int durationSeconds;
@override final  String encodedPolyline;
@override final  double startLatitude;
@override final  double startLongitude;
@override final  double endLatitude;
@override final  double endLongitude;

/// Create a copy of TripRouteSegmentEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripRouteSegmentEntityCopyWith<_TripRouteSegmentEntity> get copyWith => __$TripRouteSegmentEntityCopyWithImpl<_TripRouteSegmentEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripRouteSegmentEntity&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.encodedPolyline, encodedPolyline) || other.encodedPolyline == encodedPolyline)&&(identical(other.startLatitude, startLatitude) || other.startLatitude == startLatitude)&&(identical(other.startLongitude, startLongitude) || other.startLongitude == startLongitude)&&(identical(other.endLatitude, endLatitude) || other.endLatitude == endLatitude)&&(identical(other.endLongitude, endLongitude) || other.endLongitude == endLongitude));
}


@override
int get hashCode => Object.hash(runtimeType,distanceMeters,durationSeconds,encodedPolyline,startLatitude,startLongitude,endLatitude,endLongitude);

@override
String toString() {
  return 'TripRouteSegmentEntity(distanceMeters: $distanceMeters, durationSeconds: $durationSeconds, encodedPolyline: $encodedPolyline, startLatitude: $startLatitude, startLongitude: $startLongitude, endLatitude: $endLatitude, endLongitude: $endLongitude)';
}


}

/// @nodoc
abstract mixin class _$TripRouteSegmentEntityCopyWith<$Res> implements $TripRouteSegmentEntityCopyWith<$Res> {
  factory _$TripRouteSegmentEntityCopyWith(_TripRouteSegmentEntity value, $Res Function(_TripRouteSegmentEntity) _then) = __$TripRouteSegmentEntityCopyWithImpl;
@override @useResult
$Res call({
 int distanceMeters, int durationSeconds, String encodedPolyline, double startLatitude, double startLongitude, double endLatitude, double endLongitude
});




}
/// @nodoc
class __$TripRouteSegmentEntityCopyWithImpl<$Res>
    implements _$TripRouteSegmentEntityCopyWith<$Res> {
  __$TripRouteSegmentEntityCopyWithImpl(this._self, this._then);

  final _TripRouteSegmentEntity _self;
  final $Res Function(_TripRouteSegmentEntity) _then;

/// Create a copy of TripRouteSegmentEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? distanceMeters = null,Object? durationSeconds = null,Object? encodedPolyline = null,Object? startLatitude = null,Object? startLongitude = null,Object? endLatitude = null,Object? endLongitude = null,}) {
  return _then(_TripRouteSegmentEntity(
distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,encodedPolyline: null == encodedPolyline ? _self.encodedPolyline : encodedPolyline // ignore: cast_nullable_to_non_nullable
as String,startLatitude: null == startLatitude ? _self.startLatitude : startLatitude // ignore: cast_nullable_to_non_nullable
as double,startLongitude: null == startLongitude ? _self.startLongitude : startLongitude // ignore: cast_nullable_to_non_nullable
as double,endLatitude: null == endLatitude ? _self.endLatitude : endLatitude // ignore: cast_nullable_to_non_nullable
as double,endLongitude: null == endLongitude ? _self.endLongitude : endLongitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$TripCancellationEntity {

 String get actor; String get reason; double get refundPercent; double get refundAmount; String get currencyCode; String? get note; DateTime? get createdAtUtc;
/// Create a copy of TripCancellationEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripCancellationEntityCopyWith<TripCancellationEntity> get copyWith => _$TripCancellationEntityCopyWithImpl<TripCancellationEntity>(this as TripCancellationEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripCancellationEntity&&(identical(other.actor, actor) || other.actor == actor)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.refundPercent, refundPercent) || other.refundPercent == refundPercent)&&(identical(other.refundAmount, refundAmount) || other.refundAmount == refundAmount)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc));
}


@override
int get hashCode => Object.hash(runtimeType,actor,reason,refundPercent,refundAmount,currencyCode,note,createdAtUtc);

@override
String toString() {
  return 'TripCancellationEntity(actor: $actor, reason: $reason, refundPercent: $refundPercent, refundAmount: $refundAmount, currencyCode: $currencyCode, note: $note, createdAtUtc: $createdAtUtc)';
}


}

/// @nodoc
abstract mixin class $TripCancellationEntityCopyWith<$Res>  {
  factory $TripCancellationEntityCopyWith(TripCancellationEntity value, $Res Function(TripCancellationEntity) _then) = _$TripCancellationEntityCopyWithImpl;
@useResult
$Res call({
 String actor, String reason, double refundPercent, double refundAmount, String currencyCode, String? note, DateTime? createdAtUtc
});




}
/// @nodoc
class _$TripCancellationEntityCopyWithImpl<$Res>
    implements $TripCancellationEntityCopyWith<$Res> {
  _$TripCancellationEntityCopyWithImpl(this._self, this._then);

  final TripCancellationEntity _self;
  final $Res Function(TripCancellationEntity) _then;

/// Create a copy of TripCancellationEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? actor = null,Object? reason = null,Object? refundPercent = null,Object? refundAmount = null,Object? currencyCode = null,Object? note = freezed,Object? createdAtUtc = freezed,}) {
  return _then(_self.copyWith(
actor: null == actor ? _self.actor : actor // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,refundPercent: null == refundPercent ? _self.refundPercent : refundPercent // ignore: cast_nullable_to_non_nullable
as double,refundAmount: null == refundAmount ? _self.refundAmount : refundAmount // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdAtUtc: freezed == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripCancellationEntity].
extension TripCancellationEntityPatterns on TripCancellationEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripCancellationEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripCancellationEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripCancellationEntity value)  $default,){
final _that = this;
switch (_that) {
case _TripCancellationEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripCancellationEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TripCancellationEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String actor,  String reason,  double refundPercent,  double refundAmount,  String currencyCode,  String? note,  DateTime? createdAtUtc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripCancellationEntity() when $default != null:
return $default(_that.actor,_that.reason,_that.refundPercent,_that.refundAmount,_that.currencyCode,_that.note,_that.createdAtUtc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String actor,  String reason,  double refundPercent,  double refundAmount,  String currencyCode,  String? note,  DateTime? createdAtUtc)  $default,) {final _that = this;
switch (_that) {
case _TripCancellationEntity():
return $default(_that.actor,_that.reason,_that.refundPercent,_that.refundAmount,_that.currencyCode,_that.note,_that.createdAtUtc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String actor,  String reason,  double refundPercent,  double refundAmount,  String currencyCode,  String? note,  DateTime? createdAtUtc)?  $default,) {final _that = this;
switch (_that) {
case _TripCancellationEntity() when $default != null:
return $default(_that.actor,_that.reason,_that.refundPercent,_that.refundAmount,_that.currencyCode,_that.note,_that.createdAtUtc);case _:
  return null;

}
}

}

/// @nodoc


class _TripCancellationEntity implements TripCancellationEntity {
  const _TripCancellationEntity({required this.actor, required this.reason, required this.refundPercent, required this.refundAmount, required this.currencyCode, this.note, this.createdAtUtc});
  

@override final  String actor;
@override final  String reason;
@override final  double refundPercent;
@override final  double refundAmount;
@override final  String currencyCode;
@override final  String? note;
@override final  DateTime? createdAtUtc;

/// Create a copy of TripCancellationEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripCancellationEntityCopyWith<_TripCancellationEntity> get copyWith => __$TripCancellationEntityCopyWithImpl<_TripCancellationEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripCancellationEntity&&(identical(other.actor, actor) || other.actor == actor)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.refundPercent, refundPercent) || other.refundPercent == refundPercent)&&(identical(other.refundAmount, refundAmount) || other.refundAmount == refundAmount)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc));
}


@override
int get hashCode => Object.hash(runtimeType,actor,reason,refundPercent,refundAmount,currencyCode,note,createdAtUtc);

@override
String toString() {
  return 'TripCancellationEntity(actor: $actor, reason: $reason, refundPercent: $refundPercent, refundAmount: $refundAmount, currencyCode: $currencyCode, note: $note, createdAtUtc: $createdAtUtc)';
}


}

/// @nodoc
abstract mixin class _$TripCancellationEntityCopyWith<$Res> implements $TripCancellationEntityCopyWith<$Res> {
  factory _$TripCancellationEntityCopyWith(_TripCancellationEntity value, $Res Function(_TripCancellationEntity) _then) = __$TripCancellationEntityCopyWithImpl;
@override @useResult
$Res call({
 String actor, String reason, double refundPercent, double refundAmount, String currencyCode, String? note, DateTime? createdAtUtc
});




}
/// @nodoc
class __$TripCancellationEntityCopyWithImpl<$Res>
    implements _$TripCancellationEntityCopyWith<$Res> {
  __$TripCancellationEntityCopyWithImpl(this._self, this._then);

  final _TripCancellationEntity _self;
  final $Res Function(_TripCancellationEntity) _then;

/// Create a copy of TripCancellationEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? actor = null,Object? reason = null,Object? refundPercent = null,Object? refundAmount = null,Object? currencyCode = null,Object? note = freezed,Object? createdAtUtc = freezed,}) {
  return _then(_TripCancellationEntity(
actor: null == actor ? _self.actor : actor // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,refundPercent: null == refundPercent ? _self.refundPercent : refundPercent // ignore: cast_nullable_to_non_nullable
as double,refundAmount: null == refundAmount ? _self.refundAmount : refundAmount // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdAtUtc: freezed == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$TripCompensationClaimEntity {

 String get id; String get tripId; String get passengerId; String get note; List<String> get evidenceUrls; double get requestedAmount; String get currencyCode; String get status; String? get reviewNotes; DateTime? get createdAtUtc; DateTime? get reviewedAtUtc;
/// Create a copy of TripCompensationClaimEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripCompensationClaimEntityCopyWith<TripCompensationClaimEntity> get copyWith => _$TripCompensationClaimEntityCopyWithImpl<TripCompensationClaimEntity>(this as TripCompensationClaimEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripCompensationClaimEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other.evidenceUrls, evidenceUrls)&&(identical(other.requestedAmount, requestedAmount) || other.requestedAmount == requestedAmount)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.reviewNotes, reviewNotes) || other.reviewNotes == reviewNotes)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.reviewedAtUtc, reviewedAtUtc) || other.reviewedAtUtc == reviewedAtUtc));
}


@override
int get hashCode => Object.hash(runtimeType,id,tripId,passengerId,note,const DeepCollectionEquality().hash(evidenceUrls),requestedAmount,currencyCode,status,reviewNotes,createdAtUtc,reviewedAtUtc);

@override
String toString() {
  return 'TripCompensationClaimEntity(id: $id, tripId: $tripId, passengerId: $passengerId, note: $note, evidenceUrls: $evidenceUrls, requestedAmount: $requestedAmount, currencyCode: $currencyCode, status: $status, reviewNotes: $reviewNotes, createdAtUtc: $createdAtUtc, reviewedAtUtc: $reviewedAtUtc)';
}


}

/// @nodoc
abstract mixin class $TripCompensationClaimEntityCopyWith<$Res>  {
  factory $TripCompensationClaimEntityCopyWith(TripCompensationClaimEntity value, $Res Function(TripCompensationClaimEntity) _then) = _$TripCompensationClaimEntityCopyWithImpl;
@useResult
$Res call({
 String id, String tripId, String passengerId, String note, List<String> evidenceUrls, double requestedAmount, String currencyCode, String status, String? reviewNotes, DateTime? createdAtUtc, DateTime? reviewedAtUtc
});




}
/// @nodoc
class _$TripCompensationClaimEntityCopyWithImpl<$Res>
    implements $TripCompensationClaimEntityCopyWith<$Res> {
  _$TripCompensationClaimEntityCopyWithImpl(this._self, this._then);

  final TripCompensationClaimEntity _self;
  final $Res Function(TripCompensationClaimEntity) _then;

/// Create a copy of TripCompensationClaimEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tripId = null,Object? passengerId = null,Object? note = null,Object? evidenceUrls = null,Object? requestedAmount = null,Object? currencyCode = null,Object? status = null,Object? reviewNotes = freezed,Object? createdAtUtc = freezed,Object? reviewedAtUtc = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,passengerId: null == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,evidenceUrls: null == evidenceUrls ? _self.evidenceUrls : evidenceUrls // ignore: cast_nullable_to_non_nullable
as List<String>,requestedAmount: null == requestedAmount ? _self.requestedAmount : requestedAmount // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,reviewNotes: freezed == reviewNotes ? _self.reviewNotes : reviewNotes // ignore: cast_nullable_to_non_nullable
as String?,createdAtUtc: freezed == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedAtUtc: freezed == reviewedAtUtc ? _self.reviewedAtUtc : reviewedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripCompensationClaimEntity].
extension TripCompensationClaimEntityPatterns on TripCompensationClaimEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripCompensationClaimEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripCompensationClaimEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripCompensationClaimEntity value)  $default,){
final _that = this;
switch (_that) {
case _TripCompensationClaimEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripCompensationClaimEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TripCompensationClaimEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tripId,  String passengerId,  String note,  List<String> evidenceUrls,  double requestedAmount,  String currencyCode,  String status,  String? reviewNotes,  DateTime? createdAtUtc,  DateTime? reviewedAtUtc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripCompensationClaimEntity() when $default != null:
return $default(_that.id,_that.tripId,_that.passengerId,_that.note,_that.evidenceUrls,_that.requestedAmount,_that.currencyCode,_that.status,_that.reviewNotes,_that.createdAtUtc,_that.reviewedAtUtc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tripId,  String passengerId,  String note,  List<String> evidenceUrls,  double requestedAmount,  String currencyCode,  String status,  String? reviewNotes,  DateTime? createdAtUtc,  DateTime? reviewedAtUtc)  $default,) {final _that = this;
switch (_that) {
case _TripCompensationClaimEntity():
return $default(_that.id,_that.tripId,_that.passengerId,_that.note,_that.evidenceUrls,_that.requestedAmount,_that.currencyCode,_that.status,_that.reviewNotes,_that.createdAtUtc,_that.reviewedAtUtc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tripId,  String passengerId,  String note,  List<String> evidenceUrls,  double requestedAmount,  String currencyCode,  String status,  String? reviewNotes,  DateTime? createdAtUtc,  DateTime? reviewedAtUtc)?  $default,) {final _that = this;
switch (_that) {
case _TripCompensationClaimEntity() when $default != null:
return $default(_that.id,_that.tripId,_that.passengerId,_that.note,_that.evidenceUrls,_that.requestedAmount,_that.currencyCode,_that.status,_that.reviewNotes,_that.createdAtUtc,_that.reviewedAtUtc);case _:
  return null;

}
}

}

/// @nodoc


class _TripCompensationClaimEntity implements TripCompensationClaimEntity {
  const _TripCompensationClaimEntity({required this.id, required this.tripId, required this.passengerId, required this.note, final  List<String> evidenceUrls = const [], required this.requestedAmount, required this.currencyCode, required this.status, this.reviewNotes, this.createdAtUtc, this.reviewedAtUtc}): _evidenceUrls = evidenceUrls;
  

@override final  String id;
@override final  String tripId;
@override final  String passengerId;
@override final  String note;
 final  List<String> _evidenceUrls;
@override@JsonKey() List<String> get evidenceUrls {
  if (_evidenceUrls is EqualUnmodifiableListView) return _evidenceUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_evidenceUrls);
}

@override final  double requestedAmount;
@override final  String currencyCode;
@override final  String status;
@override final  String? reviewNotes;
@override final  DateTime? createdAtUtc;
@override final  DateTime? reviewedAtUtc;

/// Create a copy of TripCompensationClaimEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripCompensationClaimEntityCopyWith<_TripCompensationClaimEntity> get copyWith => __$TripCompensationClaimEntityCopyWithImpl<_TripCompensationClaimEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripCompensationClaimEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other._evidenceUrls, _evidenceUrls)&&(identical(other.requestedAmount, requestedAmount) || other.requestedAmount == requestedAmount)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.reviewNotes, reviewNotes) || other.reviewNotes == reviewNotes)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.reviewedAtUtc, reviewedAtUtc) || other.reviewedAtUtc == reviewedAtUtc));
}


@override
int get hashCode => Object.hash(runtimeType,id,tripId,passengerId,note,const DeepCollectionEquality().hash(_evidenceUrls),requestedAmount,currencyCode,status,reviewNotes,createdAtUtc,reviewedAtUtc);

@override
String toString() {
  return 'TripCompensationClaimEntity(id: $id, tripId: $tripId, passengerId: $passengerId, note: $note, evidenceUrls: $evidenceUrls, requestedAmount: $requestedAmount, currencyCode: $currencyCode, status: $status, reviewNotes: $reviewNotes, createdAtUtc: $createdAtUtc, reviewedAtUtc: $reviewedAtUtc)';
}


}

/// @nodoc
abstract mixin class _$TripCompensationClaimEntityCopyWith<$Res> implements $TripCompensationClaimEntityCopyWith<$Res> {
  factory _$TripCompensationClaimEntityCopyWith(_TripCompensationClaimEntity value, $Res Function(_TripCompensationClaimEntity) _then) = __$TripCompensationClaimEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String tripId, String passengerId, String note, List<String> evidenceUrls, double requestedAmount, String currencyCode, String status, String? reviewNotes, DateTime? createdAtUtc, DateTime? reviewedAtUtc
});




}
/// @nodoc
class __$TripCompensationClaimEntityCopyWithImpl<$Res>
    implements _$TripCompensationClaimEntityCopyWith<$Res> {
  __$TripCompensationClaimEntityCopyWithImpl(this._self, this._then);

  final _TripCompensationClaimEntity _self;
  final $Res Function(_TripCompensationClaimEntity) _then;

/// Create a copy of TripCompensationClaimEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tripId = null,Object? passengerId = null,Object? note = null,Object? evidenceUrls = null,Object? requestedAmount = null,Object? currencyCode = null,Object? status = null,Object? reviewNotes = freezed,Object? createdAtUtc = freezed,Object? reviewedAtUtc = freezed,}) {
  return _then(_TripCompensationClaimEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,passengerId: null == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,evidenceUrls: null == evidenceUrls ? _self._evidenceUrls : evidenceUrls // ignore: cast_nullable_to_non_nullable
as List<String>,requestedAmount: null == requestedAmount ? _self.requestedAmount : requestedAmount // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,reviewNotes: freezed == reviewNotes ? _self.reviewNotes : reviewNotes // ignore: cast_nullable_to_non_nullable
as String?,createdAtUtc: freezed == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedAtUtc: freezed == reviewedAtUtc ? _self.reviewedAtUtc : reviewedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$TripWaitingSessionEntity {

 String get id; String get tripId; String get driverId; DateTime get startedAtUtc; DateTime? get stoppedAtUtc; int? get minutes; double? get estimatedFee; bool get isActive;
/// Create a copy of TripWaitingSessionEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripWaitingSessionEntityCopyWith<TripWaitingSessionEntity> get copyWith => _$TripWaitingSessionEntityCopyWithImpl<TripWaitingSessionEntity>(this as TripWaitingSessionEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripWaitingSessionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.startedAtUtc, startedAtUtc) || other.startedAtUtc == startedAtUtc)&&(identical(other.stoppedAtUtc, stoppedAtUtc) || other.stoppedAtUtc == stoppedAtUtc)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.estimatedFee, estimatedFee) || other.estimatedFee == estimatedFee)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,id,tripId,driverId,startedAtUtc,stoppedAtUtc,minutes,estimatedFee,isActive);

@override
String toString() {
  return 'TripWaitingSessionEntity(id: $id, tripId: $tripId, driverId: $driverId, startedAtUtc: $startedAtUtc, stoppedAtUtc: $stoppedAtUtc, minutes: $minutes, estimatedFee: $estimatedFee, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $TripWaitingSessionEntityCopyWith<$Res>  {
  factory $TripWaitingSessionEntityCopyWith(TripWaitingSessionEntity value, $Res Function(TripWaitingSessionEntity) _then) = _$TripWaitingSessionEntityCopyWithImpl;
@useResult
$Res call({
 String id, String tripId, String driverId, DateTime startedAtUtc, DateTime? stoppedAtUtc, int? minutes, double? estimatedFee, bool isActive
});




}
/// @nodoc
class _$TripWaitingSessionEntityCopyWithImpl<$Res>
    implements $TripWaitingSessionEntityCopyWith<$Res> {
  _$TripWaitingSessionEntityCopyWithImpl(this._self, this._then);

  final TripWaitingSessionEntity _self;
  final $Res Function(TripWaitingSessionEntity) _then;

/// Create a copy of TripWaitingSessionEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tripId = null,Object? driverId = null,Object? startedAtUtc = null,Object? stoppedAtUtc = freezed,Object? minutes = freezed,Object? estimatedFee = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,startedAtUtc: null == startedAtUtc ? _self.startedAtUtc : startedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,stoppedAtUtc: freezed == stoppedAtUtc ? _self.stoppedAtUtc : stoppedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,minutes: freezed == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int?,estimatedFee: freezed == estimatedFee ? _self.estimatedFee : estimatedFee // ignore: cast_nullable_to_non_nullable
as double?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TripWaitingSessionEntity].
extension TripWaitingSessionEntityPatterns on TripWaitingSessionEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripWaitingSessionEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripWaitingSessionEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripWaitingSessionEntity value)  $default,){
final _that = this;
switch (_that) {
case _TripWaitingSessionEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripWaitingSessionEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TripWaitingSessionEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tripId,  String driverId,  DateTime startedAtUtc,  DateTime? stoppedAtUtc,  int? minutes,  double? estimatedFee,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripWaitingSessionEntity() when $default != null:
return $default(_that.id,_that.tripId,_that.driverId,_that.startedAtUtc,_that.stoppedAtUtc,_that.minutes,_that.estimatedFee,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tripId,  String driverId,  DateTime startedAtUtc,  DateTime? stoppedAtUtc,  int? minutes,  double? estimatedFee,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _TripWaitingSessionEntity():
return $default(_that.id,_that.tripId,_that.driverId,_that.startedAtUtc,_that.stoppedAtUtc,_that.minutes,_that.estimatedFee,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tripId,  String driverId,  DateTime startedAtUtc,  DateTime? stoppedAtUtc,  int? minutes,  double? estimatedFee,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _TripWaitingSessionEntity() when $default != null:
return $default(_that.id,_that.tripId,_that.driverId,_that.startedAtUtc,_that.stoppedAtUtc,_that.minutes,_that.estimatedFee,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc


class _TripWaitingSessionEntity implements TripWaitingSessionEntity {
  const _TripWaitingSessionEntity({required this.id, required this.tripId, required this.driverId, required this.startedAtUtc, this.stoppedAtUtc, this.minutes, this.estimatedFee, this.isActive = false});
  

@override final  String id;
@override final  String tripId;
@override final  String driverId;
@override final  DateTime startedAtUtc;
@override final  DateTime? stoppedAtUtc;
@override final  int? minutes;
@override final  double? estimatedFee;
@override@JsonKey() final  bool isActive;

/// Create a copy of TripWaitingSessionEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripWaitingSessionEntityCopyWith<_TripWaitingSessionEntity> get copyWith => __$TripWaitingSessionEntityCopyWithImpl<_TripWaitingSessionEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripWaitingSessionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.startedAtUtc, startedAtUtc) || other.startedAtUtc == startedAtUtc)&&(identical(other.stoppedAtUtc, stoppedAtUtc) || other.stoppedAtUtc == stoppedAtUtc)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.estimatedFee, estimatedFee) || other.estimatedFee == estimatedFee)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,id,tripId,driverId,startedAtUtc,stoppedAtUtc,minutes,estimatedFee,isActive);

@override
String toString() {
  return 'TripWaitingSessionEntity(id: $id, tripId: $tripId, driverId: $driverId, startedAtUtc: $startedAtUtc, stoppedAtUtc: $stoppedAtUtc, minutes: $minutes, estimatedFee: $estimatedFee, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$TripWaitingSessionEntityCopyWith<$Res> implements $TripWaitingSessionEntityCopyWith<$Res> {
  factory _$TripWaitingSessionEntityCopyWith(_TripWaitingSessionEntity value, $Res Function(_TripWaitingSessionEntity) _then) = __$TripWaitingSessionEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String tripId, String driverId, DateTime startedAtUtc, DateTime? stoppedAtUtc, int? minutes, double? estimatedFee, bool isActive
});




}
/// @nodoc
class __$TripWaitingSessionEntityCopyWithImpl<$Res>
    implements _$TripWaitingSessionEntityCopyWith<$Res> {
  __$TripWaitingSessionEntityCopyWithImpl(this._self, this._then);

  final _TripWaitingSessionEntity _self;
  final $Res Function(_TripWaitingSessionEntity) _then;

/// Create a copy of TripWaitingSessionEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tripId = null,Object? driverId = null,Object? startedAtUtc = null,Object? stoppedAtUtc = freezed,Object? minutes = freezed,Object? estimatedFee = freezed,Object? isActive = null,}) {
  return _then(_TripWaitingSessionEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,startedAtUtc: null == startedAtUtc ? _self.startedAtUtc : startedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,stoppedAtUtc: freezed == stoppedAtUtc ? _self.stoppedAtUtc : stoppedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,minutes: freezed == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int?,estimatedFee: freezed == estimatedFee ? _self.estimatedFee : estimatedFee // ignore: cast_nullable_to_non_nullable
as double?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$TripSummaryEntity {

 String get id; String get referenceCode; TripStatus get status; double get quotedFare; String get currencyCode; DateTime get createdAtUtc; DateTime? get scheduledAtUtc; List<TripStopEntity> get stops;
/// Create a copy of TripSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripSummaryEntityCopyWith<TripSummaryEntity> get copyWith => _$TripSummaryEntityCopyWithImpl<TripSummaryEntity>(this as TripSummaryEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripSummaryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.referenceCode, referenceCode) || other.referenceCode == referenceCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.quotedFare, quotedFare) || other.quotedFare == quotedFare)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.scheduledAtUtc, scheduledAtUtc) || other.scheduledAtUtc == scheduledAtUtc)&&const DeepCollectionEquality().equals(other.stops, stops));
}


@override
int get hashCode => Object.hash(runtimeType,id,referenceCode,status,quotedFare,currencyCode,createdAtUtc,scheduledAtUtc,const DeepCollectionEquality().hash(stops));

@override
String toString() {
  return 'TripSummaryEntity(id: $id, referenceCode: $referenceCode, status: $status, quotedFare: $quotedFare, currencyCode: $currencyCode, createdAtUtc: $createdAtUtc, scheduledAtUtc: $scheduledAtUtc, stops: $stops)';
}


}

/// @nodoc
abstract mixin class $TripSummaryEntityCopyWith<$Res>  {
  factory $TripSummaryEntityCopyWith(TripSummaryEntity value, $Res Function(TripSummaryEntity) _then) = _$TripSummaryEntityCopyWithImpl;
@useResult
$Res call({
 String id, String referenceCode, TripStatus status, double quotedFare, String currencyCode, DateTime createdAtUtc, DateTime? scheduledAtUtc, List<TripStopEntity> stops
});




}
/// @nodoc
class _$TripSummaryEntityCopyWithImpl<$Res>
    implements $TripSummaryEntityCopyWith<$Res> {
  _$TripSummaryEntityCopyWithImpl(this._self, this._then);

  final TripSummaryEntity _self;
  final $Res Function(TripSummaryEntity) _then;

/// Create a copy of TripSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? referenceCode = null,Object? status = null,Object? quotedFare = null,Object? currencyCode = null,Object? createdAtUtc = null,Object? scheduledAtUtc = freezed,Object? stops = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referenceCode: null == referenceCode ? _self.referenceCode : referenceCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripStatus,quotedFare: null == quotedFare ? _self.quotedFare : quotedFare // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledAtUtc: freezed == scheduledAtUtc ? _self.scheduledAtUtc : scheduledAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,stops: null == stops ? _self.stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripStopEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [TripSummaryEntity].
extension TripSummaryEntityPatterns on TripSummaryEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripSummaryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripSummaryEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripSummaryEntity value)  $default,){
final _that = this;
switch (_that) {
case _TripSummaryEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripSummaryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TripSummaryEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String referenceCode,  TripStatus status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopEntity> stops)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripSummaryEntity() when $default != null:
return $default(_that.id,_that.referenceCode,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String referenceCode,  TripStatus status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopEntity> stops)  $default,) {final _that = this;
switch (_that) {
case _TripSummaryEntity():
return $default(_that.id,_that.referenceCode,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String referenceCode,  TripStatus status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopEntity> stops)?  $default,) {final _that = this;
switch (_that) {
case _TripSummaryEntity() when $default != null:
return $default(_that.id,_that.referenceCode,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops);case _:
  return null;

}
}

}

/// @nodoc


class _TripSummaryEntity implements TripSummaryEntity {
  const _TripSummaryEntity({required this.id, required this.referenceCode, required this.status, required this.quotedFare, required this.currencyCode, required this.createdAtUtc, this.scheduledAtUtc, final  List<TripStopEntity> stops = const []}): _stops = stops;
  

@override final  String id;
@override final  String referenceCode;
@override final  TripStatus status;
@override final  double quotedFare;
@override final  String currencyCode;
@override final  DateTime createdAtUtc;
@override final  DateTime? scheduledAtUtc;
 final  List<TripStopEntity> _stops;
@override@JsonKey() List<TripStopEntity> get stops {
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stops);
}


/// Create a copy of TripSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripSummaryEntityCopyWith<_TripSummaryEntity> get copyWith => __$TripSummaryEntityCopyWithImpl<_TripSummaryEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripSummaryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.referenceCode, referenceCode) || other.referenceCode == referenceCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.quotedFare, quotedFare) || other.quotedFare == quotedFare)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.scheduledAtUtc, scheduledAtUtc) || other.scheduledAtUtc == scheduledAtUtc)&&const DeepCollectionEquality().equals(other._stops, _stops));
}


@override
int get hashCode => Object.hash(runtimeType,id,referenceCode,status,quotedFare,currencyCode,createdAtUtc,scheduledAtUtc,const DeepCollectionEquality().hash(_stops));

@override
String toString() {
  return 'TripSummaryEntity(id: $id, referenceCode: $referenceCode, status: $status, quotedFare: $quotedFare, currencyCode: $currencyCode, createdAtUtc: $createdAtUtc, scheduledAtUtc: $scheduledAtUtc, stops: $stops)';
}


}

/// @nodoc
abstract mixin class _$TripSummaryEntityCopyWith<$Res> implements $TripSummaryEntityCopyWith<$Res> {
  factory _$TripSummaryEntityCopyWith(_TripSummaryEntity value, $Res Function(_TripSummaryEntity) _then) = __$TripSummaryEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String referenceCode, TripStatus status, double quotedFare, String currencyCode, DateTime createdAtUtc, DateTime? scheduledAtUtc, List<TripStopEntity> stops
});




}
/// @nodoc
class __$TripSummaryEntityCopyWithImpl<$Res>
    implements _$TripSummaryEntityCopyWith<$Res> {
  __$TripSummaryEntityCopyWithImpl(this._self, this._then);

  final _TripSummaryEntity _self;
  final $Res Function(_TripSummaryEntity) _then;

/// Create a copy of TripSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? referenceCode = null,Object? status = null,Object? quotedFare = null,Object? currencyCode = null,Object? createdAtUtc = null,Object? scheduledAtUtc = freezed,Object? stops = null,}) {
  return _then(_TripSummaryEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referenceCode: null == referenceCode ? _self.referenceCode : referenceCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripStatus,quotedFare: null == quotedFare ? _self.quotedFare : quotedFare // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledAtUtc: freezed == scheduledAtUtc ? _self.scheduledAtUtc : scheduledAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,stops: null == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripStopEntity>,
  ));
}


}

// dart format on
