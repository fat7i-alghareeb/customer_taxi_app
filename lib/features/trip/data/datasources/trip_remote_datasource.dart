import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/trip_model.dart';

class PagedResult<T> {
  const PagedResult({
    required this.items,
    required this.totalCount,
    required this.page,
    required this.pageSize,
  });
  final List<T> items;
  final int totalCount;
  final int page;
  final int pageSize;

  factory PagedResult.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) => PagedResult(
    items: (json['items'] as List<dynamic>)
        .map((e) => fromJsonT(e as Map<String, dynamic>))
        .toList(),
    totalCount: json['totalCount'] as int,
    page: json['page'] as int,
    pageSize: json['pageSize'] as int,
  );
}

@lazySingleton
class TripRemoteDataSource {
  const TripRemoteDataSource(this._dio);

  final Dio _dio;

  Future<TripModel> getTripById(String id) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] getTripById id=$id');
      final res = await _dio.get<dynamic>(ApiEndpoints.tripById(id));
      return TripModel.fromJson(res.data as Map<String, dynamic>);
    });
  }

  Future<TripModel> cancelTrip(String id) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] cancelTrip id=$id');
      final res = await _dio.post<dynamic>(
        ApiEndpoints.cancelTrip(id),
        data: {
          'reason': 'PassengerWithinOneHour',
          'note': 'Passenger requested cancellation from customer app',
        },
      );
      return TripModel.fromJson(res.data as Map<String, dynamic>);
    });
  }

  Future<TripCompensationClaimModel> submitCompensationClaim({
    required String tripId,
    required String note,
    List<String> evidenceUrls = const [],
  }) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] submitCompensationClaim trip=$tripId');
      final res = await _dio.post<dynamic>(
        ApiEndpoints.submitCompensationClaim(tripId),
        data: {'note': note, 'evidenceUrls': evidenceUrls},
      );
      return TripCompensationClaimModel.fromJson(
        res.data as Map<String, dynamic>,
      );
    });
  }

  Future<List<String>> uploadCompensationEvidence(List<String> filePaths) {
    return rethrowAsAppException(() async {
      printY(
        '[TripRemoteDataSource] uploadCompensationEvidence count=${filePaths.length}',
      );
      final formData = FormData();
      for (final path in filePaths) {
        formData.files.add(
          MapEntry('files', await MultipartFile.fromFile(path)),
        );
      }
      final res = await _dio.post<dynamic>(
        ApiEndpoints.uploadCompensationEvidence,
        data: formData,
      );
      final data = res.data;
      final urls = data is Map<String, dynamic> ? data['urls'] : null;
      return (urls as List<dynamic>?)?.whereType<String>().toList() ??
          const <String>[];
    });
  }

  Future<PagedResult<TripSummaryModel>> getTripHistory({
    int page = 1,
    int pageSize = 20,
  }) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] getTripHistory page=$page');
      final res = await _dio.get<dynamic>(
        ApiEndpoints.tripHistory,
        queryParameters: {'page': page, 'pageSize': pageSize},
      );
      return PagedResult.fromJson(
        res.data as Map<String, dynamic>,
        TripSummaryModel.fromJson,
      );
    });
  }
}
