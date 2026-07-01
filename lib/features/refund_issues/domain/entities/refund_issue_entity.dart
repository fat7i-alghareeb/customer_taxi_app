import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:customertaxi/features/refund_issues/domain/entities/refund_issue_request_type.dart';

part 'refund_issue_entity.freezed.dart';

@freezed
abstract class RefundIssueEntity with _$RefundIssueEntity {
  const factory RefundIssueEntity({
    required String id,
    required String tripId,
    required RefundIssueRequestType requestType,
    required String customerReason,
    required RefundIssueReviewStatus reviewStatus,
    required DateTime createdAtUtc,
    String? paymentId,
    String? paymentRefundId,
    String? tripCancellationId,
    String? note,
    String? refundStatusSnapshot,
    double? refundAmountSnapshot,
    String? refundCurrencySnapshot,
    String? tripReferenceCode,
    @Default(false) bool whatsAppOpened,
  }) = _RefundIssueEntity;
}
