import 'package:injectable/injectable.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/utils/result.dart';
import '../entities/trip_entity.dart';
import '../repositories/trip_repository.dart';
import '../../data/datasources/trip_remote_datasource.dart';

@lazySingleton
class TripFacade {
  const TripFacade(this._repository);

  final TripRepository _repository;

  Future<Result<TripEntity>> getTripById(String id) {
    printC('[TripFacade] getTripById id=$id');
    return _repository.getTripById(id);
  }

  Future<Result<TripEntity>> cancelTrip(String id) {
    printC('[TripFacade] cancelTrip id=$id');
    return _repository.cancelTrip(id);
  }

  Future<Result<TripCompensationClaimEntity>> submitCompensationClaim({
    required String tripId,
    required String note,
    List<String> evidenceUrls = const [],
  }) {
    printC('[TripFacade] submitCompensationClaim trip=$tripId');
    return _repository.submitCompensationClaim(
      tripId: tripId,
      note: note,
      evidenceUrls: evidenceUrls,
    );
  }

  Future<Result<List<String>>> uploadCompensationEvidence(
    List<String> filePaths,
  ) {
    printC('[TripFacade] uploadCompensationEvidence count=${filePaths.length}');
    return _repository.uploadCompensationEvidence(filePaths);
  }

  Future<Result<PagedResult<TripSummaryEntity>>> getTripHistory({
    int page = 1,
    int pageSize = 20,
  }) {
    printC('[TripFacade] getTripHistory page=$page');
    return _repository.getTripHistory(page: page, pageSize: pageSize);
  }
}
