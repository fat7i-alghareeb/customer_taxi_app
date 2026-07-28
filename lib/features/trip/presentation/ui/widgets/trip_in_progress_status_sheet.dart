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
            Assets.images.tripCarImage.image(
              width: 24.r,
              height: 24.r,
              fit: BoxFit.contain,
            ),
            AppSpacing.md.horizontalSpace,
            Expanded(
              // "Onderweg naar uw bestemming" — the fuller destination-aware
              // wording; `tripStatusInProgress` stays the short chip label.
              // "Onderweg" is accented here too so the sheet reads as the same
              // step as the card above it. The rest keeps `onSurface`: this sheet
              // sits on a light glass surface, where white would be invisible.
              child: _AccentedTitle(
                text: AppStrings.activeTripInProgressTitle,
                accent: AppStrings.activeTripInProgressTitleAccent,
                style: AppTextStyles.s20w700.copyWith(color: colors.onSurface),
                accentColor: colors.primary,
              ),
            ),
          ],
        ),
        AppSpacing.sm.verticalSpace,

        // Reassurance cards shown while the ride is underway.
        _InfoCard(
          icon: FontAwesomeIcons.carSide,
          image: Assets.images.tripCarImage,
          title: AppStrings.activeTripInProgressEnjoyTitle,
          body: AppStrings.activeTripInProgressEnjoyBody,
          // Deliberately untinted: on this step the accent belongs to "Onderweg"
          // in the headline, so "Fijne rit!" reads as plain text (the light-surface
          // equivalent of the white it gets on the dark card above).
          titleColor: colors.onSurface,
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

/// Title with one localized substring painted in [accentColor]. Falls back to a
/// plain [Text] when the accent phrase isn't found, so a translation that drifts
/// out of sync degrades instead of breaking the headline.
class _AccentedTitle extends StatelessWidget {
  const _AccentedTitle({
    required this.text,
    required this.accent,
    required this.style,
    required this.accentColor,
  });

  final String text;
  final String accent;
  final TextStyle style;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final idx = accent.isEmpty
        ? -1
        : text.toLowerCase().indexOf(accent.toLowerCase());
    if (idx < 0) return Text(text, style: style);

    final before = text.substring(0, idx);
    final match = text.substring(idx, idx + accent.length);
    final after = text.substring(idx + accent.length);

    return RichText(
      text: TextSpan(
        style: style,
        children: [
          if (before.isNotEmpty) TextSpan(text: before),
          TextSpan(text: match, style: TextStyle(color: accentColor)),
          if (after.isNotEmpty) TextSpan(text: after),
        ],
      ),
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
    this.image,
    this.titleColor,
  });

  final FaIconData icon;
  final String title;
  final String body;

  /// Optional illustration shown in the leading chip instead of [icon].
  final AssetGenImage? image;
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
            child: image != null
                ? image!.image(width: 22.r, height: 22.r, fit: BoxFit.contain)
                : FaIcon(icon, color: colors.primary, size: 22.r),
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
