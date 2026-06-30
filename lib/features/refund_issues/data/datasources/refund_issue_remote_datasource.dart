import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../models/create_refund_issue_request_model.dart';
import '../models/refund_issue_model.dart';

@lazySingleton
class RefundIssueRemoteDataSource {
  const RefundIssueRemoteDataSource(this._dio);

  final Dio _dio;

  Future<RefundIssueModel> submitRefundIssue({
    required String tripId,
    required CreateRefundIssueRequestModel request,
  }) {
    return rethrowAsAppException(() async {
      printY('[RefundIssueRemoteDataSource] submitRefundIssue trip=$tripId');
      final response = await _dio.post<dynamic>(
        ApiEndpoints.submitRefundIssue(tripId),
        data: request.toJson(),
      );
      return RefundIssueModel.fromJson(response.data as Map<String, dynamic>);
    });
  }
}
