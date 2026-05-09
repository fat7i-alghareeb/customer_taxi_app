part of 'favorites_bloc.dart';

@freezed
abstract class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    @Default(BlocStatus.initial()) BlocStatus loadStatus,
    @Default(BlocStatus.initial()) BlocStatus actionStatus,
    @Default(BlocStatus.initial()) BlocStatus searchStatus,
    @Default([]) List<OrderSavedLocationEntity> locations,
    @Default([]) List<OrderLocationEntity> searchResults,
  }) = _FavoritesState;
}
