import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_cancel_button.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_chat_button.dart';

/// Sheet shown while `TripStatus.accepted` — the driver has been assigned but
/// hasn't started heading to pickup yet.
class TripAcceptedStatusSheet extends StatelessWidget {
  const TripAcceptedStatusSheet({
    required this.trip,
    required this.cancelStatus,
    required this.onCancelPressed,
    super.key,
  });

  final TripEntity trip;
  final BlocStatus<void> cancelStatus;
  final VoidCallback onCancelPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final pickupStop = trip.stops.isNotEmpty ? trip.stops.first : null;
    final dropoffStop = trip.stops.length > 1 ? trip.stops.last : null;
    final bookingTime = trip.createdAtUtc.toLocal().toTime24();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(
            style: AppTextStyles.s24w700.copyWith(color: colors.onSurface),
            children: [
              TextSpan(text: '${AppStrings.activeTripRideIsPrefix} '),
              TextSpan(
                text: AppStrings.activeTripConfirmedKeyword,
                style: TextStyle(color: colors.primary),
              ),
            ],
          ),
        ),
        AppSpacing.sm.verticalSpace,

        Row(
          children: [
            FaIcon(
              FontAwesomeIcons.solidClock,
              color: colors.onSurface.withValues(alpha: 0.45),
              size: 13.r,
            ),
            AppSpacing.xs.horizontalSpace,
            Text(
              AppStrings.activeTripBookedAt.replaceAll('{time}', bookingTime),
              style: AppTextStyles.s12w400.copyWith(
                color: colors.onSurface.withValues(alpha: 0.55),
              ),
            ),
          ],
        ),
        AppSpacing.xl.verticalSpace,

        if (pickupStop != null || dropoffStop != null)
          _StopsSection(pickup: pickupStop, dropoff: dropoffStop),

        AppSpacing.lg.verticalSpace,

        const TripChatButton(),
        AppSpacing.md.verticalSpace,

        if (trip.status.canCancel)
          TripCancelButton(
            isLoading: cancelStatus.isLoading,
            onTap: onCancelPressed,
          ),
      ],
    );
  }
}

class _StopsSection extends StatelessWidget {
  const _StopsSection({required this.pickup, required this.dropoff});

  final TripStopEntity? pickup;
  final TripStopEntity? dropoff;

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
              height: 20,
              color: colors.onSurface.withValues(alpha: 0.12),
            ),
          ),
        if (dropoff != null)
          locationRow(
            label: AppStrings.activeTripDropoffLabel,
            address: dropoff!.label ?? '',
            isPickup: false,
          ),
      ],
    );
  }
}
