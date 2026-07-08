// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_receipt_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripReceiptModel {

 String get tripId; String get referenceCode; String get status; double get grossAmount; double get netAmount; double get taxAmount; String get currencyCode; String get paymentMethod; String? get paymentReference; DateTime? get paidAtUtc; DateTime? get completedAtUtc; double get distanceKm; double get durationMin; String get vehicleTypeName; String? get passengerName; String get issuerName; bool get invoiceAvailable; String? get invoiceNumber; DateTime? get invoiceIssuedAtUtc; List<TripStopModel> get stops; double get waitingFeeAmount; double get walletPaidAmount; double get cardPaidAmount; double get totalPaidAmount; double get unpaidAmount; double get refundedAmount;
/// Create a copy of TripReceiptModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripReceiptModelCopyWith<TripReceiptModel> get copyWith => _$TripReceiptModelCopyWithImpl<TripReceiptModel>(this as TripReceiptModel, _$identity);

  /// Serializes this TripReceiptModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripReceiptModel&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.referenceCode, referenceCode) || other.referenceCode == referenceCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.grossAmount, grossAmount) || other.grossAmount == grossAmount)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentReference, paymentReference) || other.paymentReference == paymentReference)&&(identical(other.paidAtUtc, paidAtUtc) || other.paidAtUtc == paidAtUtc)&&(identical(other.completedAtUtc, completedAtUtc) || other.completedAtUtc == completedAtUtc)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.durationMin, durationMin) || other.durationMin == durationMin)&&(identical(other.vehicleTypeName, vehicleTypeName) || other.vehicleTypeName == vehicleTypeName)&&(identical(other.passengerName, passengerName) || other.passengerName == passengerName)&&(identical(other.issuerName, issuerName) || other.issuerName == issuerName)&&(identical(other.invoiceAvailable, invoiceAvailable) || other.invoiceAvailable == invoiceAvailable)&&(identical(other.invoiceNumber, invoiceNumber) || other.invoiceNumber == invoiceNumber)&&(identical(other.invoiceIssuedAtUtc, invoiceIssuedAtUtc) || other.invoiceIssuedAtUtc == invoiceIssuedAtUtc)&&const DeepCollectionEquality().equals(other.stops, stops)&&(identical(other.waitingFeeAmount, waitingFeeAmount) || other.waitingFeeAmount == waitingFeeAmount)&&(identical(other.walletPaidAmount, walletPaidAmount) || other.walletPaidAmount == walletPaidAmount)&&(identical(other.cardPaidAmount, cardPaidAmount) || other.cardPaidAmount == cardPaidAmount)&&(identical(other.totalPaidAmount, totalPaidAmount) || other.totalPaidAmount == totalPaidAmount)&&(identical(other.unpaidAmount, unpaidAmount) || other.unpaidAmount == unpaidAmount)&&(identical(other.refundedAmount, refundedAmount) || other.refundedAmount == refundedAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,tripId,referenceCode,status,grossAmount,netAmount,taxAmount,currencyCode,paymentMethod,paymentReference,paidAtUtc,completedAtUtc,distanceKm,durationMin,vehicleTypeName,passengerName,issuerName,invoiceAvailable,invoiceNumber,invoiceIssuedAtUtc,const DeepCollectionEquality().hash(stops),waitingFeeAmount,walletPaidAmount,cardPaidAmount,totalPaidAmount,unpaidAmount,refundedAmount]);

@override
String toString() {
  return 'TripReceiptModel(tripId: $tripId, referenceCode: $referenceCode, status: $status, grossAmount: $grossAmount, netAmount: $netAmount, taxAmount: $taxAmount, currencyCode: $currencyCode, paymentMethod: $paymentMethod, paymentReference: $paymentReference, paidAtUtc: $paidAtUtc, completedAtUtc: $completedAtUtc, distanceKm: $distanceKm, durationMin: $durationMin, vehicleTypeName: $vehicleTypeName, passengerName: $passengerName, issuerName: $issuerName, invoiceAvailable: $invoiceAvailable, invoiceNumber: $invoiceNumber, invoiceIssuedAtUtc: $invoiceIssuedAtUtc, stops: $stops, waitingFeeAmount: $waitingFeeAmount, walletPaidAmount: $walletPaidAmount, cardPaidAmount: $cardPaidAmount, totalPaidAmount: $totalPaidAmount, unpaidAmount: $unpaidAmount, refundedAmount: $refundedAmount)';
}


}

/// @nodoc
abstract mixin class $TripReceiptModelCopyWith<$Res>  {
  factory $TripReceiptModelCopyWith(TripReceiptModel value, $Res Function(TripReceiptModel) _then) = _$TripReceiptModelCopyWithImpl;
@useResult
$Res call({
 String tripId, String referenceCode, String status, double grossAmount, double netAmount, double taxAmount, String currencyCode, String paymentMethod, String? paymentReference, DateTime? paidAtUtc, DateTime? completedAtUtc, double distanceKm, double durationMin, String vehicleTypeName, String? passengerName, String issuerName, bool invoiceAvailable, String? invoiceNumber, DateTime? invoiceIssuedAtUtc, List<TripStopModel> stops, double waitingFeeAmount, double walletPaidAmount, double cardPaidAmount, double totalPaidAmount, double unpaidAmount, double refundedAmount
});




}
/// @nodoc
class _$TripReceiptModelCopyWithImpl<$Res>
    implements $TripReceiptModelCopyWith<$Res> {
  _$TripReceiptModelCopyWithImpl(this._self, this._then);

  final TripReceiptModel _self;
  final $Res Function(TripReceiptModel) _then;

/// Create a copy of TripReceiptModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,Object? referenceCode = null,Object? status = null,Object? grossAmount = null,Object? netAmount = null,Object? taxAmount = null,Object? currencyCode = null,Object? paymentMethod = null,Object? paymentReference = freezed,Object? paidAtUtc = freezed,Object? completedAtUtc = freezed,Object? distanceKm = null,Object? durationMin = null,Object? vehicleTypeName = null,Object? passengerName = freezed,Object? issuerName = null,Object? invoiceAvailable = null,Object? invoiceNumber = freezed,Object? invoiceIssuedAtUtc = freezed,Object? stops = null,Object? waitingFeeAmount = null,Object? walletPaidAmount = null,Object? cardPaidAmount = null,Object? totalPaidAmount = null,Object? unpaidAmount = null,Object? refundedAmount = null,}) {
  return _then(_self.copyWith(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,referenceCode: null == referenceCode ? _self.referenceCode : referenceCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,grossAmount: null == grossAmount ? _self.grossAmount : grossAmount // ignore: cast_nullable_to_non_nullable
as double,netAmount: null == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as double,taxAmount: null == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,paymentReference: freezed == paymentReference ? _self.paymentReference : paymentReference // ignore: cast_nullable_to_non_nullable
as String?,paidAtUtc: freezed == paidAtUtc ? _self.paidAtUtc : paidAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAtUtc: freezed == completedAtUtc ? _self.completedAtUtc : completedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,durationMin: null == durationMin ? _self.durationMin : durationMin // ignore: cast_nullable_to_non_nullable
as double,vehicleTypeName: null == vehicleTypeName ? _self.vehicleTypeName : vehicleTypeName // ignore: cast_nullable_to_non_nullable
as String,passengerName: freezed == passengerName ? _self.passengerName : passengerName // ignore: cast_nullable_to_non_nullable
as String?,issuerName: null == issuerName ? _self.issuerName : issuerName // ignore: cast_nullable_to_non_nullable
as String,invoiceAvailable: null == invoiceAvailable ? _self.invoiceAvailable : invoiceAvailable // ignore: cast_nullable_to_non_nullable
as bool,invoiceNumber: freezed == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String?,invoiceIssuedAtUtc: freezed == invoiceIssuedAtUtc ? _self.invoiceIssuedAtUtc : invoiceIssuedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,stops: null == stops ? _self.stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripStopModel>,waitingFeeAmount: null == waitingFeeAmount ? _self.waitingFeeAmount : waitingFeeAmount // ignore: cast_nullable_to_non_nullable
as double,walletPaidAmount: null == walletPaidAmount ? _self.walletPaidAmount : walletPaidAmount // ignore: cast_nullable_to_non_nullable
as double,cardPaidAmount: null == cardPaidAmount ? _self.cardPaidAmount : cardPaidAmount // ignore: cast_nullable_to_non_nullable
as double,totalPaidAmount: null == totalPaidAmount ? _self.totalPaidAmount : totalPaidAmount // ignore: cast_nullable_to_non_nullable
as double,unpaidAmount: null == unpaidAmount ? _self.unpaidAmount : unpaidAmount // ignore: cast_nullable_to_non_nullable
as double,refundedAmount: null == refundedAmount ? _self.refundedAmount : refundedAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TripReceiptModel].
extension TripReceiptModelPatterns on TripReceiptModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripReceiptModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripReceiptModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripReceiptModel value)  $default,){
final _that = this;
switch (_that) {
case _TripReceiptModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripReceiptModel value)?  $default,){
final _that = this;
switch (_that) {
case _TripReceiptModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripId,  String referenceCode,  String status,  double grossAmount,  double netAmount,  double taxAmount,  String currencyCode,  String paymentMethod,  String? paymentReference,  DateTime? paidAtUtc,  DateTime? completedAtUtc,  double distanceKm,  double durationMin,  String vehicleTypeName,  String? passengerName,  String issuerName,  bool invoiceAvailable,  String? invoiceNumber,  DateTime? invoiceIssuedAtUtc,  List<TripStopModel> stops,  double waitingFeeAmount,  double walletPaidAmount,  double cardPaidAmount,  double totalPaidAmount,  double unpaidAmount,  double refundedAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripReceiptModel() when $default != null:
return $default(_that.tripId,_that.referenceCode,_that.status,_that.grossAmount,_that.netAmount,_that.taxAmount,_that.currencyCode,_that.paymentMethod,_that.paymentReference,_that.paidAtUtc,_that.completedAtUtc,_that.distanceKm,_that.durationMin,_that.vehicleTypeName,_that.passengerName,_that.issuerName,_that.invoiceAvailable,_that.invoiceNumber,_that.invoiceIssuedAtUtc,_that.stops,_that.waitingFeeAmount,_that.walletPaidAmount,_that.cardPaidAmount,_that.totalPaidAmount,_that.unpaidAmount,_that.refundedAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripId,  String referenceCode,  String status,  double grossAmount,  double netAmount,  double taxAmount,  String currencyCode,  String paymentMethod,  String? paymentReference,  DateTime? paidAtUtc,  DateTime? completedAtUtc,  double distanceKm,  double durationMin,  String vehicleTypeName,  String? passengerName,  String issuerName,  bool invoiceAvailable,  String? invoiceNumber,  DateTime? invoiceIssuedAtUtc,  List<TripStopModel> stops,  double waitingFeeAmount,  double walletPaidAmount,  double cardPaidAmount,  double totalPaidAmount,  double unpaidAmount,  double refundedAmount)  $default,) {final _that = this;
switch (_that) {
case _TripReceiptModel():
return $default(_that.tripId,_that.referenceCode,_that.status,_that.grossAmount,_that.netAmount,_that.taxAmount,_that.currencyCode,_that.paymentMethod,_that.paymentReference,_that.paidAtUtc,_that.completedAtUtc,_that.distanceKm,_that.durationMin,_that.vehicleTypeName,_that.passengerName,_that.issuerName,_that.invoiceAvailable,_that.invoiceNumber,_that.invoiceIssuedAtUtc,_that.stops,_that.waitingFeeAmount,_that.walletPaidAmount,_that.cardPaidAmount,_that.totalPaidAmount,_that.unpaidAmount,_that.refundedAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripId,  String referenceCode,  String status,  double grossAmount,  double netAmount,  double taxAmount,  String currencyCode,  String paymentMethod,  String? paymentReference,  DateTime? paidAtUtc,  DateTime? completedAtUtc,  double distanceKm,  double durationMin,  String vehicleTypeName,  String? passengerName,  String issuerName,  bool invoiceAvailable,  String? invoiceNumber,  DateTime? invoiceIssuedAtUtc,  List<TripStopModel> stops,  double waitingFeeAmount,  double walletPaidAmount,  double cardPaidAmount,  double totalPaidAmount,  double unpaidAmount,  double refundedAmount)?  $default,) {final _that = this;
switch (_that) {
case _TripReceiptModel() when $default != null:
return $default(_that.tripId,_that.referenceCode,_that.status,_that.grossAmount,_that.netAmount,_that.taxAmount,_that.currencyCode,_that.paymentMethod,_that.paymentReference,_that.paidAtUtc,_that.completedAtUtc,_that.distanceKm,_that.durationMin,_that.vehicleTypeName,_that.passengerName,_that.issuerName,_that.invoiceAvailable,_that.invoiceNumber,_that.invoiceIssuedAtUtc,_that.stops,_that.waitingFeeAmount,_that.walletPaidAmount,_that.cardPaidAmount,_that.totalPaidAmount,_that.unpaidAmount,_that.refundedAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripReceiptModel implements TripReceiptModel {
  const _TripReceiptModel({required this.tripId, required this.referenceCode, required this.status, required this.grossAmount, required this.netAmount, required this.taxAmount, required this.currencyCode, required this.paymentMethod, this.paymentReference, this.paidAtUtc, this.completedAtUtc, required this.distanceKm, required this.durationMin, required this.vehicleTypeName, this.passengerName, required this.issuerName, required this.invoiceAvailable, this.invoiceNumber, this.invoiceIssuedAtUtc, final  List<TripStopModel> stops = const [], this.waitingFeeAmount = 0, this.walletPaidAmount = 0, this.cardPaidAmount = 0, this.totalPaidAmount = 0, this.unpaidAmount = 0, this.refundedAmount = 0}): _stops = stops;
  factory _TripReceiptModel.fromJson(Map<String, dynamic> json) => _$TripReceiptModelFromJson(json);

@override final  String tripId;
@override final  String referenceCode;
@override final  String status;
@override final  double grossAmount;
@override final  double netAmount;
@override final  double taxAmount;
@override final  String currencyCode;
@override final  String paymentMethod;
@override final  String? paymentReference;
@override final  DateTime? paidAtUtc;
@override final  DateTime? completedAtUtc;
@override final  double distanceKm;
@override final  double durationMin;
@override final  String vehicleTypeName;
@override final  String? passengerName;
@override final  String issuerName;
@override final  bool invoiceAvailable;
@override final  String? invoiceNumber;
@override final  DateTime? invoiceIssuedAtUtc;
 final  List<TripStopModel> _stops;
@override@JsonKey() List<TripStopModel> get stops {
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stops);
}

@override@JsonKey() final  double waitingFeeAmount;
@override@JsonKey() final  double walletPaidAmount;
@override@JsonKey() final  double cardPaidAmount;
@override@JsonKey() final  double totalPaidAmount;
@override@JsonKey() final  double unpaidAmount;
@override@JsonKey() final  double refundedAmount;

/// Create a copy of TripReceiptModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripReceiptModelCopyWith<_TripReceiptModel> get copyWith => __$TripReceiptModelCopyWithImpl<_TripReceiptModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripReceiptModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripReceiptModel&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.referenceCode, referenceCode) || other.referenceCode == referenceCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.grossAmount, grossAmount) || other.grossAmount == grossAmount)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentReference, paymentReference) || other.paymentReference == paymentReference)&&(identical(other.paidAtUtc, paidAtUtc) || other.paidAtUtc == paidAtUtc)&&(identical(other.completedAtUtc, completedAtUtc) || other.completedAtUtc == completedAtUtc)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.durationMin, durationMin) || other.durationMin == durationMin)&&(identical(other.vehicleTypeName, vehicleTypeName) || other.vehicleTypeName == vehicleTypeName)&&(identical(other.passengerName, passengerName) || other.passengerName == passengerName)&&(identical(other.issuerName, issuerName) || other.issuerName == issuerName)&&(identical(other.invoiceAvailable, invoiceAvailable) || other.invoiceAvailable == invoiceAvailable)&&(identical(other.invoiceNumber, invoiceNumber) || other.invoiceNumber == invoiceNumber)&&(identical(other.invoiceIssuedAtUtc, invoiceIssuedAtUtc) || other.invoiceIssuedAtUtc == invoiceIssuedAtUtc)&&const DeepCollectionEquality().equals(other._stops, _stops)&&(identical(other.waitingFeeAmount, waitingFeeAmount) || other.waitingFeeAmount == waitingFeeAmount)&&(identical(other.walletPaidAmount, walletPaidAmount) || other.walletPaidAmount == walletPaidAmount)&&(identical(other.cardPaidAmount, cardPaidAmount) || other.cardPaidAmount == cardPaidAmount)&&(identical(other.totalPaidAmount, totalPaidAmount) || other.totalPaidAmount == totalPaidAmount)&&(identical(other.unpaidAmount, unpaidAmount) || other.unpaidAmount == unpaidAmount)&&(identical(other.refundedAmount, refundedAmount) || other.refundedAmount == refundedAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,tripId,referenceCode,status,grossAmount,netAmount,taxAmount,currencyCode,paymentMethod,paymentReference,paidAtUtc,completedAtUtc,distanceKm,durationMin,vehicleTypeName,passengerName,issuerName,invoiceAvailable,invoiceNumber,invoiceIssuedAtUtc,const DeepCollectionEquality().hash(_stops),waitingFeeAmount,walletPaidAmount,cardPaidAmount,totalPaidAmount,unpaidAmount,refundedAmount]);

@override
String toString() {
  return 'TripReceiptModel(tripId: $tripId, referenceCode: $referenceCode, status: $status, grossAmount: $grossAmount, netAmount: $netAmount, taxAmount: $taxAmount, currencyCode: $currencyCode, paymentMethod: $paymentMethod, paymentReference: $paymentReference, paidAtUtc: $paidAtUtc, completedAtUtc: $completedAtUtc, distanceKm: $distanceKm, durationMin: $durationMin, vehicleTypeName: $vehicleTypeName, passengerName: $passengerName, issuerName: $issuerName, invoiceAvailable: $invoiceAvailable, invoiceNumber: $invoiceNumber, invoiceIssuedAtUtc: $invoiceIssuedAtUtc, stops: $stops, waitingFeeAmount: $waitingFeeAmount, walletPaidAmount: $walletPaidAmount, cardPaidAmount: $cardPaidAmount, totalPaidAmount: $totalPaidAmount, unpaidAmount: $unpaidAmount, refundedAmount: $refundedAmount)';
}


}

/// @nodoc
abstract mixin class _$TripReceiptModelCopyWith<$Res> implements $TripReceiptModelCopyWith<$Res> {
  factory _$TripReceiptModelCopyWith(_TripReceiptModel value, $Res Function(_TripReceiptModel) _then) = __$TripReceiptModelCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String referenceCode, String status, double grossAmount, double netAmount, double taxAmount, String currencyCode, String paymentMethod, String? paymentReference, DateTime? paidAtUtc, DateTime? completedAtUtc, double distanceKm, double durationMin, String vehicleTypeName, String? passengerName, String issuerName, bool invoiceAvailable, String? invoiceNumber, DateTime? invoiceIssuedAtUtc, List<TripStopModel> stops, double waitingFeeAmount, double walletPaidAmount, double cardPaidAmount, double totalPaidAmount, double unpaidAmount, double refundedAmount
});




}
/// @nodoc
class __$TripReceiptModelCopyWithImpl<$Res>
    implements _$TripReceiptModelCopyWith<$Res> {
  __$TripReceiptModelCopyWithImpl(this._self, this._then);

  final _TripReceiptModel _self;
  final $Res Function(_TripReceiptModel) _then;

/// Create a copy of TripReceiptModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? referenceCode = null,Object? status = null,Object? grossAmount = null,Object? netAmount = null,Object? taxAmount = null,Object? currencyCode = null,Object? paymentMethod = null,Object? paymentReference = freezed,Object? paidAtUtc = freezed,Object? completedAtUtc = freezed,Object? distanceKm = null,Object? durationMin = null,Object? vehicleTypeName = null,Object? passengerName = freezed,Object? issuerName = null,Object? invoiceAvailable = null,Object? invoiceNumber = freezed,Object? invoiceIssuedAtUtc = freezed,Object? stops = null,Object? waitingFeeAmount = null,Object? walletPaidAmount = null,Object? cardPaidAmount = null,Object? totalPaidAmount = null,Object? unpaidAmount = null,Object? refundedAmount = null,}) {
  return _then(_TripReceiptModel(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,referenceCode: null == referenceCode ? _self.referenceCode : referenceCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,grossAmount: null == grossAmount ? _self.grossAmount : grossAmount // ignore: cast_nullable_to_non_nullable
as double,netAmount: null == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as double,taxAmount: null == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,paymentReference: freezed == paymentReference ? _self.paymentReference : paymentReference // ignore: cast_nullable_to_non_nullable
as String?,paidAtUtc: freezed == paidAtUtc ? _self.paidAtUtc : paidAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAtUtc: freezed == completedAtUtc ? _self.completedAtUtc : completedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,durationMin: null == durationMin ? _self.durationMin : durationMin // ignore: cast_nullable_to_non_nullable
as double,vehicleTypeName: null == vehicleTypeName ? _self.vehicleTypeName : vehicleTypeName // ignore: cast_nullable_to_non_nullable
as String,passengerName: freezed == passengerName ? _self.passengerName : passengerName // ignore: cast_nullable_to_non_nullable
as String?,issuerName: null == issuerName ? _self.issuerName : issuerName // ignore: cast_nullable_to_non_nullable
as String,invoiceAvailable: null == invoiceAvailable ? _self.invoiceAvailable : invoiceAvailable // ignore: cast_nullable_to_non_nullable
as bool,invoiceNumber: freezed == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String?,invoiceIssuedAtUtc: freezed == invoiceIssuedAtUtc ? _self.invoiceIssuedAtUtc : invoiceIssuedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,stops: null == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<TripStopModel>,waitingFeeAmount: null == waitingFeeAmount ? _self.waitingFeeAmount : waitingFeeAmount // ignore: cast_nullable_to_non_nullable
as double,walletPaidAmount: null == walletPaidAmount ? _self.walletPaidAmount : walletPaidAmount // ignore: cast_nullable_to_non_nullable
as double,cardPaidAmount: null == cardPaidAmount ? _self.cardPaidAmount : cardPaidAmount // ignore: cast_nullable_to_non_nullable
as double,totalPaidAmount: null == totalPaidAmount ? _self.totalPaidAmount : totalPaidAmount // ignore: cast_nullable_to_non_nullable
as double,unpaidAmount: null == unpaidAmount ? _self.unpaidAmount : unpaidAmount // ignore: cast_nullable_to_non_nullable
as double,refundedAmount: null == refundedAmount ? _self.refundedAmount : refundedAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
