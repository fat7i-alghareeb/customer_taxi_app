import 'dart:typed_data';

import '../../../../core/utils/result.dart';
import '../entities/trip_entity.dart';
import '../entities/trip_invoice_entity.dart';
import '../entities/trip_receipt_entity.dart';
import '../entities/waiting_fee_settlement_entity.dart';
import '../../data/datasources/trip_remote_datasource.dart';

abstract class TripRepository {
  Future<Result<TripEntity>> getTripById(String id);
  Future<Result<TripEntity?>> getActiveTrip();
  Future<Result<TripEntity>> cancelTrip(String id, {String? note});
  Future<Result<TripEntity>> updatePassengerNote({
    required String tripId,
    required String? passengerNote,
  });
  Future<Result<void>> rateTrip({
    required String tripId,
    required int stars,
    String? comment,
  });
  Future<Result<WaitingFeeSettlementEntity>> settleWaitingFee(String tripId);
  Future<Result<TripCompensationClaimEntity>> submitCompensationClaim({
    required String tripId,
    required String note,
    List<String> evidenceUrls = const [],
  });
  Future<Result<List<String>>> uploadCompensationEvidence(
    List<String> filePaths,
  );
  Future<Result<PagedResult<TripSummaryEntity>>> getTripHistory({
    int page = 1,
    int pageSize = 20,
  });
  Future<Result<TripReceiptEntity>> getTripReceipt(String id);
  Future<Result<TripInvoiceEntity>> getTripInvoice(String id);
  Future<Result<Uint8List>> getTripInvoicePdf(
    String id, {
    required String languageCode,
  });
}
