import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/order/domain/entities/order_location_entity.dart';
import 'package:customertaxi/features/order/presentation/ui/screens/location_picker_screen.dart';
import 'package:customertaxi/features/root/domain/entities/root_map_location_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_count_picker_dialog.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_edit_flow.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_fare_card.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_info_row_widget.dart';

/// Stop timeline plus passenger and bag rows — the shared trip details block
/// rendered identically on the confirmation (pending / accepted) and en-route
/// sheets. Any stop can be repointed while the route edit window is open
/// (`TripEntity.canEditStops`); passengers and bags stay editable only until the
/// driver starts moving (`canEditPartySize`). Route and passenger edits are
/// previewed and charged/refunded server-side via [runTripEditFlow].
class TripEditableDetails extends StatelessWidget {
  const TripEditableDetails({
    required this.trip,
    this.compactPartyRow = false,
    super.key,
  });

  final TripEntity trip;

  /// En-route/arrived: collapse passengers, bags and vehicle into one read-only
  /// line (no edit pencils, no lock reason) instead of three full rows.
  final bool compactPartyRow;

  /// Opens the same search + pin-on-map picker used when booking, centred on the
  /// stop being changed, and re-prices the trip with the new route.
  Future<void> _editStop(BuildContext context, int index) async {
    final current = trip.stops;
    if (index < 0 || index >= current.length) return;

    final stop = current[index];
    final picked = await context.pushNamed<OrderLocationEntity>(
      LocationPickerScreen.pageName,
      extra: RootMapLocationEntity(
        latitude: stop.latitude,
        longitude: stop.longitude,
        zoom: 15,
      ),
    );
    if (picked == null || !context.mounted) return;

    final updated = <TripStopEntity>[
      for (var i = 0; i < current.length; i++)
        if (i == index)
          TripStopEntity(
            latitude: picked.latitude,
            longitude: picked.longitude,
            label: picked.label,
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
    final canEditStops = trip.canEditStops;
    final canEditPartySize = trip.canEditPartySize;

    // Party size closes once the driver is moving, because a bigger party can force a
    // different vehicle. Say so — a bare greyed pencil just looks broken.
    final partySizeLockReason = canEditPartySize
        ? null
        : AppStrings.tripEditLockedDriverOnWay;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (trip.stops.isNotEmpty)
          _StopsSection(
            stops: trip.stops,
            onEditStop: canEditStops
                ? (index) => _editStop(context, index)
                : null,
          ),
        AppSpacing.xl.verticalSpace,

        if (compactPartyRow)
          _CompactPartyRow(trip: trip)
        else ...[
          TripInfoRowWidget(
            icon: FontAwesomeIcons.users,
            label: AppStrings.tripInfoPassengersLabel,
            value: AppStrings.tripPassengersValue.replaceAll(
              '{count}',
              trip.passengerCount.toString(),
            ),
            onEditTap: canEditPartySize ? () => _editPassengers(context) : null,
            disabledReason: partySizeLockReason,
          ),

          TripInfoRowWidget(
            icon: FontAwesomeIcons.suitcase,
            label: AppStrings.tripInfoBagsLabel,
            value: AppStrings.tripBagsValue.replaceAll(
              '{count}',
              trip.bagCount.toString(),
            ),
            onEditTap: canEditPartySize ? () => _editBags(context) : null,
            disabledReason: partySizeLockReason,
          ),

          // Read-only, but essential: a passenger-count edit past the current capacity swaps
          // the vehicle, and without this row that upgrade happens invisibly.
          if (trip.vehicleTypeName case final vehicle? when vehicle.isNotEmpty)
            TripInfoRowWidget(
              icon: FontAwesomeIcons.carSide,
              label: AppStrings.tripInfoVehicleLabel,
              value: vehicle,
              showEditAffordance: false,
            ),
        ],

        AppSpacing.sm.verticalSpace,
        TripFareCard(trip: trip),
      ],
    );
  }
}

/// Compact one-line "passengers · bags · vehicle" summary shown once the party
/// size is locked (en-route / arrived) — replaces the three full editable rows
/// with icon + value pairs, no pencils and no lock reason.
class _CompactPartyRow extends StatelessWidget {
  const _CompactPartyRow({required this.trip});

  final TripEntity trip;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    Widget item(FaIconData icon, String value, {bool flexible = false}) {
      final content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            icon,
            size: 18.r,
            color: colors.primary.withValues(alpha: 0.8),
          ),
          AppSpacing.sm.horizontalSpace,
          flexible
              ? Flexible(
                  child: Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s16w600.copyWith(
                      color: colors.onSurface,
                    ),
                  ),
                )
              : Text(
                  value,
                  style: AppTextStyles.s16w600.copyWith(
                    color: colors.onSurface,
                  ),
                ),
        ],
      );
      return flexible ? Flexible(child: content) : content;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        item(
          FontAwesomeIcons.users,
          AppStrings.tripPassengersValue.replaceAll(
            '{count}',
            trip.passengerCount.toString(),
          ),
        ),
        AppSpacing.lg.horizontalSpace,
        item(
          FontAwesomeIcons.suitcase,
          AppStrings.tripBagsValue.replaceAll(
            '{count}',
            trip.bagCount.toString(),
          ),
        ),
        if (trip.vehicleTypeName case final vehicle?
            when vehicle.isNotEmpty) ...[
          AppSpacing.lg.horizontalSpace,
          item(FontAwesomeIcons.carSide, vehicle, flexible: true),
        ],
      ],
    );
  }
}

/// Dot timeline over every stop — orange pickup dot, connectors, outlined dots
/// for intermediate stops and the drop-off. Each row shows an edit pencil when
/// [onEditStop] is provided. Intermediate stops used to be hidden entirely; they
/// are part of the fare, so the rider needs to see and correct them.
class _StopsSection extends StatelessWidget {
  const _StopsSection({required this.stops, this.onEditStop});

  final List<TripStopEntity> stops;
  final void Function(int index)? onEditStop;

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

    final connector = Padding(
      padding: REdgeInsets.only(left: dotSize / 2 - 1),
      child: Container(
        width: 2,
        height: 18,
        color: colors.onSurface.withValues(alpha: 0.12),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < stops.length; i++) ...[
          if (i > 0) connector,
          locationRow(
            label: _labelFor(i),
            address: stops[i].label ?? '',
            isPickup: i == 0,
            onEdit: onEditStop == null ? null : () => onEditStop!(i),
          ),
        ],
      ],
    );
  }

  String _labelFor(int index) {
    if (index == 0) return AppStrings.activeTripPickupLabel;
    if (index == stops.length - 1) return AppStrings.activeTripDropoffLabel;
    return AppStrings.tripInfoStopLabel.replaceAll('{index}', index.toString());
  }
}
