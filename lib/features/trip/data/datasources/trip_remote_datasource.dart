import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/entities/waiting_fee_settlement_entity.dart';
import '../models/trip_invoice_model.dart';
import '../models/trip_model.dart';
import '../models/trip_receipt_model.dart';

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

  /// Returns the caller's current active trip, or null when the server
  /// responds 204 (no active trip).
  Future<TripModel?> getActiveTrip() {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] getActiveTrip');
      final res = await _dio.get<dynamic>(ApiEndpoints.tripActive);
      final data = res.data;
      if (res.statusCode == 204 || data == null || data is! Map) {
        return null;
      }
      return TripModel.fromJson(Map<String, dynamic>.from(data));
    });
  }

  Future<TripModel> cancelTrip(String id, {String? note}) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] cancelTrip id=$id note=$note');
      final res = await _dio.post<dynamic>(
        ApiEndpoints.cancelTrip(id),
        data: {
          'reason': 'PassengerWithinOneHour',
          'note': (note == null || note.trim().isEmpty)
              ? 'Passenger requested cancellation from customer app'
              : note.trim(),
        },
      );
      return TripModel.fromJson(res.data as Map<String, dynamic>);
    });
  }

  Future<TripModel> updatePassengerNote({
    required String tripId,
    required String? passengerNote,
  }) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] updatePassengerNote id=$tripId');
      final res = await _dio.put<dynamic>(
        ApiEndpoints.updatePassengerNote(tripId),
        data: {'passengerNote': passengerNote},
      );
      return TripModel.fromJson(res.data as Map<String, dynamic>);
    });
  }

  Future<void> rateTrip({
    required String tripId,
    required int stars,
    String? comment,
  }) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] rateTrip id=$tripId stars=$stars');
      await _dio.post<dynamic>(
        ApiEndpoints.rateTrip(tripId),
        data: {'stars': stars, 'comment': comment},
      );
    });
  }

  Future<WaitingFeeSettlementEntity> settleWaitingFee(String tripId) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] settleWaitingFee id=$tripId');
      final res = await _dio.post<dynamic>(
        ApiEndpoints.settleWaitingFee(tripId),
      );
      final data = res.data as Map<String, dynamic>;
      final sp = data['stripePayment'] as Map<String, dynamic>?;
      return WaitingFeeSettlementEntity(
        amount: (data['amount'] as num?)?.toDouble() ?? 0,
        currencyCode: data['currencyCode'] as String? ?? 'EUR',
        stripePayment: sp == null
            ? null
            : WaitingFeeStripePaymentEntity(
                paymentIntentId: sp['paymentIntentId'] as String? ?? '',
                clientSecret: sp['clientSecret'] as String? ?? '',
                publishableKey: sp['publishableKey'] as String? ?? '',
                customerId: sp['customerId'] as String? ?? '',
                ephemeralKeySecret: sp['ephemeralKeySecret'] as String? ?? '',
              ),
      );
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

  Future<TripReceiptModel> getTripReceipt(String id) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] getTripReceipt id=$id');
      final res = await _dio.get<dynamic>(ApiEndpoints.tripReceipt(id));
      return TripReceiptModel.fromJson(res.data as Map<String, dynamic>);
    });
  }

  Future<TripInvoiceModel> getTripInvoice(String id) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] getTripInvoice id=$id');
      final res = await _dio.get<dynamic>(ApiEndpoints.tripInvoice(id));
      return TripInvoiceModel.fromJson(res.data as Map<String, dynamic>);
    });
  }

  Future<Uint8List> getTripInvoicePdfBytes(
    String id, {
    required String languageCode,
  }) {
    return rethrowAsAppException(() async {
      printY(
        '[TripRemoteDataSource] getTripInvoicePdfBytes id=$id lang=$languageCode',
      );
      final res = await _dio.get<List<int>>(
        ApiEndpoints.tripInvoicePdf(id),
        queryParameters: {'language': languageCode},
        options: Options(responseType: ResponseType.bytes),
      );
      return Uint8List.fromList(res.data ?? const <int>[]);
    });
  }
}
