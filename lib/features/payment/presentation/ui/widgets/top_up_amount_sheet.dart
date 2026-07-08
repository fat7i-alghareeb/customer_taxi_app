import 'package:flutter/services.dart';
import 'package:customertaxi/common/imports/imports.dart';

import 'payment_format.dart';

/// Shows a bottom sheet to choose a top-up amount. Returns the chosen amount,
/// or null if dismissed.
Future<double?> showTopUpAmountSheet(BuildContext context) {
  return showModalBottomSheet<double>(
    context: context,
    isScrollControlled: true,
    backgroundColor: context.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadii.xl.r)),
    ),
    builder: (_) => const _TopUpAmountSheet(),
  );
}

class _TopUpAmountSheet extends StatefulWidget {
  const _TopUpAmountSheet();

  @override
  State<_TopUpAmountSheet> createState() => _TopUpAmountSheetState();
}

class _TopUpAmountSheetState extends State<_TopUpAmountSheet> {
  static const List<double> _presets = [10, 20, 50, 100];
  final TextEditingController _controller = TextEditingController();
  double? _selectedPreset;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double? get _amount {
    if (_controller.text.trim().isNotEmpty) {
      return double.tryParse(_controller.text.trim().replaceAll(',', '.'));
    }
    return _selectedPreset;
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: REdgeInsets.only(
        left: AppSpacing.xl,
        right: AppSpacing.xl,
        top: AppSpacing.lg,
      ).add(EdgeInsets.only(bottom: bottomInset + 24.h)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: context.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(999.r),
              ),
            ),
          ),
          AppSpacing.lg.verticalSpace,
          Text(
            AppStrings.walletTopUpAmountTitle,
            style: AppTextStyles.s18w600.copyWith(color: context.onSurface),
          ),
          AppSpacing.lg.verticalSpace,
          Wrap(
            spacing: AppSpacing.md.w,
            runSpacing: AppSpacing.md.h,
            children: _presets.map((amount) {
              final selected = _selectedPreset == amount &&
                  _controller.text.trim().isEmpty;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedPreset = amount;
                    _controller.clear();
                  });
                },
                child: Container(
                  padding: REdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? context.primary.withValues(alpha: 0.14)
                        : context.onSurface.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(AppRadii.md.r),
                    border: Border.all(
                      color: selected
                          ? context.primary
                          : context.onSurface.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Text(
                    formatMoney(amount, 'EUR'),
                    style: AppTextStyles.s14w700.copyWith(
                      color: selected ? context.primary : context.onSurface,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          AppSpacing.lg.verticalSpace,
          TextField(
            controller: _controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
            ],
            onChanged: (_) => setState(() => _selectedPreset = null),
            decoration: InputDecoration(
              prefixText: '€ ',
              hintText: AppStrings.walletTopUpCustomHint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.md.r),
              ),
            ),
          ),
          AppSpacing.xl.verticalSpace,
          AppButton.primary(
            layout: const AppButtonLayout(percentageWidth: 1),
            isActive: (_amount ?? 0) > 0,
            onTap: () {
              final amount = _amount;
              if (amount != null && amount > 0) {
                Navigator.of(context).pop(amount);
              }
            },
            child: AppButtonChild.label(
              AppStrings.walletTopUpCta,
              textStyle: AppTextStyles.s14w700,
            ),
          ),
        ],
      ),
    );
  }
}
