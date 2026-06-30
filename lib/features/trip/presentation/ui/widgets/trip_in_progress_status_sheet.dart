import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/in_trip_safety_panel.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_chat_button.dart';

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

        // Real-time progress toward the destination — car → destination now
        // that the passenger is on board. Sits above the safety options.
        arrivalProgressHeader,
        AppSpacing.lg.verticalSpace,

        // Safety panel — only while the passenger is in the car with the
        // driver. Lives inside the sheet so it reads as a section, not a
        // floating card.
        Divider(
          height: 1.h,
          thickness: 1.r,
          color: colors.onSurface.withValues(alpha: 0.08),
        ),
        AppSpacing.md.verticalSpace,
        InTripSafetyPanel(tripId: trip.id),
        AppSpacing.lg.verticalSpace,

        // Chat with the driver (kept in-sheet after removing the floating pill).
        const TripChatButton(),
      ],
    );
  }
}
