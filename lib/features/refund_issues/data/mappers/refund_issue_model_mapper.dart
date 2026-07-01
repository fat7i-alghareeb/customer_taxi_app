import 'package:customertaxi/features/refund_issues/data/models/refund_issue_model.dart';
import 'package:customertaxi/features/refund_issues/domain/entities/refund_issue_entity.dart';
import 'package:customertaxi/features/refund_issues/domain/entities/refund_issue_request_type.dart';

extension RefundIssueModelMapper on RefundIssueModel {
  RefundIssueEntity get toEntity => RefundIssueEntity(
    id: id,
    tripId: tripId,
    requestType: RefundIssueRequestType.fromJson(requestType),
    customerReason: customerReason,
    reviewStatus: RefundIssueReviewStatus.fromJson(reviewStatus),
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
