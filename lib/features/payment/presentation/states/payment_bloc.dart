import 'package:customertaxi/core/services/payments/stripe_initializer.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:customertaxi/common/imports/imports.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/payment_method_entities.dart';
import '../../domain/entities/wallet_entities.dart';
import '../../domain/facade/payment_facade.dart';

part 'payment_event.dart';
part 'payment_state.dart';
part 'payment_bloc.freezed.dart';

@injectable
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc(this._facade) : super(const PaymentState()) {
    on<_Started>(_onStarted);
    on<_BalanceRefreshed>((e, emit) => _loadBalance(emit));
    on<_TransactionsRequested>((e, emit) => _loadTransactions(emit));
    on<_MethodsRefreshed>((e, emit) => _loadMethods(emit));
    on<_TopUpSubmitted>(_onTopUpSubmitted);
    on<_AddCardRequested>(_onAddCardRequested);
    on<_DefaultMethodSelected>(_onDefaultMethodSelected);
    on<_MethodDeleted>(_onMethodDeleted);
    on<_TransientStatusReset>(_onTransientStatusReset);
  }

  final PaymentFacade _facade;

  static const String _merchantName = 'Fat7i';
  static const String _returnUrl = 'customertaxi://stripe-redirect';
  static const Duration _webhookGrace = Duration(seconds: 2);

  Future<void> _onStarted(_Started event, Emitter<PaymentState> emit) async {
    await _loadBalance(emit);
    await _loadMethods(emit);
  }

  Future<void> _loadBalance(Emitter<PaymentState> emit) async {
    emit(state.copyWith(balanceStatus: const BlocStatus.loading()));
    final result = await _facade.getWalletBalance();
    if (isClosed) return;
    result.when(
      success: (balance) =>
          emit(state.copyWith(balanceStatus: BlocStatus.success(balance))),
      failure: (message) =>
          emit(state.copyWith(balanceStatus: BlocStatus.failure(message))),
    );
  }

  Future<void> _loadTransactions(Emitter<PaymentState> emit) async {
    emit(state.copyWith(transactionsStatus: const BlocStatus.loading()));
    final result = await _facade.getWalletTransactions();
    if (isClosed) return;
    result.when(
      success: (page) =>
          emit(state.copyWith(transactionsStatus: BlocStatus.success(page))),
      failure: (message) =>
          emit(state.copyWith(transactionsStatus: BlocStatus.failure(message))),
    );
  }

  Future<void> _loadMethods(Emitter<PaymentState> emit) async {
    emit(state.copyWith(methodsStatus: const BlocStatus.loading()));
    final result = await _facade.getPaymentMethods();
    if (isClosed) return;
    result.when(
      success: (methods) =>
          emit(state.copyWith(methodsStatus: BlocStatus.success(methods))),
      failure: (message) =>
          emit(state.copyWith(methodsStatus: BlocStatus.failure(message))),
    );
  }

  // ── Top-up (Stripe payment sheet) ────────────────────────────────────────

  Future<void> _onTopUpSubmitted(
    _TopUpSubmitted event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(topUpStatus: const BlocStatus.loading()));
    final result = await _facade.createTopUp(amount: event.amount);
    if (isClosed) return;

    await result.when(
      success: (topUp) async {
        try {
          // Stripe is configured lazily so bootstrap no longer waits on it.
          await getIt<StripeInitializer>().ensureReady();
          await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: topUp.stripePayment.clientSecret,
              customerId: topUp.stripePayment.customerId,
              customerEphemeralKeySecret:
                  topUp.stripePayment.ephemeralKeySecret,
              merchantDisplayName: _merchantName,
              linkDisplayParams: const LinkDisplayParams(
                linkDisplay: LinkDisplay.never,
              ),
              style: ThemeMode.system,
              returnURL: _returnUrl,
            ),
          );
          await Stripe.instance.presentPaymentSheet();

          if (isClosed) return;
          emit(state.copyWith(topUpStatus: const BlocStatus.success(null)));

          // The wallet is credited asynchronously by the backend webhook; give it a
          // moment, then refresh the balance so the new amount shows up.
          await Future<void>.delayed(_webhookGrace);
          if (isClosed) return;
          await _loadBalance(emit);
        } on StripeException catch (e) {
          if (isClosed) return;
          final canceled = e.error.code == FailureCode.Canceled;
          emit(
            state.copyWith(
              topUpStatus: canceled
                  ? const BlocStatus.initial()
                  : BlocStatus.failure(AppStrings.paymentFailed),
            ),
          );
        } catch (_) {
          if (isClosed) return;
          emit(
            state.copyWith(
              topUpStatus: BlocStatus.failure(AppStrings.paymentFailed),
            ),
          );
        }
      },
      failure: (message) async =>
          emit(state.copyWith(topUpStatus: BlocStatus.failure(message))),
    );
  }

  // ── Add card (Stripe SetupIntent / setup mode) ───────────────────────────

  Future<void> _onAddCardRequested(
    _AddCardRequested event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(addCardStatus: const BlocStatus.loading()));
    final result = await _facade.createSetupIntent();
    if (isClosed) return;

    await result.when(
      success: (setup) async {
        try {
          // Stripe is configured lazily so bootstrap no longer waits on it.
          await getIt<StripeInitializer>().ensureReady();
          await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              setupIntentClientSecret: setup.clientSecret,
              customerId: setup.customerId,
              customerEphemeralKeySecret: setup.ephemeralKeySecret,
              merchantDisplayName: _merchantName,
              linkDisplayParams: const LinkDisplayParams(
                linkDisplay: LinkDisplay.never,
              ),
              style: ThemeMode.system,
              returnURL: _returnUrl,
            ),
          );
          await Stripe.instance.presentPaymentSheet();

          // Resolve the saved payment method id from the confirmed SetupIntent.
          final confirmed = await Stripe.instance.retrieveSetupIntent(
            setup.clientSecret,
          );
          final paymentMethodId = confirmed.paymentMethodId;
          if (isClosed) return;

          if (paymentMethodId.isEmpty) {
            emit(
              state.copyWith(
                addCardStatus: BlocStatus.failure(AppStrings.paymentFailed),
              ),
            );
            return;
          }

          final addResult = await _facade.addPaymentMethod(
            paymentMethodId: paymentMethodId,
            setAsDefault: event.setAsDefault,
          );
          if (isClosed) return;
          await addResult.when(
            success: (_) async {
              emit(
                state.copyWith(addCardStatus: const BlocStatus.success(null)),
              );
              await _loadMethods(emit);
            },
            failure: (message) async => emit(
              state.copyWith(addCardStatus: BlocStatus.failure(message)),
            ),
          );
        } on StripeException catch (e) {
          if (isClosed) return;
          final canceled = e.error.code == FailureCode.Canceled;
          emit(
            state.copyWith(
              addCardStatus: canceled
                  ? const BlocStatus.initial()
                  : BlocStatus.failure(AppStrings.paymentFailed),
            ),
          );
        } catch (_) {
          if (isClosed) return;
          emit(
            state.copyWith(
              addCardStatus: BlocStatus.failure(AppStrings.paymentFailed),
            ),
          );
        }
      },
      failure: (message) async =>
          emit(state.copyWith(addCardStatus: BlocStatus.failure(message))),
    );
  }

  // ── Method actions ───────────────────────────────────────────────────────

  Future<void> _onDefaultMethodSelected(
    _DefaultMethodSelected event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(actionStatus: const BlocStatus.loading()));
    final result = await _facade.setDefaultPaymentMethod(event.id);
    if (isClosed) return;
    await result.when(
      success: (_) async {
        emit(state.copyWith(actionStatus: const BlocStatus.success(null)));
        await _loadMethods(emit);
      },
      failure: (message) async =>
          emit(state.copyWith(actionStatus: BlocStatus.failure(message))),
    );
  }

  Future<void> _onMethodDeleted(
    _MethodDeleted event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(actionStatus: const BlocStatus.loading()));
    final result = await _facade.deletePaymentMethod(event.id);
    if (isClosed) return;
    await result.when(
      success: (_) async {
        emit(state.copyWith(actionStatus: const BlocStatus.success(null)));
        await _loadMethods(emit);
      },
      failure: (message) async =>
          emit(state.copyWith(actionStatus: BlocStatus.failure(message))),
    );
  }

  void _onTransientStatusReset(
    _TransientStatusReset event,
    Emitter<PaymentState> emit,
  ) {
    emit(
      state.copyWith(
        topUpStatus: const BlocStatus.initial(),
        addCardStatus: const BlocStatus.initial(),
        actionStatus: const BlocStatus.initial(),
      ),
    );
  }
}
