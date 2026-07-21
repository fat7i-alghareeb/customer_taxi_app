part of 'trip_bloc.dart';

@freezed
abstract class TripState with _$TripState {
  const factory TripState({
    // Active trip
    @Default(BlocStatus<TripEntity>.initial()) BlocStatus<TripEntity> tripStatus,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> cancelStatus,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> passengerNoteStatus,
    @Default(BlocStatus<TripCompensationClaimEntity>.initial())
    BlocStatus<TripCompensationClaimEntity> compensationClaimStatus,
    @Default(false) bool isPolling,
    String? activeTripId,
    DriverLocationEntity? activeDriverLocation,

    // Trip history
    @Default(BlocStatus<List<TripSummaryEntity>>.initial())
    BlocStatus<List<TripSummaryEntity>> historyStatus,
    @Default([]) List<TripSummaryEntity> trips,
    @Default(1) int currentPage,
    @Default(true) bool hasMore,
    @Default(false) bool isLoadingMore,
    @Default('') String searchQuery,

    // Receipt / Invoice (per-section loading)
    @Default(BlocStatus<TripReceiptEntity>.initial())
    BlocStatus<TripReceiptEntity> receiptStatus,
    @Default(BlocStatus<TripInvoiceEntity>.initial())
    BlocStatus<TripInvoiceEntity> invoiceStatus,
    @Default(BlocStatus<Uint8List>.initial())
    BlocStatus<Uint8List> invoicePdfStatus,

    // Pre-trip edit operations
    @Default(BlocStatus<void>.initial()) BlocStatus<void> tripEditStatus,

    // Mid-trip re-pricing edit (preview → confirm → apply/settle)
    @Default(BlocStatus<TripEditPreviewEntity>.initial())
    BlocStatus<TripEditPreviewEntity> editPreviewStatus,
    @Default(BlocStatus<TripEditApplyResultEntity>.initial())
    BlocStatus<TripEditApplyResultEntity> editApplyStatus,

    /// Set once an edit is actually settled — including the PaymentSheet path, which only
    /// commits at the Stripe webhook. Widgets listen for this to confirm the amount.
    TripEditSettlementEntity? editSettlement,

    // "No driver found" postpone action
    @Default(BlocStatus<void>.initial()) BlocStatus<void> postponeStatus,
  }) = _TripState;
}
