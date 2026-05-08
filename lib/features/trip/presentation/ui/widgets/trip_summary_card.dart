import 'package:customertaxi/common/imports/imports.dart';
import '../../../domain/entities/trip_entity.dart';
import 'trip_status_chip.dart';
import '../screens/active_trip_screen.dart';

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
        onTap: () => context.pushNamed(
          ActiveTripScreen.pageName,
          extra: trip.id, // Or ScreenArgs if exists
        ),
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
              Text(
                dateStr,
                style: AppTextStyles.s12w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.5),
                ),
              ),
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
