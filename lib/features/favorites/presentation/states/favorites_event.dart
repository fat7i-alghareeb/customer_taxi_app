part of 'favorites_bloc.dart';

@freezed
class FavoritesEvent with _$FavoritesEvent {
  const factory FavoritesEvent.started() = _Started;
  const factory FavoritesEvent.locationAdded(OrderLocationEntity location) = _LocationAdded;
  const factory FavoritesEvent.locationRemoved(String identityKey) = _LocationRemoved;
  const factory FavoritesEvent.pinToggled(OrderLocationEntity location) = _PinToggled;
  const factory FavoritesEvent.searchRequested(String query) = _SearchRequested;
}
