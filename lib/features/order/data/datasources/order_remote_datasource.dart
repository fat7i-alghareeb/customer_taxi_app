import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:injectable/injectable.dart';
import 'package:customertaxi/utils/helpers/app_strings.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/order_location_model.dart';
import '../models/order_trip_route_model.dart';
import '../models/order_pricing_quote_model.dart';
import '../models/order_trip_response_model.dart';
import '../params/order_params.dart';

List<PointLatLng> _decodePolyline(String encoded) {
  if (encoded.isEmpty) return const [];
  return PolylinePoints.decodePolyline(encoded);
}

@lazySingleton
class OrderRemoteDataSource {
  const OrderRemoteDataSource(this._dio);

  static const int _polylineDecodeIsolateThreshold = 900;

  final Dio _dio;

  Future<List<PointLatLng>> _decodeOptimized(String encoded) async {
    if (encoded.isEmpty) return const [];
    final stopwatch = Stopwatch()..start();

    printY(
      '[OrderRemoteDataSource] _decodeOptimized: starting decode for string length=${encoded.length}',
      tag: false,
    );

    List<PointLatLng> points;
    if (encoded.length >= _polylineDecodeIsolateThreshold) {
      printY('[OrderRemoteDataSource] _decodeOptimized: using compute (isolate)', tag: false);
      points = await compute(_decodePolyline, encoded);
    } else {
      printY('[OrderRemoteDataSource] _decodeOptimized: using main thread', tag: false);
      points = _decodePolyline(encoded);
    }

    stopwatch.stop();
    printY(
      '[OrderRemoteDataSource] _decodeOptimized: finished in ${stopwatch.elapsedMilliseconds}ms. Points: ${points.length}',
      tag: false,
    );

    if (points.isNotEmpty) {
      printY(
        '[OrderRemoteDataSource] _decodeOptimized: firstPoint=(${points.first.latitude}, ${points.first.longitude}), lastPoint=(${points.last.latitude}, ${points.last.longitude})',
        tag: false,
      );
    }

    return points;
  }

  Future<List<OrderLocationModel>> searchLocations(
    OrderSearchLocationParams params,
  ) {
    return rethrowAsAppException(() async {
      printY(
        '[OrderRemoteDataSource] searchLocations query="${params.query}"',
        tag: false,
      );
      final res = await _dio.post(
        ApiEndpoints.mapsSearch,
        data: params.toJson(),
      );
      final list = res.data as List<dynamic>;
      return list
          .whereType<Map<String, dynamic>>()
          .map(OrderLocationModel.fromBackend)
          .toList();
    });
  }

  Future<OrderLocationModel> reverseGeocode(
    OrderReverseGeocodeParams params,
  ) {
    return rethrowAsAppException(() async {
      printY(
        '[OrderRemoteDataSource] reverseGeocode lat=${params.latitude} lng=${params.longitude}',
        tag: false,
      );
      final res = await _dio.post(
        ApiEndpoints.mapsReverseGeocode,
        data: params.toJson(),
      );
      if (res.data == null) {
        return OrderLocationModel(
          latitude: params.latitude,
          longitude: params.longitude,
          label: AppStrings.orderLocationUnknownLabel,
        );
      }
      return OrderLocationModel.fromReverseGeocodeBackend(
        res.data as Map<String, dynamic>,
      );
    });
  }

  Future<OrderTripRouteModel> getTripRoute(OrderTripRouteParams params) {
    return rethrowAsAppException(() async {
      printY(
        '[OrderRemoteDataSource] getTripRoute: requested for ${params.stops.length} stops',
        tag: false,
      );
      final res = await _dio.post(
        ApiEndpoints.mapsDirections,
        data: params.toJson(),
      );
      final json = res.data as Map<String, dynamic>;

      printY('[OrderRemoteDataSource] getTripRoute: decoding main polyline...', tag: false);
      final encoded = json['encodedPolyline'] as String? ?? '';
      final decoded = await _decodeOptimized(encoded);
      final points = decoded
          .map(
            (p) => OrderTripRoutePointModel(
              latitude: p.latitude,
              longitude: p.longitude,
            ),
          )
          .toList();

      final legsJson = json['legs'] as List<dynamic>? ?? const [];
      final List<List<OrderTripRoutePointModel>> legPoints = [];

      printY(
        '[OrderRemoteDataSource] getTripRoute: total distance=${json['totalDistanceMeters']}m, duration=${json['totalDurationSeconds']}s, legs=${legsJson.length}',
        tag: false,
      );

      for (int i = 0; i < legsJson.length; i++) {
        final leg = legsJson[i] as Map<String, dynamic>;
        printY('[OrderRemoteDataSource] getTripRoute: decoding leg $i...', tag: false);
        final legEncoded = leg['encodedPolyline'] as String? ?? '';
        final legDecoded = await _decodeOptimized(legEncoded);
        final pointsForLeg =
            legDecoded
                .map(
                  (p) => OrderTripRoutePointModel(
                    latitude: p.latitude,
                    longitude: p.longitude,
                  ),
                )
                .toList();

        legPoints.add(pointsForLeg);
      }

      return OrderTripRouteModel.fromBackend(json, points, legPoints);
    });
  }

  Future<List<OrderPricingQuoteModel>> getPricingQuotes(
    OrderPricingQuotesParams params,
  ) {
    return rethrowAsAppException(() async {
      printY(
        '[OrderRemoteDataSource] getPricingQuotes stops=${params.stops.length}',
        tag: false,
      );
      final res = await _dio.post(
        ApiEndpoints.tripQuotes,
        data: params.toJson(),
      );
      final json = res.data as Map<String, dynamic>;
      final list = json['quotes'] as List<dynamic>? ?? const [];
      final distance = (json['totalDistanceKm'] as num?)?.toDouble() ?? 0.0;
      final duration = (json['totalDurationMin'] as num?)?.toDouble() ?? 0.0;

      printY(
        '[OrderRemoteDataSource] getPricingQuotes success distance=$distance duration=$duration quotes=${list.length}',
        tag: false,
      );

      return list.whereType<Map<String, dynamic>>().map((quoteJson) {
        // Inject top-level fields into each quote for model parsing
        final fullQuoteJson = {
          ...quoteJson,
          'totalDistanceKm': distance,
          'totalDurationMin': duration,
        };
        return OrderPricingQuoteModel.fromJson(fullQuoteJson);
      }).toList();
    });
  }

  Future<OrderTripResponseModel> requestTrip(OrderRequestTripParams params) {
    return rethrowAsAppException(() async {
      printY('[OrderRemoteDataSource] requestTrip quoteId=${params.quoteId}', tag: false);
      final res = await _dio.post(
        ApiEndpoints.requestTrip,
        data: params.toJson(),
      );
      return OrderTripResponseModel.fromJson(res.data as Map<String, dynamic>);
    });
  }
 
  Future<int> getPassengerTripCount() {
    return rethrowAsAppException(() async {
      printY('[OrderRemoteDataSource] getPassengerTripCount', tag: false);
      final res = await _dio.get<dynamic>(ApiEndpoints.tripCount);
      return res.data as int;
    });
  }
}
