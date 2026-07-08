import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/order/domain/entities/order_location_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_status.dart';
import 'package:customertaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_address_picker_sheet.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_cancel_button.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_chat_button.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_info_row_widget.dart';

class TripConfirmationStatusSheet extends StatefulWidget {
  const TripConfirmationStatusSheet({
    required this.trip,
    required this.cancelStatus,
    required this.onCancelPressed,
    super.key,
  });

  final TripEntity trip;
  final BlocStatus<void> cancelStatus;
  final VoidCallback onCancelPressed;

  @override
  State<TripConfirmationStatusSheet> createState() =>
      _TripConfirmationStatusSheetState();
}

class _TripConfirmationStatusSheetState
    extends State<TripConfirmationStatusSheet> {
  TripEntity get trip => widget.trip;

  bool get _isWithinEditWindow => DateTime.now().toUtc().isBefore(
    trip.createdAtUtc.add(const Duration(hours: 1)),
  );

  VoidCallback? _editGuard(VoidCallback action) =>
      _isWithinEditWindow ? action : null;

  Future<void> _editAddress(int stopIndex) async {
    final location = await showTripAddressPickerSheet(
      context,
      title: AppStrings.tripInfoDestinationAddress,
    );
    if (location == null || !mounted) return;
    final updatedStops = _updatedStops(stopIndex, location);
    context.read<TripBloc>().add(TripEvent.stopsUpdateRequested(updatedStops));
  }

  List<TripStopEntity> _updatedStops(
    int index,
    OrderLocationEntity location,
  ) {
    final current = trip.stops;
    final updated = <TripStopEntity>[];
    for (var i = 0; i < current.length; i++) {
      if (i == index) {
        updated.add(
          TripStopEntity(
            latitude: location.latitude,
            longitude: location.longitude,
            label: location.label,
          ),
        );
      } else {
        updated.add(current[i]);
      }
    }
    return updated;
  }

  Future<void> _editPassengers() async {
    final current = trip.passengerCount;
    final picked = await _showCountPickerDialog(
      title: AppStrings.tripEditPassengers,
      initial: current,
      min: 1,
      max: 8,
    );
    if (picked == null || !mounted || picked == current) return;

    if (picked > 4) {
      final confirmed = await AppDialog.show<bool>(
        context,
        dialog: AppDialog.basic(
          title: AppStrings.tripVanUpgradeConfirmTitle,
          message: AppStrings.tripVanUpgradeNotice,
          primaryAction: AppDialogAction.primary(
            label: AppStrings.onboardingContinue,
            onPressed: () => Navigator.of(context).pop(true),
          ),
          secondaryAction: AppDialogAction.secondary(
            label: AppStrings.cancel,
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ),
      );
      if (confirmed != true || !mounted) return;
    }

    context.read<TripBloc>().add(
      TripEvent.passengerCountUpdateRequested(picked),
    );
  }

  Future<void> _editBags() async {
    final current = trip.bagCount;
    final picked = await _showCountPickerDialog(
      title: AppStrings.tripEditBags,
      initial: current,
      min: 0,
      max: 10,
    );
    if (picked == null || !mounted || picked == current) return;
    context.read<TripBloc>().add(TripEvent.bagCountUpdateRequested(picked));
  }

  Future<int?> _showCountPickerDialog({
    required String title,
    required int initial,
    required int min,
    required int max,
  }) {
    return showDialog<int>(
      context: context,
      builder: (ctx) => _CountPickerDialog(
        title: title,
        initial: initial,
        min: min,
        max: max,
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    return dt.formatDateTime(
      "d MMMM yyyy '•' HH:mm",
      locale: context.locale.languageCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final isAccepted = trip.status == TripStatus.accepted;
    final pickupStop = trip.stops.isNotEmpty ? trip.stops.first : null;
    final dropoffStop = trip.stops.length > 1 ? trip.stops.last : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 2-step status indicator
        _StatusIndicator(isAccepted: isAccepted),

        AppSpacing.md.verticalSpace,
        Divider(height: 1, color: colors.onSurface.withValues(alpha: 0.08)),
        AppSpacing.md.verticalSpace,

        // Booking time — read-only
        TripInfoRowWidget(
          icon: FontAwesomeIcons.solidClock,
          label: AppStrings.tripInfoBookingTime,
          value: _formatDateTime(trip.createdAtUtc.toLocal()),
        ),

        // Scheduled trip — read-only, only shown for scheduled trips
        if (trip.isScheduled && trip.scheduledAtUtc != null)
          TripInfoRowWidget(
            icon: FontAwesomeIcons.calendarDays,
            label: AppStrings.tripInfoScheduledTrip,
            value: _formatDateTime(trip.scheduledAtUtc!.toLocal()),
          ),

        // Pickup address — read-only
        if (pickupStop != null)
          TripInfoRowWidget(
            icon: FontAwesomeIcons.locationDot,
            label: AppStrings.tripInfoPickupAddress,
            value: pickupStop.label ?? '',
          ),

        // Destination address — editable
        if (dropoffStop != null)
          TripInfoRowWidget(
            icon: FontAwesomeIcons.flag,
            label: AppStrings.tripInfoDestinationAddress,
            value: dropoffStop.label ?? '',
            onEditTap: _editGuard(() => _editAddress(trip.stops.length - 1)),
          ),

        // Passengers — editable
        TripInfoRowWidget(
          icon: FontAwesomeIcons.users,
          label: AppStrings.tripInfoPassengersLabel,
          value: AppStrings.tripPassengersValue.replaceAll(
            '{count}',
            trip.passengerCount.toString(),
          ),
          onEditTap: _editGuard(_editPassengers),
        ),

        // Bags — editable
        TripInfoRowWidget(
          icon: FontAwesomeIcons.suitcase,
          label: AppStrings.tripInfoBagsLabel,
          value: AppStrings.tripBagsValue.replaceAll(
            '{count}',
            trip.bagCount.toString(),
          ),
          onEditTap: _editGuard(_editBags),
        ),

        AppSpacing.xl.verticalSpace,
        const TripChatButton(),
        AppSpacing.md.verticalSpace,

        if (trip.status.canCancel)
          TripCancelButton(
            isLoading: widget.cancelStatus.isLoading,
            onTap: widget.onCancelPressed,
          ),
      ],
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  const _StatusIndicator({required this.isAccepted});

  final bool isAccepted;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: dots + connector
          Column(
            children: [
              _StepDot(isCompleted: isAccepted, isActive: !isAccepted),
              Expanded(
                child: Container(
                  width: 2.w,
                  margin: REdgeInsets.symmetric(vertical: 2),
                  color: isAccepted
                      ? colors.primary
                      : colors.onSurface.withValues(alpha: 0.15),
                ),
              ),
              _StepDot(isCompleted: false, isActive: isAccepted),
            ],
          ),
          AppSpacing.md.horizontalSpace,
          // Right: labels
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: REdgeInsets.only(top: 3),
                  child: Text(
                    AppStrings.activeTripStepRideAccepted,
                    style: AppTextStyles.s14w700.copyWith(
                      color: colors.onSurface,
                    ),
                  ),
                ),
                AppSpacing.lg.verticalSpace,
                Padding(
                  padding: REdgeInsets.only(bottom: 3),
                  child: Text(
                    AppStrings.activeTripDriverComing,
                    style: AppTextStyles.s14w700.copyWith(
                      color: isAccepted
                          ? colors.onSurface
                          : colors.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepDot extends StatelessWidget {
  const _StepDot({required this.isCompleted, required this.isActive});

  final bool isCompleted;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    const size = 22.0;

    if (isCompleted) {
      return Container(
        width: size.r,
        height: size.r,
        decoration: BoxDecoration(
          color: colors.primary,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: FaIcon(FontAwesomeIcons.check, color: Colors.white, size: 11.r),
        ),
      );
    }

    return Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive
              ? colors.primary
              : colors.onSurface.withValues(alpha: 0.3),
          width: isActive ? 2.5.r : 2.r,
        ),
      ),
    );
  }
}

class _CountPickerDialog extends StatefulWidget {
  const _CountPickerDialog({
    required this.title,
    required this.initial,
    required this.min,
    required this.max,
  });

  final String title;
  final int initial;
  final int min;
  final int max;

  @override
  State<_CountPickerDialog> createState() => _CountPickerDialogState();
}

class _CountPickerDialogState extends State<_CountPickerDialog> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return AlertDialog(
      title: Text(widget.title, style: AppTextStyles.s16w700),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _value > widget.min
                ? () => setState(() => _value--)
                : null,
            icon: const Icon(Icons.remove_circle_outline),
            color: colors.primary,
            iconSize: 32.r,
          ),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Text(
              '$_value',
              style: AppTextStyles.s24w700.copyWith(color: colors.onSurface),
            ),
          ),
          IconButton(
            onPressed: _value < widget.max
                ? () => setState(() => _value++)
                : null,
            icon: const Icon(Icons.add_circle_outline),
            color: colors.primary,
            iconSize: 32.r,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppStrings.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_value),
          child: Text(AppStrings.confirm),
        ),
      ],
    );
  }
}
