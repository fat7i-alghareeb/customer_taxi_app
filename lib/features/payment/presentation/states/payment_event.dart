part of 'payment_bloc.dart';

@freezed
class PaymentEvent with _$PaymentEvent {
  /// Loads balance, saved methods and the preferred method for the Betaling screen.
  const factory PaymentEvent.started() = _Started;

  const factory PaymentEvent.balanceRefreshed() = _BalanceRefreshed;
  const factory PaymentEvent.transactionsRequested() = _TransactionsRequested;
  const factory PaymentEvent.methodsRefreshed() = _MethodsRefreshed;

  /// Starts a wallet top-up: creates the Stripe intent and presents the payment sheet.
  const factory PaymentEvent.topUpSubmitted(double amount) = _TopUpSubmitted;

  /// Starts the add-card flow: creates a SetupIntent and presents the sheet in setup mode.
  const factory PaymentEvent.addCardRequested({@Default(false) bool setAsDefault}) =
      _AddCardRequested;

  const factory PaymentEvent.defaultMethodSelected(String id) =
      _DefaultMethodSelected;
  const factory PaymentEvent.methodDeleted(String id) = _MethodDeleted;

  /// Resets the transient action/top-up/add-card statuses after the UI consumes them.
  const factory PaymentEvent.transientStatusReset() = _TransientStatusReset;
}
