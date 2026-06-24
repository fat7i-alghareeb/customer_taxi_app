import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/driver_location_entity.dart';

/// Formatting helpers for the live driver-arrival estimate shown to the passenger
/// while the driver is heading to the pickup. Keeps presentation pure (no BLoC).
abstract final class LiveArrival {
  /// Whole minutes until the driver reaches the pickup (always at least 1).
  static int minutes(int etaSeconds) {
    final mins = (etaSeconds / 60).ceil();
    return mins < 1 ? 1 : mins;
  }

  /// Remaining distance to pickup, e.g. `2.3 km` or `450 m`.
  static String distance(int meters) {
    if (meters >= 1000) {
      return '${(meters / 1000).toStringAsFixed(1)} km';
    }
    return '$meters m';
  }

  /// Clock time the driver is expected to arrive, formatted 24h `HH:mm`.
  static String arrivalClock(int etaSeconds, {DateTime? now}) {
    final eta = (now ?? DateTime.now()).add(Duration(seconds: etaSeconds));
    final hh = eta.hour.toString().padLeft(2, '0');
    final mm = eta.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }

  /// True when the location carries a usable live arrival estimate.
  static bool hasEstimate(DriverLocationEntity? loc) =>
      loc?.etaToPickupSeconds != null;
}

/// Compact dark pill shown at the top-left of the map: bold orange "{n} min"
/// over a muted "Arrival" label — the live driver-arrival badge.
class LiveArrivalBadge extends StatelessWidget {
  const LiveArrivalBadge({super.key, required this.etaSeconds});

  final int etaSeconds;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final mins = LiveArrival.minutes(etaSeconds);

    return Container(
      padding: REdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xCC1C1C1E),
        borderRadius: BorderRadius.circular(AppRadii.md.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$mins',
                style: AppTextStyles.s20w700.copyWith(color: colors.primary),
              ),
              Text(
                'min',
                style: AppTextStyles.s12w500.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
          AppSpacing.md.horizontalSpace,
          Text(
            AppStrings.activeTripArrivalLabel,
            style: AppTextStyles.s14w600.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}
