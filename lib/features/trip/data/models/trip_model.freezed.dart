// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripModel {

 String get id; String get referenceCode; String get status; double get quotedFare; String get currencyCode; DateTime get createdAtUtc; DateTime? get scheduledAtUtc; List<TripStopModel> get stops; String? get vehicleTypeName; double? get driverLat; double? get driverLng; DateTime? get etaToPickup; TripCancellationModel? get cancellation; TripCompensationClaimModel? get compensationClaim; TripWaitingSessionModel? get activeWaitingSession; String? get encodedOverviewPolyline; List<TripRouteSegmentModel> get routeSegments; String? get passengerNote;
/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripModelCopyWith<TripModel> get copyWith => _$TripModelCopyWithImpl<TripModel>(this as TripModel, _$identity);

  /// Serializes this TripModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripModel&&(identical(other.id, id) || other.id == id)&&(identical(other.referenceCode, referenceCode) || other.referenceCode == referenceCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.quotedFare, quotedFare) || other.quotedFare == quotedFare)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.scheduledAtUtc, scheduledAtUtc) || other.scheduledAtUtc == scheduledAtUtc)&&const DeepCollectionEquality().equals(other.stops, stops)&&(identical(other.vehicleTypeName, vehicleTypeName) || other.vehicleTypeName == vehicleTypeName)&&(identical(other.driverLat, driverLat) || other.driverLat == driverLat)&&(identical(other.driverLng, driverLng) || other.driverLng == driverLng)&&(identical(other.etaToPickup, etaToPickup) || other.etaToPickup == etaToPickup)&&(identical(other.cancellation, cancellation) || other.cancellation == cancellation)&&(identical(other.compensationClaim, compensationClaim) || other.compensationClaim == compensationClaim)&&(identical(other.activeWaitingSession, activeWaitingSession) || other.activeWaitingSession == activeWaitingSession)&&(identical(other.encodedOverviewPolyline, encodedOverviewPolyline) || other.encodedOverviewPolyline == encodedOverviewPolyline)&&const DeepCollectionEquality().equals(other.routeSegments, routeSegments)&&(identical(other.passengerNote, passengerNote) || other.passengerNote == passengerNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,referenceCode,status,quotedFare,currencyCode,createdAtUtc,scheduledAtUtc,const DeepCollectionEquality().hash(stops),vehicleTypeName,driverLat,driverLng,etaToPickup,cancellation,compensationClaim,activeWaitingSession,encodedOverviewPolyline,const DeepCollectionEquality().hash(routeSegments),passengerNote);

@override
String toString() {
  return 'TripModel(id: $id, referenceCode: $referenceCode, status: $status, quotedFare: $quotedFare, currencyCode: $currencyCode, createdAtUtc: $createdAtUtc, scheduledAtUtc: $scheduledAtUtc, stops: $stops, vehicleTypeName: $vehicleTypeName, driverLat: $driverLat, driverLng: $driverLng, etaToPickup: $etaToPickup, cancellation: $cancellation, compensationClaim: $compensationClaim, activeWaitingSession: $activeWaitingSession, encodedOverviewPolyline: $encodedOverviewPolyline, routeSegments: $routeSegments, passengerNote: $passengerNote)';
}


}

/// @nodoc
abstract mixin class $TripModelCopyWith<$Res>  {
  factory $TripModelCopyWith(TripModel value, $Res Function(TripModel) _then) = _$TripModelCopyWithImpl;
@useResult
$Res call({
 String id, String referenceCode, String status, double quotedFare, String currencyCode, DateTime createdAtUtc, DateTime? scheduledAtUtc, List<TripStopModel> stops, String? vehicleTypeName, double? driverLat, double? driverLng, DateTime? etaToPickup, TripCancellationModel? cancellation, TripCompensationClaimModel? compensationClaim, TripWaitingSessionModel? activeWaitingSession, String? encodedOverviewPolyline, List<TripRouteSegmentModel> routeSegments, String? passengerNote
});


$TripCancellationModelCopyWith<$Res>? get cancellation;$TripCompensationClaimModelCopyWith<$Res>? get compensationClaim;$TripWaitingSessionModelCopyWith<$Res>? get activeWaitingSession;

}
/// @nodoc
class _$TripModelCopyWithImpl<$Res>
    implements $TripModelCopyWith<$Res> {
  _$TripModelCopyWithImpl(this._self, this._then);

  final TripModel _self;
  final $Res Function(TripModel) _then;

/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? referenceCode = null,Object? status = null,Object? quotedFare = null,Object? currencyCode = null,Object? createdAtUtc = null,Object? scheduledAtUtc = freezed,Object? stops = null,Object? vehicleTypeName = freezed,Object? driverLat = freezed,Object? driverLng = freezed,Object? etaToPickup = freezed,Object? cancellation = freezed,Object? compensationClaim = freezed,Object? activeWaitingSession = freezed,Object? encodedOverviewPolyline = freezed,Object? routeSegments = null,Object? passengerNote = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referenceCode: null == referenceCode ? _self.referenceCode : referenceCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,quotedFare: null == quotedFare ? _self.quotedFare : quotedFare // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledAtUtc: freezed == scheduledAtUtc ? _self.scheduledAtUtc : scheduledAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,stops: null == stops ? _self.stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripStopModel>,vehicleTypeName: freezed == vehicleTypeName ? _self.vehicleTypeName : vehicleTypeName // ignore: cast_nullable_to_non_nullable
as String?,driverLat: freezed == driverLat ? _self.driverLat : driverLat // ignore: cast_nullable_to_non_nullable
as double?,driverLng: freezed == driverLng ? _self.driverLng : driverLng // ignore: cast_nullable_to_non_nullable
as double?,etaToPickup: freezed == etaToPickup ? _self.etaToPickup : etaToPickup // ignore: cast_nullable_to_non_nullable
as DateTime?,cancellation: freezed == cancellation ? _self.cancellation : cancellation // ignore: cast_nullable_to_non_nullable
as TripCancellationModel?,compensationClaim: freezed == compensationClaim ? _self.compensationClaim : compensationClaim // ignore: cast_nullable_to_non_nullable
as TripCompensationClaimModel?,activeWaitingSession: freezed == activeWaitingSession ? _self.activeWaitingSession : activeWaitingSession // ignore: cast_nullable_to_non_nullable
as TripWaitingSessionModel?,encodedOverviewPolyline: freezed == encodedOverviewPolyline ? _self.encodedOverviewPolyline : encodedOverviewPolyline // ignore: cast_nullable_to_non_nullable
as String?,routeSegments: null == routeSegments ? _self.routeSegments : routeSegments // ignore: cast_nullable_to_non_nullable
as List<TripRouteSegmentModel>,passengerNote: freezed == passengerNote ? _self.passengerNote : passengerNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripCancellationModelCopyWith<$Res>? get cancellation {
    if (_self.cancellation == null) {
    return null;
  }

  return $TripCancellationModelCopyWith<$Res>(_self.cancellation!, (value) {
    return _then(_self.copyWith(cancellation: value));
  });
}/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripCompensationClaimModelCopyWith<$Res>? get compensationClaim {
    if (_self.compensationClaim == null) {
    return null;
  }

  return $TripCompensationClaimModelCopyWith<$Res>(_self.compensationClaim!, (value) {
    return _then(_self.copyWith(compensationClaim: value));
  });
}/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripWaitingSessionModelCopyWith<$Res>? get activeWaitingSession {
    if (_self.activeWaitingSession == null) {
    return null;
  }

  return $TripWaitingSessionModelCopyWith<$Res>(_self.activeWaitingSession!, (value) {
    return _then(_self.copyWith(activeWaitingSession: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripModel].
extension TripModelPatterns on TripModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripModel value)  $default,){
final _that = this;
switch (_that) {
case _TripModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripModel value)?  $default,){
final _that = this;
switch (_that) {
case _TripModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String referenceCode,  String status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopModel> stops,  String? vehicleTypeName,  double? driverLat,  double? driverLng,  DateTime? etaToPickup,  TripCancellationModel? cancellation,  TripCompensationClaimModel? compensationClaim,  TripWaitingSessionModel? activeWaitingSession,  String? encodedOverviewPolyline,  List<TripRouteSegmentModel> routeSegments,  String? passengerNote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripModel() when $default != null:
return $default(_that.id,_that.referenceCode,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops,_that.vehicleTypeName,_that.driverLat,_that.driverLng,_that.etaToPickup,_that.cancellation,_that.compensationClaim,_that.activeWaitingSession,_that.encodedOverviewPolyline,_that.routeSegments,_that.passengerNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String referenceCode,  String status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopModel> stops,  String? vehicleTypeName,  double? driverLat,  double? driverLng,  DateTime? etaToPickup,  TripCancellationModel? cancellation,  TripCompensationClaimModel? compensationClaim,  TripWaitingSessionModel? activeWaitingSession,  String? encodedOverviewPolyline,  List<TripRouteSegmentModel> routeSegments,  String? passengerNote)  $default,) {final _that = this;
switch (_that) {
case _TripModel():
return $default(_that.id,_that.referenceCode,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops,_that.vehicleTypeName,_that.driverLat,_that.driverLng,_that.etaToPickup,_that.cancellation,_that.compensationClaim,_that.activeWaitingSession,_that.encodedOverviewPolyline,_that.routeSegments,_that.passengerNote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String referenceCode,  String status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopModel> stops,  String? vehicleTypeName,  double? driverLat,  double? driverLng,  DateTime? etaToPickup,  TripCancellationModel? cancellation,  TripCompensationClaimModel? compensationClaim,  TripWaitingSessionModel? activeWaitingSession,  String? encodedOverviewPolyline,  List<TripRouteSegmentModel> routeSegments,  String? passengerNote)?  $default,) {final _that = this;
switch (_that) {
case _TripModel() when $default != null:
return $default(_that.id,_that.referenceCode,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops,_that.vehicleTypeName,_that.driverLat,_that.driverLng,_that.etaToPickup,_that.cancellation,_that.compensationClaim,_that.activeWaitingSession,_that.encodedOverviewPolyline,_that.routeSegments,_that.passengerNote);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripModel implements TripModel {
  const _TripModel({required this.id, required this.referenceCode, required this.status, required this.quotedFare, required this.currencyCode, required this.createdAtUtc, this.scheduledAtUtc, final  List<TripStopModel> stops = const [], this.vehicleTypeName, this.driverLat, this.driverLng, this.etaToPickup, this.cancellation, this.compensationClaim, this.activeWaitingSession, this.encodedOverviewPolyline, final  List<TripRouteSegmentModel> routeSegments = const [], this.passengerNote}): _stops = stops,_routeSegments = routeSegments;
  factory _TripModel.fromJson(Map<String, dynamic> json) => _$TripModelFromJson(json);

@override final  String id;
@override final  String referenceCode;
@override final  String status;
@override final  double quotedFare;
@override final  String currencyCode;
@override final  DateTime createdAtUtc;
@override final  DateTime? scheduledAtUtc;
 final  List<TripStopModel> _stops;
@override@JsonKey() List<TripStopModel> get stops {
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stops);
}

@override final  String? vehicleTypeName;
@override final  double? driverLat;
@override final  double? driverLng;
@override final  DateTime? etaToPickup;
@override final  TripCancellationModel? cancellation;
@override final  TripCompensationClaimModel? compensationClaim;
@override final  TripWaitingSessionModel? activeWaitingSession;
@override final  String? encodedOverviewPolyline;
 final  List<TripRouteSegmentModel> _routeSegments;
@override@JsonKey() List<TripRouteSegmentModel> get routeSegments {
  if (_routeSegments is EqualUnmodifiableListView) return _routeSegments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_routeSegments);
}

@override final  String? passengerNote;

/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripModelCopyWith<_TripModel> get copyWith => __$TripModelCopyWithImpl<_TripModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripModel&&(identical(other.id, id) || other.id == id)&&(identical(other.referenceCode, referenceCode) || other.referenceCode == referenceCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.quotedFare, quotedFare) || other.quotedFare == quotedFare)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.scheduledAtUtc, scheduledAtUtc) || other.scheduledAtUtc == scheduledAtUtc)&&const DeepCollectionEquality().equals(other._stops, _stops)&&(identical(other.vehicleTypeName, vehicleTypeName) || other.vehicleTypeName == vehicleTypeName)&&(identical(other.driverLat, driverLat) || other.driverLat == driverLat)&&(identical(other.driverLng, driverLng) || other.driverLng == driverLng)&&(identical(other.etaToPickup, etaToPickup) || other.etaToPickup == etaToPickup)&&(identical(other.cancellation, cancellation) || other.cancellation == cancellation)&&(identical(other.compensationClaim, compensationClaim) || other.compensationClaim == compensationClaim)&&(identical(other.activeWaitingSession, activeWaitingSession) || other.activeWaitingSession == activeWaitingSession)&&(identical(other.encodedOverviewPolyline, encodedOverviewPolyline) || other.encodedOverviewPolyline == encodedOverviewPolyline)&&const DeepCollectionEquality().equals(other._routeSegments, _routeSegments)&&(identical(other.passengerNote, passengerNote) || other.passengerNote == passengerNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,referenceCode,status,quotedFare,currencyCode,createdAtUtc,scheduledAtUtc,const DeepCollectionEquality().hash(_stops),vehicleTypeName,driverLat,driverLng,etaToPickup,cancellation,compensationClaim,activeWaitingSession,encodedOverviewPolyline,const DeepCollectionEquality().hash(_routeSegments),passengerNote);

@override
String toString() {
  return 'TripModel(id: $id, referenceCode: $referenceCode, status: $status, quotedFare: $quotedFare, currencyCode: $currencyCode, createdAtUtc: $createdAtUtc, scheduledAtUtc: $scheduledAtUtc, stops: $stops, vehicleTypeName: $vehicleTypeName, driverLat: $driverLat, driverLng: $driverLng, etaToPickup: $etaToPickup, cancellation: $cancellation, compensationClaim: $compensationClaim, activeWaitingSession: $activeWaitingSession, encodedOverviewPolyline: $encodedOverviewPolyline, routeSegments: $routeSegments, passengerNote: $passengerNote)';
}


}

/// @nodoc
abstract mixin class _$TripModelCopyWith<$Res> implements $TripModelCopyWith<$Res> {
  factory _$TripModelCopyWith(_TripModel value, $Res Function(_TripModel) _then) = __$TripModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String referenceCode, String status, double quotedFare, String currencyCode, DateTime createdAtUtc, DateTime? scheduledAtUtc, List<TripStopModel> stops, String? vehicleTypeName, double? driverLat, double? driverLng, DateTime? etaToPickup, TripCancellationModel? cancellation, TripCompensationClaimModel? compensationClaim, TripWaitingSessionModel? activeWaitingSession, String? encodedOverviewPolyline, List<TripRouteSegmentModel> routeSegments, String? passengerNote
});


@override $TripCancellationModelCopyWith<$Res>? get cancellation;@override $TripCompensationClaimModelCopyWith<$Res>? get compensationClaim;@override $TripWaitingSessionModelCopyWith<$Res>? get activeWaitingSession;

}
/// @nodoc
class __$TripModelCopyWithImpl<$Res>
    implements _$TripModelCopyWith<$Res> {
  __$TripModelCopyWithImpl(this._self, this._then);

  final _TripModel _self;
  final $Res Function(_TripModel) _then;

/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? referenceCode = null,Object? status = null,Object? quotedFare = null,Object? currencyCode = null,Object? createdAtUtc = null,Object? scheduledAtUtc = freezed,Object? stops = null,Object? vehicleTypeName = freezed,Object? driverLat = freezed,Object? driverLng = freezed,Object? etaToPickup = freezed,Object? cancellation = freezed,Object? compensationClaim = freezed,Object? activeWaitingSession = freezed,Object? encodedOverviewPolyline = freezed,Object? routeSegments = null,Object? passengerNote = freezed,}) {
  return _then(_TripModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referenceCode: null == referenceCode ? _self.referenceCode : referenceCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,quotedFare: null == quotedFare ? _self.quotedFare : quotedFare // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledAtUtc: freezed == scheduledAtUtc ? _self.scheduledAtUtc : scheduledAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,stops: null == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripStopModel>,vehicleTypeName: freezed == vehicleTypeName ? _self.vehicleTypeName : vehicleTypeName // ignore: cast_nullable_to_non_nullable
as String?,driverLat: freezed == driverLat ? _self.driverLat : driverLat // ignore: cast_nullable_to_non_nullable
as double?,driverLng: freezed == driverLng ? _self.driverLng : driverLng // ignore: cast_nullable_to_non_nullable
as double?,etaToPickup: freezed == etaToPickup ? _self.etaToPickup : etaToPickup // ignore: cast_nullable_to_non_nullable
as DateTime?,cancellation: freezed == cancellation ? _self.cancellation : cancellation // ignore: cast_nullable_to_non_nullable
as TripCancellationModel?,compensationClaim: freezed == compensationClaim ? _self.compensationClaim : compensationClaim // ignore: cast_nullable_to_non_nullable
as TripCompensationClaimModel?,activeWaitingSession: freezed == activeWaitingSession ? _self.activeWaitingSession : activeWaitingSession // ignore: cast_nullable_to_non_nullable
as TripWaitingSessionModel?,encodedOverviewPolyline: freezed == encodedOverviewPolyline ? _self.encodedOverviewPolyline : encodedOverviewPolyline // ignore: cast_nullable_to_non_nullable
as String?,routeSegments: null == routeSegments ? _self._routeSegments : routeSegments // ignore: cast_nullable_to_non_nullable
as List<TripRouteSegmentModel>,passengerNote: freezed == passengerNote ? _self.passengerNote : passengerNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripCancellationModelCopyWith<$Res>? get cancellation {
    if (_self.cancellation == null) {
    return null;
  }

  return $TripCancellationModelCopyWith<$Res>(_self.cancellation!, (value) {
    return _then(_self.copyWith(cancellation: value));
  });
}/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripCompensationClaimModelCopyWith<$Res>? get compensationClaim {
    if (_self.compensationClaim == null) {
    return null;
  }

  return $TripCompensationClaimModelCopyWith<$Res>(_self.compensationClaim!, (value) {
    return _then(_self.copyWith(compensationClaim: value));
  });
}/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripWaitingSessionModelCopyWith<$Res>? get activeWaitingSession {
    if (_self.activeWaitingSession == null) {
    return null;
  }

  return $TripWaitingSessionModelCopyWith<$Res>(_self.activeWaitingSession!, (value) {
    return _then(_self.copyWith(activeWaitingSession: value));
  });
}
}


/// @nodoc
mixin _$TripRouteSegmentModel {

 int get distanceMeters; int get durationSeconds; String get encodedPolyline; double get startLatitude; double get startLongitude; double get endLatitude; double get endLongitude;
/// Create a copy of TripRouteSegmentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripRouteSegmentModelCopyWith<TripRouteSegmentModel> get copyWith => _$TripRouteSegmentModelCopyWithImpl<TripRouteSegmentModel>(this as TripRouteSegmentModel, _$identity);

  /// Serializes this TripRouteSegmentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripRouteSegmentModel&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.encodedPolyline, encodedPolyline) || other.encodedPolyline == encodedPolyline)&&(identical(other.startLatitude, startLatitude) || other.startLatitude == startLatitude)&&(identical(other.startLongitude, startLongitude) || other.startLongitude == startLongitude)&&(identical(other.endLatitude, endLatitude) || other.endLatitude == endLatitude)&&(identical(other.endLongitude, endLongitude) || other.endLongitude == endLongitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,distanceMeters,durationSeconds,encodedPolyline,startLatitude,startLongitude,endLatitude,endLongitude);

@override
String toString() {
  return 'TripRouteSegmentModel(distanceMeters: $distanceMeters, durationSeconds: $durationSeconds, encodedPolyline: $encodedPolyline, startLatitude: $startLatitude, startLongitude: $startLongitude, endLatitude: $endLatitude, endLongitude: $endLongitude)';
}


}

/// @nodoc
abstract mixin class $TripRouteSegmentModelCopyWith<$Res>  {
  factory $TripRouteSegmentModelCopyWith(TripRouteSegmentModel value, $Res Function(TripRouteSegmentModel) _then) = _$TripRouteSegmentModelCopyWithImpl;
@useResult
$Res call({
 int distanceMeters, int durationSeconds, String encodedPolyline, double startLatitude, double startLongitude, double endLatitude, double endLongitude
});




}
/// @nodoc
class _$TripRouteSegmentModelCopyWithImpl<$Res>
    implements $TripRouteSegmentModelCopyWith<$Res> {
  _$TripRouteSegmentModelCopyWithImpl(this._self, this._then);

  final TripRouteSegmentModel _self;
  final $Res Function(TripRouteSegmentModel) _then;

/// Create a copy of TripRouteSegmentModel
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


/// Adds pattern-matching-related methods to [TripRouteSegmentModel].
extension TripRouteSegmentModelPatterns on TripRouteSegmentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripRouteSegmentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripRouteSegmentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripRouteSegmentModel value)  $default,){
final _that = this;
switch (_that) {
case _TripRouteSegmentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripRouteSegmentModel value)?  $default,){
final _that = this;
switch (_that) {
case _TripRouteSegmentModel() when $default != null:
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
case _TripRouteSegmentModel() when $default != null:
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
case _TripRouteSegmentModel():
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
case _TripRouteSegmentModel() when $default != null:
return $default(_that.distanceMeters,_that.durationSeconds,_that.encodedPolyline,_that.startLatitude,_that.startLongitude,_that.endLatitude,_that.endLongitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripRouteSegmentModel implements TripRouteSegmentModel {
  const _TripRouteSegmentModel({required this.distanceMeters, required this.durationSeconds, required this.encodedPolyline, required this.startLatitude, required this.startLongitude, required this.endLatitude, required this.endLongitude});
  factory _TripRouteSegmentModel.fromJson(Map<String, dynamic> json) => _$TripRouteSegmentModelFromJson(json);

@override final  int distanceMeters;
@override final  int durationSeconds;
@override final  String encodedPolyline;
@override final  double startLatitude;
@override final  double startLongitude;
@override final  double endLatitude;
@override final  double endLongitude;

/// Create a copy of TripRouteSegmentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripRouteSegmentModelCopyWith<_TripRouteSegmentModel> get copyWith => __$TripRouteSegmentModelCopyWithImpl<_TripRouteSegmentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripRouteSegmentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripRouteSegmentModel&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.encodedPolyline, encodedPolyline) || other.encodedPolyline == encodedPolyline)&&(identical(other.startLatitude, startLatitude) || other.startLatitude == startLatitude)&&(identical(other.startLongitude, startLongitude) || other.startLongitude == startLongitude)&&(identical(other.endLatitude, endLatitude) || other.endLatitude == endLatitude)&&(identical(other.endLongitude, endLongitude) || other.endLongitude == endLongitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,distanceMeters,durationSeconds,encodedPolyline,startLatitude,startLongitude,endLatitude,endLongitude);

@override
String toString() {
  return 'TripRouteSegmentModel(distanceMeters: $distanceMeters, durationSeconds: $durationSeconds, encodedPolyline: $encodedPolyline, startLatitude: $startLatitude, startLongitude: $startLongitude, endLatitude: $endLatitude, endLongitude: $endLongitude)';
}


}

/// @nodoc
abstract mixin class _$TripRouteSegmentModelCopyWith<$Res> implements $TripRouteSegmentModelCopyWith<$Res> {
  factory _$TripRouteSegmentModelCopyWith(_TripRouteSegmentModel value, $Res Function(_TripRouteSegmentModel) _then) = __$TripRouteSegmentModelCopyWithImpl;
@override @useResult
$Res call({
 int distanceMeters, int durationSeconds, String encodedPolyline, double startLatitude, double startLongitude, double endLatitude, double endLongitude
});




}
/// @nodoc
class __$TripRouteSegmentModelCopyWithImpl<$Res>
    implements _$TripRouteSegmentModelCopyWith<$Res> {
  __$TripRouteSegmentModelCopyWithImpl(this._self, this._then);

  final _TripRouteSegmentModel _self;
  final $Res Function(_TripRouteSegmentModel) _then;

/// Create a copy of TripRouteSegmentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? distanceMeters = null,Object? durationSeconds = null,Object? encodedPolyline = null,Object? startLatitude = null,Object? startLongitude = null,Object? endLatitude = null,Object? endLongitude = null,}) {
  return _then(_TripRouteSegmentModel(
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
mixin _$TripStopModel {

 double get latitude; double get longitude; String? get label; int get sequence; bool get isCompleted; DateTime? get completedAtUtc;
/// Create a copy of TripStopModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripStopModelCopyWith<TripStopModel> get copyWith => _$TripStopModelCopyWithImpl<TripStopModel>(this as TripStopModel, _$identity);

  /// Serializes this TripStopModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripStopModel&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.label, label) || other.label == label)&&(identical(other.sequence, sequence) || other.sequence == sequence)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.completedAtUtc, completedAtUtc) || other.completedAtUtc == completedAtUtc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,label,sequence,isCompleted,completedAtUtc);

@override
String toString() {
  return 'TripStopModel(latitude: $latitude, longitude: $longitude, label: $label, sequence: $sequence, isCompleted: $isCompleted, completedAtUtc: $completedAtUtc)';
}


}

/// @nodoc
abstract mixin class $TripStopModelCopyWith<$Res>  {
  factory $TripStopModelCopyWith(TripStopModel value, $Res Function(TripStopModel) _then) = _$TripStopModelCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, String? label, int sequence, bool isCompleted, DateTime? completedAtUtc
});




}
/// @nodoc
class _$TripStopModelCopyWithImpl<$Res>
    implements $TripStopModelCopyWith<$Res> {
  _$TripStopModelCopyWithImpl(this._self, this._then);

  final TripStopModel _self;
  final $Res Function(TripStopModel) _then;

/// Create a copy of TripStopModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? label = freezed,Object? sequence = null,Object? isCompleted = null,Object? completedAtUtc = freezed,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,sequence: null == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,completedAtUtc: freezed == completedAtUtc ? _self.completedAtUtc : completedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripStopModel].
extension TripStopModelPatterns on TripStopModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripStopModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripStopModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripStopModel value)  $default,){
final _that = this;
switch (_that) {
case _TripStopModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripStopModel value)?  $default,){
final _that = this;
switch (_that) {
case _TripStopModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude,  String? label,  int sequence,  bool isCompleted,  DateTime? completedAtUtc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripStopModel() when $default != null:
return $default(_that.latitude,_that.longitude,_that.label,_that.sequence,_that.isCompleted,_that.completedAtUtc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude,  String? label,  int sequence,  bool isCompleted,  DateTime? completedAtUtc)  $default,) {final _that = this;
switch (_that) {
case _TripStopModel():
return $default(_that.latitude,_that.longitude,_that.label,_that.sequence,_that.isCompleted,_that.completedAtUtc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude,  String? label,  int sequence,  bool isCompleted,  DateTime? completedAtUtc)?  $default,) {final _that = this;
switch (_that) {
case _TripStopModel() when $default != null:
return $default(_that.latitude,_that.longitude,_that.label,_that.sequence,_that.isCompleted,_that.completedAtUtc);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripStopModel implements TripStopModel {
  const _TripStopModel({required this.latitude, required this.longitude, this.label, this.sequence = 0, this.isCompleted = false, this.completedAtUtc});
  factory _TripStopModel.fromJson(Map<String, dynamic> json) => _$TripStopModelFromJson(json);

@override final  double latitude;
@override final  double longitude;
@override final  String? label;
@override@JsonKey() final  int sequence;
@override@JsonKey() final  bool isCompleted;
@override final  DateTime? completedAtUtc;

/// Create a copy of TripStopModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripStopModelCopyWith<_TripStopModel> get copyWith => __$TripStopModelCopyWithImpl<_TripStopModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripStopModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripStopModel&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.label, label) || other.label == label)&&(identical(other.sequence, sequence) || other.sequence == sequence)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.completedAtUtc, completedAtUtc) || other.completedAtUtc == completedAtUtc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,label,sequence,isCompleted,completedAtUtc);

@override
String toString() {
  return 'TripStopModel(latitude: $latitude, longitude: $longitude, label: $label, sequence: $sequence, isCompleted: $isCompleted, completedAtUtc: $completedAtUtc)';
}


}

/// @nodoc
abstract mixin class _$TripStopModelCopyWith<$Res> implements $TripStopModelCopyWith<$Res> {
  factory _$TripStopModelCopyWith(_TripStopModel value, $Res Function(_TripStopModel) _then) = __$TripStopModelCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude, String? label, int sequence, bool isCompleted, DateTime? completedAtUtc
});




}
/// @nodoc
class __$TripStopModelCopyWithImpl<$Res>
    implements _$TripStopModelCopyWith<$Res> {
  __$TripStopModelCopyWithImpl(this._self, this._then);

  final _TripStopModel _self;
  final $Res Function(_TripStopModel) _then;

/// Create a copy of TripStopModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? label = freezed,Object? sequence = null,Object? isCompleted = null,Object? completedAtUtc = freezed,}) {
  return _then(_TripStopModel(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,sequence: null == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,completedAtUtc: freezed == completedAtUtc ? _self.completedAtUtc : completedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$TripCancellationModel {

 String get actor; String get reason; double get refundPercent; double get refundAmount; String get currencyCode; String? get note; DateTime? get createdAtUtc;
/// Create a copy of TripCancellationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripCancellationModelCopyWith<TripCancellationModel> get copyWith => _$TripCancellationModelCopyWithImpl<TripCancellationModel>(this as TripCancellationModel, _$identity);

  /// Serializes this TripCancellationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripCancellationModel&&(identical(other.actor, actor) || other.actor == actor)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.refundPercent, refundPercent) || other.refundPercent == refundPercent)&&(identical(other.refundAmount, refundAmount) || other.refundAmount == refundAmount)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,actor,reason,refundPercent,refundAmount,currencyCode,note,createdAtUtc);

@override
String toString() {
  return 'TripCancellationModel(actor: $actor, reason: $reason, refundPercent: $refundPercent, refundAmount: $refundAmount, currencyCode: $currencyCode, note: $note, createdAtUtc: $createdAtUtc)';
}


}

/// @nodoc
abstract mixin class $TripCancellationModelCopyWith<$Res>  {
  factory $TripCancellationModelCopyWith(TripCancellationModel value, $Res Function(TripCancellationModel) _then) = _$TripCancellationModelCopyWithImpl;
@useResult
$Res call({
 String actor, String reason, double refundPercent, double refundAmount, String currencyCode, String? note, DateTime? createdAtUtc
});




}
/// @nodoc
class _$TripCancellationModelCopyWithImpl<$Res>
    implements $TripCancellationModelCopyWith<$Res> {
  _$TripCancellationModelCopyWithImpl(this._self, this._then);

  final TripCancellationModel _self;
  final $Res Function(TripCancellationModel) _then;

/// Create a copy of TripCancellationModel
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


/// Adds pattern-matching-related methods to [TripCancellationModel].
extension TripCancellationModelPatterns on TripCancellationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripCancellationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripCancellationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripCancellationModel value)  $default,){
final _that = this;
switch (_that) {
case _TripCancellationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripCancellationModel value)?  $default,){
final _that = this;
switch (_that) {
case _TripCancellationModel() when $default != null:
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
case _TripCancellationModel() when $default != null:
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
case _TripCancellationModel():
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
case _TripCancellationModel() when $default != null:
return $default(_that.actor,_that.reason,_that.refundPercent,_that.refundAmount,_that.currencyCode,_that.note,_that.createdAtUtc);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripCancellationModel implements TripCancellationModel {
  const _TripCancellationModel({required this.actor, required this.reason, required this.refundPercent, required this.refundAmount, required this.currencyCode, this.note, this.createdAtUtc});
  factory _TripCancellationModel.fromJson(Map<String, dynamic> json) => _$TripCancellationModelFromJson(json);

@override final  String actor;
@override final  String reason;
@override final  double refundPercent;
@override final  double refundAmount;
@override final  String currencyCode;
@override final  String? note;
@override final  DateTime? createdAtUtc;

/// Create a copy of TripCancellationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripCancellationModelCopyWith<_TripCancellationModel> get copyWith => __$TripCancellationModelCopyWithImpl<_TripCancellationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripCancellationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripCancellationModel&&(identical(other.actor, actor) || other.actor == actor)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.refundPercent, refundPercent) || other.refundPercent == refundPercent)&&(identical(other.refundAmount, refundAmount) || other.refundAmount == refundAmount)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,actor,reason,refundPercent,refundAmount,currencyCode,note,createdAtUtc);

@override
String toString() {
  return 'TripCancellationModel(actor: $actor, reason: $reason, refundPercent: $refundPercent, refundAmount: $refundAmount, currencyCode: $currencyCode, note: $note, createdAtUtc: $createdAtUtc)';
}


}

/// @nodoc
abstract mixin class _$TripCancellationModelCopyWith<$Res> implements $TripCancellationModelCopyWith<$Res> {
  factory _$TripCancellationModelCopyWith(_TripCancellationModel value, $Res Function(_TripCancellationModel) _then) = __$TripCancellationModelCopyWithImpl;
@override @useResult
$Res call({
 String actor, String reason, double refundPercent, double refundAmount, String currencyCode, String? note, DateTime? createdAtUtc
});




}
/// @nodoc
class __$TripCancellationModelCopyWithImpl<$Res>
    implements _$TripCancellationModelCopyWith<$Res> {
  __$TripCancellationModelCopyWithImpl(this._self, this._then);

  final _TripCancellationModel _self;
  final $Res Function(_TripCancellationModel) _then;

/// Create a copy of TripCancellationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? actor = null,Object? reason = null,Object? refundPercent = null,Object? refundAmount = null,Object? currencyCode = null,Object? note = freezed,Object? createdAtUtc = freezed,}) {
  return _then(_TripCancellationModel(
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
mixin _$TripCompensationClaimModel {

 String get id; String get tripId; String get passengerId; String get note; List<String> get evidenceUrls; double get requestedAmount; String get currencyCode; String get status; String? get reviewNotes; DateTime? get createdAtUtc; DateTime? get reviewedAtUtc;
/// Create a copy of TripCompensationClaimModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripCompensationClaimModelCopyWith<TripCompensationClaimModel> get copyWith => _$TripCompensationClaimModelCopyWithImpl<TripCompensationClaimModel>(this as TripCompensationClaimModel, _$identity);

  /// Serializes this TripCompensationClaimModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripCompensationClaimModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other.evidenceUrls, evidenceUrls)&&(identical(other.requestedAmount, requestedAmount) || other.requestedAmount == requestedAmount)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.reviewNotes, reviewNotes) || other.reviewNotes == reviewNotes)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.reviewedAtUtc, reviewedAtUtc) || other.reviewedAtUtc == reviewedAtUtc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tripId,passengerId,note,const DeepCollectionEquality().hash(evidenceUrls),requestedAmount,currencyCode,status,reviewNotes,createdAtUtc,reviewedAtUtc);

@override
String toString() {
  return 'TripCompensationClaimModel(id: $id, tripId: $tripId, passengerId: $passengerId, note: $note, evidenceUrls: $evidenceUrls, requestedAmount: $requestedAmount, currencyCode: $currencyCode, status: $status, reviewNotes: $reviewNotes, createdAtUtc: $createdAtUtc, reviewedAtUtc: $reviewedAtUtc)';
}


}

/// @nodoc
abstract mixin class $TripCompensationClaimModelCopyWith<$Res>  {
  factory $TripCompensationClaimModelCopyWith(TripCompensationClaimModel value, $Res Function(TripCompensationClaimModel) _then) = _$TripCompensationClaimModelCopyWithImpl;
@useResult
$Res call({
 String id, String tripId, String passengerId, String note, List<String> evidenceUrls, double requestedAmount, String currencyCode, String status, String? reviewNotes, DateTime? createdAtUtc, DateTime? reviewedAtUtc
});




}
/// @nodoc
class _$TripCompensationClaimModelCopyWithImpl<$Res>
    implements $TripCompensationClaimModelCopyWith<$Res> {
  _$TripCompensationClaimModelCopyWithImpl(this._self, this._then);

  final TripCompensationClaimModel _self;
  final $Res Function(TripCompensationClaimModel) _then;

/// Create a copy of TripCompensationClaimModel
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


/// Adds pattern-matching-related methods to [TripCompensationClaimModel].
extension TripCompensationClaimModelPatterns on TripCompensationClaimModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripCompensationClaimModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripCompensationClaimModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripCompensationClaimModel value)  $default,){
final _that = this;
switch (_that) {
case _TripCompensationClaimModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripCompensationClaimModel value)?  $default,){
final _that = this;
switch (_that) {
case _TripCompensationClaimModel() when $default != null:
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
case _TripCompensationClaimModel() when $default != null:
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
case _TripCompensationClaimModel():
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
case _TripCompensationClaimModel() when $default != null:
return $default(_that.id,_that.tripId,_that.passengerId,_that.note,_that.evidenceUrls,_that.requestedAmount,_that.currencyCode,_that.status,_that.reviewNotes,_that.createdAtUtc,_that.reviewedAtUtc);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripCompensationClaimModel implements TripCompensationClaimModel {
  const _TripCompensationClaimModel({required this.id, required this.tripId, required this.passengerId, required this.note, final  List<String> evidenceUrls = const [], required this.requestedAmount, required this.currencyCode, required this.status, this.reviewNotes, this.createdAtUtc, this.reviewedAtUtc}): _evidenceUrls = evidenceUrls;
  factory _TripCompensationClaimModel.fromJson(Map<String, dynamic> json) => _$TripCompensationClaimModelFromJson(json);

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

/// Create a copy of TripCompensationClaimModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripCompensationClaimModelCopyWith<_TripCompensationClaimModel> get copyWith => __$TripCompensationClaimModelCopyWithImpl<_TripCompensationClaimModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripCompensationClaimModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripCompensationClaimModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other._evidenceUrls, _evidenceUrls)&&(identical(other.requestedAmount, requestedAmount) || other.requestedAmount == requestedAmount)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.reviewNotes, reviewNotes) || other.reviewNotes == reviewNotes)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.reviewedAtUtc, reviewedAtUtc) || other.reviewedAtUtc == reviewedAtUtc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tripId,passengerId,note,const DeepCollectionEquality().hash(_evidenceUrls),requestedAmount,currencyCode,status,reviewNotes,createdAtUtc,reviewedAtUtc);

@override
String toString() {
  return 'TripCompensationClaimModel(id: $id, tripId: $tripId, passengerId: $passengerId, note: $note, evidenceUrls: $evidenceUrls, requestedAmount: $requestedAmount, currencyCode: $currencyCode, status: $status, reviewNotes: $reviewNotes, createdAtUtc: $createdAtUtc, reviewedAtUtc: $reviewedAtUtc)';
}


}

/// @nodoc
abstract mixin class _$TripCompensationClaimModelCopyWith<$Res> implements $TripCompensationClaimModelCopyWith<$Res> {
  factory _$TripCompensationClaimModelCopyWith(_TripCompensationClaimModel value, $Res Function(_TripCompensationClaimModel) _then) = __$TripCompensationClaimModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String tripId, String passengerId, String note, List<String> evidenceUrls, double requestedAmount, String currencyCode, String status, String? reviewNotes, DateTime? createdAtUtc, DateTime? reviewedAtUtc
});




}
/// @nodoc
class __$TripCompensationClaimModelCopyWithImpl<$Res>
    implements _$TripCompensationClaimModelCopyWith<$Res> {
  __$TripCompensationClaimModelCopyWithImpl(this._self, this._then);

  final _TripCompensationClaimModel _self;
  final $Res Function(_TripCompensationClaimModel) _then;

/// Create a copy of TripCompensationClaimModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tripId = null,Object? passengerId = null,Object? note = null,Object? evidenceUrls = null,Object? requestedAmount = null,Object? currencyCode = null,Object? status = null,Object? reviewNotes = freezed,Object? createdAtUtc = freezed,Object? reviewedAtUtc = freezed,}) {
  return _then(_TripCompensationClaimModel(
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
mixin _$TripWaitingSessionModel {

 String get id; String get tripId; String get driverId; DateTime get startedAtUtc; DateTime? get stoppedAtUtc; int? get minutes; double? get estimatedFee; bool get isActive;
/// Create a copy of TripWaitingSessionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripWaitingSessionModelCopyWith<TripWaitingSessionModel> get copyWith => _$TripWaitingSessionModelCopyWithImpl<TripWaitingSessionModel>(this as TripWaitingSessionModel, _$identity);

  /// Serializes this TripWaitingSessionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripWaitingSessionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.startedAtUtc, startedAtUtc) || other.startedAtUtc == startedAtUtc)&&(identical(other.stoppedAtUtc, stoppedAtUtc) || other.stoppedAtUtc == stoppedAtUtc)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.estimatedFee, estimatedFee) || other.estimatedFee == estimatedFee)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tripId,driverId,startedAtUtc,stoppedAtUtc,minutes,estimatedFee,isActive);

@override
String toString() {
  return 'TripWaitingSessionModel(id: $id, tripId: $tripId, driverId: $driverId, startedAtUtc: $startedAtUtc, stoppedAtUtc: $stoppedAtUtc, minutes: $minutes, estimatedFee: $estimatedFee, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $TripWaitingSessionModelCopyWith<$Res>  {
  factory $TripWaitingSessionModelCopyWith(TripWaitingSessionModel value, $Res Function(TripWaitingSessionModel) _then) = _$TripWaitingSessionModelCopyWithImpl;
@useResult
$Res call({
 String id, String tripId, String driverId, DateTime startedAtUtc, DateTime? stoppedAtUtc, int? minutes, double? estimatedFee, bool isActive
});




}
/// @nodoc
class _$TripWaitingSessionModelCopyWithImpl<$Res>
    implements $TripWaitingSessionModelCopyWith<$Res> {
  _$TripWaitingSessionModelCopyWithImpl(this._self, this._then);

  final TripWaitingSessionModel _self;
  final $Res Function(TripWaitingSessionModel) _then;

/// Create a copy of TripWaitingSessionModel
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


/// Adds pattern-matching-related methods to [TripWaitingSessionModel].
extension TripWaitingSessionModelPatterns on TripWaitingSessionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripWaitingSessionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripWaitingSessionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripWaitingSessionModel value)  $default,){
final _that = this;
switch (_that) {
case _TripWaitingSessionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripWaitingSessionModel value)?  $default,){
final _that = this;
switch (_that) {
case _TripWaitingSessionModel() when $default != null:
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
case _TripWaitingSessionModel() when $default != null:
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
case _TripWaitingSessionModel():
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
case _TripWaitingSessionModel() when $default != null:
return $default(_that.id,_that.tripId,_that.driverId,_that.startedAtUtc,_that.stoppedAtUtc,_that.minutes,_that.estimatedFee,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripWaitingSessionModel implements TripWaitingSessionModel {
  const _TripWaitingSessionModel({required this.id, required this.tripId, required this.driverId, required this.startedAtUtc, this.stoppedAtUtc, this.minutes, this.estimatedFee, this.isActive = false});
  factory _TripWaitingSessionModel.fromJson(Map<String, dynamic> json) => _$TripWaitingSessionModelFromJson(json);

@override final  String id;
@override final  String tripId;
@override final  String driverId;
@override final  DateTime startedAtUtc;
@override final  DateTime? stoppedAtUtc;
@override final  int? minutes;
@override final  double? estimatedFee;
@override@JsonKey() final  bool isActive;

/// Create a copy of TripWaitingSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripWaitingSessionModelCopyWith<_TripWaitingSessionModel> get copyWith => __$TripWaitingSessionModelCopyWithImpl<_TripWaitingSessionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripWaitingSessionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripWaitingSessionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.startedAtUtc, startedAtUtc) || other.startedAtUtc == startedAtUtc)&&(identical(other.stoppedAtUtc, stoppedAtUtc) || other.stoppedAtUtc == stoppedAtUtc)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.estimatedFee, estimatedFee) || other.estimatedFee == estimatedFee)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tripId,driverId,startedAtUtc,stoppedAtUtc,minutes,estimatedFee,isActive);

@override
String toString() {
  return 'TripWaitingSessionModel(id: $id, tripId: $tripId, driverId: $driverId, startedAtUtc: $startedAtUtc, stoppedAtUtc: $stoppedAtUtc, minutes: $minutes, estimatedFee: $estimatedFee, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$TripWaitingSessionModelCopyWith<$Res> implements $TripWaitingSessionModelCopyWith<$Res> {
  factory _$TripWaitingSessionModelCopyWith(_TripWaitingSessionModel value, $Res Function(_TripWaitingSessionModel) _then) = __$TripWaitingSessionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String tripId, String driverId, DateTime startedAtUtc, DateTime? stoppedAtUtc, int? minutes, double? estimatedFee, bool isActive
});




}
/// @nodoc
class __$TripWaitingSessionModelCopyWithImpl<$Res>
    implements _$TripWaitingSessionModelCopyWith<$Res> {
  __$TripWaitingSessionModelCopyWithImpl(this._self, this._then);

  final _TripWaitingSessionModel _self;
  final $Res Function(_TripWaitingSessionModel) _then;

/// Create a copy of TripWaitingSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tripId = null,Object? driverId = null,Object? startedAtUtc = null,Object? stoppedAtUtc = freezed,Object? minutes = freezed,Object? estimatedFee = freezed,Object? isActive = null,}) {
  return _then(_TripWaitingSessionModel(
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
mixin _$TripSummaryModel {

 String get id; String get referenceCode; String get status; double get quotedFare; String get currencyCode; DateTime get createdAtUtc; DateTime? get scheduledAtUtc; List<TripStopModel> get stops; String? get passengerNote;
/// Create a copy of TripSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripSummaryModelCopyWith<TripSummaryModel> get copyWith => _$TripSummaryModelCopyWithImpl<TripSummaryModel>(this as TripSummaryModel, _$identity);

  /// Serializes this TripSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripSummaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.referenceCode, referenceCode) || other.referenceCode == referenceCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.quotedFare, quotedFare) || other.quotedFare == quotedFare)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.scheduledAtUtc, scheduledAtUtc) || other.scheduledAtUtc == scheduledAtUtc)&&const DeepCollectionEquality().equals(other.stops, stops)&&(identical(other.passengerNote, passengerNote) || other.passengerNote == passengerNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,referenceCode,status,quotedFare,currencyCode,createdAtUtc,scheduledAtUtc,const DeepCollectionEquality().hash(stops),passengerNote);

@override
String toString() {
  return 'TripSummaryModel(id: $id, referenceCode: $referenceCode, status: $status, quotedFare: $quotedFare, currencyCode: $currencyCode, createdAtUtc: $createdAtUtc, scheduledAtUtc: $scheduledAtUtc, stops: $stops, passengerNote: $passengerNote)';
}


}

/// @nodoc
abstract mixin class $TripSummaryModelCopyWith<$Res>  {
  factory $TripSummaryModelCopyWith(TripSummaryModel value, $Res Function(TripSummaryModel) _then) = _$TripSummaryModelCopyWithImpl;
@useResult
$Res call({
 String id, String referenceCode, String status, double quotedFare, String currencyCode, DateTime createdAtUtc, DateTime? scheduledAtUtc, List<TripStopModel> stops, String? passengerNote
});




}
/// @nodoc
class _$TripSummaryModelCopyWithImpl<$Res>
    implements $TripSummaryModelCopyWith<$Res> {
  _$TripSummaryModelCopyWithImpl(this._self, this._then);

  final TripSummaryModel _self;
  final $Res Function(TripSummaryModel) _then;

/// Create a copy of TripSummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? referenceCode = null,Object? status = null,Object? quotedFare = null,Object? currencyCode = null,Object? createdAtUtc = null,Object? scheduledAtUtc = freezed,Object? stops = null,Object? passengerNote = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referenceCode: null == referenceCode ? _self.referenceCode : referenceCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,quotedFare: null == quotedFare ? _self.quotedFare : quotedFare // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledAtUtc: freezed == scheduledAtUtc ? _self.scheduledAtUtc : scheduledAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,stops: null == stops ? _self.stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripStopModel>,passengerNote: freezed == passengerNote ? _self.passengerNote : passengerNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripSummaryModel].
extension TripSummaryModelPatterns on TripSummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripSummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _TripSummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _TripSummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String referenceCode,  String status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopModel> stops,  String? passengerNote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripSummaryModel() when $default != null:
return $default(_that.id,_that.referenceCode,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops,_that.passengerNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String referenceCode,  String status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopModel> stops,  String? passengerNote)  $default,) {final _that = this;
switch (_that) {
case _TripSummaryModel():
return $default(_that.id,_that.referenceCode,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops,_that.passengerNote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String referenceCode,  String status,  double quotedFare,  String currencyCode,  DateTime createdAtUtc,  DateTime? scheduledAtUtc,  List<TripStopModel> stops,  String? passengerNote)?  $default,) {final _that = this;
switch (_that) {
case _TripSummaryModel() when $default != null:
return $default(_that.id,_that.referenceCode,_that.status,_that.quotedFare,_that.currencyCode,_that.createdAtUtc,_that.scheduledAtUtc,_that.stops,_that.passengerNote);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripSummaryModel implements TripSummaryModel {
  const _TripSummaryModel({required this.id, required this.referenceCode, required this.status, required this.quotedFare, required this.currencyCode, required this.createdAtUtc, this.scheduledAtUtc, final  List<TripStopModel> stops = const [], this.passengerNote}): _stops = stops;
  factory _TripSummaryModel.fromJson(Map<String, dynamic> json) => _$TripSummaryModelFromJson(json);

@override final  String id;
@override final  String referenceCode;
@override final  String status;
@override final  double quotedFare;
@override final  String currencyCode;
@override final  DateTime createdAtUtc;
@override final  DateTime? scheduledAtUtc;
 final  List<TripStopModel> _stops;
@override@JsonKey() List<TripStopModel> get stops {
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stops);
}

@override final  String? passengerNote;

/// Create a copy of TripSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripSummaryModelCopyWith<_TripSummaryModel> get copyWith => __$TripSummaryModelCopyWithImpl<_TripSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripSummaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.referenceCode, referenceCode) || other.referenceCode == referenceCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.quotedFare, quotedFare) || other.quotedFare == quotedFare)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.scheduledAtUtc, scheduledAtUtc) || other.scheduledAtUtc == scheduledAtUtc)&&const DeepCollectionEquality().equals(other._stops, _stops)&&(identical(other.passengerNote, passengerNote) || other.passengerNote == passengerNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,referenceCode,status,quotedFare,currencyCode,createdAtUtc,scheduledAtUtc,const DeepCollectionEquality().hash(_stops),passengerNote);

@override
String toString() {
  return 'TripSummaryModel(id: $id, referenceCode: $referenceCode, status: $status, quotedFare: $quotedFare, currencyCode: $currencyCode, createdAtUtc: $createdAtUtc, scheduledAtUtc: $scheduledAtUtc, stops: $stops, passengerNote: $passengerNote)';
}


}

/// @nodoc
abstract mixin class _$TripSummaryModelCopyWith<$Res> implements $TripSummaryModelCopyWith<$Res> {
  factory _$TripSummaryModelCopyWith(_TripSummaryModel value, $Res Function(_TripSummaryModel) _then) = __$TripSummaryModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String referenceCode, String status, double quotedFare, String currencyCode, DateTime createdAtUtc, DateTime? scheduledAtUtc, List<TripStopModel> stops, String? passengerNote
});




}
/// @nodoc
class __$TripSummaryModelCopyWithImpl<$Res>
    implements _$TripSummaryModelCopyWith<$Res> {
  __$TripSummaryModelCopyWithImpl(this._self, this._then);

  final _TripSummaryModel _self;
  final $Res Function(_TripSummaryModel) _then;

/// Create a copy of TripSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? referenceCode = null,Object? status = null,Object? quotedFare = null,Object? currencyCode = null,Object? createdAtUtc = null,Object? scheduledAtUtc = freezed,Object? stops = null,Object? passengerNote = freezed,}) {
  return _then(_TripSummaryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referenceCode: null == referenceCode ? _self.referenceCode : referenceCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,quotedFare: null == quotedFare ? _self.quotedFare : quotedFare // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledAtUtc: freezed == scheduledAtUtc ? _self.scheduledAtUtc : scheduledAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,stops: null == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripStopModel>,passengerNote: freezed == passengerNote ? _self.passengerNote : passengerNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
