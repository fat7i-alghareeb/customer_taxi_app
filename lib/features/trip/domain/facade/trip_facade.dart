import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/utils/result.dart';
import '../entities/trip_entity.dart';
import '../entities/trip_invoice_entity.dart';
import '../entities/trip_receipt_entity.dart';
import '../entities/waiting_fee_settlement_entity.dart';
import '../repositories/trip_repository.dart';
import '../../data/datasources/trip_remote_datasource.dart';

@lazySingleton
class TripFacade {
  const TripFacade(this._repository);

  final TripRepository _repository;

  Future<Result<TripEntity>> getTripById(String id) {
    printC('[TripFacade] getTripById id=$id');
    return _repository.getTripById(id);
  }

  Future<Result<TripEntity?>> getActiveTrip() {
    printC('[TripFacade] getActiveTrip');
    return _repository.getActiveTrip();
  }

  Future<Result<TripEntity>> cancelTrip(String id, {String? note}) {
    printC('[TripFacade] cancelTrip id=$id');
    return _repository.cancelTrip(id, note: note);
  }

  Future<Result<TripEntity>> updatePassengerNote({
    required String tripId,
    required String? passengerNote,
  }) {
    printC('[TripFacade] updatePassengerNote id=$tripId');
    return _repository.updatePassengerNote(
      tripId: tripId,
      passengerNote: passengerNote,
    );
  }

  Future<Result<void>> rateTrip({
    required String tripId,
    required int stars,
    String? comment,
  }) {
    printC('[TripFacade] rateTrip id=$tripId stars=$stars');
    return _repository.rateTrip(tripId: tripId, stars: stars, comment: comment);
  }

  Future<Result<WaitingFeeSettlementEntity>> settleWaitingFee(String tripId) {
    printC('[TripFacade] settleWaitingFee id=$tripId');
    return _repository.settleWaitingFee(tripId);
  }

  Future<Result<TripCompensationClaimEntity>> submitCompensationClaim({
    required String tripId,
    required String note,
    List<String> evidenceUrls = const [],
  }) {
    printC('[TripFacade] submitCompensationClaim trip=$tripId');
    return _repository.submitCompensationClaim(
      tripId: tripId,
      note: note,
      evidenceUrls: evidenceUrls,
    );
  }

  Future<Result<List<String>>> uploadCompensationEvidence(
    List<String> filePaths,
  ) {
    printC('[TripFacade] uploadCompensationEvidence count=${filePaths.length}');
    return _repository.uploadCompensationEvidence(filePaths);
  }

  Future<Result<PagedResult<TripSummaryEntity>>> getTripHistory({
    int page = 1,
    int pageSize = 20,
    String? search,
  }) {
    printC('[TripFacade] getTripHistory page=$page search=$search');
    return _repository.getTripHistory(
      page: page,
      pageSize: pageSize,
      search: search,
    );
  }

  Future<Result<TripReceiptEntity>> getTripReceipt(String id) {
    printC('[TripFacade] getTripReceipt id=$id');
    return _repository.getTripReceipt(id);
  }

  Future<Result<TripInvoiceEntity>> getTripInvoice(String id) {
    printC('[TripFacade] getTripInvoice id=$id');
    return _repository.getTripInvoice(id);
  }

  Future<Result<Uint8List>> getTripInvoicePdf(
    String id, {
    required String languageCode,
  }) {
    printC('[TripFacade] getTripInvoicePdf id=$id lang=$languageCode');
    return _repository.getTripInvoicePdf(id, languageCode: languageCode);
  }
}
