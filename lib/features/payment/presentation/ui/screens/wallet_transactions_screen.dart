import 'package:customertaxi/common/imports/imports.dart';

import '../../../domain/entities/wallet_entities.dart';
import '../../states/payment_bloc.dart';
import '../widgets/wallet_transaction_tile.dart';

class WalletTransactionsScreen extends StatelessWidget {
  const WalletTransactionsScreen({super.key});

  static const String pagePath = '/wallet_transactions';
  static const String pageName = 'WalletTransactionsScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentBloc>(
      create: (_) =>
          getIt<PaymentBloc>()..add(const PaymentEvent.transactionsRequested()),
      child: AppScaffold.appBar(
        appBarConfig: AppScaffoldAppBarConfig(
          title: AppStrings.walletTransactionsTitle,
        ),
        child: const _WalletTransactionsBody(),
      ),
    );
  }
}

class _WalletTransactionsBody extends StatelessWidget {
  const _WalletTransactionsBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      buildWhen: (a, b) => a.transactionsStatus != b.transactionsStatus,
      builder: (context, state) {
        return StatusBuilder<WalletTransactionsPage>(
          state: state.transactionsStatus,
          onRefresh: () async => context.read<PaymentBloc>().add(
            const PaymentEvent.transactionsRequested(),
          ),
          isEmpty: (page) => page.items.isEmpty,
          empty: () => EmptyStateWidget(
            text: AppStrings.walletNoTransactions,
            onRefresh: () async => context.read<PaymentBloc>().add(
              const PaymentEvent.transactionsRequested(),
            ),
          ),
          success: (page) => ListView.separated(
            padding: REdgeInsets.symmetric(vertical: AppSpacing.md),
            itemCount: page.items.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: context.onSurface.withValues(alpha: 0.06),
            ),
            itemBuilder: (_, index) =>
                WalletTransactionTile(transaction: page.items[index]),
          ),
        );
      },
    );
  }
}
