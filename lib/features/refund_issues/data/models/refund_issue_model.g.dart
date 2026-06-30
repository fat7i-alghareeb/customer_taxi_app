// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund_issue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RefundIssueModel _$RefundIssueModelFromJson(Map<String, dynamic> json) =>
    _RefundIssueModel(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      requestType: json['requestType'] as String,
      customerReason: json['customerReason'] as String,
      reviewStatus: json['reviewStatus'] as String,
      createdAtUtc: DateTime.parse(json['createdAtUtc'] as String),
      paymentId: json['paymentId'] as String?,
      paymentRefundId: json['paymentRefundId'] as String?,
      tripCancellationId: json['tripCancellationId'] as String?,
      note: json['note'] as String?,
      refundStatusSnapshot: json['refundStatusSnapshot'] as String?,
      refundAmountSnapshot: (json['refundAmountSnapshot'] as num?)?.toDouble(),
      refundCurrencySnapshot: json['refundCurrencySnapshot'] as String?,
      tripReferenceCode: json['tripReferenceCode'] as String?,
      whatsAppOpened: json['whatsAppOpened'] as bool? ?? false,
    );

Map<String, dynamic> _$RefundIssueModelToJson(_RefundIssueModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tripId': instance.tripId,
      'requestType': instance.requestType,
      'customerReason': instance.customerReason,
      'reviewStatus': instance.reviewStatus,
      'createdAtUtc': instance.createdAtUtc.toIso8601String(),
      'paymentId': instance.paymentId,
      'paymentRefundId': instance.paymentRefundId,
      'tripCancellationId': instance.tripCancellationId,
      'note': instance.note,
      'refundStatusSnapshot': instance.refundStatusSnapshot,
      'refundAmountSnapshot': instance.refundAmountSnapshot,
      'refundCurrencySnapshot': instance.refundCurrencySnapshot,
      'tripReferenceCode': instance.tripReferenceCode,
      'whatsAppOpened': instance.whatsAppOpened,
    };
