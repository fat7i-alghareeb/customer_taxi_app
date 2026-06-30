import 'package:freezed_annotation/freezed_annotation.dart';

part 'refund_issue_model.freezed.dart';
part 'refund_issue_model.g.dart';

@freezed
abstract class RefundIssueModel with _$RefundIssueModel {
  const factory RefundIssueModel({
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
  }) = _RefundIssueModel;

  factory RefundIssueModel.fromJson(Map<String, dynamic> json) =>
      _$RefundIssueModelFromJson(json);
}
