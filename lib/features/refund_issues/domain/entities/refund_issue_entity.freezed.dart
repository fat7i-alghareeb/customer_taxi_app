// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'refund_issue_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RefundIssueEntity {

 String get id; String get tripId; String get requestType; String get customerReason; String get reviewStatus; DateTime get createdAtUtc; String? get paymentId; String? get paymentRefundId; String? get tripCancellationId; String? get note; String? get refundStatusSnapshot; double? get refundAmountSnapshot; String? get refundCurrencySnapshot; String? get tripReferenceCode; bool get whatsAppOpened;
/// Create a copy of RefundIssueEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefundIssueEntityCopyWith<RefundIssueEntity> get copyWith => _$RefundIssueEntityCopyWithImpl<RefundIssueEntity>(this as RefundIssueEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefundIssueEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.requestType, requestType) || other.requestType == requestType)&&(identical(other.customerReason, customerReason) || other.customerReason == customerReason)&&(identical(other.reviewStatus, reviewStatus) || other.reviewStatus == reviewStatus)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.paymentRefundId, paymentRefundId) || other.paymentRefundId == paymentRefundId)&&(identical(other.tripCancellationId, tripCancellationId) || other.tripCancellationId == tripCancellationId)&&(identical(other.note, note) || other.note == note)&&(identical(other.refundStatusSnapshot, refundStatusSnapshot) || other.refundStatusSnapshot == refundStatusSnapshot)&&(identical(other.refundAmountSnapshot, refundAmountSnapshot) || other.refundAmountSnapshot == refundAmountSnapshot)&&(identical(other.refundCurrencySnapshot, refundCurrencySnapshot) || other.refundCurrencySnapshot == refundCurrencySnapshot)&&(identical(other.tripReferenceCode, tripReferenceCode) || other.tripReferenceCode == tripReferenceCode)&&(identical(other.whatsAppOpened, whatsAppOpened) || other.whatsAppOpened == whatsAppOpened));
}


@override
int get hashCode => Object.hash(runtimeType,id,tripId,requestType,customerReason,reviewStatus,createdAtUtc,paymentId,paymentRefundId,tripCancellationId,note,refundStatusSnapshot,refundAmountSnapshot,refundCurrencySnapshot,tripReferenceCode,whatsAppOpened);

@override
String toString() {
  return 'RefundIssueEntity(id: $id, tripId: $tripId, requestType: $requestType, customerReason: $customerReason, reviewStatus: $reviewStatus, createdAtUtc: $createdAtUtc, paymentId: $paymentId, paymentRefundId: $paymentRefundId, tripCancellationId: $tripCancellationId, note: $note, refundStatusSnapshot: $refundStatusSnapshot, refundAmountSnapshot: $refundAmountSnapshot, refundCurrencySnapshot: $refundCurrencySnapshot, tripReferenceCode: $tripReferenceCode, whatsAppOpened: $whatsAppOpened)';
}


}

/// @nodoc
abstract mixin class $RefundIssueEntityCopyWith<$Res>  {
  factory $RefundIssueEntityCopyWith(RefundIssueEntity value, $Res Function(RefundIssueEntity) _then) = _$RefundIssueEntityCopyWithImpl;
@useResult
$Res call({
 String id, String tripId, String requestType, String customerReason, String reviewStatus, DateTime createdAtUtc, String? paymentId, String? paymentRefundId, String? tripCancellationId, String? note, String? refundStatusSnapshot, double? refundAmountSnapshot, String? refundCurrencySnapshot, String? tripReferenceCode, bool whatsAppOpened
});




}
/// @nodoc
class _$RefundIssueEntityCopyWithImpl<$Res>
    implements $RefundIssueEntityCopyWith<$Res> {
  _$RefundIssueEntityCopyWithImpl(this._self, this._then);

  final RefundIssueEntity _self;
  final $Res Function(RefundIssueEntity) _then;

/// Create a copy of RefundIssueEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tripId = null,Object? requestType = null,Object? customerReason = null,Object? reviewStatus = null,Object? createdAtUtc = null,Object? paymentId = freezed,Object? paymentRefundId = freezed,Object? tripCancellationId = freezed,Object? note = freezed,Object? refundStatusSnapshot = freezed,Object? refundAmountSnapshot = freezed,Object? refundCurrencySnapshot = freezed,Object? tripReferenceCode = freezed,Object? whatsAppOpened = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,requestType: null == requestType ? _self.requestType : requestType // ignore: cast_nullable_to_non_nullable
as String,customerReason: null == customerReason ? _self.customerReason : customerReason // ignore: cast_nullable_to_non_nullable
as String,reviewStatus: null == reviewStatus ? _self.reviewStatus : reviewStatus // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,paymentId: freezed == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String?,paymentRefundId: freezed == paymentRefundId ? _self.paymentRefundId : paymentRefundId // ignore: cast_nullable_to_non_nullable
as String?,tripCancellationId: freezed == tripCancellationId ? _self.tripCancellationId : tripCancellationId // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,refundStatusSnapshot: freezed == refundStatusSnapshot ? _self.refundStatusSnapshot : refundStatusSnapshot // ignore: cast_nullable_to_non_nullable
as String?,refundAmountSnapshot: freezed == refundAmountSnapshot ? _self.refundAmountSnapshot : refundAmountSnapshot // ignore: cast_nullable_to_non_nullable
as double?,refundCurrencySnapshot: freezed == refundCurrencySnapshot ? _self.refundCurrencySnapshot : refundCurrencySnapshot // ignore: cast_nullable_to_non_nullable
as String?,tripReferenceCode: freezed == tripReferenceCode ? _self.tripReferenceCode : tripReferenceCode // ignore: cast_nullable_to_non_nullable
as String?,whatsAppOpened: null == whatsAppOpened ? _self.whatsAppOpened : whatsAppOpened // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RefundIssueEntity].
extension RefundIssueEntityPatterns on RefundIssueEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RefundIssueEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RefundIssueEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RefundIssueEntity value)  $default,){
final _that = this;
switch (_that) {
case _RefundIssueEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RefundIssueEntity value)?  $default,){
final _that = this;
switch (_that) {
case _RefundIssueEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tripId,  String requestType,  String customerReason,  String reviewStatus,  DateTime createdAtUtc,  String? paymentId,  String? paymentRefundId,  String? tripCancellationId,  String? note,  String? refundStatusSnapshot,  double? refundAmountSnapshot,  String? refundCurrencySnapshot,  String? tripReferenceCode,  bool whatsAppOpened)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RefundIssueEntity() when $default != null:
return $default(_that.id,_that.tripId,_that.requestType,_that.customerReason,_that.reviewStatus,_that.createdAtUtc,_that.paymentId,_that.paymentRefundId,_that.tripCancellationId,_that.note,_that.refundStatusSnapshot,_that.refundAmountSnapshot,_that.refundCurrencySnapshot,_that.tripReferenceCode,_that.whatsAppOpened);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tripId,  String requestType,  String customerReason,  String reviewStatus,  DateTime createdAtUtc,  String? paymentId,  String? paymentRefundId,  String? tripCancellationId,  String? note,  String? refundStatusSnapshot,  double? refundAmountSnapshot,  String? refundCurrencySnapshot,  String? tripReferenceCode,  bool whatsAppOpened)  $default,) {final _that = this;
switch (_that) {
case _RefundIssueEntity():
return $default(_that.id,_that.tripId,_that.requestType,_that.customerReason,_that.reviewStatus,_that.createdAtUtc,_that.paymentId,_that.paymentRefundId,_that.tripCancellationId,_that.note,_that.refundStatusSnapshot,_that.refundAmountSnapshot,_that.refundCurrencySnapshot,_that.tripReferenceCode,_that.whatsAppOpened);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tripId,  String requestType,  String customerReason,  String reviewStatus,  DateTime createdAtUtc,  String? paymentId,  String? paymentRefundId,  String? tripCancellationId,  String? note,  String? refundStatusSnapshot,  double? refundAmountSnapshot,  String? refundCurrencySnapshot,  String? tripReferenceCode,  bool whatsAppOpened)?  $default,) {final _that = this;
switch (_that) {
case _RefundIssueEntity() when $default != null:
return $default(_that.id,_that.tripId,_that.requestType,_that.customerReason,_that.reviewStatus,_that.createdAtUtc,_that.paymentId,_that.paymentRefundId,_that.tripCancellationId,_that.note,_that.refundStatusSnapshot,_that.refundAmountSnapshot,_that.refundCurrencySnapshot,_that.tripReferenceCode,_that.whatsAppOpened);case _:
  return null;

}
}

}

/// @nodoc


class _RefundIssueEntity implements RefundIssueEntity {
  const _RefundIssueEntity({required this.id, required this.tripId, required this.requestType, required this.customerReason, required this.reviewStatus, required this.createdAtUtc, this.paymentId, this.paymentRefundId, this.tripCancellationId, this.note, this.refundStatusSnapshot, this.refundAmountSnapshot, this.refundCurrencySnapshot, this.tripReferenceCode, this.whatsAppOpened = false});
  

@override final  String id;
@override final  String tripId;
@override final  String requestType;
@override final  String customerReason;
@override final  String reviewStatus;
@override final  DateTime createdAtUtc;
@override final  String? paymentId;
@override final  String? paymentRefundId;
@override final  String? tripCancellationId;
@override final  String? note;
@override final  String? refundStatusSnapshot;
@override final  double? refundAmountSnapshot;
@override final  String? refundCurrencySnapshot;
@override final  String? tripReferenceCode;
@override@JsonKey() final  bool whatsAppOpened;

/// Create a copy of RefundIssueEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefundIssueEntityCopyWith<_RefundIssueEntity> get copyWith => __$RefundIssueEntityCopyWithImpl<_RefundIssueEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefundIssueEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.requestType, requestType) || other.requestType == requestType)&&(identical(other.customerReason, customerReason) || other.customerReason == customerReason)&&(identical(other.reviewStatus, reviewStatus) || other.reviewStatus == reviewStatus)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc)&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.paymentRefundId, paymentRefundId) || other.paymentRefundId == paymentRefundId)&&(identical(other.tripCancellationId, tripCancellationId) || other.tripCancellationId == tripCancellationId)&&(identical(other.note, note) || other.note == note)&&(identical(other.refundStatusSnapshot, refundStatusSnapshot) || other.refundStatusSnapshot == refundStatusSnapshot)&&(identical(other.refundAmountSnapshot, refundAmountSnapshot) || other.refundAmountSnapshot == refundAmountSnapshot)&&(identical(other.refundCurrencySnapshot, refundCurrencySnapshot) || other.refundCurrencySnapshot == refundCurrencySnapshot)&&(identical(other.tripReferenceCode, tripReferenceCode) || other.tripReferenceCode == tripReferenceCode)&&(identical(other.whatsAppOpened, whatsAppOpened) || other.whatsAppOpened == whatsAppOpened));
}


@override
int get hashCode => Object.hash(runtimeType,id,tripId,requestType,customerReason,reviewStatus,createdAtUtc,paymentId,paymentRefundId,tripCancellationId,note,refundStatusSnapshot,refundAmountSnapshot,refundCurrencySnapshot,tripReferenceCode,whatsAppOpened);

@override
String toString() {
  return 'RefundIssueEntity(id: $id, tripId: $tripId, requestType: $requestType, customerReason: $customerReason, reviewStatus: $reviewStatus, createdAtUtc: $createdAtUtc, paymentId: $paymentId, paymentRefundId: $paymentRefundId, tripCancellationId: $tripCancellationId, note: $note, refundStatusSnapshot: $refundStatusSnapshot, refundAmountSnapshot: $refundAmountSnapshot, refundCurrencySnapshot: $refundCurrencySnapshot, tripReferenceCode: $tripReferenceCode, whatsAppOpened: $whatsAppOpened)';
}


}

/// @nodoc
abstract mixin class _$RefundIssueEntityCopyWith<$Res> implements $RefundIssueEntityCopyWith<$Res> {
  factory _$RefundIssueEntityCopyWith(_RefundIssueEntity value, $Res Function(_RefundIssueEntity) _then) = __$RefundIssueEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String tripId, String requestType, String customerReason, String reviewStatus, DateTime createdAtUtc, String? paymentId, String? paymentRefundId, String? tripCancellationId, String? note, String? refundStatusSnapshot, double? refundAmountSnapshot, String? refundCurrencySnapshot, String? tripReferenceCode, bool whatsAppOpened
});




}
/// @nodoc
class __$RefundIssueEntityCopyWithImpl<$Res>
    implements _$RefundIssueEntityCopyWith<$Res> {
  __$RefundIssueEntityCopyWithImpl(this._self, this._then);

  final _RefundIssueEntity _self;
  final $Res Function(_RefundIssueEntity) _then;

/// Create a copy of RefundIssueEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tripId = null,Object? requestType = null,Object? customerReason = null,Object? reviewStatus = null,Object? createdAtUtc = null,Object? paymentId = freezed,Object? paymentRefundId = freezed,Object? tripCancellationId = freezed,Object? note = freezed,Object? refundStatusSnapshot = freezed,Object? refundAmountSnapshot = freezed,Object? refundCurrencySnapshot = freezed,Object? tripReferenceCode = freezed,Object? whatsAppOpened = null,}) {
  return _then(_RefundIssueEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,requestType: null == requestType ? _self.requestType : requestType // ignore: cast_nullable_to_non_nullable
as String,customerReason: null == customerReason ? _self.customerReason : customerReason // ignore: cast_nullable_to_non_nullable
as String,reviewStatus: null == reviewStatus ? _self.reviewStatus : reviewStatus // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,paymentId: freezed == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String?,paymentRefundId: freezed == paymentRefundId ? _self.paymentRefundId : paymentRefundId // ignore: cast_nullable_to_non_nullable
as String?,tripCancellationId: freezed == tripCancellationId ? _self.tripCancellationId : tripCancellationId // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,refundStatusSnapshot: freezed == refundStatusSnapshot ? _self.refundStatusSnapshot : refundStatusSnapshot // ignore: cast_nullable_to_non_nullable
as String?,refundAmountSnapshot: freezed == refundAmountSnapshot ? _self.refundAmountSnapshot : refundAmountSnapshot // ignore: cast_nullable_to_non_nullable
as double?,refundCurrencySnapshot: freezed == refundCurrencySnapshot ? _self.refundCurrencySnapshot : refundCurrencySnapshot // ignore: cast_nullable_to_non_nullable
as String?,tripReferenceCode: freezed == tripReferenceCode ? _self.tripReferenceCode : tripReferenceCode // ignore: cast_nullable_to_non_nullable
as String?,whatsAppOpened: null == whatsAppOpened ? _self.whatsAppOpened : whatsAppOpened // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
