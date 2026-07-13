import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/in_trip_safety_panel.dart';

/// Sheet shown while `TripStatus.inProgress` — passenger is in the car.
class TripInProgressStatusSheet extends StatelessWidget {
  const TripInProgressStatusSheet({required this.trip, super.key});

  final TripEntity trip;

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
        AppSpacing.sm.verticalSpace,

        // Reassurance cards shown while the ride is underway.
        _InfoCard(
          icon: FontAwesomeIcons.carSide,
          title: AppStrings.activeTripInProgressEnjoyTitle,
          body: AppStrings.activeTripInProgressEnjoyBody,
        ),
        AppSpacing.sm.verticalSpace,
        _InfoCard(
          icon: FontAwesomeIcons.solidClock,
          title: AppStrings.activeTripInProgressEtaTitle,
          body: AppStrings.activeTripInProgressEtaBody,
          titleColor: colors.primary,
        ),
        AppSpacing.md.verticalSpace,

        Divider(
          height: 1.h,
          thickness: 1.r,
          color: colors.onSurface.withValues(alpha: 0.08),
        ),
        AppSpacing.sm.verticalSpace,
        InTripSafetyPanel(tripId: trip.id),
      ],
    );
  }
}

/// Rounded info card: circular primary icon + title + (multi-line) body. Used
/// for the in-ride reassurance messages.
class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.body,
    this.titleColor,
  });

  final FaIconData icon;
  final String title;
  final String body;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Container(
      padding: REdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: colors.onSurface.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(
          color: colors.onSurface.withValues(alpha: 0.06),
          width: 1.r,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: REdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: FaIcon(icon, color: colors.primary, size: 22.r),
          ),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.s16w700.copyWith(
                    color: titleColor ?? colors.onSurface,
                  ),
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  body,
                  style: AppTextStyles.s12w400.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.65),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
