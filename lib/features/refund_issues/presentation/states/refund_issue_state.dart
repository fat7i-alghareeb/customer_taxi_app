part of 'refund_issue_bloc.dart';

@freezed
abstract class RefundIssueState with _$RefundIssueState {
  const factory RefundIssueState({
    @Default(RefundIssueRequestType.refundTakingTooLong)
    RefundIssueRequestType selectedType,
    @Default(BlocStatus<RefundIssueEntity>.initial())
    BlocStatus<RefundIssueEntity> submitStatus,
  }) = _RefundIssueState;
}
