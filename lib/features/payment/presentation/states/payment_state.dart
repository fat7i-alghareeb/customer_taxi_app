part of 'payment_bloc.dart';

@freezed
abstract class PaymentState with _$PaymentState {
  const factory PaymentState({
    @Default(BlocStatus<WalletBalanceEntity>.initial())
    BlocStatus<WalletBalanceEntity> balanceStatus,
    @Default(BlocStatus<WalletTransactionsPage>.initial())
    BlocStatus<WalletTransactionsPage> transactionsStatus,
    @Default(BlocStatus<List<PaymentMethodEntity>>.initial())
    BlocStatus<List<PaymentMethodEntity>> methodsStatus,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> topUpStatus,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> addCardStatus,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> actionStatus,
  }) = _PaymentState;
}
