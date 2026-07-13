import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_address_picker_sheet.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_count_picker_dialog.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_edit_flow.dart';

/// Compact "change destination / passengers" actions shown on the en-route and
/// arrived sheets so the customer can still edit the ride while the driver is on
/// the way. Each action previews the fare difference, confirms it, and settles
/// (charge or refund) via [runTripEditFlow].
class TripEditActions extends StatelessWidget {
  const TripEditActions({required this.trip, super.key});

  final TripEntity trip;

  Future<void> _editDestination(BuildContext context) async {
    final location = await showTripAddressPickerSheet(
      context,
      title: AppStrings.tripInfoDestinationAddress,
    );
    if (location == null || !context.mounted) return;

    final current = trip.stops;
    if (current.isEmpty) return;
    final lastIndex = current.length - 1;
    final updated = <TripStopEntity>[
      for (var i = 0; i < current.length; i++)
        if (i == lastIndex)
          TripStopEntity(
            latitude: location.latitude,
            longitude: location.longitude,
            label: location.label,
          )
        else
          current[i],
    ];

    await runTripEditFlow(
      context,
      bloc: context.read<TripBloc>(),
      stops: updated,
    );
  }

  Future<void> _editPassengers(BuildContext context) async {
    final picked = await showTripCountPicker(
      context,
      title: AppStrings.tripEditPassengers,
      initial: trip.passengerCount,
      min: 1,
      max: 8,
    );
    if (picked == null || !context.mounted || picked == trip.passengerCount) {
      return;
    }
    await runTripEditFlow(
      context,
      bloc: context.read<TripBloc>(),
      passengerCount: picked,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _EditChip(
            icon: FontAwesomeIcons.locationDot,
            label: AppStrings.tripEditAddress,
            onTap: () => _editDestination(context),
          ),
        ),
        AppSpacing.sm.horizontalSpace,
        Expanded(
          child: _EditChip(
            icon: FontAwesomeIcons.users,
            label: AppStrings.tripEditPassengers,
            onTap: () => _editPassengers(context),
          ),
        ),
      ],
    );
  }
}

class _EditChip extends StatelessWidget {
  const _EditChip({
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.lg.r),
      child: Container(
        padding: REdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: colors.onSurface.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          border: Border.all(
            color: colors.onSurface.withValues(alpha: 0.06),
            width: 1.r,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, size: 14.r, color: colors.primary),
            AppSpacing.xs.horizontalSpace,
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s12w500.copyWith(color: colors.onSurface),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
