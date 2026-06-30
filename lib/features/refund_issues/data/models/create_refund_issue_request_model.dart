import '../../domain/entities/refund_issue_request_type.dart';

class CreateRefundIssueRequestModel {
  const CreateRefundIssueRequestModel({
    required this.requestType,
    required this.customerReason,
    this.note,
    this.whatsAppOpened = false,
  });

  final RefundIssueRequestType requestType;
  final String customerReason;
  final String? note;
  final bool whatsAppOpened;

  Map<String, dynamic> toJson() => {
    'requestType': requestType.apiValue,
    'customerReason': customerReason,
    'note': note,
    'whatsAppOpened': whatsAppOpened,
  };
}
