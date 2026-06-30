import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../domain/entities/refund_issue_entity.dart';
import '../../domain/repositories/refund_issue_repository.dart';
import '../datasources/refund_issue_remote_datasource.dart';
import '../mappers/refund_issue_model_mapper.dart';
import '../models/create_refund_issue_request_model.dart';

@LazySingleton(as: RefundIssueRepository)
class RefundIssueRepositoryImpl implements RefundIssueRepository {
  const RefundIssueRepositoryImpl(this._remote);

  final RefundIssueRemoteDataSource _remote;

  @override
  Future<Result<RefundIssueEntity>> submitRefundIssue({
    required String tripId,
    required CreateRefundIssueRequestModel request,
  }) {
    return runAsResult(() async {
      printM('[RefundIssueRepository] submitRefundIssue trip=$tripId');
      final model = await _remote.submitRefundIssue(
        tripId: tripId,
        request: request,
      );
      printG(
        '[RefundIssueRepository] submitRefundIssue success id=${model.id}',
      );
      return model.toEntity;
    });
  }
}
