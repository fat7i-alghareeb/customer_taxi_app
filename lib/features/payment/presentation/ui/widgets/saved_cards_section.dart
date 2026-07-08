import 'package:customertaxi/common/imports/imports.dart';

import '../../../domain/entities/payment_method_entities.dart';
import '../../states/payment_bloc.dart';
import 'payment_section_header.dart';

/// "Betaalmethode toevoegen" — saved reusable cards used for automatic ride-related
/// fees, plus the add-card entry point (SetupIntent + consent).
class SavedCardsSection extends StatelessWidget {
  const SavedCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      buildWhen: (a, b) =>
          a.methodsStatus != b.methodsStatus ||
          a.addCardStatus != b.addCardStatus,
      builder: (context, state) {
        final methods = state.methodsStatus.getDataWhenSuccess ?? const [];
        final isAdding = state.addCardStatus.isLoading;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PaymentSectionHeader(title: AppStrings.savedCardsSectionTitle),
            AppSpacing.md.verticalSpace,
            if (methods.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  color: context.surface,
                  borderRadius: BorderRadius.circular(AppRadii.lg.r),
                  border: Border.all(
                    color: context.onSurface.withValues(alpha: 0.08),
                  ),
                ),
                child: Column(
                  children: [
                    for (var i = 0; i < methods.length; i++) ...[
                      if (i > 0)
                        Divider(
                          height: 1,
                          color: context.onSurface.withValues(alpha: 0.06),
                        ),
                      _CardRow(method: methods[i]),
                    ],
                  ],
                ),
              ),
            AppSpacing.md.verticalSpace,
            _AddCardRow(
              isLoading: isAdding,
              onTap: () => _addCard(context, makeDefault: methods.isEmpty),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addCard(
    BuildContext context, {
    required bool makeDefault,
  }) async {
    final bloc = context.read<PaymentBloc>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppStrings.addPaymentMethodCta),
        content: Text(AppStrings.addCardConsent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(AppStrings.addCardConsentAgree),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      bloc.add(PaymentEvent.addCardRequested(setAsDefault: makeDefault));
    }
  }
}

class _CardRow extends StatelessWidget {
  const _CardRow({required this.method});

  final PaymentMethodEntity method;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          FaIcon(
            FontAwesomeIcons.creditCard,
            size: 20.r,
            color: context.onSurface,
          ),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${method.cardBrand.toUpperCase()} •••• ${method.lastFour}',
                  style: AppTextStyles.s14w600.copyWith(
                    color: context.onSurface,
                  ),
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  method.expiryLabel,
                  style: AppTextStyles.s12w400.copyWith(
                    color: context.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          if (method.isDefault)
            _DefaultChip()
          else
            TextButton(
              onPressed: () => context.read<PaymentBloc>().add(
                PaymentEvent.defaultMethodSelected(method.id),
              ),
              child: Text(
                AppStrings.paymentMethodSetDefault,
                style: AppTextStyles.s12w700.copyWith(color: context.primary),
              ),
            ),
          IconButton(
            onPressed: () => _confirmDelete(context),
            icon: FaIcon(
              FontAwesomeIcons.trashCan,
              size: 16.r,
              color: context.error,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final bloc = context.read<PaymentBloc>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppStrings.paymentMethodDelete),
        content: Text(AppStrings.paymentMethodDeleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(
              AppStrings.paymentMethodDelete,
              style: TextStyle(color: context.error),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      bloc.add(PaymentEvent.methodDeleted(method.id));
    }
  }
}

class _DefaultChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
      decoration: BoxDecoration(
        color: context.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Text(
        AppStrings.paymentMethodDefaultLabel,
        style: AppTextStyles.s11w500.copyWith(color: context.primary),
      ),
    );
  }
}

class _AddCardRow extends StatelessWidget {
  const _AddCardRow({required this.isLoading, required this.onTap});

  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.lg.r),
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
        ),
        child: Row(
          children: [
            FaIcon(FontAwesomeIcons.plus, size: 16.r, color: context.primary),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Text(
                AppStrings.addPaymentMethodCta,
                style: AppTextStyles.s14w600.copyWith(color: context.onSurface),
              ),
            ),
            if (isLoading)
              SizedBox(
                width: 16.r,
                height: 16.r,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: context.primary,
                ),
              )
            else
              FaIcon(
                context.chevronEnd,
                size: 12.r,
                color: context.primary,
              ),
          ],
        ),
      ),
    );
  }
}
