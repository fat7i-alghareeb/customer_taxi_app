// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_invoice_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TripInvoiceEntity {

 String get invoiceId; String get tripId; String get invoiceNumber; DateTime get issuedAtUtc; String get currencyCode; double get grossAmount; double get netAmount; double get taxRate; double get taxAmount; String get paymentMethod; String? get paymentReference; DateTime? get paidAtUtc; String get issuerName; String get issuerAddress; String? get issuerVatNumber; String get tripReferenceCode; DateTime? get tripCompletedAtUtc; double get distanceKm; double get durationMin; String get vehicleTypeName; String? get passengerName; List<TripInvoiceStopEntity> get stops;
/// Create a copy of TripInvoiceEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripInvoiceEntityCopyWith<TripInvoiceEntity> get copyWith => _$TripInvoiceEntityCopyWithImpl<TripInvoiceEntity>(this as TripInvoiceEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripInvoiceEntity&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.invoiceNumber, invoiceNumber) || other.invoiceNumber == invoiceNumber)&&(identical(other.issuedAtUtc, issuedAtUtc) || other.issuedAtUtc == issuedAtUtc)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.grossAmount, grossAmount) || other.grossAmount == grossAmount)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentReference, paymentReference) || other.paymentReference == paymentReference)&&(identical(other.paidAtUtc, paidAtUtc) || other.paidAtUtc == paidAtUtc)&&(identical(other.issuerName, issuerName) || other.issuerName == issuerName)&&(identical(other.issuerAddress, issuerAddress) || other.issuerAddress == issuerAddress)&&(identical(other.issuerVatNumber, issuerVatNumber) || other.issuerVatNumber == issuerVatNumber)&&(identical(other.tripReferenceCode, tripReferenceCode) || other.tripReferenceCode == tripReferenceCode)&&(identical(other.tripCompletedAtUtc, tripCompletedAtUtc) || other.tripCompletedAtUtc == tripCompletedAtUtc)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.durationMin, durationMin) || other.durationMin == durationMin)&&(identical(other.vehicleTypeName, vehicleTypeName) || other.vehicleTypeName == vehicleTypeName)&&(identical(other.passengerName, passengerName) || other.passengerName == passengerName)&&const DeepCollectionEquality().equals(other.stops, stops));
}


@override
int get hashCode => Object.hashAll([runtimeType,invoiceId,tripId,invoiceNumber,issuedAtUtc,currencyCode,grossAmount,netAmount,taxRate,taxAmount,paymentMethod,paymentReference,paidAtUtc,issuerName,issuerAddress,issuerVatNumber,tripReferenceCode,tripCompletedAtUtc,distanceKm,durationMin,vehicleTypeName,passengerName,const DeepCollectionEquality().hash(stops)]);

@override
String toString() {
  return 'TripInvoiceEntity(invoiceId: $invoiceId, tripId: $tripId, invoiceNumber: $invoiceNumber, issuedAtUtc: $issuedAtUtc, currencyCode: $currencyCode, grossAmount: $grossAmount, netAmount: $netAmount, taxRate: $taxRate, taxAmount: $taxAmount, paymentMethod: $paymentMethod, paymentReference: $paymentReference, paidAtUtc: $paidAtUtc, issuerName: $issuerName, issuerAddress: $issuerAddress, issuerVatNumber: $issuerVatNumber, tripReferenceCode: $tripReferenceCode, tripCompletedAtUtc: $tripCompletedAtUtc, distanceKm: $distanceKm, durationMin: $durationMin, vehicleTypeName: $vehicleTypeName, passengerName: $passengerName, stops: $stops)';
}


}

/// @nodoc
abstract mixin class $TripInvoiceEntityCopyWith<$Res>  {
  factory $TripInvoiceEntityCopyWith(TripInvoiceEntity value, $Res Function(TripInvoiceEntity) _then) = _$TripInvoiceEntityCopyWithImpl;
@useResult
$Res call({
 String invoiceId, String tripId, String invoiceNumber, DateTime issuedAtUtc, String currencyCode, double grossAmount, double netAmount, double taxRate, double taxAmount, String paymentMethod, String? paymentReference, DateTime? paidAtUtc, String issuerName, String issuerAddress, String? issuerVatNumber, String tripReferenceCode, DateTime? tripCompletedAtUtc, double distanceKm, double durationMin, String vehicleTypeName, String? passengerName, List<TripInvoiceStopEntity> stops
});




}
/// @nodoc
class _$TripInvoiceEntityCopyWithImpl<$Res>
    implements $TripInvoiceEntityCopyWith<$Res> {
  _$TripInvoiceEntityCopyWithImpl(this._self, this._then);

  final TripInvoiceEntity _self;
  final $Res Function(TripInvoiceEntity) _then;

/// Create a copy of TripInvoiceEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? invoiceId = null,Object? tripId = null,Object? invoiceNumber = null,Object? issuedAtUtc = null,Object? currencyCode = null,Object? grossAmount = null,Object? netAmount = null,Object? taxRate = null,Object? taxAmount = null,Object? paymentMethod = null,Object? paymentReference = freezed,Object? paidAtUtc = freezed,Object? issuerName = null,Object? issuerAddress = null,Object? issuerVatNumber = freezed,Object? tripReferenceCode = null,Object? tripCompletedAtUtc = freezed,Object? distanceKm = null,Object? durationMin = null,Object? vehicleTypeName = null,Object? passengerName = freezed,Object? stops = null,}) {
  return _then(_self.copyWith(
invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,invoiceNumber: null == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String,issuedAtUtc: null == issuedAtUtc ? _self.issuedAtUtc : issuedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,grossAmount: null == grossAmount ? _self.grossAmount : grossAmount // ignore: cast_nullable_to_non_nullable
as double,netAmount: null == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as double,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,taxAmount: null == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,paymentReference: freezed == paymentReference ? _self.paymentReference : paymentReference // ignore: cast_nullable_to_non_nullable
as String?,paidAtUtc: freezed == paidAtUtc ? _self.paidAtUtc : paidAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,issuerName: null == issuerName ? _self.issuerName : issuerName // ignore: cast_nullable_to_non_nullable
as String,issuerAddress: null == issuerAddress ? _self.issuerAddress : issuerAddress // ignore: cast_nullable_to_non_nullable
as String,issuerVatNumber: freezed == issuerVatNumber ? _self.issuerVatNumber : issuerVatNumber // ignore: cast_nullable_to_non_nullable
as String?,tripReferenceCode: null == tripReferenceCode ? _self.tripReferenceCode : tripReferenceCode // ignore: cast_nullable_to_non_nullable
as String,tripCompletedAtUtc: freezed == tripCompletedAtUtc ? _self.tripCompletedAtUtc : tripCompletedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,durationMin: null == durationMin ? _self.durationMin : durationMin // ignore: cast_nullable_to_non_nullable
as double,vehicleTypeName: null == vehicleTypeName ? _self.vehicleTypeName : vehicleTypeName // ignore: cast_nullable_to_non_nullable
as String,passengerName: freezed == passengerName ? _self.passengerName : passengerName // ignore: cast_nullable_to_non_nullable
as String?,stops: null == stops ? _self.stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripInvoiceStopEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [TripInvoiceEntity].
extension TripInvoiceEntityPatterns on TripInvoiceEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripInvoiceEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripInvoiceEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripInvoiceEntity value)  $default,){
final _that = this;
switch (_that) {
case _TripInvoiceEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripInvoiceEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TripInvoiceEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String invoiceId,  String tripId,  String invoiceNumber,  DateTime issuedAtUtc,  String currencyCode,  double grossAmount,  double netAmount,  double taxRate,  double taxAmount,  String paymentMethod,  String? paymentReference,  DateTime? paidAtUtc,  String issuerName,  String issuerAddress,  String? issuerVatNumber,  String tripReferenceCode,  DateTime? tripCompletedAtUtc,  double distanceKm,  double durationMin,  String vehicleTypeName,  String? passengerName,  List<TripInvoiceStopEntity> stops)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripInvoiceEntity() when $default != null:
return $default(_that.invoiceId,_that.tripId,_that.invoiceNumber,_that.issuedAtUtc,_that.currencyCode,_that.grossAmount,_that.netAmount,_that.taxRate,_that.taxAmount,_that.paymentMethod,_that.paymentReference,_that.paidAtUtc,_that.issuerName,_that.issuerAddress,_that.issuerVatNumber,_that.tripReferenceCode,_that.tripCompletedAtUtc,_that.distanceKm,_that.durationMin,_that.vehicleTypeName,_that.passengerName,_that.stops);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String invoiceId,  String tripId,  String invoiceNumber,  DateTime issuedAtUtc,  String currencyCode,  double grossAmount,  double netAmount,  double taxRate,  double taxAmount,  String paymentMethod,  String? paymentReference,  DateTime? paidAtUtc,  String issuerName,  String issuerAddress,  String? issuerVatNumber,  String tripReferenceCode,  DateTime? tripCompletedAtUtc,  double distanceKm,  double durationMin,  String vehicleTypeName,  String? passengerName,  List<TripInvoiceStopEntity> stops)  $default,) {final _that = this;
switch (_that) {
case _TripInvoiceEntity():
return $default(_that.invoiceId,_that.tripId,_that.invoiceNumber,_that.issuedAtUtc,_that.currencyCode,_that.grossAmount,_that.netAmount,_that.taxRate,_that.taxAmount,_that.paymentMethod,_that.paymentReference,_that.paidAtUtc,_that.issuerName,_that.issuerAddress,_that.issuerVatNumber,_that.tripReferenceCode,_that.tripCompletedAtUtc,_that.distanceKm,_that.durationMin,_that.vehicleTypeName,_that.passengerName,_that.stops);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String invoiceId,  String tripId,  String invoiceNumber,  DateTime issuedAtUtc,  String currencyCode,  double grossAmount,  double netAmount,  double taxRate,  double taxAmount,  String paymentMethod,  String? paymentReference,  DateTime? paidAtUtc,  String issuerName,  String issuerAddress,  String? issuerVatNumber,  String tripReferenceCode,  DateTime? tripCompletedAtUtc,  double distanceKm,  double durationMin,  String vehicleTypeName,  String? passengerName,  List<TripInvoiceStopEntity> stops)?  $default,) {final _that = this;
switch (_that) {
case _TripInvoiceEntity() when $default != null:
return $default(_that.invoiceId,_that.tripId,_that.invoiceNumber,_that.issuedAtUtc,_that.currencyCode,_that.grossAmount,_that.netAmount,_that.taxRate,_that.taxAmount,_that.paymentMethod,_that.paymentReference,_that.paidAtUtc,_that.issuerName,_that.issuerAddress,_that.issuerVatNumber,_that.tripReferenceCode,_that.tripCompletedAtUtc,_that.distanceKm,_that.durationMin,_that.vehicleTypeName,_that.passengerName,_that.stops);case _:
  return null;

}
}

}

/// @nodoc


class _TripInvoiceEntity implements TripInvoiceEntity {
  const _TripInvoiceEntity({required this.invoiceId, required this.tripId, required this.invoiceNumber, required this.issuedAtUtc, required this.currencyCode, required this.grossAmount, required this.netAmount, required this.taxRate, required this.taxAmount, required this.paymentMethod, this.paymentReference, this.paidAtUtc, required this.issuerName, required this.issuerAddress, this.issuerVatNumber, required this.tripReferenceCode, this.tripCompletedAtUtc, required this.distanceKm, required this.durationMin, required this.vehicleTypeName, this.passengerName, final  List<TripInvoiceStopEntity> stops = const []}): _stops = stops;
  

@override final  String invoiceId;
@override final  String tripId;
@override final  String invoiceNumber;
@override final  DateTime issuedAtUtc;
@override final  String currencyCode;
@override final  double grossAmount;
@override final  double netAmount;
@override final  double taxRate;
@override final  double taxAmount;
@override final  String paymentMethod;
@override final  String? paymentReference;
@override final  DateTime? paidAtUtc;
@override final  String issuerName;
@override final  String issuerAddress;
@override final  String? issuerVatNumber;
@override final  String tripReferenceCode;
@override final  DateTime? tripCompletedAtUtc;
@override final  double distanceKm;
@override final  double durationMin;
@override final  String vehicleTypeName;
@override final  String? passengerName;
 final  List<TripInvoiceStopEntity> _stops;
@override@JsonKey() List<TripInvoiceStopEntity> get stops {
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stops);
}


/// Create a copy of TripInvoiceEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripInvoiceEntityCopyWith<_TripInvoiceEntity> get copyWith => __$TripInvoiceEntityCopyWithImpl<_TripInvoiceEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripInvoiceEntity&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.invoiceNumber, invoiceNumber) || other.invoiceNumber == invoiceNumber)&&(identical(other.issuedAtUtc, issuedAtUtc) || other.issuedAtUtc == issuedAtUtc)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.grossAmount, grossAmount) || other.grossAmount == grossAmount)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentReference, paymentReference) || other.paymentReference == paymentReference)&&(identical(other.paidAtUtc, paidAtUtc) || other.paidAtUtc == paidAtUtc)&&(identical(other.issuerName, issuerName) || other.issuerName == issuerName)&&(identical(other.issuerAddress, issuerAddress) || other.issuerAddress == issuerAddress)&&(identical(other.issuerVatNumber, issuerVatNumber) || other.issuerVatNumber == issuerVatNumber)&&(identical(other.tripReferenceCode, tripReferenceCode) || other.tripReferenceCode == tripReferenceCode)&&(identical(other.tripCompletedAtUtc, tripCompletedAtUtc) || other.tripCompletedAtUtc == tripCompletedAtUtc)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.durationMin, durationMin) || other.durationMin == durationMin)&&(identical(other.vehicleTypeName, vehicleTypeName) || other.vehicleTypeName == vehicleTypeName)&&(identical(other.passengerName, passengerName) || other.passengerName == passengerName)&&const DeepCollectionEquality().equals(other._stops, _stops));
}


@override
int get hashCode => Object.hashAll([runtimeType,invoiceId,tripId,invoiceNumber,issuedAtUtc,currencyCode,grossAmount,netAmount,taxRate,taxAmount,paymentMethod,paymentReference,paidAtUtc,issuerName,issuerAddress,issuerVatNumber,tripReferenceCode,tripCompletedAtUtc,distanceKm,durationMin,vehicleTypeName,passengerName,const DeepCollectionEquality().hash(_stops)]);

@override
String toString() {
  return 'TripInvoiceEntity(invoiceId: $invoiceId, tripId: $tripId, invoiceNumber: $invoiceNumber, issuedAtUtc: $issuedAtUtc, currencyCode: $currencyCode, grossAmount: $grossAmount, netAmount: $netAmount, taxRate: $taxRate, taxAmount: $taxAmount, paymentMethod: $paymentMethod, paymentReference: $paymentReference, paidAtUtc: $paidAtUtc, issuerName: $issuerName, issuerAddress: $issuerAddress, issuerVatNumber: $issuerVatNumber, tripReferenceCode: $tripReferenceCode, tripCompletedAtUtc: $tripCompletedAtUtc, distanceKm: $distanceKm, durationMin: $durationMin, vehicleTypeName: $vehicleTypeName, passengerName: $passengerName, stops: $stops)';
}


}

/// @nodoc
abstract mixin class _$TripInvoiceEntityCopyWith<$Res> implements $TripInvoiceEntityCopyWith<$Res> {
  factory _$TripInvoiceEntityCopyWith(_TripInvoiceEntity value, $Res Function(_TripInvoiceEntity) _then) = __$TripInvoiceEntityCopyWithImpl;
@override @useResult
$Res call({
 String invoiceId, String tripId, String invoiceNumber, DateTime issuedAtUtc, String currencyCode, double grossAmount, double netAmount, double taxRate, double taxAmount, String paymentMethod, String? paymentReference, DateTime? paidAtUtc, String issuerName, String issuerAddress, String? issuerVatNumber, String tripReferenceCode, DateTime? tripCompletedAtUtc, double distanceKm, double durationMin, String vehicleTypeName, String? passengerName, List<TripInvoiceStopEntity> stops
});




}
/// @nodoc
class __$TripInvoiceEntityCopyWithImpl<$Res>
    implements _$TripInvoiceEntityCopyWith<$Res> {
  __$TripInvoiceEntityCopyWithImpl(this._self, this._then);

  final _TripInvoiceEntity _self;
  final $Res Function(_TripInvoiceEntity) _then;

/// Create a copy of TripInvoiceEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? invoiceId = null,Object? tripId = null,Object? invoiceNumber = null,Object? issuedAtUtc = null,Object? currencyCode = null,Object? grossAmount = null,Object? netAmount = null,Object? taxRate = null,Object? taxAmount = null,Object? paymentMethod = null,Object? paymentReference = freezed,Object? paidAtUtc = freezed,Object? issuerName = null,Object? issuerAddress = null,Object? issuerVatNumber = freezed,Object? tripReferenceCode = null,Object? tripCompletedAtUtc = freezed,Object? distanceKm = null,Object? durationMin = null,Object? vehicleTypeName = null,Object? passengerName = freezed,Object? stops = null,}) {
  return _then(_TripInvoiceEntity(
invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,invoiceNumber: null == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String,issuedAtUtc: null == issuedAtUtc ? _self.issuedAtUtc : issuedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,grossAmount: null == grossAmount ? _self.grossAmount : grossAmount // ignore: cast_nullable_to_non_nullable
as double,netAmount: null == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as double,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,taxAmount: null == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,paymentReference: freezed == paymentReference ? _self.paymentReference : paymentReference // ignore: cast_nullable_to_non_nullable
as String?,paidAtUtc: freezed == paidAtUtc ? _self.paidAtUtc : paidAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,issuerName: null == issuerName ? _self.issuerName : issuerName // ignore: cast_nullable_to_non_nullable
as String,issuerAddress: null == issuerAddress ? _self.issuerAddress : issuerAddress // ignore: cast_nullable_to_non_nullable
as String,issuerVatNumber: freezed == issuerVatNumber ? _self.issuerVatNumber : issuerVatNumber // ignore: cast_nullable_to_non_nullable
as String?,tripReferenceCode: null == tripReferenceCode ? _self.tripReferenceCode : tripReferenceCode // ignore: cast_nullable_to_non_nullable
as String,tripCompletedAtUtc: freezed == tripCompletedAtUtc ? _self.tripCompletedAtUtc : tripCompletedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,durationMin: null == durationMin ? _self.durationMin : durationMin // ignore: cast_nullable_to_non_nullable
as double,vehicleTypeName: null == vehicleTypeName ? _self.vehicleTypeName : vehicleTypeName // ignore: cast_nullable_to_non_nullable
as String,passengerName: freezed == passengerName ? _self.passengerName : passengerName // ignore: cast_nullable_to_non_nullable
as String?,stops: null == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripInvoiceStopEntity>,
  ));
}


}

/// @nodoc
mixin _$TripInvoiceStopEntity {

 int get sequence; String? get label; DateTime? get completedAtUtc;
/// Create a copy of TripInvoiceStopEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripInvoiceStopEntityCopyWith<TripInvoiceStopEntity> get copyWith => _$TripInvoiceStopEntityCopyWithImpl<TripInvoiceStopEntity>(this as TripInvoiceStopEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripInvoiceStopEntity&&(identical(other.sequence, sequence) || other.sequence == sequence)&&(identical(other.label, label) || other.label == label)&&(identical(other.completedAtUtc, completedAtUtc) || other.completedAtUtc == completedAtUtc));
}


@override
int get hashCode => Object.hash(runtimeType,sequence,label,completedAtUtc);

@override
String toString() {
  return 'TripInvoiceStopEntity(sequence: $sequence, label: $label, completedAtUtc: $completedAtUtc)';
}


}

/// @nodoc
abstract mixin class $TripInvoiceStopEntityCopyWith<$Res>  {
  factory $TripInvoiceStopEntityCopyWith(TripInvoiceStopEntity value, $Res Function(TripInvoiceStopEntity) _then) = _$TripInvoiceStopEntityCopyWithImpl;
@useResult
$Res call({
 int sequence, String? label, DateTime? completedAtUtc
});




}
/// @nodoc
class _$TripInvoiceStopEntityCopyWithImpl<$Res>
    implements $TripInvoiceStopEntityCopyWith<$Res> {
  _$TripInvoiceStopEntityCopyWithImpl(this._self, this._then);

  final TripInvoiceStopEntity _self;
  final $Res Function(TripInvoiceStopEntity) _then;

/// Create a copy of TripInvoiceStopEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sequence = null,Object? label = freezed,Object? completedAtUtc = freezed,}) {
  return _then(_self.copyWith(
sequence: null == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as int,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,completedAtUtc: freezed == completedAtUtc ? _self.completedAtUtc : completedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripInvoiceStopEntity].
extension TripInvoiceStopEntityPatterns on TripInvoiceStopEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripInvoiceStopEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripInvoiceStopEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripInvoiceStopEntity value)  $default,){
final _that = this;
switch (_that) {
case _TripInvoiceStopEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripInvoiceStopEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TripInvoiceStopEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sequence,  String? label,  DateTime? completedAtUtc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripInvoiceStopEntity() when $default != null:
return $default(_that.sequence,_that.label,_that.completedAtUtc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sequence,  String? label,  DateTime? completedAtUtc)  $default,) {final _that = this;
switch (_that) {
case _TripInvoiceStopEntity():
return $default(_that.sequence,_that.label,_that.completedAtUtc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sequence,  String? label,  DateTime? completedAtUtc)?  $default,) {final _that = this;
switch (_that) {
case _TripInvoiceStopEntity() when $default != null:
return $default(_that.sequence,_that.label,_that.completedAtUtc);case _:
  return null;

}
}

}

/// @nodoc


class _TripInvoiceStopEntity implements TripInvoiceStopEntity {
  const _TripInvoiceStopEntity({this.sequence = 0, this.label, this.completedAtUtc});
  

@override@JsonKey() final  int sequence;
@override final  String? label;
@override final  DateTime? completedAtUtc;

/// Create a copy of TripInvoiceStopEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripInvoiceStopEntityCopyWith<_TripInvoiceStopEntity> get copyWith => __$TripInvoiceStopEntityCopyWithImpl<_TripInvoiceStopEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripInvoiceStopEntity&&(identical(other.sequence, sequence) || other.sequence == sequence)&&(identical(other.label, label) || other.label == label)&&(identical(other.completedAtUtc, completedAtUtc) || other.completedAtUtc == completedAtUtc));
}


@override
int get hashCode => Object.hash(runtimeType,sequence,label,completedAtUtc);

@override
String toString() {
  return 'TripInvoiceStopEntity(sequence: $sequence, label: $label, completedAtUtc: $completedAtUtc)';
}


}

/// @nodoc
abstract mixin class _$TripInvoiceStopEntityCopyWith<$Res> implements $TripInvoiceStopEntityCopyWith<$Res> {
  factory _$TripInvoiceStopEntityCopyWith(_TripInvoiceStopEntity value, $Res Function(_TripInvoiceStopEntity) _then) = __$TripInvoiceStopEntityCopyWithImpl;
@override @useResult
$Res call({
 int sequence, String? label, DateTime? completedAtUtc
});




}
/// @nodoc
class __$TripInvoiceStopEntityCopyWithImpl<$Res>
    implements _$TripInvoiceStopEntityCopyWith<$Res> {
  __$TripInvoiceStopEntityCopyWithImpl(this._self, this._then);

  final _TripInvoiceStopEntity _self;
  final $Res Function(_TripInvoiceStopEntity) _then;

/// Create a copy of TripInvoiceStopEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sequence = null,Object? label = freezed,Object? completedAtUtc = freezed,}) {
  return _then(_TripInvoiceStopEntity(
sequence: null == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as int,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,completedAtUtc: freezed == completedAtUtc ? _self.completedAtUtc : completedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
