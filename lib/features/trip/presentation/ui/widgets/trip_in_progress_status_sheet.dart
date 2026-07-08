import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/in_trip_safety_panel.dart';

/// Sheet shown while `TripStatus.inProgress` — passenger is in the car.
class TripInProgressStatusSheet extends StatelessWidget {
  const TripInProgressStatusSheet({
    required this.trip,
    required this.arrivalProgressHeader,
    super.key,
  });

  final TripEntity trip;

  /// Live ETA + dashed-line-with-car header (car → destination), built by the
  /// parent since it owns the distance baseline.
  final Widget arrivalProgressHeader;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            FaIcon(FontAwesomeIcons.route, color: colors.primary, size: 24.r),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Text(
                AppStrings.tripStatusInProgress,
                style: AppTextStyles.s20w700.copyWith(color: colors.onSurface),
              ),
            ),
          ],
        ),
        AppSpacing.lg.verticalSpace,

        // // Real-time progress toward the destination:
        // arrivalProgressHeader,
        // AppSpacing.lg.verticalSpace,

        Divider(
          height: 1.h,
          thickness: 1.r,
          color: colors.onSurface.withValues(alpha: 0.08),
        ),
        AppSpacing.md.verticalSpace,
        InTripSafetyPanel(tripId: trip.id),
      ],
    );
  }
}
