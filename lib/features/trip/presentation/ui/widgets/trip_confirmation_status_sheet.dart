import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_status.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_cancel_button.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_chat_button.dart';

/// Confirmation sheet covering the `awaitingAdminAcceptance` → `accepted`
/// transition. Both statuses share the same layout (booking time, pickup /
/// drop-off, chat, cancel); only the headline differs — "Your ride is
/// **pending**" while awaiting, "Your ride is **confirmed**" once accepted. The
/// headline cross-fades between the two as the status flips, since the parent
/// keeps this widget mounted across the change.
class TripConfirmationStatusSheet extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final isAccepted = trip.status == TripStatus.accepted;
    final pickupStop = trip.stops.isNotEmpty ? trip.stops.first : null;
    final dropoffStop = trip.stops.length > 1 ? trip.stops.last : null;
    final bookingTime = trip.createdAtUtc.toLocal().toTime24();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Headline swaps "pending" ↔ "confirmed" with a fade + slide when the
        // admin accepts the ride.
        AnimatedSwitcher(
          duration: AppDurations.slow,
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.25),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
          child: _Headline(key: ValueKey(isAccepted), isAccepted: isAccepted),
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

/// "Your ride is **pending / confirmed**" — the keyword and its colour reflect
/// whether the ride has been accepted yet.
class _Headline extends StatelessWidget {
  const _Headline({required this.isAccepted, super.key});

  final bool isAccepted;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final keyword = isAccepted
        ? AppStrings.activeTripConfirmedKeyword
        : AppStrings.activeTripPendingKeyword;
    final keywordColor = isAccepted
        ? colors.primary
        : colors.onSurface.withValues(alpha: 0.45);

    return RichText(
      text: TextSpan(
        style: AppTextStyles.s24w700.copyWith(color: colors.onSurface),
        children: [
          TextSpan(text: '${AppStrings.activeTripRideIsPrefix} '),
          TextSpan(text: keyword, style: TextStyle(color: keywordColor)),
        ],
      ),
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
