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
import '../models/order_model.dart';
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
    if (encoded.length >= _polylineDecodeIsolateThreshold) {
      return compute(_decodePolyline, encoded);
    }
    return _decodePolyline(encoded);
  }

  Future<List<OrderModel>> getAllOrders() {
    return rethrowAsAppException(() async {
      printY('[OrderRemoteDataSource] getAllOrders -> /order', tag: false);
      final response = await _dio.get<dynamic>('/order');
      final data = response.data;
      final dataList = data['data'] as List<dynamic>;
      return dataList.map((e) => OrderModel.fromJson(e)).toList();
    });
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
        '[OrderRemoteDataSource] getTripRoute stops=${params.stops.length}',
        tag: false,
      );
      final res = await _dio.post(
        ApiEndpoints.mapsDirections,
        data: params.toJson(),
      );
      final json = res.data as Map<String, dynamic>;
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
      return OrderTripRouteModel.fromBackend(json, points);
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
      final list = res.data as List<dynamic>;
      return list
          .whereType<Map<String, dynamic>>()
          .map(OrderPricingQuoteModel.fromJson)
          .toList();
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
}
