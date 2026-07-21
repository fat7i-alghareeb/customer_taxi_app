import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';

/// The trip's current price, shown on the live trip sheets.
///
/// The active-trip sheets used to render the route, passengers and bags but never the fare,
/// so a re-priced edit changed the trip with no visible trace of what it cost — customers
/// reported being changed "without being charged" while the money had in fact moved. Giving
/// the fare a permanent home means every edit is legible the moment it lands.
class TripFareCard extends StatelessWidget {
  const TripFareCard({required this.trip, super.key});

  final TripEntity trip;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(
          color: colors.primary.withValues(alpha: 0.16),
          width: 1.r,
        ),
      ),
      child: Row(
        children: [
          FaIcon(
            FontAwesomeIcons.receipt,
            size: 16.r,
            color: colors.primary.withValues(alpha: 0.7),
          ),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Text(
              AppStrings.tripInfoFareLabel,
              style: AppTextStyles.s12w400.copyWith(
                color: colors.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
          Text(
            '${trip.quotedFare.toStringAsFixed(2)} ${trip.currencyCode}',
            style: AppTextStyles.s16w700.copyWith(color: colors.primary),
          ),
        ],
      ),
    );
  }
}
