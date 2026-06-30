import 'package:injectable/injectable.dart';

import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../data/models/create_refund_issue_request_model.dart';
import '../entities/refund_issue_entity.dart';
import '../repositories/refund_issue_repository.dart';

@lazySingleton
class RefundIssueFacade {
  const RefundIssueFacade(this._repository);

  final RefundIssueRepository _repository;

  Future<Result<RefundIssueEntity>> submitRefundIssue({
    required String tripId,
    required CreateRefundIssueRequestModel request,
  }) {
    printC('[RefundIssueFacade] submitRefundIssue trip=$tripId');
    return _repository.submitRefundIssue(tripId: tripId, request: request);
  }
}
