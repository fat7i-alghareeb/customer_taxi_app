import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/trip_edit_apply_result_entity.dart';
import '../../domain/entities/trip_edit_preview_entity.dart';
import '../../domain/entities/trip_entity.dart';
import '../../domain/entities/trip_invoice_entity.dart';
import '../../domain/entities/trip_receipt_entity.dart';
import '../../domain/entities/waiting_fee_settlement_entity.dart';
import '../../domain/repositories/trip_repository.dart';
import '../datasources/trip_remote_datasource.dart';
import '../mappers/trip_model_mapper.dart';

@LazySingleton(as: TripRepository)
class TripRepositoryImpl implements TripRepository {
  const TripRepositoryImpl(this._remote);

  final TripRemoteDataSource _remote;

  @override
  Future<Result<TripEntity>> getTripById(String id) {
    return runAsResult(() async {
      printM('[TripRepository] getTripById id=$id');
      final model = await _remote.getTripById(id);
      printG('[TripRepository] getTripById success status=${model.status}');
      return model.toEntity;
    });
  }

  @override
  Future<Result<TripEntity?>> getActiveTrip() {
    return runAsResult(() async {
      printM('[TripRepository] getActiveTrip');
      final model = await _remote.getActiveTrip();
      if (model == null) {
        printG('[TripRepository] getActiveTrip none');
        return null;
      }
      printG('[TripRepository] getActiveTrip status=${model.status}');
      return model.toEntity;
    });
  }

  @override
  Future<Result<TripEntity>> cancelTrip(String id, {String? note}) {
    return runAsResult(() async {
      printM('[TripRepository] cancelTrip id=$id');
      final model = await _remote.cancelTrip(id, note: note);
      printG('[TripRepository] cancelTrip success');
      return model.toEntity;
    });
  }

  @override
  Future<Result<TripEntity>> postponeNoDriverSearch(String id) {
    return runAsResult(() async {
      printM('[TripRepository] postponeNoDriverSearch id=$id');
      final model = await _remote.postponeNoDriverSearch(id);
      printG('[TripRepository] postponeNoDriverSearch success');
      return model.toEntity;
    });
  }

  @override
  Future<Result<TripEntity>> noDriverCancelTrip(String id, {String? note}) {
    return runAsResult(() async {
      printM('[TripRepository] noDriverCancelTrip id=$id');
      final model = await _remote.noDriverCancelTrip(id, note: note);
      printG('[TripRepository] noDriverCancelTrip success');
      return model.toEntity;
    });
  }

  @override
  Future<Result<TripEntity>> updatePassengerNote({
    required String tripId,
    required String? passengerNote,
  }) {
    return runAsResult(() async {
      printM('[TripRepository] updatePassengerNote id=$tripId');
      final model = await _remote.updatePassengerNote(
        tripId: tripId,
        passengerNote: passengerNote,
      );
      printG('[TripRepository] updatePassengerNote success');
      return model.toEntity;
    });
  }

  @override
  Future<Result<void>> rateTrip({
    required String tripId,
    required int stars,
    String? comment,
  }) {
    return runAsResult(() async {
      printM('[TripRepository] rateTrip id=$tripId stars=$stars');
      await _remote.rateTrip(tripId: tripId, stars: stars, comment: comment);
      printG('[TripRepository] rateTrip success');
    });
  }

  @override
  Future<Result<WaitingFeeSettlementEntity>> settleWaitingFee(String tripId) {
    return runAsResult(() async {
      printM('[TripRepository] settleWaitingFee id=$tripId');
      final settlement = await _remote.settleWaitingFee(tripId);
      printG('[TripRepository] settleWaitingFee amount=${settlement.amount}');
      return settlement;
    });
  }

  @override
  Future<Result<TripCompensationClaimEntity>> submitCompensationClaim({
    required String tripId,
    required String note,
    List<String> evidenceUrls = const [],
  }) {
    return runAsResult(() async {
      printM('[TripRepository] submitCompensationClaim trip=$tripId');
      final model = await _remote.submitCompensationClaim(
        tripId: tripId,
        note: note,
        evidenceUrls: evidenceUrls,
      );
      printG('[TripRepository] submitCompensationClaim success');
      return model.toEntity;
    });
  }

  @override
  Future<Result<List<String>>> uploadCompensationEvidence(
    List<String> filePaths,
  ) {
    return runAsResult(() async {
      printM('[TripRepository] uploadCompensationEvidence count=${filePaths.length}');
      final urls = await _remote.uploadCompensationEvidence(filePaths);
      printG('[TripRepository] uploadCompensationEvidence urls=${urls.length}');
      return urls;
    });
  }

  @override
  Future<Result<PagedResult<TripSummaryEntity>>> getTripHistory({
    int page = 1,
    int pageSize = 20,
    String? search,
  }) {
    return runAsResult(() async {
      printM('[TripRepository] getTripHistory page=$page search=$search');
      final result = await _remote.getTripHistory(
        page: page,
        pageSize: pageSize,
        search: search,
      );
      printG('[TripRepository] getTripHistory count=${result.items.length}');
      return PagedResult<TripSummaryEntity>(
        items: result.items.map((m) => m.toSummaryEntity).toList(),
        totalCount: result.totalCount,
        page: result.page,
        pageSize: result.pageSize,
      );
    });
  }

  @override
  Future<Result<TripReceiptEntity>> getTripReceipt(String id) {
    return runAsResult(() async {
      printM('[TripRepository] getTripReceipt id=$id');
      final model = await _remote.getTripReceipt(id);
      printG('[TripRepository] getTripReceipt success');
      return model.toEntity;
    });
  }

  @override
  Future<Result<TripInvoiceEntity>> getTripInvoice(String id) {
    return runAsResult(() async {
      printM('[TripRepository] getTripInvoice id=$id');
      final model = await _remote.getTripInvoice(id);
      printG('[TripRepository] getTripInvoice success');
      return model.toEntity;
    });
  }

  @override
  Future<Result<Uint8List>> getTripInvoicePdf(
    String id, {
    required String languageCode,
  }) {
    return runAsResult(() async {
      printM('[TripRepository] getTripInvoicePdf id=$id lang=$languageCode');
      final bytes = await _remote.getTripInvoicePdfBytes(
        id,
        languageCode: languageCode,
      );
      printG('[TripRepository] getTripInvoicePdf bytes=${bytes.length}');
      return bytes;
    });
  }

  @override
  Future<Result<void>> updateTripScheduledTime({
    required String tripId,
    required DateTime? scheduledAtUtc,
  }) {
    return runAsResult(() async {
      printM('[TripRepository] updateTripScheduledTime id=$tripId');
      await _remote.updateTripScheduledTime(
        tripId: tripId,
        scheduledAtUtc: scheduledAtUtc,
      );
      printG('[TripRepository] updateTripScheduledTime success');
    });
  }

  @override
  Future<Result<void>> updateTripBagCount({
    required String tripId,
    required int bagCount,
  }) {
    return runAsResult(() async {
      printM('[TripRepository] updateTripBagCount id=$tripId count=$bagCount');
      await _remote.updateTripBagCount(tripId: tripId, bagCount: bagCount);
      printG('[TripRepository] updateTripBagCount success');
    });
  }

  @override
  Future<Result<TripEditPreviewEntity>> previewTripEdit({
    required String tripId,
    List<TripStopEntity>? stops,
    int? passengerCount,
  }) {
    return runAsResult(() async {
      printM('[TripRepository] previewTripEdit id=$tripId');
      final preview = await _remote.previewTripEdit(
        tripId: tripId,
        stops: stops == null ? null : _stopsToJson(stops),
        passengerCount: passengerCount,
      );
      printG('[TripRepository] previewTripEdit delta=${preview.delta}');
      return preview;
    });
  }

  @override
  Future<Result<TripEditApplyResultEntity>> applyTripEdit({
    required String tripId,
    List<TripStopEntity>? stops,
    int? passengerCount,
    required double expectedDelta,
    String? previewToken,
  }) {
    return runAsResult(() async {
      printM('[TripRepository] applyTripEdit id=$tripId');
      final result = await _remote.applyTripEdit(
        tripId: tripId,
        stops: stops == null ? null : _stopsToJson(stops),
        passengerCount: passengerCount,
        expectedDelta: expectedDelta,
        previewToken: previewToken,
      );
      printG('[TripRepository] applyTripEdit status=${result.status}');
      return result;
    });
  }

  List<Map<String, dynamic>> _stopsToJson(List<TripStopEntity> stops) => stops
      .map(
        (s) => {
          'latitude': s.latitude,
          'longitude': s.longitude,
          if (s.label != null) 'label': s.label,
        },
      )
      .toList();
}
