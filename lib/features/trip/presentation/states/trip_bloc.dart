import 'dart:typed_data';

import 'package:customertaxi/common/imports/imports.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';

import 'package:customertaxi/core/services/realtime/realtime_event.dart';
import 'package:customertaxi/core/services/realtime/realtime_connection_state.dart';
import 'package:customertaxi/core/services/realtime/realtime_service.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_edit_apply_result_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_edit_preview_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_invoice_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_receipt_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_status.dart';
import 'package:customertaxi/features/trip/domain/entities/driver_location_entity.dart';
import 'package:customertaxi/features/trip/domain/facade/trip_facade.dart';
import 'package:customertaxi/features/trip/data/datasources/trip_remote_datasource.dart';

part 'trip_event.dart';
part 'trip_state.dart';
part 'trip_bloc.freezed.dart';

// SignalR is the primary update channel; polling is a defense-in-depth
// fallback that reconciles missed pushes (e.g. transient socket drops).
const _pollingInterval = Duration(seconds: 30);

@injectable
class TripBloc extends Bloc<TripEvent, TripState> {
  TripBloc(this._facade, this._realtime) : super(const TripState()) {
    on<_Started>(_onStarted);
    on<_PollingTick>(_onPollingTick);
    on<_CancelRequested>(_onCancelRequested);
    on<_PassengerNoteSubmitted>(_onPassengerNoteSubmitted);
    on<_CompensationClaimSubmitted>(_onCompensationClaimSubmitted);
    on<_StopPolling>(_onStopPolling);
    on<_HistoryStarted>(_onHistoryStarted);
    on<_SearchChanged>(_onSearchChanged);
    on<_NextPageRequested>(_onNextPageRequested);
    on<_DriverLocationUpdated>(_onDriverLocationUpdated);
    on<_LoadReceipt>(_onLoadReceipt);
    on<_LoadInvoice>(_onLoadInvoice);
    on<_LoadInvoicePdf>(_onLoadInvoicePdf);
    on<_ScheduledTimeUpdateRequested>(_onScheduledTimeUpdateRequested);
    on<_StopsUpdateRequested>(_onStopsUpdateRequested);
    on<_PassengerCountUpdateRequested>(_onPassengerCountUpdateRequested);
    on<_BagCountUpdateRequested>(_onBagCountUpdateRequested);
    on<_EditPreviewRequested>(_onEditPreviewRequested);
    on<_EditApplyRequested>(_onEditApplyRequested);
    on<_EditStatusReset>(_onEditStatusReset);
    on<_NoDriverPostponeRequested>(_onNoDriverPostponeRequested);
    on<_NoDriverCancelRequested>(_onNoDriverCancelRequested);
  }

  final TripFacade _facade;
  final RealtimeService _realtime;
  Timer? _pollingTimer;
  Timer? _searchDebounce;
  StreamSubscription<RealtimeEvent>? _realtimeSub;
  StreamSubscription<RealtimeConnectionState>? _connectionSub;
  String? _joinedTripId;

  bool _isTerminal(TripStatus status) => status.isTerminal;

  void _startPolling() {
    printC(
      '[TripBloc] polling started interval=${_pollingInterval.inSeconds}s',
    );
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(_pollingInterval, (_) {
      if (!isClosed) add(const TripEvent.pollingTick());
    });
  }

  void _stopPolling() {
    printC('[TripBloc] polling stopped');
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  Future<void> _subscribeToRealtime(String tripId) async {
    printC('[TripBloc] subscribing realtime trip=$tripId');
    await _unsubscribeFromRealtime();
    _joinedTripId = tripId;
    _realtimeSub = _realtime.events
        .where((event) => event.tripId == tripId)
        .listen(_onRealtimeEvent);
    await _realtime.joinTripGroup(tripId);
  }

  Future<void> _unsubscribeFromRealtime() async {
    await _realtimeSub?.cancel();
    _realtimeSub = null;
    final tripId = _joinedTripId;
    _joinedTripId = null;
    if (tripId != null) {
      printC('[TripBloc] unsubscribing realtime trip=$tripId');
      await _realtime.leaveTripGroup(tripId);
    }
  }

  void _onRealtimeEvent(RealtimeEvent event) {
    if (isClosed) return;
    if (event is RealtimeDriverLocationUpdated) {
      add(
        TripEvent.driverLocationUpdated(
          event.latitude,
          event.longitude,
          etaToPickupSeconds: event.etaToPickupSeconds,
          distanceToPickupMeters: event.distanceToPickupMeters,
          routeToPickupPolyline: event.routeToPickupPolyline,
        ),
      );
      return;
    }
    // Events carry IDs only — re-fetch the trip to get authoritative state.
    printC('[TripBloc] realtime event ${event.runtimeType} -> refreshing trip');
    add(const TripEvent.pollingTick());
  }

  @override
  Future<void> close() async {
    _stopPolling();
    _searchDebounce?.cancel();
    await _connectionSub?.cancel();
    await _unsubscribeFromRealtime();
    return super.close();
  }

  Future<void> _onStarted(_Started event, Emitter<TripState> emit) async {
    _connectionSub ??= _realtime.connectionState.listen((connectionState) {
      if (connectionState == RealtimeConnectionState.connected &&
          state.activeTripId != null &&
          !isClosed) {
        add(const TripEvent.pollingTick());
      }
    });
    emit(
      state.copyWith(
        tripStatus: const BlocStatus.loading(),
        activeTripId: event.tripId,
        isPolling: false,
      ),
    );
    await _subscribeToRealtime(event.tripId);
    final Result<TripEntity> result = await _facade.getTripById(event.tripId);
    result.when(
      success: (trip) {
        printG('[TripBloc] started loaded status=${trip.status}');
        emit(state.copyWith(tripStatus: BlocStatus<TripEntity>.success(trip)));
        if (!_isTerminal(trip.status)) {
          _startPolling();
          emit(state.copyWith(isPolling: true));
        }
      },
      failure: (msg) {
        printY('[TripBloc] started failed=$msg');
        emit(state.copyWith(tripStatus: BlocStatus<TripEntity>.failure(msg)));
      },
    );
  }

  Future<void> _onPollingTick(
    _PollingTick event,
    Emitter<TripState> emit,
  ) async {
    final id = state.activeTripId;
    if (id == null) return;
    printC('[TripBloc] polling tick trip=$id');
    final Result<TripEntity> result = await _facade.getTripById(id);
    result.when(
      success: (trip) {
        printG('[TripBloc] polling refreshed status=${trip.status}');
        emit(state.copyWith(tripStatus: BlocStatus<TripEntity>.success(trip)));
        if (_isTerminal(trip.status)) {
          _stopPolling();
          unawaited(_unsubscribeFromRealtime());
          emit(state.copyWith(isPolling: false));
        }
      },
      failure: (msg) {
        printY('[TripBloc] polling refresh failed=$msg');
      },
    );
  }

  Future<void> _onCancelRequested(
    _CancelRequested event,
    Emitter<TripState> emit,
  ) async {
    final id = state.activeTripId;
    if (id == null) return;
    emit(state.copyWith(cancelStatus: const BlocStatus.loading()));
    final Result<TripEntity> result = await _facade.cancelTrip(
      id,
      note: event.note,
    );
    result.when(
      success: (trip) {
        printG('[TripBloc] cancel success');
        _stopPolling();
        unawaited(_unsubscribeFromRealtime());
        emit(
          state.copyWith(
            cancelStatus: const BlocStatus<void>.success(null),
            tripStatus: BlocStatus<TripEntity>.success(trip),
            isPolling: false,
          ),
        );
      },
      failure: (msg) {
        printY('[TripBloc] cancel failed=$msg');
        emit(state.copyWith(cancelStatus: BlocStatus<void>.failure(msg)));
      },
    );
  }

  Future<void> _onNoDriverPostponeRequested(
    _NoDriverPostponeRequested event,
    Emitter<TripState> emit,
  ) async {
    final id = state.activeTripId;
    if (id == null) return;
    emit(state.copyWith(postponeStatus: const BlocStatus.loading()));
    final Result<TripEntity> result = await _facade.postponeNoDriverSearch(id);
    result.when(
      success: (trip) {
        printG('[TripBloc] postpone success');
        // The returned trip has noDriverDecisionRequired=false, which hides the
        // overlay. The trip keeps polling/searching as before.
        emit(
          state.copyWith(
            postponeStatus: const BlocStatus<void>.success(null),
            tripStatus: BlocStatus<TripEntity>.success(trip),
          ),
        );
      },
      failure: (msg) {
        printY('[TripBloc] postpone failed=$msg');
        emit(state.copyWith(postponeStatus: BlocStatus<void>.failure(msg)));
        // Reconcile in case an admin accepted the trip in the meantime.
        add(const TripEvent.pollingTick());
      },
    );
  }

  Future<void> _onNoDriverCancelRequested(
    _NoDriverCancelRequested event,
    Emitter<TripState> emit,
  ) async {
    final id = state.activeTripId;
    if (id == null) return;
    emit(state.copyWith(cancelStatus: const BlocStatus.loading()));
    final Result<TripEntity> result = await _facade.noDriverCancelTrip(
      id,
      note: event.note,
    );
    result.when(
      success: (trip) {
        printG('[TripBloc] no-driver cancel success');
        _stopPolling();
        unawaited(_unsubscribeFromRealtime());
        emit(
          state.copyWith(
            cancelStatus: const BlocStatus<void>.success(null),
            tripStatus: BlocStatus<TripEntity>.success(trip),
            isPolling: false,
          ),
        );
      },
      failure: (msg) {
        printY('[TripBloc] no-driver cancel failed=$msg');
        emit(state.copyWith(cancelStatus: BlocStatus<void>.failure(msg)));
      },
    );
  }

  Future<void> _onPassengerNoteSubmitted(
    _PassengerNoteSubmitted event,
    Emitter<TripState> emit,
  ) async {
    final id = state.activeTripId;
    if (id == null) return;
    final note = event.passengerNote?.trim();
    emit(state.copyWith(passengerNoteStatus: const BlocStatus.loading()));
    final Result<TripEntity> result = await _facade.updatePassengerNote(
      tripId: id,
      passengerNote: note == null || note.isEmpty ? null : note,
    );
    result.when(
      success: (trip) {
        printG('[TripBloc] passenger note updated');
        emit(
          state.copyWith(
            passengerNoteStatus: const BlocStatus<void>.success(null),
            tripStatus: BlocStatus<TripEntity>.success(trip),
          ),
        );
      },
      failure: (msg) {
        printY('[TripBloc] passenger note failed=$msg');
        emit(
          state.copyWith(passengerNoteStatus: BlocStatus<void>.failure(msg)),
        );
      },
    );
  }

  Future<void> _onCompensationClaimSubmitted(
    _CompensationClaimSubmitted event,
    Emitter<TripState> emit,
  ) async {
    final id = state.activeTripId;
    if (id == null) return;
    emit(
      state.copyWith(
        compensationClaimStatus:
            const BlocStatus<TripCompensationClaimEntity>.loading(),
      ),
    );
    final Result<TripCompensationClaimEntity> result = await _facade
        .submitCompensationClaim(
          tripId: id,
          note: event.note,
          evidenceUrls: event.evidenceUrls,
        );
    result.when(
      success: (claim) {
        printG('[TripBloc] compensation claim submitted id=${claim.id}');
        emit(
          state.copyWith(
            compensationClaimStatus:
                BlocStatus<TripCompensationClaimEntity>.success(claim),
          ),
        );
        add(const TripEvent.pollingTick());
      },
      failure: (msg) {
        printY('[TripBloc] compensation claim failed=$msg');
        emit(
          state.copyWith(
            compensationClaimStatus:
                BlocStatus<TripCompensationClaimEntity>.failure(msg),
          ),
        );
      },
    );
  }

  void _onStopPolling(_StopPolling event, Emitter<TripState> emit) {
    _stopPolling();
    unawaited(_unsubscribeFromRealtime());
    emit(state.copyWith(isPolling: false));
  }

  Future<void> _onHistoryStarted(
    _HistoryStarted event,
    Emitter<TripState> emit,
  ) async {
    emit(
      state.copyWith(
        historyStatus: const BlocStatus.loading(),
        trips: [],
        currentPage: 1,
        hasMore: true,
        isLoadingMore: false,
      ),
    );
    final search = state.searchQuery.trim();
    final Result<PagedResult<TripSummaryEntity>> result = await _facade
        .getTripHistory(search: search.isEmpty ? null : search);
    result.when(
      success: (paged) {
        printG('[TripBloc] history loaded count=${paged.items.length}');
        emit(
          state.copyWith(
            historyStatus: BlocStatus<List<TripSummaryEntity>>.success(
              paged.items,
            ),
            trips: paged.items,
            currentPage: 1,
            hasMore: paged.items.length < paged.totalCount,
          ),
        );
      },
      failure: (msg) {
        printY('[TripBloc] history failed=$msg');
        emit(
          state.copyWith(
            historyStatus: BlocStatus<List<TripSummaryEntity>>.failure(msg),
          ),
        );
      },
    );
  }

  void _onSearchChanged(_SearchChanged event, Emitter<TripState> emit) {
    final query = event.query;
    // Store immediately so the debounced reload picks up the latest term.
    emit(state.copyWith(searchQuery: query));
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      if (!isClosed) add(const TripEvent.historyStarted());
    });
  }

  Future<void> _onNextPageRequested(
    _NextPageRequested event,
    Emitter<TripState> emit,
  ) async {
    if (!state.hasMore || state.historyStatus.isLoading || state.isLoadingMore) {
      return;
    }
    final nextPage = state.currentPage + 1;
    printC('[TripBloc] history next page requested page=$nextPage');
    // Keep the existing list visible; only flag the footer loader.
    emit(state.copyWith(isLoadingMore: true));
    final search = state.searchQuery.trim();
    final Result<PagedResult<TripSummaryEntity>> result = await _facade
        .getTripHistory(page: nextPage, search: search.isEmpty ? null : search);
    result.when(
      success: (paged) {
        printG('[TripBloc] history page loaded count=${paged.items.length}');
        final List<TripSummaryEntity> merged = [...state.trips, ...paged.items];
        emit(
          state.copyWith(
            historyStatus: BlocStatus<List<TripSummaryEntity>>.success(merged),
            trips: merged,
            currentPage: nextPage,
            hasMore: merged.length < paged.totalCount,
            isLoadingMore: false,
          ),
        );
      },
      failure: (msg) {
        printY('[TripBloc] history page failed=$msg');
        emit(state.copyWith(isLoadingMore: false));
      },
    );
  }

  Future<void> _onLoadReceipt(
    _LoadReceipt event,
    Emitter<TripState> emit,
  ) async {
    emit(state.copyWith(receiptStatus: const BlocStatus.loading()));
    final Result<TripReceiptEntity> result = await _facade.getTripReceipt(
      event.tripId,
    );
    result.when(
      success: (receipt) {
        printG('[TripBloc] receipt loaded trip=${event.tripId}');
        emit(
          state.copyWith(
            receiptStatus: BlocStatus<TripReceiptEntity>.success(receipt),
          ),
        );
      },
      failure: (msg) {
        printY('[TripBloc] receipt failed=$msg');
        emit(
          state.copyWith(
            receiptStatus: BlocStatus<TripReceiptEntity>.failure(msg),
          ),
        );
      },
    );
  }

  Future<void> _onLoadInvoice(
    _LoadInvoice event,
    Emitter<TripState> emit,
  ) async {
    emit(state.copyWith(invoiceStatus: const BlocStatus.loading()));
    final Result<TripInvoiceEntity> result = await _facade.getTripInvoice(
      event.tripId,
    );
    result.when(
      success: (invoice) {
        printG('[TripBloc] invoice loaded number=${invoice.invoiceNumber}');
        emit(
          state.copyWith(
            invoiceStatus: BlocStatus<TripInvoiceEntity>.success(invoice),
          ),
        );
      },
      failure: (msg) {
        printY('[TripBloc] invoice failed=$msg');
        emit(
          state.copyWith(
            invoiceStatus: BlocStatus<TripInvoiceEntity>.failure(msg),
          ),
        );
      },
    );
  }

  Future<void> _onLoadInvoicePdf(
    _LoadInvoicePdf event,
    Emitter<TripState> emit,
  ) async {
    emit(state.copyWith(invoicePdfStatus: const BlocStatus.loading()));
    final Result<Uint8List> result = await _facade.getTripInvoicePdf(
      event.tripId,
      languageCode: event.languageCode,
    );
    result.when(
      success: (bytes) {
        printG('[TripBloc] invoice pdf loaded bytes=${bytes.length}');
        emit(
          state.copyWith(
            invoicePdfStatus: BlocStatus<Uint8List>.success(bytes),
          ),
        );
      },
      failure: (msg) {
        printY('[TripBloc] invoice pdf failed=$msg');
        emit(
          state.copyWith(invoicePdfStatus: BlocStatus<Uint8List>.failure(msg)),
        );
      },
    );
  }

  bool _isWithinEditWindow(DateTime createdAtUtc) =>
      DateTime.now().toUtc().isBefore(createdAtUtc.add(const Duration(hours: 1)));

  Future<void> _onScheduledTimeUpdateRequested(
    _ScheduledTimeUpdateRequested event,
    Emitter<TripState> emit,
  ) async {
    final id = state.activeTripId;
    final trip = state.tripStatus.getDataWhenSuccess;
    if (id == null || trip == null) return;
    if (!_isWithinEditWindow(trip.createdAtUtc)) {
      emit(
        state.copyWith(
          tripEditStatus: const BlocStatus<void>.failure('tripEditNotAllowed'),
        ),
      );
      return;
    }
    emit(state.copyWith(tripEditStatus: const BlocStatus<void>.loading()));
    final Result<void> result = await _facade.updateTripScheduledTime(
      tripId: id,
      scheduledAtUtc: event.scheduledAtUtc,
    );
    result.when(
      success: (_) {
        printG('[TripBloc] scheduled time updated');
        emit(state.copyWith(tripEditStatus: const BlocStatus<void>.success(null)));
        add(const TripEvent.pollingTick());
      },
      failure: (msg) {
        printY('[TripBloc] scheduled time update failed=$msg');
        emit(state.copyWith(tripEditStatus: BlocStatus<void>.failure(msg)));
      },
    );
  }

  Future<void> _onStopsUpdateRequested(
    _StopsUpdateRequested event,
    Emitter<TripState> emit,
  ) async {
    final id = state.activeTripId;
    final trip = state.tripStatus.getDataWhenSuccess;
    if (id == null || trip == null) return;
    // No client-side window gate — editing is gated purely by trip status server-side
    // (allowed through Arrived, rejected once the ride is in progress / terminal).
    emit(state.copyWith(tripEditStatus: const BlocStatus<void>.loading()));
    final Result<TripEntity> result = await _facade.updateTripStops(
      tripId: id,
      stops: event.stops,
    );
    result.when(
      success: (updatedTrip) {
        printG('[TripBloc] stops updated fare=${updatedTrip.quotedFare}');
        emit(
          state.copyWith(
            tripEditStatus: const BlocStatus<void>.success(null),
            tripStatus: BlocStatus<TripEntity>.success(updatedTrip),
          ),
        );
      },
      failure: (msg) {
        printY('[TripBloc] stops update failed=$msg');
        emit(state.copyWith(tripEditStatus: BlocStatus<void>.failure(msg)));
      },
    );
  }

  Future<void> _onPassengerCountUpdateRequested(
    _PassengerCountUpdateRequested event,
    Emitter<TripState> emit,
  ) async {
    final id = state.activeTripId;
    final trip = state.tripStatus.getDataWhenSuccess;
    if (id == null || trip == null) return;
    // No client-side window gate — gated purely by trip status server-side.
    emit(state.copyWith(tripEditStatus: const BlocStatus<void>.loading()));
    final Result<TripEntity> result = await _facade.updateTripPassengerCount(
      tripId: id,
      passengerCount: event.count,
    );
    result.when(
      success: (updatedTrip) {
        printG(
          '[TripBloc] passenger count updated count=${updatedTrip.passengerCount}',
        );
        emit(
          state.copyWith(
            tripEditStatus: const BlocStatus<void>.success(null),
            tripStatus: BlocStatus<TripEntity>.success(updatedTrip),
          ),
        );
      },
      failure: (msg) {
        printY('[TripBloc] passenger count update failed=$msg');
        emit(state.copyWith(tripEditStatus: BlocStatus<void>.failure(msg)));
      },
    );
  }

  Future<void> _onBagCountUpdateRequested(
    _BagCountUpdateRequested event,
    Emitter<TripState> emit,
  ) async {
    final id = state.activeTripId;
    final trip = state.tripStatus.getDataWhenSuccess;
    if (id == null || trip == null) return;
    if (!_isWithinEditWindow(trip.createdAtUtc)) {
      emit(
        state.copyWith(
          tripEditStatus: const BlocStatus<void>.failure('tripEditNotAllowed'),
        ),
      );
      return;
    }
    emit(state.copyWith(tripEditStatus: const BlocStatus<void>.loading()));
    final Result<void> result = await _facade.updateTripBagCount(
      tripId: id,
      bagCount: event.count,
    );
    result.when(
      success: (_) {
        printG('[TripBloc] bag count updated count=${event.count}');
        // Optimistically update the bag count on the cached trip entity.
        final updatedTrip = trip.copyWith(bagCount: event.count);
        emit(
          state.copyWith(
            tripEditStatus: const BlocStatus<void>.success(null),
            tripStatus: BlocStatus<TripEntity>.success(updatedTrip),
          ),
        );
      },
      failure: (msg) {
        printY('[TripBloc] bag count update failed=$msg');
        emit(state.copyWith(tripEditStatus: BlocStatus<void>.failure(msg)));
      },
    );
  }

  Future<void> _onEditPreviewRequested(
    _EditPreviewRequested event,
    Emitter<TripState> emit,
  ) async {
    final id = state.activeTripId;
    if (id == null) return;
    emit(
      state.copyWith(
        editPreviewStatus: const BlocStatus<TripEditPreviewEntity>.loading(),
      ),
    );
    final result = await _facade.previewTripEdit(
      tripId: id,
      stops: event.stops,
      passengerCount: event.passengerCount,
    );
    result.when(
      success: (preview) {
        printG('[TripBloc] edit preview delta=${preview.delta}');
        emit(
          state.copyWith(
            editPreviewStatus:
                BlocStatus<TripEditPreviewEntity>.success(preview),
          ),
        );
      },
      failure: (msg) {
        printY('[TripBloc] edit preview failed=$msg');
        emit(
          state.copyWith(
            editPreviewStatus: BlocStatus<TripEditPreviewEntity>.failure(msg),
          ),
        );
      },
    );
  }

  Future<void> _onEditApplyRequested(
    _EditApplyRequested event,
    Emitter<TripState> emit,
  ) async {
    final id = state.activeTripId;
    if (id == null) return;
    emit(
      state.copyWith(
        editApplyStatus: const BlocStatus<TripEditApplyResultEntity>.loading(),
      ),
    );
    final result = await _facade.applyTripEdit(
      tripId: id,
      stops: event.stops,
      passengerCount: event.passengerCount,
      expectedDelta: event.expectedDelta,
    );
    result.when(
      success: (applyResult) {
        printG('[TripBloc] edit apply status=${applyResult.status}');
        final updatedTrip = applyResult.trip;
        emit(
          state.copyWith(
            editApplyStatus:
                BlocStatus<TripEditApplyResultEntity>.success(applyResult),
            // When applied synchronously the server returns the updated trip; adopt it.
            // The PaymentSheet path leaves the trip unchanged (a realtime refresh follows).
            tripStatus: updatedTrip != null
                ? BlocStatus<TripEntity>.success(updatedTrip)
                : state.tripStatus,
          ),
        );
      },
      failure: (msg) {
        printY('[TripBloc] edit apply failed=$msg');
        emit(
          state.copyWith(
            editApplyStatus:
                BlocStatus<TripEditApplyResultEntity>.failure(msg),
          ),
        );
      },
    );
  }

  void _onEditStatusReset(_EditStatusReset event, Emitter<TripState> emit) {
    emit(
      state.copyWith(
        editPreviewStatus: const BlocStatus<TripEditPreviewEntity>.initial(),
        editApplyStatus: const BlocStatus<TripEditApplyResultEntity>.initial(),
      ),
    );
  }

  Future<void> _onDriverLocationUpdated(
    _DriverLocationUpdated event,
    Emitter<TripState> emit,
  ) async {
    if (state.tripStatus.getDataWhenSuccess?.status == TripStatus.inProgress) return;
    printC(
      '[TripBloc] driver location updated lat=${event.latitude} lng=${event.longitude}',
    );
    final oldLocation = state.activeDriverLocation;
    double? bearing;
    if (oldLocation != null) {
      bearing = Geolocator.bearingBetween(
        oldLocation.latitude,
        oldLocation.longitude,
        event.latitude,
        event.longitude,
      );
    }

    emit(
      state.copyWith(
        activeDriverLocation: DriverLocationEntity(
          latitude: event.latitude,
          longitude: event.longitude,
          bearing: bearing,
          etaToPickupSeconds: event.etaToPickupSeconds,
          distanceToPickupMeters: event.distanceToPickupMeters,
          routeToPickupPolyline: event.routeToPickupPolyline,
        ),
      ),
    );
  }
}
