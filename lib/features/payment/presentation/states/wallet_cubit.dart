import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio_refresh_bot/dio_refresh_bot.dart' show AuthStatus, Status;
import 'package:injectable/injectable.dart';

import '../../../../core/services/realtime/realtime_event.dart';
import '../../../../core/services/realtime/realtime_service.dart';
import '../../../../core/services/session/auth_manager.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../domain/entities/wallet_entities.dart';
import '../../domain/facade/payment_facade.dart';

class WalletState {
  const WalletState({this.balance, this.loaded = false});

  final WalletBalanceEntity? balance;
  final bool loaded;

  /// Whether the customer currently owes enough to be stopped from booking. Defaults to false
  /// until the balance has actually loaded, so a slow network never blocks the UI on a guess.
  bool get isBookingBlocked => balance?.isBookingBlocked ?? false;

  double get amountOwed => balance?.amountOwed ?? 0;

  String get currencyCode => balance?.currencyCode ?? 'EUR';

  WalletState copyWith({WalletBalanceEntity? balance, bool? loaded, bool clear = false}) =>
      WalletState(
        balance: clear ? null : (balance ?? this.balance),
        loaded: loaded ?? this.loaded,
      );
}

/// App-wide wallet balance, kept because a debt has to be visible and enforced everywhere, not
/// just on the wallet screen. `PaymentBloc` is a factory — a fresh instance per screen — so it
/// cannot answer "is this customer blocked?" for the booking flow.
///
/// Mirrors [ActiveTripCubit]: started once, refreshes on auth changes and on the realtime
/// balance event that fires the moment a fee is charged to debt.
@lazySingleton
class WalletCubit extends Cubit<WalletState> {
  WalletCubit(this._facade, this._realtime, this._authManager)
    : super(const WalletState());

  final PaymentFacade _facade;
  final RealtimeService _realtime;
  final AuthManager _authManager;

  StreamSubscription<RealtimeEvent>? _eventsSub;
  StreamSubscription<AuthStatus>? _authSub;
  bool _started = false;

  /// Idempotent. Only fetches while authenticated — the balance endpoint is protected, so a
  /// guest must never trigger it.
  void start() {
    if (_started) return;
    _started = true;
    printC('[WalletCubit] start');
    _authSub = _authManager.authStatusStream.listen(_onAuthStatus);
    _eventsSub = _realtime.events
        .where((event) => event is RealtimeWalletBalanceChanged)
        .listen(_onBalanceChanged);
    if (_authManager.isAuthenticated) {
      unawaited(refresh());
    }
  }

  void _onAuthStatus(AuthStatus status) {
    switch (status.status) {
      case Status.authenticated:
        unawaited(refresh());
        break;
      case Status.unauthenticated:
        printC('[WalletCubit] auth -> unauthenticated, resetting');
        if (!isClosed) emit(const WalletState(loaded: true));
        break;
      case Status.initial:
        break;
    }
  }

  /// The event carries the new figures, so adopt them directly rather than round-tripping.
  /// The blocking verdict is the server's, and the event does not carry it — refetch for that.
  void _onBalanceChanged(RealtimeEvent event) {
    if (event is! RealtimeWalletBalanceChanged || isClosed) return;
    printC('[WalletCubit] realtime balance=${event.balance} owed=${event.amountOwed}');
    unawaited(refresh());
  }

  Future<void> refresh() async {
    if (!_authManager.isAuthenticated || isClosed) return;
    final result = await _facade.getWalletBalance();
    if (isClosed) return;
    result.when(
      success: (balance) {
        printG(
          '[WalletCubit] balance=${balance.balance} owed=${balance.amountOwed} '
          'blocked=${balance.isBookingBlocked}',
        );
        emit(state.copyWith(balance: balance, loaded: true));
      },
      failure: (message) {
        // A failed balance fetch must never block booking — the server enforces the rule
        // anyway and will reject the request if the customer really does owe money.
        printY('[WalletCubit] balance fetch failed=$message');
        emit(state.copyWith(loaded: true));
      },
    );
  }

  @override
  Future<void> close() async {
    await _authSub?.cancel();
    await _eventsSub?.cancel();
    return super.close();
  }
}
