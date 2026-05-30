import 'package:injectable/injectable.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/trip_entity.dart';
import '../../domain/repositories/trip_repository.dart';
import '../datasources/trip_remote_datasource.dart';
import '../mappers/trip_model_mapper.dart';

@LazySingleton(as: TripRepository)
class TripRepositoryImpl implements TripRepository {
  const TripRepositoryImpl(this._remote);

  final TripRemoteDataSource _remote;

  @override
  Future<Result<TripEntity>> getTripById(String id) {
    return runAsResult(() async {
      printM('[TripRepository] getTripById id=$id');
      final model = await _remote.getTripById(id);
      printG('[TripRepository] getTripById success status=${model.status}');
      return model.toEntity;
    });
  }

  @override
  Future<Result<TripEntity>> cancelTrip(String id) {
    return runAsResult(() async {
      printM('[TripRepository] cancelTrip id=$id');
      final model = await _remote.cancelTrip(id);
      printG('[TripRepository] cancelTrip success');
      return model.toEntity;
    });
  }

  @override
  Future<Result<TripCompensationClaimEntity>> submitCompensationClaim({
    required String tripId,
    required String note,
    List<String> evidenceUrls = const [],
  }) {
    return runAsResult(() async {
      printM('[TripRepository] submitCompensationClaim trip=$tripId');
      final model = await _remote.submitCompensationClaim(
        tripId: tripId,
        note: note,
        evidenceUrls: evidenceUrls,
      );
      printG('[TripRepository] submitCompensationClaim success');
      return model.toEntity;
    });
  }

  @override
  Future<Result<List<String>>> uploadCompensationEvidence(
    List<String> filePaths,
  ) {
    return runAsResult(() async {
      printM('[TripRepository] uploadCompensationEvidence count=${filePaths.length}');
      final urls = await _remote.uploadCompensationEvidence(filePaths);
      printG('[TripRepository] uploadCompensationEvidence urls=${urls.length}');
      return urls;
    });
  }

  @override
  Future<Result<PagedResult<TripSummaryEntity>>> getTripHistory({
    int page = 1,
    int pageSize = 20,
  }) {
    return runAsResult(() async {
      printM('[TripRepository] getTripHistory page=$page');
      final result = await _remote.getTripHistory(page: page, pageSize: pageSize);
      printG('[TripRepository] getTripHistory count=${result.items.length}');
      return PagedResult<TripSummaryEntity>(
        items: result.items.map((m) => m.toSummaryEntity).toList(),
        totalCount: result.totalCount,
        page: result.page,
        pageSize: result.pageSize,
      );
    });
  }
}
