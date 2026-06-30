import '../../domain/entities/refund_issue_entity.dart';
import '../models/refund_issue_model.dart';

extension RefundIssueModelMapper on RefundIssueModel {
  RefundIssueEntity get toEntity => RefundIssueEntity(
    id: id,
    tripId: tripId,
    requestType: requestType,
    customerReason: customerReason,
    reviewStatus: reviewStatus,
    createdAtUtc: createdAtUtc,
    paymentId: paymentId,
    paymentRefundId: paymentRefundId,
    tripCancellationId: tripCancellationId,
    note: note,
    refundStatusSnapshot: refundStatusSnapshot,
    refundAmountSnapshot: refundAmountSnapshot,
    refundCurrencySnapshot: refundCurrencySnapshot,
    tripReferenceCode: tripReferenceCode,
    whatsAppOpened: whatsAppOpened,
  );
}
