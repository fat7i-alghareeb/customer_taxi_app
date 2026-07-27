import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/root/presentation/ui/screens/root_screen.dart';
import 'package:customertaxi/features/root/presentation/ui/widgets/root_body.dart';

import '../../../domain/entities/trip_entity.dart';
import '../../../domain/entities/trip_status.dart';
import '../../utils/trip_countdown_format.dart';
import '../screens/active_trip_screen.dart';
import '../screens/trip_details_screen.dart';
import 'trip_status_chip.dart';

/// Which group the card is rendered in. Drives emphasis, not content: a trip
/// looks different depending on whether it is happening now, still a
/// reservation, or already history.
enum TripCardVariant { live, upcoming, past }

/// The fields a trip card needs, so one card serves both the full [TripEntity]
/// (live and upcoming trips, which come from `ActiveTripCubit`) and the lighter
/// [TripSummaryEntity] the paged history returns.
class TripCardData {
  const TripCardData({
    required this.id,
    required this.referenceCode,
    required this.status,
    required this.fare,
    required this.currencyCode,
    required this.createdAtUtc,
    required this.stops,
    required this.isLiveNow,
    this.scheduledAtUtc,
  });

  factory TripCardData.fromSummary(TripSummaryEntity trip) => TripCardData(
    id: trip.id,
    referenceCode: trip.referenceCode,
    status: trip.status,
    fare: trip.quotedFare,
    currencyCode: trip.currencyCode,
    createdAtUtc: trip.createdAtUtc,
    stops: trip.stops,
    scheduledAtUtc: trip.scheduledAtUtc,
    // The summary has no dispatch window, so fall back to the same 15-minute
    // lead the server uses. Only ever reached for the Past section, where the
    // trip is terminal and this is false regardless.
    isLiveNow:
        !trip.status.isTerminal &&
        (trip.scheduledAtUtc == null ||
            !DateTime.now().toUtc().isBefore(
              trip.scheduledAtUtc!.toUtc().subtract(const Duration(minutes: 15)),
            )),
  );

  factory TripCardData.fromTrip(TripEntity trip) => TripCardData(
    id: trip.id,
    referenceCode: trip.referenceCode,
    status: trip.status,
    fare: trip.quotedFare,
    currencyCode: trip.currencyCode,
    createdAtUtc: trip.createdAtUtc,
    stops: trip.stops,
    scheduledAtUtc: trip.scheduledAtUtc,
    // Authoritative: the entity owns the liveness rule.
    isLiveNow: trip.isLiveNow,
  );

  final String id;
  final String referenceCode;
  final TripStatus status;
  final double fare;
  final String currencyCode;
  final DateTime createdAtUtc;
  final List<TripStopEntity> stops;
  final DateTime? scheduledAtUtc;

  /// Whether the ride is underway. Decides where a tap goes — see
  /// [TripCard._open].
  final bool isLiveNow;

  String? get pickupLabel => _labelAt(0);
  String? get dropoffLabel => stops.length < 2 ? null : _labelAt(stops.length - 1);

  /// Stops between pickup and dropoff, which the card summarises as "+N stops"
  /// rather than listing.
  int get intermediateStopCount => stops.length <= 2 ? 0 : stops.length - 2;

  String? _labelAt(int index) {
    if (index < 0 || index >= stops.length) return null;
    final label = stops[index].label?.trim();
    return (label == null || label.isEmpty) ? null : label;
  }
}

/// A trip in the Trips tab. Shows where the ride goes — the old card only had a
/// reference code, a date and a fare, which made two trips indistinguishable.
class TripCard extends StatelessWidget {
  const TripCard({required this.trip, required this.variant, super.key});

  final TripCardData trip;
  final TripCardVariant variant;

  bool get _isLive => variant == TripCardVariant.live;
  bool get _isUpcoming => variant == TripCardVariant.upcoming;

  @override
  Widget build(BuildContext context) {
    final accent = _isLive ? AppColors.tripOrange : context.primary;

    return Card(
      margin: REdgeInsets.only(bottom: AppSpacing.md),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        side: BorderSide(
          color: _isLive
              ? AppColors.tripOrange.withValues(alpha: 0.5)
              : context.colorScheme.outline.withValues(alpha: 0.1),
          width: _isLive ? 1.5 : 1,
        ),
      ),
      child: InkWell(
        onTap: () => _open(context),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        child: Padding(
          padding: REdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (_isLive) ...[
                    _LivePulse(color: accent),
                    AppSpacing.sm.horizontalSpace,
                  ],
                  Expanded(
                    child: Text(
                      trip.referenceCode,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.s16w700,
                    ),
                  ),
                  AppSpacing.sm.horizontalSpace,
                  TripStatusChip(status: trip.status),
                ],
              ),
              AppSpacing.md.verticalSpace,
              _RouteBlock(trip: trip, accent: accent),
              AppSpacing.md.verticalSpace,
              Divider(
                height: 1,
                color: context.colorScheme.outline.withValues(alpha: 0.12),
              ),
              AppSpacing.md.verticalSpace,
              Row(
                children: [
                  Expanded(child: _timeLine(context, accent)),
                  AppSpacing.sm.horizontalSpace,
                  Text(
                    '${trip.fare.toStringAsFixed(2)} ${trip.currencyCode}',
                    style: AppTextStyles.s16w700.copyWith(color: accent),
                  ),
                ],
              ),
              if (_isLive) ...[
                AppSpacing.md.verticalSpace,
                AppButton.primary(
                  layout: AppButtonLayout(
                    width: double.infinity,
                    height: 44.h,
                    borderRadius: AppRadii.md,
                    backgroundColor: AppColors.tripOrange,
                  ),
                  noShadow: true,
                  child: AppButtonChild.labelIcon(
                    label: AppStrings.tripTrackRide,
                    icon: IconSource.icon(Icons.navigation_outlined),
                    iconSize: 16,
                    textStyle: AppTextStyles.s14w700,
                  ),
                  onTap: () => _open(context),
                ),
              ],
            ],
          ),
        ),
      ),
    ).animate().fadeIn().slideX(begin: 0.05);
  }

  /// The bottom-left line: a live countdown for reservations, the pickup time
  /// for a trip underway, the booking date for history.
  Widget _timeLine(BuildContext context, Color accent) {
    final scheduled = trip.scheduledAtUtc;

    if (_isUpcoming && scheduled != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.tripScheduledFor.replaceAll(
              '{time}',
              scheduled.toLocal().toSmartDateTime(),
            ),
            style: AppTextStyles.s12w700.copyWith(color: accent),
          ),
          AppSpacing.xs.verticalSpace,
          Text(
            formatStartsIn(scheduled),
            style: AppTextStyles.s11w500.copyWith(
              color: context.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      );
    }

    final label = scheduled != null && !trip.status.isTerminal
        ? AppStrings.tripScheduledFor.replaceAll(
            '{time}',
            scheduled.toLocal().toSmartDateTime(),
          )
        : trip.createdAtUtc.toLocal().toYmd();

    return Text(
      label,
      style: AppTextStyles.s12w400.copyWith(
        color: context.onSurface.withValues(alpha: 0.6),
      ),
    );
  }

  void _open(BuildContext context) {
    // Finished trips → TripDetailsScreen (post-trip view with the receipt /
    // invoice chips). It has an app bar, so back works.
    if (trip.status.isTerminal) {
      context.pushNamed(TripDetailsScreen.pageName, extra: trip.id);
      return;
    }

    // A ride underway already has a home: the Home tab, where `ActiveTripGate`
    // shows it full-screen with the bottom bar still reachable. Pushing it
    // instead would create a screen a rider cannot leave — an active trip is
    // deliberately not backable-out-of, and the pushed route has no bottom bar.
    if (trip.isLiveNow) {
      context.goNamed(RootScreen.pageName, extra: RootTab.home);
      return;
    }

    // A future reservation opens as its own screen, which carries a close
    // button (see `ActiveTripScreen`).
    context.pushNamed(ActiveTripScreen.pageName, extra: trip.id);
  }
}

/// Pickup → dropoff with a small timeline rail, so two trips are told apart at
/// a glance instead of by reference code alone.
class _RouteBlock extends StatelessWidget {
  const _RouteBlock({required this.trip, required this.accent});

  final TripCardData trip;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final pickup = trip.pickupLabel;
    final dropoff = trip.dropoffLabel;
    if (pickup == null && dropoff == null) return const SizedBox.shrink();

    final muted = context.onSurface.withValues(alpha: 0.35);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.only(top: AppSpacing.xs),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 9.r,
                height: 9.r,
                decoration: BoxDecoration(shape: BoxShape.circle, color: accent),
              ),
              Container(
                width: 1.5.r,
                height: 22.h,
                margin: REdgeInsets.symmetric(vertical: 2),
                color: muted,
              ),
              Container(
                width: 9.r,
                height: 9.r,
                decoration: BoxDecoration(
                  color: muted,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ],
          ),
        ),
        AppSpacing.md.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pickup ?? AppStrings.notAvailable,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s14w600,
              ),
              if (trip.intermediateStopCount > 0) ...[
                AppSpacing.xs.verticalSpace,
                Text(
                  AppStrings.tripExtraStops.replaceAll(
                    '{count}',
                    '${trip.intermediateStopCount}',
                  ),
                  style: AppTextStyles.s11w500.copyWith(
                    color: context.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ] else
                AppSpacing.md.verticalSpace,
              Text(
                dropoff ?? AppStrings.notAvailable,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s14w600,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Slow pulsing dot marking a trip that is happening right now.
class _LivePulse extends StatelessWidget {
  const _LivePulse({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 10.r,
          height: 10.r,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .fadeIn(duration: 700.ms)
        .then()
        .fadeOut(duration: 700.ms);
  }
}
