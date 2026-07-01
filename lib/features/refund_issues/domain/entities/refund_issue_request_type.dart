import 'package:customertaxi/utils/helpers/app_strings.dart';

enum RefundIssueRequestType {
  didNotReceiveRefund('DidNotReceiveRefund'),
  receivedLessThanExpected('ReceivedLessThanExpected'),
  refundTakingTooLong('RefundTakingTooLong'),
  questionAboutRefund('QuestionAboutRefund'),
  knownFailedRefundReview('KnownFailedRefundReview'),
  other('Other'),
  unknown('');

  const RefundIssueRequestType(this.apiValue);

  final String apiValue;

  static RefundIssueRequestType fromJson(String? value) {
    final normalized = value?.trim().toLowerCase();
    return RefundIssueRequestType.values.firstWhere(
      (type) => type.apiValue.toLowerCase() == normalized,
      orElse: () => RefundIssueRequestType.unknown,
    );
  }

  String toJson() => apiValue;

  String title() {
    return switch (this) {
      RefundIssueRequestType.didNotReceiveRefund =>
        AppStrings.refundIssueReasonDidNotReceive,
      RefundIssueRequestType.receivedLessThanExpected =>
        AppStrings.refundIssueReasonLessThanExpected,
      RefundIssueRequestType.refundTakingTooLong =>
        AppStrings.refundIssueReasonTakingTooLong,
      RefundIssueRequestType.questionAboutRefund =>
        AppStrings.refundIssueReasonQuestion,
      RefundIssueRequestType.knownFailedRefundReview =>
        AppStrings.refundIssueKnownFailedReason,
      RefundIssueRequestType.other => AppStrings.refundIssueReasonOther,
      RefundIssueRequestType.unknown => AppStrings.notAvailable,
    };
  }
}

enum RefundIssueReviewStatus {
  open('Open'),
  inReview('InReview'),
  resolved('Resolved'),
  dismissed('Dismissed'),
  unknown('');

  const RefundIssueReviewStatus(this.apiValue);

  final String apiValue;

  static RefundIssueReviewStatus fromJson(String? value) {
    final normalized = value?.trim().toLowerCase();
    return RefundIssueReviewStatus.values.firstWhere(
      (status) => status.apiValue.toLowerCase() == normalized,
      orElse: () => RefundIssueReviewStatus.unknown,
    );
  }

  String toJson() => apiValue;

  String title() {
    return switch (this) {
      RefundIssueReviewStatus.open => AppStrings.refundIssueReviewStatusOpen,
      RefundIssueReviewStatus.inReview =>
        AppStrings.refundIssueReviewStatusInReview,
      RefundIssueReviewStatus.resolved =>
        AppStrings.refundIssueReviewStatusResolved,
      RefundIssueReviewStatus.dismissed =>
        AppStrings.refundIssueReviewStatusDismissed,
      RefundIssueReviewStatus.unknown => AppStrings.notAvailable,
    };
  }
}
