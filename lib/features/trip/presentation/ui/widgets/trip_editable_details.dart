import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_address_picker_sheet.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_count_picker_dialog.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_edit_flow.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_info_row_widget.dart';

/// Pickup → drop-off timeline plus passenger and bag rows — the shared trip
/// details block rendered identically on the confirmation (pending / accepted)
/// and en-route sheets. Destination, passengers and bags stay editable while
/// the trip status allows repricing (`isEditableForRepricing`); each edit is
/// previewed and charged/refunded server-side via [runTripEditFlow].
class TripEditableDetails extends StatelessWidget {
  const TripEditableDetails({required this.trip, super.key});

  final TripEntity trip;

  bool get _canEdit => trip.status.isEditableForRepricing;

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

  Future<void> _editBags(BuildContext context) async {
    final picked = await showTripCountPicker(
      context,
      title: AppStrings.tripEditBags,
      initial: trip.bagCount,
      min: 0,
      max: 10,
    );
    if (picked == null || !context.mounted || picked == trip.bagCount) return;
    context.read<TripBloc>().add(TripEvent.bagCountUpdateRequested(picked));
  }

  @override
  Widget build(BuildContext context) {
    final pickup = trip.stops.isNotEmpty ? trip.stops.first : null;
    final dropoff = trip.stops.length > 1 ? trip.stops.last : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (pickup != null || dropoff != null)
          _StopsSection(
            pickup: pickup,
            dropoff: dropoff,
            onEditDropoff: (dropoff != null && _canEdit)
                ? () => _editDestination(context)
                : null,
          ),
        AppSpacing.sm.verticalSpace,

        TripInfoRowWidget(
          icon: FontAwesomeIcons.users,
          label: AppStrings.tripInfoPassengersLabel,
          value: AppStrings.tripPassengersValue.replaceAll(
            '{count}',
            trip.passengerCount.toString(),
          ),
          onEditTap: _canEdit ? () => _editPassengers(context) : null,
        ),

        TripInfoRowWidget(
          icon: FontAwesomeIcons.suitcase,
          label: AppStrings.tripInfoBagsLabel,
          value: AppStrings.tripBagsValue.replaceAll(
            '{count}',
            trip.bagCount.toString(),
          ),
          onEditTap: _canEdit ? () => _editBags(context) : null,
        ),
      ],
    );
  }
}

/// Pickup → drop-off dot timeline (orange pickup dot, connector, outlined
/// drop-off dot). The drop-off row shows an edit pencil when [onEditDropoff]
/// is provided.
class _StopsSection extends StatelessWidget {
  const _StopsSection({
    required this.pickup,
    required this.dropoff,
    this.onEditDropoff,
  });

  final TripStopEntity? pickup;
  final TripStopEntity? dropoff;
  final VoidCallback? onEditDropoff;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    const dotSize = 12.0;

    Widget dot({required bool isPickup}) => Container(
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(
        color: isPickup ? colors.primary : Colors.transparent,
        shape: BoxShape.circle,
        border: isPickup
            ? null
            : Border.all(
                color: colors.onSurface.withValues(alpha: 0.35),
                width: 2,
              ),
      ),
    );

    Widget locationRow({
      required String label,
      required String address,
      required bool isPickup,
      VoidCallback? onEdit,
    }) => Row(
      children: [
        dot(isPickup: isPickup),
        AppSpacing.md.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.s12w500.copyWith(
                  color: isPickup
                      ? colors.primary
                      : colors.onSurface.withValues(alpha: 0.5),
                ),
              ),
              AppSpacing.xs.verticalSpace,
              Text(
                address,
                style: AppTextStyles.s14w600.copyWith(color: colors.onSurface),
              ),
            ],
          ),
        ),
        if (onEdit != null)
          SizedBox(
            width: 36.r,
            height: 36.r,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: onEdit,
              icon: FaIcon(
                FontAwesomeIcons.penToSquare,
                size: 16.r,
                color: colors.primary,
              ),
            ),
          ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (pickup != null)
          locationRow(
            label: AppStrings.activeTripPickupLabel,
            address: pickup!.label ?? '',
            isPickup: true,
          ),
        if (pickup != null && dropoff != null)
          Padding(
            padding: REdgeInsets.only(left: dotSize / 2 - 1),
            child: Container(
              width: 2,
              height: 18,
              color: colors.onSurface.withValues(alpha: 0.12),
            ),
          ),
        if (dropoff != null)
          locationRow(
            label: AppStrings.activeTripDropoffLabel,
            address: dropoff!.label ?? '',
            isPickup: false,
            onEdit: onEditDropoff,
          ),
      ],
    );
  }
}
