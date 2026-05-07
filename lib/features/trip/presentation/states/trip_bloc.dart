import 'package:customertaxi/common/imports/imports.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_status.dart';
import 'package:customertaxi/features/trip/domain/facade/trip_facade.dart';
import 'package:customertaxi/features/trip/data/datasources/trip_remote_datasource.dart';

part 'trip_event.dart';
part 'trip_state.dart';
part 'trip_bloc.freezed.dart';

const _pollingInterval = Duration(seconds: 5);

@injectable
class TripBloc extends Bloc<TripEvent, TripState> {
  TripBloc(this._facade) : super(const TripState()) {
    on<_Started>(_onStarted);
    on<_PollingTick>(_onPollingTick);
    on<_CancelRequested>(_onCancelRequested);
    on<_StopPolling>(_onStopPolling);
    on<_HistoryStarted>(_onHistoryStarted);
    on<_NextPageRequested>(_onNextPageRequested);
  }

  final TripFacade _facade;
  Timer? _pollingTimer;

  bool _isTerminal(TripStatus status) => status.isTerminal;

  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(_pollingInterval, (_) {
      if (!isClosed) add(const TripEvent.pollingTick());
    });
  }

  void _stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  @override
  Future<void> close() {
    _stopPolling();
    return super.close();
  }

  Future<void> _onStarted(_Started event, Emitter<TripState> emit) async {
    emit(state.copyWith(
      tripStatus: const BlocStatus.loading(),
      activeTripId: event.tripId,
      isPolling: false,
    ));
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

  Future<void> _onPollingTick(_PollingTick event, Emitter<TripState> emit) async {
    final id = state.activeTripId;
    if (id == null) return;
    final Result<TripEntity> result = await _facade.getTripById(id);
    result.when(
      success: (trip) {
        emit(state.copyWith(tripStatus: BlocStatus<TripEntity>.success(trip)));
        if (_isTerminal(trip.status)) {
          _stopPolling();
          emit(state.copyWith(isPolling: false));
        }
      },
      failure: (_) {},
    );
  }

  Future<void> _onCancelRequested(
    _CancelRequested event,
    Emitter<TripState> emit,
  ) async {
    final id = state.activeTripId;
    if (id == null) return;
    emit(state.copyWith(cancelStatus: const BlocStatus.loading()));
    final Result<TripEntity> result = await _facade.cancelTrip(id);
    result.when(
      success: (trip) {
        printG('[TripBloc] cancel success');
        _stopPolling();
        emit(state.copyWith(
          cancelStatus: const BlocStatus<void>.success(null),
          tripStatus: BlocStatus<TripEntity>.success(trip),
          isPolling: false,
        ));
      },
      failure: (msg) {
        printY('[TripBloc] cancel failed=$msg');
        emit(state.copyWith(cancelStatus: BlocStatus<void>.failure(msg)));
      },
    );
  }

  void _onStopPolling(_StopPolling event, Emitter<TripState> emit) {
    _stopPolling();
    emit(state.copyWith(isPolling: false));
  }

  Future<void> _onHistoryStarted(
    _HistoryStarted event,
    Emitter<TripState> emit,
  ) async {
    emit(state.copyWith(
      historyStatus: const BlocStatus.loading(),
      trips: [],
      currentPage: 1,
      hasMore: true,
    ));
    final Result<PagedResult<TripSummaryEntity>> result = await _facade.getTripHistory();
    result.when(
      success: (paged) {
        printG('[TripBloc] history loaded count=${paged.items.length}');
        emit(state.copyWith(
          historyStatus: BlocStatus<List<TripSummaryEntity>>.success(paged.items),
          trips: paged.items,
          currentPage: 1,
          hasMore: paged.items.length < paged.totalCount,
        ));
      },
      failure: (msg) {
        printY('[TripBloc] history failed=$msg');
        emit(state.copyWith(historyStatus: BlocStatus<List<TripSummaryEntity>>.failure(msg)));
      },
    );
  }

  Future<void> _onNextPageRequested(
    _NextPageRequested event,
    Emitter<TripState> emit,
  ) async {
    if (!state.hasMore || state.historyStatus.isLoading) return;
    final nextPage = state.currentPage + 1;
    emit(state.copyWith(historyStatus: const BlocStatus.loading()));
    final Result<PagedResult<TripSummaryEntity>> result = await _facade.getTripHistory(page: nextPage);
    result.when(
      success: (paged) {
        final List<TripSummaryEntity> merged = [...state.trips, ...paged.items];
        emit(state.copyWith(
          historyStatus: BlocStatus<List<TripSummaryEntity>>.success(merged),
          trips: merged,
          currentPage: nextPage,
          hasMore: merged.length < paged.totalCount,
        ));
      },
      failure: (msg) {
        emit(state.copyWith(historyStatus: BlocStatus<List<TripSummaryEntity>>.failure(msg)));
      },
    );
  }
}
