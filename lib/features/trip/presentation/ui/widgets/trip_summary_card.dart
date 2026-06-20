import 'package:customertaxi/common/imports/imports.dart';
import '../../../domain/entities/trip_entity.dart';
import '../../../domain/entities/trip_status.dart';
import 'trip_status_chip.dart';
import '../screens/active_trip_screen.dart';
import '../screens/trip_details_screen.dart';

class TripSummaryCard extends StatelessWidget {
  const TripSummaryCard({super.key, required this.trip});
  final TripSummaryEntity trip;

  @override
  Widget build(BuildContext context) {
    final dateStr = trip.createdAtUtc.toLocal().toYmd(); // Using extension §24

    return Card(
      margin: REdgeInsets.only(bottom: AppSpacing.md),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        side: BorderSide(color: context.colorScheme.outline.withValues(alpha: 0.1)),
      ),
      child: InkWell(
        onTap: () {
          // Live trips → ActiveTripScreen (map + status sheet).
          // Completed trips → TripDetailsScreen (post-trip view with the
          // receipt / invoice chips, mirroring the Uber reference image).
          final pageName = trip.status == TripStatus.completed
              ? TripDetailsScreen.pageName
              : ActiveTripScreen.pageName;
          context.pushNamed(pageName, extra: trip.id);
        },
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        child: Padding(
          padding: REdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(trip.referenceCode, style: AppTextStyles.s16w700),
                  TripStatusChip(status: trip.status),
                ],
              ),
              AppSpacing.sm.verticalSpace,
              if (trip.scheduledAtUtc != null &&
                  !trip.status.isTerminal) ...[
                Text(
                  AppStrings.tripScheduledFor.replaceAll(
                    '{time}',
                    trip.scheduledAtUtc!.toLocal().toSmartDateTime(),
                  ),
                  style: AppTextStyles.s12w700.copyWith(
                    color: AppColors.warning,
                  ),
                ),
              ] else ...[
                Text(
                  dateStr,
                  style: AppTextStyles.s12w400.copyWith(
                    color: context.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
              AppSpacing.md.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.tripFare,
                    style: AppTextStyles.s14w400.copyWith(
                      color: context.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  Text(
                    '${trip.quotedFare.toStringAsFixed(2)} ${trip.currencyCode}',
                    style: AppTextStyles.s16w700.copyWith(color: context.primary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn().slideX(begin: 0.05); // Entry animation §18
  }
}
