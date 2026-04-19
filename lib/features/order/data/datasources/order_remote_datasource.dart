import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:injectable/injectable.dart';
import 'package:customertaxi/core/config/env/env.dart';
import 'package:customertaxi/utils/helpers/app_strings.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../constants/order_constants.dart';
import '../../../../core/error/global_error_handler.dart';
import '../models/order_trip_car_option_model.dart';
import '../models/order_trip_route_model.dart';
import '../params/order_params.dart';
import '../models/order_location_model.dart';
import '../models/order_model.dart';

List<PointLatLng> _decodeOverviewPolyline(String encodedPolyline) {
  if (encodedPolyline.isEmpty) {
    return const <PointLatLng>[];
  }

  return PolylinePoints.decodePolyline(encodedPolyline);
}

@lazySingleton
class OrderRemoteDataSource {
  const OrderRemoteDataSource(this._dio);

  static const String _googleGeocodeEndpoint =
      'https://maps.googleapis.com/maps/api/geocode/json';
  static const String _googlePlacesTextSearchEndpoint =
      'https://maps.googleapis.com/maps/api/place/textsearch/json';
  static const String _googleDirectionsEndpoint =
      'https://maps.googleapis.com/maps/api/directions/json';
  static const String _googlePlacesNearbySearchEndpoint =
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json';

  static const Duration _mockPricingDelay = Duration(milliseconds: 900);
  static const int _polylineDecodeIsolateThresholdChars = 900;

  final Dio _dio;

  Future<List<PointLatLng>> _decodeOverviewPolylineOptimized(
    String encodedPolyline,
  ) async {
    if (encodedPolyline.isEmpty) {
      return const <PointLatLng>[];
    }

    final useIsolate =
        encodedPolyline.length >= _polylineDecodeIsolateThresholdChars;

    printM(
      '[OrderRemoteDataSource] decodeOverviewPolyline mode=${useIsolate ? 'isolate' : 'inline'} encodedLength=${encodedPolyline.length}',
    );

    if (!useIsolate) {
      return _decodeOverviewPolyline(encodedPolyline);
    }

    return compute(_decodeOverviewPolyline, encodedPolyline);
  }

  Future<List<OrderModel>> getAllOrders() {
    return rethrowAsAppException(() async {
      printY('[OrderRemoteDataSource] getAllOrders -> /order');
      final response = await _dio.get<dynamic>('/order');
      final data = response.data;
      final dataList = data['data'] as List<dynamic>;
      printG(
        '[OrderRemoteDataSource] getAllOrders success count=${dataList.length}',
      );
      return dataList.map((e) => OrderModel.fromJson(e)).toList();
    });
  }

  Future<List<OrderLocationModel>> searchLocations(
    OrderSearchLocationParams params,
  ) {
    return rethrowAsAppException(() async {
      printY('[OrderRemoteDataSource] searchLocations query="${params.query}"');

      final geocodeResults = await _searchByGeocode(params.query);
      final placesResults = await _searchByPlacesText(params.query);

      printC(
        '[OrderRemoteDataSource] searchLocations sources geocode=${geocodeResults.length} places=${placesResults.length}',
      );

      final merged = _mergeUniqueLocations(
        primary: placesResults,
        secondary: geocodeResults,
        limit: 30,
      );

      printG(
        '[OrderRemoteDataSource] searchLocations mergedCount=${merged.length}',
      );
      return merged;
    });
  }

  Future<List<OrderLocationModel>> _searchByGeocode(String query) async {
    try {
      final response = await _dio.get<dynamic>(
        _googleGeocodeEndpoint,
        queryParameters: {'address': query, 'key': Env.googleMapsApiKey},
      );

      final data = response.data as Map<String, dynamic>;
      final status = data['status']?.toString() ?? '';
      printC('[OrderRemoteDataSource] geocode status=$status');

      if (status == 'ZERO_RESULTS') {
        return const <OrderLocationModel>[];
      }

      if (status != 'OK') {
        printY('[OrderRemoteDataSource] geocode ignored status=$status');
        return const <OrderLocationModel>[];
      }

      final results = data['results'] as List<dynamic>? ?? const [];
      return results
          .whereType<Map<String, dynamic>>()
          .map(OrderLocationModel.fromGoogleResult)
          .toList();
    } catch (e) {
      printY('[OrderRemoteDataSource] geocode search failed: $e');
      return const <OrderLocationModel>[];
    }
  }

  Future<List<OrderLocationModel>> _searchByPlacesText(String query) async {
    try {
      final response = await _dio.get<dynamic>(
        _googlePlacesTextSearchEndpoint,
        queryParameters: {'query': query, 'key': Env.googleMapsApiKey},
      );

      final data = response.data as Map<String, dynamic>;
      final status = data['status']?.toString() ?? '';
      printC('[OrderRemoteDataSource] placesText status=$status');

      if (status == 'ZERO_RESULTS') {
        return const <OrderLocationModel>[];
      }

      if (status != 'OK') {
        printY('[OrderRemoteDataSource] placesText ignored status=$status');
        return const <OrderLocationModel>[];
      }

      final results = data['results'] as List<dynamic>? ?? const [];
      return results
          .whereType<Map<String, dynamic>>()
          .map(OrderLocationModel.fromPlacesTextResult)
          .toList();
    } catch (e) {
      printY('[OrderRemoteDataSource] placesText search failed: $e');
      return const <OrderLocationModel>[];
    }
  }

  List<OrderLocationModel> _mergeUniqueLocations({
    required List<OrderLocationModel> primary,
    required List<OrderLocationModel> secondary,
    required int limit,
  }) {
    final seen = <String>{};
    final merged = <OrderLocationModel>[];

    void addAllUnique(List<OrderLocationModel> input) {
      for (final item in input) {
        final key =
            '${item.label.trim().toLowerCase()}|${item.latitude.toStringAsFixed(5)}|${item.longitude.toStringAsFixed(5)}';

        if (!seen.add(key)) {
          continue;
        }

        merged.add(item);
        if (merged.length >= limit) {
          return;
        }
      }
    }

    addAllUnique(primary);
    if (merged.length < limit) {
      addAllUnique(secondary);
    }

    return merged;
  }

  Future<OrderLocationModel?> getNearbyPlace({
    required double latitude,
    required double longitude,
    int radius = 60,
  }) {
    return rethrowAsAppException(() async {
      printY(
        '[OrderRemoteDataSource] getNearbyPlace lat=$latitude lng=$longitude radius=$radius',
      );

      final response = await _dio.get<dynamic>(
        _googlePlacesNearbySearchEndpoint,
        queryParameters: {
          'location': '$latitude,$longitude',
          'radius': radius.toString(),
          'key': Env.googleMapsApiKey,
          // We want the most specific/prominent names first
          'rankby': 'prominence',
        },
      );

      final data = response.data as Map<String, dynamic>;
      final status = data['status']?.toString() ?? '';
      final results = data['results'] as List<dynamic>? ?? const [];

      printC(
        '[OrderRemoteDataSource] getNearbyPlace status=$status results=${results.length}',
      );

      if (status == 'OK' && results.isNotEmpty) {
        // Exclude generic types like 'political', 'locality' where the name is just the city
        final specificResults = results.whereType<Map<String, dynamic>>().where((
          res,
        ) {
          final types = (res['types'] as List<dynamic>? ?? const [])
              .map((t) => t.toString())
              .toSet();
          return !types.contains('locality') &&
              !types.contains('political') &&
              !types.contains('country');
        }).toList();

        if (specificResults.isNotEmpty) {
          final bestNearby = specificResults.first;
          final model = OrderLocationModel.fromNearbyResult(bestNearby);
          printG(
            '[OrderRemoteDataSource] getNearbyPlace found name="${model.primaryName}" vicinity="${model.secondaryAddress}"',
          );
          return model;
        }
      }

      return null;
    });
  }

  Future<OrderLocationModel> reverseGeocode(OrderReverseGeocodeParams params) {

    return rethrowAsAppException(() async {
      printY(
        '[OrderRemoteDataSource] reverseGeocode lat=${params.latitude} lng=${params.longitude}',
      );
      final response = await _dio.get<dynamic>(
        _googleGeocodeEndpoint,
        queryParameters: {
          'latlng': '${params.latitude},${params.longitude}',
          'key': Env.googleMapsApiKey,
        },
      );

      final data = response.data as Map<String, dynamic>;
      final status = data['status']?.toString() ?? '';
      final results = data['results'] as List<dynamic>? ?? const [];
      printC(
        '[OrderRemoteDataSource] reverseGeocode status=$status results=${results.length}',
      );

      if (status == 'OK' && results.isNotEmpty) {
        final normalizedResults =
            results.whereType<Map<String, dynamic>>().toList()..sort(
              (first, second) => _reverseGeocodeResultScore(
                second,
              ).compareTo(_reverseGeocodeResultScore(first)),
            );

        final bestResult = normalizedResults.first;
        final bestReadable = OrderLocationModel.fromGoogleResult(bestResult);

        printG(
          '[OrderRemoteDataSource] reverseGeocode success label="${bestReadable.label}"',
        );

        return bestReadable;
      }

      printY(
        '[OrderRemoteDataSource] reverseGeocode fallback to default label',
      );

      return OrderLocationModel(
        latitude: params.latitude,
        longitude: params.longitude,
        label: AppStrings.orderLocationUnknownLabel,
      );
    });
  }

  int _reverseGeocodeResultScore(Map<String, dynamic> result) {
    final resultTypes = (result['types'] as List<dynamic>? ?? const <dynamic>[])
        .map((type) => type.toString())
        .toSet();

    int score = 0;

    if (resultTypes.contains('street_address')) {
      score += 100;
    }

    if (resultTypes.contains('premise') ||
        resultTypes.contains('subpremise') ||
        resultTypes.contains('establishment')) {
      score += 90;
    }

    if (resultTypes.contains('route') || resultTypes.contains('intersection')) {
      score += 80;
    }

    if (resultTypes.contains('point_of_interest')) {
      score += 75;
    }

    if (resultTypes.contains('neighborhood') ||
        resultTypes.contains('sublocality') ||
        resultTypes.contains('sublocality_level_1')) {
      score += 65;
    }

    if (resultTypes.contains('plus_code')) {
      score += 20;
    }

    if (resultTypes.contains('locality')) {
      score += 10;
    }

    final components =
        result['address_components'] as List<dynamic>? ?? const <dynamic>[];

    final hasStreetComponent = components.whereType<Map<String, dynamic>>().any(
      (component) {
        final types = component['types'] as List<dynamic>? ?? const <dynamic>[];
        final typeSet = types.map((type) => type.toString()).toSet();

        return typeSet.contains('route') ||
            typeSet.contains('street_number') ||
            typeSet.contains('premise');
      },
    );

    if (hasStreetComponent) {
      score += 25;
    }

    return score;
  }

  Future<OrderTripRouteModel> getTripRoute(OrderTripRouteParams params) {
    return rethrowAsAppException(() async {
      printY(
        '[OrderRemoteDataSource] getTripRoute from=(${params.fromLatitude},${params.fromLongitude}) to=(${params.toLatitude},${params.toLongitude})',
      );

      final response = await _dio.get<dynamic>(
        _googleDirectionsEndpoint,
        queryParameters: {
          'origin': '${params.fromLatitude},${params.fromLongitude}',
          'destination': '${params.toLatitude},${params.toLongitude}',
          'mode': 'driving',
          'key': Env.googleMapsApiKey,
        },
      );

      final data = response.data as Map<String, dynamic>;
      final status = data['status']?.toString() ?? '';
      final routes = data['routes'] as List<dynamic>? ?? const [];

      printC(
        '[OrderRemoteDataSource] getTripRoute status=$status routes=${routes.length}',
      );

      if (status != 'OK' || routes.isEmpty) {
        throw Exception('directions_failed_status_$status');
      }

      final route = routes.first;
      if (route is! Map<String, dynamic>) {
        throw Exception('directions_invalid_route_shape');
      }

      final overviewPolyline = route['overview_polyline'];
      final encodedPolyline = overviewPolyline is Map<String, dynamic>
          ? overviewPolyline['points']?.toString() ?? ''
          : '';

      final decodedPolyline = await _decodeOverviewPolylineOptimized(
        encodedPolyline,
      );

      final legs = route['legs'] as List<dynamic>? ?? const [];
      final legMaps = legs.whereType<Map<String, dynamic>>().toList();

      final firstLeg = legMaps.isNotEmpty ? legMaps.first : null;
      final firstDuration = firstLeg?['duration'];
      final firstDistance = firstLeg?['distance'];

      final durationText = firstDuration is Map<String, dynamic>
          ? firstDuration['text']?.toString() ?? ''
          : '';

      final distanceText = firstDistance is Map<String, dynamic>
          ? firstDistance['text']?.toString() ?? ''
          : '';

      final distanceMetersFromLegs = legMaps.fold<int>(0, (sum, leg) {
        final distanceMap = leg['distance'];
        if (distanceMap is! Map<String, dynamic>) {
          return sum;
        }

        final meters = (distanceMap['value'] as num?)?.toInt() ?? 0;
        return sum + meters;
      });

      final distanceMeters = distanceMetersFromLegs > 0
          ? distanceMetersFromLegs
          : _estimateDistanceMeters(
              fromLatitude: params.fromLatitude,
              fromLongitude: params.fromLongitude,
              toLatitude: params.toLatitude,
              toLongitude: params.toLongitude,
            );

      final points = decodedPolyline.isNotEmpty
          ? decodedPolyline
                .map(
                  (point) => <String, dynamic>{
                    'latitude': point.latitude,
                    'longitude': point.longitude,
                  },
                )
                .toList()
          : <Map<String, dynamic>>[
              {
                'latitude': params.fromLatitude,
                'longitude': params.fromLongitude,
              },
              {'latitude': params.toLatitude, 'longitude': params.toLongitude},
            ];

      final model = OrderTripRouteModel.fromJson({
        'points': points,
        'durationText': durationText,
        'distanceText': distanceText,
        'distanceMeters': distanceMeters,
      });

      printG(
        '[OrderRemoteDataSource] getTripRoute success duration="${model.durationText}" distanceMeters=${model.distanceMeters} points=${model.points.length}',
      );

      return model;
    });
  }

  Future<List<OrderTripCarOptionModel>> getTripCarOptions(
    OrderTripPricingParams params,
  ) {
    return rethrowAsAppException(() async {
      printY(
        '[OrderRemoteDataSource] getTripCarOptions from=(${params.fromLatitude},${params.fromLongitude}) to=(${params.toLatitude},${params.toLongitude})',
      );

      await Future<void>.delayed(_mockPricingDelay);

      final distanceKm =
          _estimateDistanceMeters(
            fromLatitude: params.fromLatitude,
            fromLongitude: params.fromLongitude,
            toLatitude: params.toLatitude,
            toLongitude: params.toLongitude,
          ) /
          1000;

      final baseFare = 2.4 + (distanceKm * 0.78);

      final models = <OrderTripCarOptionModel>[
        OrderTripCarOptionModel.fromJson({
          'typeId': OrderConstants.carTypeStandard,
          'name': 'Standard',
          'price': _roundPrice(baseFare),
          'currency': 'USD',
        }),
        OrderTripCarOptionModel.fromJson({
          'typeId': OrderConstants.carTypeComfort,
          'name': 'Comfort',
          'price': _roundPrice(baseFare * 1.28),
          'currency': 'USD',
        }),
        OrderTripCarOptionModel.fromJson({
          'typeId': OrderConstants.carTypeBus8,
          'name': '8-passenger bus',
          'price': _roundPrice(baseFare * 1.95),
          'currency': 'USD',
        }),
      ];

      printG(
        '[OrderRemoteDataSource] getTripCarOptions success count=${models.length}',
      );

      return models;
    });
  }

  int _estimateDistanceMeters({
    required double fromLatitude,
    required double fromLongitude,
    required double toLatitude,
    required double toLongitude,
  }) {
    const earthRadiusKm = 6371.0;

    final dLat = _toRadians(toLatitude - fromLatitude);
    final dLng = _toRadians(toLongitude - fromLongitude);

    final sinLat = math.sin(dLat / 2);
    final sinLng = math.sin(dLng / 2);

    final a =
        (sinLat * sinLat) +
        math.cos(_toRadians(fromLatitude)) *
            math.cos(_toRadians(toLatitude)) *
            (sinLng * sinLng);

    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    final distanceKm = earthRadiusKm * c;

    return (distanceKm * 1000).round();
  }

  double _toRadians(double value) {
    return value * (math.pi / 180);
  }

  double _roundPrice(double value) {
    return (value * 100).roundToDouble() / 100;
  }
}
