enum RefundIssueRequestType {
  didNotReceiveRefund('DidNotReceiveRefund'),
  receivedLessThanExpected('ReceivedLessThanExpected'),
  refundTakingTooLong('RefundTakingTooLong'),
  questionAboutRefund('QuestionAboutRefund'),
  knownFailedRefundReview('KnownFailedRefundReview'),
  other('Other');

  const RefundIssueRequestType(this.apiValue);

  final String apiValue;
}
