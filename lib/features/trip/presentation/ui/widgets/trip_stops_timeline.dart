import 'package:customertaxi/common/imports/imports.dart';

import '../../../domain/entities/trip_entity.dart';

/// Vertical stops timeline (pickup → intermediate → destination) with
/// completion times. Extracted from the original inline completion sheet so
/// both [ActiveTripBody] and [TripDetailsScreen] can render it identically.
class TripStopsTimeline extends StatelessWidget {
  const TripStopsTimeline({super.key, required this.stops});

  final List<TripStopEntity> stops;

  @override
  Widget build(BuildContext context) {
    if (stops.isEmpty) return const SizedBox.shrink();

    final colors = context.colorScheme;
    return Container(
      padding: REdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.onSurface.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(
          color: colors.onSurface.withValues(alpha: 0.04),
          width: 1.r,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(stops.length, (index) {
          final stop = stops[index];
          final isLast = index == stops.length - 1;

          final timeStr = stop.completedAtUtc != null
              ? stop.completedAtUtc!.toLocal().toTime12Compact()
              : '';
          final completedStr = timeStr.isNotEmpty
              ? AppStrings.tripStopCompletedAt.replaceAll('{time}', timeStr)
              : AppStrings.tripStatusCompleted;

          final label = stop.label ??
              (index == 0
                  ? 'Pickup'
                  : isLast
                      ? 'Destination'
                      : 'Stop ${index + 1}');

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 10.r,
                    height: 10.r,
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                  ),
                  if (!isLast)
                    Container(
                      width: 2.w,
                      height: 24.h,
                      color: AppColors.success.withValues(alpha: 0.25),
                    ),
                ],
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTextStyles.s14w600.copyWith(
                        color: colors.onSurface,
                      ),
                    ),
                    Text(
                      completedStr,
                      style: AppTextStyles.s12w400.copyWith(
                        color: colors.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                    if (!isLast) AppSpacing.sm.verticalSpace,
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
