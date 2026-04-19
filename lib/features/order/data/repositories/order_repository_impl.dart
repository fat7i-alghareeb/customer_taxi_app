import 'package:injectable/injectable.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/order_location_entity.dart';
import '../../domain/entities/order_location_request_entity.dart';
import '../../domain/entities/order_saved_location_entity.dart';
import '../../domain/entities/order_trip_car_option_entity.dart';
import '../../domain/entities/order_trip_route_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_local_datasource.dart';
import '../datasources/order_remote_datasource.dart';
import '../mappers/order_location_model_mapper.dart';
import '../mappers/order_model_mapper.dart';
import '../mappers/order_saved_location_cache_model_mapper.dart';
import '../mappers/order_trip_car_option_model_mapper.dart';
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
  Future<Result<List<OrderEntity>>> getAllOrders() {
    return runAsResult(() async {
      printM('[OrderRepository] getAllOrders start');
      final models = await _remote.getAllOrders();
      printG('[OrderRepository] getAllOrders success count=${models.length}');
      return models.map((e) => e.toEntity).toList();
    });
  }

  @override
  Future<Result<List<OrderLocationEntity>>> searchLocations(
    OrderLocationSearchRequestEntity request,
  ) {
    return runAsResult(() async {
      printM('[OrderRepository] searchLocations query="${request.query}"');
      final models = await _remote.searchLocations(
        OrderSearchLocationParams(query: request.query),
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
        '[OrderRepository] hybrid reverseGeocode lat=${request.latitude} lng=${request.longitude}',
      );

      // Perform parallel lookups for best performance
      final results = await Future.wait([
        _remote.reverseGeocode(
          OrderReverseGeocodeParams(
            latitude: request.latitude,
            longitude: request.longitude,
          ),
        ),
        _remote.getNearbyPlace(
          latitude: request.latitude,
          longitude: request.longitude,
        ),
      ]);

      final geocodeResult = results[0]!;
      final nearbyPlace = results[1];

      if (nearbyPlace != null) {
        // Smart Selection Logic:
        // By default, we prefer the Nearby Search result (specific establishment).
        // BUT: If Geocoding found a Building/Establishment and Nearby only found a Street (Route),
        // we prefer the Geocoding building name as the primary.
        final preferGeocode =
            geocodeResult.isEstablishment && !nearbyPlace.isEstablishment;

        final bestPrimary = preferGeocode ? geocodeResult.primaryName : nearbyPlace.primaryName;

        // Triple-Anchor Display Logic:
        // Combine [Place] + [Street] + [Neighborhood]
        final placeName = bestPrimary ?? '';
        final street = geocodeResult.street ?? '';
        final neighborhood = geocodeResult.neighborhood ?? '';

        final displayParts = <String>[];
        if (placeName.isNotEmpty) displayParts.add(placeName);
        
        // Add street if not already in place name
        if (street.isNotEmpty && !placeName.toLowerCase().contains(street.toLowerCase())) {
          displayParts.add(street);
        }

        String finalPrimary = displayParts.join(', ');

        // Add neighborhood in parentheses if not already present
        if (neighborhood.isNotEmpty && !finalPrimary.toLowerCase().contains(neighborhood.toLowerCase())) {
          finalPrimary = '$finalPrimary ($neighborhood)';
        }

        printG(
          '[OrderRepository] triple-anchor success: "$finalPrimary" (Place=$placeName, Street=$street, Neighborhood=$neighborhood)',
        );

        final genericSecondary = geocodeResult.label;
        final hybridModel = nearbyPlace.copyWith(
          primaryName: finalPrimary,
          label: finalPrimary,
          secondaryAddress: genericSecondary,
        );

        return hybridModel.toEntity;
      }


      printG(
        '[OrderRepository] geocode-only success label="${geocodeResult.label}"',
      );

      return geocodeResult.toEntity;
    });
  }

  @override
  Future<Result<OrderTripRouteEntity>> getTripRoute(
    OrderTripRouteRequestEntity request,
  ) {
    return runAsResult(() async {
      printM(
        '[OrderRepository] getTripRoute from=(${request.fromLatitude},${request.fromLongitude}) to=(${request.toLatitude},${request.toLongitude})',
      );

      final model = await _remote.getTripRoute(
        OrderTripRouteParams(
          fromLatitude: request.fromLatitude,
          fromLongitude: request.fromLongitude,
          toLatitude: request.toLatitude,
          toLongitude: request.toLongitude,
        ),
      );

      printG(
        '[OrderRepository] getTripRoute success duration="${model.durationText}" points=${model.points.length}',
      );

      return model.toEntity;
    });
  }

  @override
  Future<Result<List<OrderTripCarOptionEntity>>> getTripCarOptions(
    OrderTripPricingRequestEntity request,
  ) {
    return runAsResult(() async {
      printM(
        '[OrderRepository] getTripCarOptions from=(${request.fromLatitude},${request.fromLongitude}) to=(${request.toLatitude},${request.toLongitude})',
      );

      final models = await _remote.getTripCarOptions(
        OrderTripPricingParams(
          fromLatitude: request.fromLatitude,
          fromLongitude: request.fromLongitude,
          toLatitude: request.toLatitude,
          toLongitude: request.toLongitude,
        ),
      );

      printG(
        '[OrderRepository] getTripCarOptions success count=${models.length}',
      );

      return models.map((model) => model.toEntity).toList();
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
}
