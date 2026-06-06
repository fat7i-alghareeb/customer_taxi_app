import 'package:customertaxi/common/imports/imports.dart';

import '../screens/trip_invoice_screen.dart';
import '../screens/trip_receipt_screen.dart';

/// Two pill-shaped chips ("Receipt" / "Invoice") shown above the fare card on
/// completed trips. Mirrors the Uber reference image. Reused by both the
/// inline completion sheet in [ActiveTripBody] and the dedicated
/// [TripDetailsScreen].
class CompletedActionChips extends StatelessWidget {
  const CompletedActionChips({super.key, required this.tripId});

  final String tripId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ActionChip(
          icon: FontAwesomeIcons.fileInvoice,
          label: AppStrings.tripInvoiceChip,
          onTap: () => context.pushNamed(
            TripInvoiceScreen.pageName,
            extra: tripId,
          ),
        ),
        AppSpacing.md.horizontalSpace,
        _ActionChip(
          icon: FontAwesomeIcons.receipt,
          label: AppStrings.tripReceiptChip,
          onTap: () => context.pushNamed(
            TripReceiptScreen.pageName,
            extra: tripId,
          ),
        ),
      ],
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final FaIconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return Material(
      color: colors.onSurface.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(AppRadii.xl.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.xl.r),
        onTap: onTap,
        child: Padding(
          padding: REdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm + 2,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppTextStyles.s14w600.copyWith(color: colors.onSurface),
              ),
              AppSpacing.sm.horizontalSpace,
              FaIcon(icon, size: 16.r, color: colors.onSurface),
            ],
          ),
        ),
      ),
    );
  }
}
