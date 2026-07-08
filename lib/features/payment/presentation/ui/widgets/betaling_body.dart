import 'package:customertaxi/common/imports/imports.dart';

import '../../states/payment_bloc.dart';
import 'saved_cards_section.dart';
import 'wallet_saldo_card.dart';

class BetalingBody extends StatelessWidget {
  const BetalingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listenWhen: (a, b) =>
          a.topUpStatus != b.topUpStatus ||
          a.addCardStatus != b.addCardStatus ||
          a.actionStatus != b.actionStatus,
      listener: _onStatusChanged,
      child: RefreshIndicator(
        onRefresh: () async =>
            context.read<PaymentBloc>().add(const PaymentEvent.started()),
        child: ListView(
          padding: REdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.lg,
          ),
          children: [
            const WalletSaldoCard(),
            AppSpacing.xl.verticalSpace,
            const SavedCardsSection(),
            AppSpacing.xxl.verticalSpace,
          ],
        ),
      ),
    );
  }

  void _onStatusChanged(BuildContext context, PaymentState state) {
    var handled = false;

    if (state.topUpStatus.isSuccess) {
      _snack(context, AppStrings.walletTopUpProcessing);
      handled = true;
    } else if (state.topUpStatus.isFailed) {
      _snack(context, state.topUpStatus.errorMessage, isError: true);
      handled = true;
    }

    if (state.addCardStatus.isSuccess) {
      _snack(context, AppStrings.addCardSuccess);
      handled = true;
    } else if (state.addCardStatus.isFailed) {
      _snack(context, state.addCardStatus.errorMessage, isError: true);
      handled = true;
    }

    if (state.actionStatus.isFailed) {
      _snack(context, state.actionStatus.errorMessage, isError: true);
      handled = true;
    }

    if (handled) {
      context.read<PaymentBloc>().add(const PaymentEvent.transientStatusReset());
    }
  }

  void _snack(BuildContext context, String? message, {bool isError = false}) {
    if (message == null || message.isEmpty) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? context.error : context.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}
