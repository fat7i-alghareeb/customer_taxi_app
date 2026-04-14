import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:customertaxi/core/config/env/env.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/error/global_error_handler.dart';
import '../params/order_params.dart';
import '../models/order_location_model.dart';
import '../models/order_model.dart';

@lazySingleton
class OrderRemoteDataSource {
  const OrderRemoteDataSource(this._dio);

  static const String _googleGeocodeEndpoint =
      'https://maps.googleapis.com/maps/api/geocode/json';
  static const String _googlePlacesTextSearchEndpoint =
      'https://maps.googleapis.com/maps/api/place/textsearch/json';

  final Dio _dio;

  static final RegExp _coordinatesLabelRegex = RegExp(
    r'^-?\d+(?:\.\d+)?,\s*-?\d+(?:\.\d+)?$',
  );

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
        final normalizedResults = results.whereType<Map<String, dynamic>>();
        final bestReadable = normalizedResults
            .map(OrderLocationModel.fromGoogleResult)
            .firstWhere(
              (location) => !_coordinatesLabelRegex.hasMatch(location.label),
              orElse: () => OrderLocationModel(
                latitude: params.latitude,
                longitude: params.longitude,
                label:
                    '${params.latitude.toStringAsFixed(6)}, ${params.longitude.toStringAsFixed(6)}',
              ),
            );

        if (!_coordinatesLabelRegex.hasMatch(bestReadable.label)) {
          printG(
            '[OrderRemoteDataSource] reverseGeocode success label="${bestReadable.label}"',
          );
          return bestReadable;
        }

        final first = results.first;
        if (first is Map<String, dynamic>) {
          final fallbackReadable = OrderLocationModel.fromGoogleResult(first);
          printY(
            '[OrderRemoteDataSource] reverseGeocode fallback first result label="${fallbackReadable.label}"',
          );
          return fallbackReadable;
        }
      }

      printY(
        '[OrderRemoteDataSource] reverseGeocode fallback to lat,lng label',
      );

      return OrderLocationModel(
        latitude: params.latitude,
        longitude: params.longitude,
        label:
            '${params.latitude.toStringAsFixed(6)}, ${params.longitude.toStringAsFixed(6)}',
      );
    });
  }
}
