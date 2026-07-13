import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/entities/trip_edit_apply_result_entity.dart';
import '../../domain/entities/trip_edit_preview_entity.dart';
import '../../domain/entities/waiting_fee_settlement_entity.dart';
import '../mappers/trip_model_mapper.dart';
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
      // The server recomputes the policy reason/refund from trip timing; the
      // passenger's own reason is carried as a free-text note only.
      final res = await _dio.post<dynamic>(
        ApiEndpoints.cancelTrip(id),
        data: {
          'note': (note == null || note.trim().isEmpty)
              ? 'Passenger requested cancellation from customer app'
              : note.trim(),
        },
      );
      return TripModel.fromJson(res.data as Map<String, dynamic>);
    });
  }

  Future<TripModel> postponeNoDriverSearch(String tripId) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] postponeNoDriverSearch id=$tripId');
      final res = await _dio.post<dynamic>(
        ApiEndpoints.postponeNoDriver(tripId),
      );
      return TripModel.fromJson(res.data as Map<String, dynamic>);
    });
  }

  Future<TripModel> noDriverCancelTrip(String tripId, {String? note}) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] noDriverCancelTrip id=$tripId');
      final res = await _dio.post<dynamic>(
        ApiEndpoints.noDriverCancelTrip(tripId),
        data: {
          if (note != null && note.trim().isNotEmpty) 'note': note.trim(),
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

  /// Uploads an in-trip safety audio recording and returns its server URL.
  Future<String> uploadTripRecording({
    required String tripId,
    required String filePath,
    int? durationSeconds,
  }) {
    return rethrowAsAppException(() async {
      printY(
        '[TripRemoteDataSource] uploadTripRecording trip=$tripId duration=$durationSeconds',
      );
      final formData = FormData();
      formData.files.add(
        MapEntry('file', await MultipartFile.fromFile(filePath)),
      );
      if (durationSeconds != null) {
        formData.fields.add(
          MapEntry('durationSeconds', durationSeconds.toString()),
        );
      }
      final res = await _dio.post<dynamic>(
        ApiEndpoints.uploadTripRecording(tripId),
        data: formData,
      );
      final data = res.data;
      return (data is Map<String, dynamic> ? data['url'] as String? : null) ??
          '';
    });
  }

  Future<PagedResult<TripSummaryModel>> getTripHistory({
    int page = 1,
    int pageSize = 20,
    String? search,
  }) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] getTripHistory page=$page search=$search');
      final res = await _dio.get<dynamic>(
        ApiEndpoints.tripHistory,
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
          if (search != null && search.isNotEmpty) 'search': search,
        },
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

  Future<void> updateTripScheduledTime({
    required String tripId,
    required DateTime? scheduledAtUtc,
  }) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] updateTripScheduledTime id=$tripId');
      await _dio.put<dynamic>(
        ApiEndpoints.updateTripScheduledTime(tripId),
        data: {'scheduledAtUtc': scheduledAtUtc?.toUtc().toIso8601String()},
      );
    });
  }

  Future<TripModel> updateTripStops({
    required String tripId,
    required List<Map<String, dynamic>> stops,
  }) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] updateTripStops id=$tripId');
      final res = await _dio.put<dynamic>(
        ApiEndpoints.updateTripStops(tripId),
        data: {'stops': stops},
      );
      return TripModel.fromJson(res.data as Map<String, dynamic>);
    });
  }

  Future<TripModel> updateTripPassengerCount({
    required String tripId,
    required int passengerCount,
  }) {
    return rethrowAsAppException(() async {
      printY(
        '[TripRemoteDataSource] updateTripPassengerCount id=$tripId count=$passengerCount',
      );
      final res = await _dio.put<dynamic>(
        ApiEndpoints.updateTripPassengerCount(tripId),
        data: {'passengerCount': passengerCount},
      );
      return TripModel.fromJson(res.data as Map<String, dynamic>);
    });
  }

  Future<TripEditPreviewEntity> previewTripEdit({
    required String tripId,
    List<Map<String, dynamic>>? stops,
    int? passengerCount,
  }) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] previewTripEdit id=$tripId');
      final res = await _dio.post<dynamic>(
        ApiEndpoints.previewTripEdit(tripId),
        data: {
          'stops': ?stops,
          'passengerCount': ?passengerCount,
        },
      );
      final data = res.data as Map<String, dynamic>;
      return TripEditPreviewEntity(
        oldFinalFare: (data['oldFinalFare'] as num?)?.toDouble() ?? 0,
        newFinalFare: (data['newFinalFare'] as num?)?.toDouble() ?? 0,
        delta: (data['delta'] as num?)?.toDouble() ?? 0,
        currency: data['currency'] as String? ?? 'EUR',
        effectivePassengerCount: (data['effectivePassengerCount'] as num?)
                ?.toInt() ??
            0,
        direction: data['direction'] as String? ?? 'none',
        newVehicleTypeId: data['newVehicleTypeId'] as String?,
        newVehicleTypeName: data['newVehicleTypeName'] as String?,
      );
    });
  }

  Future<TripEditApplyResultEntity> applyTripEdit({
    required String tripId,
    List<Map<String, dynamic>>? stops,
    int? passengerCount,
    required double expectedDelta,
  }) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] applyTripEdit id=$tripId');
      final res = await _dio.post<dynamic>(
        ApiEndpoints.applyTripEdit(tripId),
        data: {
          'stops': ?stops,
          'passengerCount': ?passengerCount,
          'expectedDelta': expectedDelta,
        },
      );
      final data = res.data as Map<String, dynamic>;
      final tripJson = data['trip'] as Map<String, dynamic>?;
      final sheet = data['paymentSheet'] as Map<String, dynamic>?;
      return TripEditApplyResultEntity(
        status: data['status'] as String? ?? 'applied',
        delta: (data['delta'] as num?)?.toDouble() ?? 0,
        currency: data['currency'] as String? ?? 'EUR',
        trip: tripJson == null ? null : TripModel.fromJson(tripJson).toEntity,
        pendingEditId: data['pendingEditId'] as String?,
        paymentSheet: sheet == null
            ? null
            : WaitingFeeStripePaymentEntity(
                paymentIntentId: sheet['paymentIntentId'] as String? ?? '',
                clientSecret: sheet['clientSecret'] as String? ?? '',
                publishableKey: sheet['publishableKey'] as String? ?? '',
                customerId: sheet['customerId'] as String? ?? '',
                ephemeralKeySecret:
                    sheet['ephemeralKeySecret'] as String? ?? '',
              ),
      );
    });
  }

  Future<void> updateTripBagCount({
    required String tripId,
    required int bagCount,
  }) {
    return rethrowAsAppException(() async {
      printY(
        '[TripRemoteDataSource] updateTripBagCount id=$tripId count=$bagCount',
      );
      await _dio.put<dynamic>(
        ApiEndpoints.updateTripBagCount(tripId),
        data: {'bagCount': bagCount},
      );
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
