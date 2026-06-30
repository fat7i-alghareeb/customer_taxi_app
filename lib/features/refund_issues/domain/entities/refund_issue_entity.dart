import 'package:freezed_annotation/freezed_annotation.dart';

part 'refund_issue_entity.freezed.dart';

@freezed
abstract class RefundIssueEntity with _$RefundIssueEntity {
  const factory RefundIssueEntity({
    required String id,
    required String tripId,
    required String requestType,
    required String customerReason,
    required String reviewStatus,
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
