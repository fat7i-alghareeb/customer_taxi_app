import '../../../../core/utils/result.dart';
import '../entities/trip_entity.dart';
import '../../data/datasources/trip_remote_datasource.dart';

abstract class TripRepository {
  Future<Result<TripEntity>> getTripById(String id);
  Future<Result<TripEntity>> cancelTrip(String id);
  Future<Result<PagedResult<TripSummaryEntity>>> getTripHistory({
    int page = 1,
    int pageSize = 20,
  });
}
