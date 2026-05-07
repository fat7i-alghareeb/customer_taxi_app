part of 'trip_bloc.dart';

@freezed
abstract class TripState with _$TripState {
  const factory TripState({
    // Active trip
    @Default(BlocStatus<TripEntity>.initial()) BlocStatus<TripEntity> tripStatus,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> cancelStatus,
    @Default(false) bool isPolling,
    String? activeTripId,

    // Trip history
    @Default(BlocStatus<List<TripSummaryEntity>>.initial())
    BlocStatus<List<TripSummaryEntity>> historyStatus,
    @Default([]) List<TripSummaryEntity> trips,
    @Default(1) int currentPage,
    @Default(true) bool hasMore,
  }) = _TripState;
}
