// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_booking_slice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderBookingSlice {

 OrderScheduleMode get scheduleMode; DateTime? get scheduledAt; String get passengerNote; String get flightNumber; OrderPaymentMethod get paymentMethod; double? get walletBalance; String get walletCurrency; BlocStatus<OrderTripResponseEntity> get tripRequestStatus; BlocStatus<void> get paymentSheetState;// Stores the trip created by requestTrip so the same PaymentIntent can be
// re-presented if the user dismisses the sheet without paying. Cleared on
// success, full payment failure, or when the user abandons the booking.
 OrderTripResponseEntity? get pendingTripResponse;
/// Create a copy of OrderBookingSlice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderBookingSliceCopyWith<OrderBookingSlice> get copyWith => _$OrderBookingSliceCopyWithImpl<OrderBookingSlice>(this as OrderBookingSlice, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderBookingSlice&&(identical(other.scheduleMode, scheduleMode) || other.scheduleMode == scheduleMode)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.passengerNote, passengerNote) || other.passengerNote == passengerNote)&&(identical(other.flightNumber, flightNumber) || other.flightNumber == flightNumber)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.walletBalance, walletBalance) || other.walletBalance == walletBalance)&&(identical(other.walletCurrency, walletCurrency) || other.walletCurrency == walletCurrency)&&(identical(other.tripRequestStatus, tripRequestStatus) || other.tripRequestStatus == tripRequestStatus)&&(identical(other.paymentSheetState, paymentSheetState) || other.paymentSheetState == paymentSheetState)&&(identical(other.pendingTripResponse, pendingTripResponse) || other.pendingTripResponse == pendingTripResponse));
}


@override
int get hashCode => Object.hash(runtimeType,scheduleMode,scheduledAt,passengerNote,flightNumber,paymentMethod,walletBalance,walletCurrency,tripRequestStatus,paymentSheetState,pendingTripResponse);

@override
String toString() {
  return 'OrderBookingSlice(scheduleMode: $scheduleMode, scheduledAt: $scheduledAt, passengerNote: $passengerNote, flightNumber: $flightNumber, paymentMethod: $paymentMethod, walletBalance: $walletBalance, walletCurrency: $walletCurrency, tripRequestStatus: $tripRequestStatus, paymentSheetState: $paymentSheetState, pendingTripResponse: $pendingTripResponse)';
}


}

/// @nodoc
abstract mixin class $OrderBookingSliceCopyWith<$Res>  {
  factory $OrderBookingSliceCopyWith(OrderBookingSlice value, $Res Function(OrderBookingSlice) _then) = _$OrderBookingSliceCopyWithImpl;
@useResult
$Res call({
 OrderScheduleMode scheduleMode, DateTime? scheduledAt, String passengerNote, String flightNumber, OrderPaymentMethod paymentMethod, double? walletBalance, String walletCurrency, BlocStatus<OrderTripResponseEntity> tripRequestStatus, BlocStatus<void> paymentSheetState, OrderTripResponseEntity? pendingTripResponse
});


$BlocStatusCopyWith<OrderTripResponseEntity, $Res> get tripRequestStatus;$BlocStatusCopyWith<void, $Res> get paymentSheetState;

}
/// @nodoc
class _$OrderBookingSliceCopyWithImpl<$Res>
    implements $OrderBookingSliceCopyWith<$Res> {
  _$OrderBookingSliceCopyWithImpl(this._self, this._then);

  final OrderBookingSlice _self;
  final $Res Function(OrderBookingSlice) _then;

/// Create a copy of OrderBookingSlice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scheduleMode = null,Object? scheduledAt = freezed,Object? passengerNote = null,Object? flightNumber = null,Object? paymentMethod = null,Object? walletBalance = freezed,Object? walletCurrency = null,Object? tripRequestStatus = null,Object? paymentSheetState = null,Object? pendingTripResponse = freezed,}) {
  return _then(_self.copyWith(
scheduleMode: null == scheduleMode ? _self.scheduleMode : scheduleMode // ignore: cast_nullable_to_non_nullable
as OrderScheduleMode,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,passengerNote: null == passengerNote ? _self.passengerNote : passengerNote // ignore: cast_nullable_to_non_nullable
as String,flightNumber: null == flightNumber ? _self.flightNumber : flightNumber // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as OrderPaymentMethod,walletBalance: freezed == walletBalance ? _self.walletBalance : walletBalance // ignore: cast_nullable_to_non_nullable
as double?,walletCurrency: null == walletCurrency ? _self.walletCurrency : walletCurrency // ignore: cast_nullable_to_non_nullable
as String,tripRequestStatus: null == tripRequestStatus ? _self.tripRequestStatus : tripRequestStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<OrderTripResponseEntity>,paymentSheetState: null == paymentSheetState ? _self.paymentSheetState : paymentSheetState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,pendingTripResponse: freezed == pendingTripResponse ? _self.pendingTripResponse : pendingTripResponse // ignore: cast_nullable_to_non_nullable
as OrderTripResponseEntity?,
  ));
}
/// Create a copy of OrderBookingSlice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<OrderTripResponseEntity, $Res> get tripRequestStatus {
  
  return $BlocStatusCopyWith<OrderTripResponseEntity, $Res>(_self.tripRequestStatus, (value) {
    return _then(_self.copyWith(tripRequestStatus: value));
  });
}/// Create a copy of OrderBookingSlice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get paymentSheetState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.paymentSheetState, (value) {
    return _then(_self.copyWith(paymentSheetState: value));
  });
}
}


/// Adds pattern-matching-related methods to [OrderBookingSlice].
extension OrderBookingSlicePatterns on OrderBookingSlice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderBookingSlice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderBookingSlice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderBookingSlice value)  $default,){
final _that = this;
switch (_that) {
case _OrderBookingSlice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderBookingSlice value)?  $default,){
final _that = this;
switch (_that) {
case _OrderBookingSlice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OrderScheduleMode scheduleMode,  DateTime? scheduledAt,  String passengerNote,  String flightNumber,  OrderPaymentMethod paymentMethod,  double? walletBalance,  String walletCurrency,  BlocStatus<OrderTripResponseEntity> tripRequestStatus,  BlocStatus<void> paymentSheetState,  OrderTripResponseEntity? pendingTripResponse)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderBookingSlice() when $default != null:
return $default(_that.scheduleMode,_that.scheduledAt,_that.passengerNote,_that.flightNumber,_that.paymentMethod,_that.walletBalance,_that.walletCurrency,_that.tripRequestStatus,_that.paymentSheetState,_that.pendingTripResponse);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OrderScheduleMode scheduleMode,  DateTime? scheduledAt,  String passengerNote,  String flightNumber,  OrderPaymentMethod paymentMethod,  double? walletBalance,  String walletCurrency,  BlocStatus<OrderTripResponseEntity> tripRequestStatus,  BlocStatus<void> paymentSheetState,  OrderTripResponseEntity? pendingTripResponse)  $default,) {final _that = this;
switch (_that) {
case _OrderBookingSlice():
return $default(_that.scheduleMode,_that.scheduledAt,_that.passengerNote,_that.flightNumber,_that.paymentMethod,_that.walletBalance,_that.walletCurrency,_that.tripRequestStatus,_that.paymentSheetState,_that.pendingTripResponse);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OrderScheduleMode scheduleMode,  DateTime? scheduledAt,  String passengerNote,  String flightNumber,  OrderPaymentMethod paymentMethod,  double? walletBalance,  String walletCurrency,  BlocStatus<OrderTripResponseEntity> tripRequestStatus,  BlocStatus<void> paymentSheetState,  OrderTripResponseEntity? pendingTripResponse)?  $default,) {final _that = this;
switch (_that) {
case _OrderBookingSlice() when $default != null:
return $default(_that.scheduleMode,_that.scheduledAt,_that.passengerNote,_that.flightNumber,_that.paymentMethod,_that.walletBalance,_that.walletCurrency,_that.tripRequestStatus,_that.paymentSheetState,_that.pendingTripResponse);case _:
  return null;

}
}

}

/// @nodoc


class _OrderBookingSlice implements OrderBookingSlice {
  const _OrderBookingSlice({this.scheduleMode = OrderScheduleMode.now, this.scheduledAt, this.passengerNote = '', this.flightNumber = '', this.paymentMethod = OrderPaymentMethod.card, this.walletBalance, this.walletCurrency = 'EUR', this.tripRequestStatus = const BlocStatus<OrderTripResponseEntity>.initial(), this.paymentSheetState = const BlocStatus<void>.initial(), this.pendingTripResponse});
  

@override@JsonKey() final  OrderScheduleMode scheduleMode;
@override final  DateTime? scheduledAt;
@override@JsonKey() final  String passengerNote;
@override@JsonKey() final  String flightNumber;
@override@JsonKey() final  OrderPaymentMethod paymentMethod;
@override final  double? walletBalance;
@override@JsonKey() final  String walletCurrency;
@override@JsonKey() final  BlocStatus<OrderTripResponseEntity> tripRequestStatus;
@override@JsonKey() final  BlocStatus<void> paymentSheetState;
// Stores the trip created by requestTrip so the same PaymentIntent can be
// re-presented if the user dismisses the sheet without paying. Cleared on
// success, full payment failure, or when the user abandons the booking.
@override final  OrderTripResponseEntity? pendingTripResponse;

/// Create a copy of OrderBookingSlice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderBookingSliceCopyWith<_OrderBookingSlice> get copyWith => __$OrderBookingSliceCopyWithImpl<_OrderBookingSlice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderBookingSlice&&(identical(other.scheduleMode, scheduleMode) || other.scheduleMode == scheduleMode)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.passengerNote, passengerNote) || other.passengerNote == passengerNote)&&(identical(other.flightNumber, flightNumber) || other.flightNumber == flightNumber)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.walletBalance, walletBalance) || other.walletBalance == walletBalance)&&(identical(other.walletCurrency, walletCurrency) || other.walletCurrency == walletCurrency)&&(identical(other.tripRequestStatus, tripRequestStatus) || other.tripRequestStatus == tripRequestStatus)&&(identical(other.paymentSheetState, paymentSheetState) || other.paymentSheetState == paymentSheetState)&&(identical(other.pendingTripResponse, pendingTripResponse) || other.pendingTripResponse == pendingTripResponse));
}


@override
int get hashCode => Object.hash(runtimeType,scheduleMode,scheduledAt,passengerNote,flightNumber,paymentMethod,walletBalance,walletCurrency,tripRequestStatus,paymentSheetState,pendingTripResponse);

@override
String toString() {
  return 'OrderBookingSlice(scheduleMode: $scheduleMode, scheduledAt: $scheduledAt, passengerNote: $passengerNote, flightNumber: $flightNumber, paymentMethod: $paymentMethod, walletBalance: $walletBalance, walletCurrency: $walletCurrency, tripRequestStatus: $tripRequestStatus, paymentSheetState: $paymentSheetState, pendingTripResponse: $pendingTripResponse)';
}


}

/// @nodoc
abstract mixin class _$OrderBookingSliceCopyWith<$Res> implements $OrderBookingSliceCopyWith<$Res> {
  factory _$OrderBookingSliceCopyWith(_OrderBookingSlice value, $Res Function(_OrderBookingSlice) _then) = __$OrderBookingSliceCopyWithImpl;
@override @useResult
$Res call({
 OrderScheduleMode scheduleMode, DateTime? scheduledAt, String passengerNote, String flightNumber, OrderPaymentMethod paymentMethod, double? walletBalance, String walletCurrency, BlocStatus<OrderTripResponseEntity> tripRequestStatus, BlocStatus<void> paymentSheetState, OrderTripResponseEntity? pendingTripResponse
});


@override $BlocStatusCopyWith<OrderTripResponseEntity, $Res> get tripRequestStatus;@override $BlocStatusCopyWith<void, $Res> get paymentSheetState;

}
/// @nodoc
class __$OrderBookingSliceCopyWithImpl<$Res>
    implements _$OrderBookingSliceCopyWith<$Res> {
  __$OrderBookingSliceCopyWithImpl(this._self, this._then);

  final _OrderBookingSlice _self;
  final $Res Function(_OrderBookingSlice) _then;

/// Create a copy of OrderBookingSlice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scheduleMode = null,Object? scheduledAt = freezed,Object? passengerNote = null,Object? flightNumber = null,Object? paymentMethod = null,Object? walletBalance = freezed,Object? walletCurrency = null,Object? tripRequestStatus = null,Object? paymentSheetState = null,Object? pendingTripResponse = freezed,}) {
  return _then(_OrderBookingSlice(
scheduleMode: null == scheduleMode ? _self.scheduleMode : scheduleMode // ignore: cast_nullable_to_non_nullable
as OrderScheduleMode,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,passengerNote: null == passengerNote ? _self.passengerNote : passengerNote // ignore: cast_nullable_to_non_nullable
as String,flightNumber: null == flightNumber ? _self.flightNumber : flightNumber // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as OrderPaymentMethod,walletBalance: freezed == walletBalance ? _self.walletBalance : walletBalance // ignore: cast_nullable_to_non_nullable
as double?,walletCurrency: null == walletCurrency ? _self.walletCurrency : walletCurrency // ignore: cast_nullable_to_non_nullable
as String,tripRequestStatus: null == tripRequestStatus ? _self.tripRequestStatus : tripRequestStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<OrderTripResponseEntity>,paymentSheetState: null == paymentSheetState ? _self.paymentSheetState : paymentSheetState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,pendingTripResponse: freezed == pendingTripResponse ? _self.pendingTripResponse : pendingTripResponse // ignore: cast_nullable_to_non_nullable
as OrderTripResponseEntity?,
  ));
}

/// Create a copy of OrderBookingSlice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<OrderTripResponseEntity, $Res> get tripRequestStatus {
  
  return $BlocStatusCopyWith<OrderTripResponseEntity, $Res>(_self.tripRequestStatus, (value) {
    return _then(_self.copyWith(tripRequestStatus: value));
  });
}/// Create a copy of OrderBookingSlice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get paymentSheetState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.paymentSheetState, (value) {
    return _then(_self.copyWith(paymentSheetState: value));
  });
}
}

// dart format on
