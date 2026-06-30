part of 'refund_issue_bloc.dart';

@freezed
class RefundIssueEvent with _$RefundIssueEvent {
  const factory RefundIssueEvent.reasonSelected(RefundIssueRequestType type) =
      _ReasonSelected;
  const factory RefundIssueEvent.submitted({
    required String tripId,
    required RefundIssueRequestType type,
    required String customerReason,
    String? note,
  }) = _Submitted;
  const factory RefundIssueEvent.resetSubmission() = _ResetSubmission;
}
