import 'package:injectable/injectable.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/order_location_entity.dart';
import '../../domain/entities/order_location_request_entity.dart';
import '../../domain/entities/order_saved_location_entity.dart';
import '../../domain/entities/order_trip_car_option_entity.dart';
import '../../domain/entities/order_trip_response_entity.dart';
import '../../domain/entities/order_trip_route_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_local_datasource.dart';
import '../datasources/order_remote_datasource.dart';
import '../mappers/order_location_model_mapper.dart';
import '../mappers/order_pricing_quote_model_mapper.dart';
import '../mappers/order_saved_location_cache_model_mapper.dart';
import '../mappers/order_trip_response_model_mapper.dart';
import '../mappers/order_trip_route_model_mapper.dart';
import '../models/order_saved_location_cache_model.dart';
import '../params/order_params.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl(this._remote, this._local);

  final OrderRemoteDataSource _remote;
  final OrderLocalDataSource _local;

  String _buildLocationIdentityKey(OrderLocationEntity location) {
    return '${location.latitude.toStringAsFixed(6)},${location.longitude.toStringAsFixed(6)}';
  }

  OrderSavedLocationCacheModel _toSavedCacheModel(
    OrderLocationEntity location,
  ) {
    final normalizedLabel = location.label.trim();
    return OrderSavedLocationCacheModel(
      identityKey: _buildLocationIdentityKey(location),
      latitude: location.latitude,
      longitude: location.longitude,
      label: normalizedLabel,
      isPinned: false,
      touchedAtMillis: 0,
    );
  }

  @override
  Future<Result<List<OrderLocationEntity>>> searchLocations(
    OrderLocationSearchRequestEntity request,
  ) {
    return runAsResult(() async {
      printM('[OrderRepository] searchLocations query="${request.query}"');
      final models = await _remote.searchLocations(
        OrderSearchLocationParams(
          query: request.query,
          biasLat: request.biasLat,
          biasLng: request.biasLng,
        ),
      );
      printG(
        '[OrderRepository] searchLocations success count=${models.length}',
      );
      return models.map((e) => e.toEntity).toList();
    });
  }

  @override
  Future<Result<OrderLocationEntity>> reverseGeocode(
    OrderReverseGeocodeRequestEntity request,
  ) {
    return runAsResult(() async {
      printM(
        '[OrderRepository] reverseGeocode lat=${request.latitude} lng=${request.longitude}',
      );

      final model = await _remote.reverseGeocode(
        OrderReverseGeocodeParams(
          latitude: request.latitude,
          longitude: request.longitude,
        ),
      );

      printG(
        '[OrderRepository] reverseGeocode success label="${model.label}"',
      );

      return model.toEntity;
    });
  }

  @override
  Future<Result<OrderTripRouteEntity>> getTripRoute(
    OrderTripRouteRequestEntity request,
  ) {
    return runAsResult(() async {
      printM(
        '[OrderRepository] getTripRoute stops=${request.stops.length}',
      );

      final model = await _remote.getTripRoute(
        OrderTripRouteParams(
          stops: request.stops
              .map(
                (s) => OrderCoordinateParam(
                  latitude: s.latitude,
                  longitude: s.longitude,
                  label: s.label,
                ),
              )
              .toList(),
        ),
      );

      printG(
        '[OrderRepository] getTripRoute success duration="${model.durationText}" points=${model.points.length}',
      );

      return model.toEntity;
    });
  }

  @override
  Future<Result<List<OrderTripCarOptionEntity>>> getPricingQuotes(
    OrderPricingQuotesRequestEntity request,
  ) {
    return runAsResult(() async {
      printM(
        '[OrderRepository] getPricingQuotes stops=${request.stops.length}',
      );

      final models = await _remote.getPricingQuotes(
        OrderPricingQuotesParams(
          stops: request.stops
              .map(
                (s) => OrderCoordinateParam(
                  latitude: s.latitude,
                  longitude: s.longitude,
                  label: s.label,
                ),
              )
              .toList(),
        ),
      );

      printG(
        '[OrderRepository] getPricingQuotes success count=${models.length}',
      );

      return models.map((model) => model.toEntity).toList();
    });
  }

  @override
  Future<Result<OrderTripResponseEntity>> requestTrip(
    OrderRequestTripEntity request,
  ) {
    return runAsResult(() async {
      printM(
        '[OrderRepository] requestTrip quoteId=${request.quoteId} stops=${request.stops.length}',
      );

      final model = await _remote.requestTrip(
        OrderRequestTripParams(
          quoteId: request.quoteId,
          stops: request.stops
              .map(
                (s) => OrderCoordinateParam(
                  latitude: s.latitude,
                  longitude: s.longitude,
                  label: s.label,
                ),
              )
              .toList(),
          scheduledAt: request.scheduledAt,
        ),
      );

      printG('[OrderRepository] requestTrip success');

      return model.toEntity;
    });
  }

  @override
  Future<Result<List<OrderSavedLocationEntity>>> getSavedLocations() {
    return runAsResult(() async {
      printM('[OrderRepository] getSavedLocations start');
      final models = await _local.getSavedLocations();
      printC('[OrderRepository] getSavedLocations count=${models.length}');
      return models.map((model) => model.toEntity).toList();
    });
  }

  @override
  Future<Result<List<OrderSavedLocationEntity>>> saveSelectedLocation(
    OrderLocationEntity location,
  ) {
    return runAsResult(() async {
      printM(
        '[OrderRepository] saveSelectedLocation lat=${location.latitude} lng=${location.longitude} label="${location.label}"',
      );

      late final List<OrderSavedLocationCacheModel> saved;
      try {
        saved = await _local.saveSelectedLocation(_toSavedCacheModel(location));
      } catch (error, stackTrace) {
        printR('[OrderRepository] saveSelectedLocation local error=$error');
        printR('$stackTrace');
        rethrow;
      }

      printC('[OrderRepository] saveSelectedLocation count=${saved.length}');

      return saved.map((item) => item.toEntity).toList();
    });
  }

  @override
  Future<Result<List<OrderSavedLocationEntity>>> togglePinnedLocation(
    OrderLocationEntity location,
  ) {
    return runAsResult(() async {
      printM(
        '[OrderRepository] togglePinnedLocation lat=${location.latitude} lng=${location.longitude} label="${location.label}"',
      );

      late final List<OrderSavedLocationCacheModel> saved;
      try {
        saved = await _local.togglePinnedLocation(_toSavedCacheModel(location));
      } catch (error, stackTrace) {
        printR('[OrderRepository] togglePinnedLocation local error=$error');
        printR('$stackTrace');
        rethrow;
      }

      printC('[OrderRepository] togglePinnedLocation count=${saved.length}');

      return saved.map((item) => item.toEntity).toList();
    });
  }

  @override
  Future<Result<int>> getTripCount() {
    return runAsResult(() async {
      printM('[OrderRepository] getTripCount start');
      final count = await _remote.getPassengerTripCount();
      printG('[OrderRepository] getTripCount success: $count');
      return count;
    });
  }

  @override
  Future<Result<List<OrderSavedLocationEntity>>> removeSavedLocation(String identityKey) {
    return runAsResult(() async {
      printM('[OrderRepository] removeSavedLocation identity=$identityKey');
      final models = await _local.removeSavedLocation(identityKey);
      printG('[OrderRepository] removeSavedLocation success');
      return models.map((e) => e.toEntity).toList();
    });
  }
}
