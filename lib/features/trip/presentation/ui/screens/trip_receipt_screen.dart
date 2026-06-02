import 'package:customertaxi/common/imports/imports.dart';

import '../../../domain/entities/trip_receipt_entity.dart';
import '../../states/trip_bloc.dart';
import 'trip_invoice_screen.dart';

/// Customer-facing receipt screen — mirrors the Uber "الإيصال" reference image.
/// Loaded via [TripBloc] using the per-section [TripState.receiptStatus] so
/// the rest of the trip view doesn't get a whole-screen spinner.
class TripReceiptScreen extends StatelessWidget {
  const TripReceiptScreen({super.key});

  static const String pagePath = '/trip_receipt';
  static const String pageName = 'TripReceiptScreen';

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final tripId =
        (state.extra as String?) ?? state.uri.queryParameters['id'] ?? '';

    return BlocProvider<TripBloc>(
      create: (_) => getIt<TripBloc>()..add(TripEvent.loadReceipt(tripId)),
      child: AppScaffold.appBar(
        appBarConfig: AppScaffoldAppBarConfig(title: AppStrings.receiptTitle),
        child: _TripReceiptBody(tripId: tripId),
      ),
    );
  }
}

class _TripReceiptBody extends StatelessWidget {
  const _TripReceiptBody({required this.tripId});

  final String tripId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripBloc, TripState>(
      buildWhen: (a, b) => a.receiptStatus != b.receiptStatus,
      builder: (context, state) {
        return StatusBuilder<TripReceiptEntity>(
          state: state.receiptStatus,
          onError: () =>
              context.read<TripBloc>().add(TripEvent.loadReceipt(tripId)),
          success: (receipt) => _ReceiptContent(receipt: receipt),
        );
      },
    );
  }
}

class _ReceiptContent extends StatelessWidget {
  const _ReceiptContent({required this.receipt});

  final TripReceiptEntity receipt;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final issuedAt = receipt.invoiceIssuedAtUtc ?? receipt.completedAtUtc;
    final issuedAtStr = issuedAt != null
        ? '${issuedAt.toLocal().toYmd()} • ${issuedAt.toLocal().toTime12Compact()}'
        : '';

    return SingleChildScrollView(
      padding: REdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Branding / issued date header
          Text(
            receipt.issuerName,
            style: AppTextStyles.s20w700.copyWith(color: colors.onSurface),
          ),
          if (issuedAtStr.isNotEmpty) ...[
            AppSpacing.xs.verticalSpace,
            Text(
              issuedAtStr,
              style: AppTextStyles.s12w400.copyWith(
                color: colors.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],

          AppSpacing.xl.verticalSpace,
          Text(
            AppStrings.receiptThankYou.replaceAll(
              '{name}',
              receipt.passengerName ?? '',
            ),
            style: AppTextStyles.s24w700.copyWith(color: colors.onSurface),
          ),
          AppSpacing.sm.verticalSpace,
          Text(
            AppStrings.receiptHopeEnjoyed,
            style: AppTextStyles.s14w400.copyWith(
              color: colors.onSurface.withValues(alpha: 0.6),
            ),
          ),

          AppSpacing.xl.verticalSpace,
          _TotalCard(
            amount: receipt.grossAmount,
            currencyCode: receipt.currencyCode,
          ),

          AppSpacing.lg.verticalSpace,
          _ReceiptLineItem(
            label: AppStrings.receiptTripFare,
            amount: receipt.netAmount,
            currencyCode: receipt.currencyCode,
          ),

          AppSpacing.xl.verticalSpace,
          _SectionHeader(title: AppStrings.receiptPayments),
          AppSpacing.md.verticalSpace,
          _PaymentRow(
            method: receipt.paymentMethod,
            amount: receipt.grossAmount,
            currencyCode: receipt.currencyCode,
            paidAtUtc: receipt.paidAtUtc ?? receipt.completedAtUtc,
          ),

          AppSpacing.xl.verticalSpace,
          if (receipt.invoiceAvailable)
            AppButton.outline(
              onTap: () => context.pushNamed(
                TripInvoiceScreen.pageName,
                extra: receipt.tripId,
              ),
              child: AppButtonChild.label(AppStrings.tripInvoiceChip),
            )
          else
            Container(
              padding: REdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: colors.onSurface.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(AppRadii.lg.r),
              ),
              child: Text(
                AppStrings.invoiceNotIssuedYet,
                style: AppTextStyles.s12w400.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}

class _TotalCard extends StatelessWidget {
  const _TotalCard({required this.amount, required this.currencyCode});

  final double amount;
  final String currencyCode;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return Container(
      padding: REdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.onSurface.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              AppStrings.receiptTotal,
              style: AppTextStyles.s20w700.copyWith(color: colors.onSurface),
            ),
          ),
          Text(
            '${amount.toStringAsFixed(2)} $currencyCode',
            style: AppTextStyles.s24w700.copyWith(color: colors.primary),
          ),
        ],
      ),
    );
  }
}

class _ReceiptLineItem extends StatelessWidget {
  const _ReceiptLineItem({
    required this.label,
    required this.amount,
    required this.currencyCode,
  });

  final String label;
  final double amount;
  final String currencyCode;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.s14w400.copyWith(
              color: colors.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
        Text(
          '${amount.toStringAsFixed(2)} $currencyCode',
          style: AppTextStyles.s14w600.copyWith(color: colors.onSurface),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.s16w700.copyWith(color: context.colorScheme.onSurface),
    );
  }
}

class _PaymentRow extends StatelessWidget {
  const _PaymentRow({
    required this.method,
    required this.amount,
    required this.currencyCode,
    required this.paidAtUtc,
  });

  final String method;
  final double amount;
  final String currencyCode;
  final DateTime? paidAtUtc;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final methodLabel = switch (method.toLowerCase()) {
      'cash' => AppStrings.paymentMethodCash,
      'creditcard' || 'credit_card' || 'card' => AppStrings.paymentMethodCard,
      'wallet' => AppStrings.paymentMethodWallet,
      _ => method,
    };
    final icon = switch (method.toLowerCase()) {
      'cash' => FontAwesomeIcons.moneyBill1,
      'creditcard' || 'credit_card' || 'card' => FontAwesomeIcons.creditCard,
      'wallet' => FontAwesomeIcons.wallet,
      _ => FontAwesomeIcons.circleDollarToSlot,
    };
    final paidStr = paidAtUtc != null
        ? '${paidAtUtc!.toLocal().toYmd()} • ${paidAtUtc!.toLocal().toTime12Compact()}'
        : '';

    return Row(
      children: [
        Container(
          padding: REdgeInsets.all(AppSpacing.sm + 2),
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppRadii.md.r),
          ),
          child: FaIcon(icon, color: colors.primary, size: 18.r),
        ),
        AppSpacing.md.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                methodLabel,
                style: AppTextStyles.s14w600.copyWith(color: colors.onSurface),
              ),
              if (paidStr.isNotEmpty)
                Text(
                  paidStr,
                  style: AppTextStyles.s12w400.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.5),
                  ),
                ),
            ],
          ),
        ),
        Text(
          '${amount.toStringAsFixed(2)} $currencyCode',
          style: AppTextStyles.s14w700.copyWith(color: colors.onSurface),
        ),
      ],
    );
  }
}

