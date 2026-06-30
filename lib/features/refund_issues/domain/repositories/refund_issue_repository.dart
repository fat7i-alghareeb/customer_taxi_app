import '../../../../core/utils/result.dart';
import '../../data/models/create_refund_issue_request_model.dart';
import '../entities/refund_issue_entity.dart';

abstract class RefundIssueRepository {
  Future<Result<RefundIssueEntity>> submitRefundIssue({
    required String tripId,
    required CreateRefundIssueRequestModel request,
  });
}
