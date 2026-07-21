import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_status.dart';

/// Icon + text content for the status banner shown above the map. `null` from
/// [forStatus] means the given status keeps the plain map with no banner.
class TripStatusBannerContent {
  const TripStatusBannerContent({
    required this.icon,
    required this.title,
    required this.bodyLines,
  });

  final FaIconData icon;
  final String title;
  final List<String> bodyLines;

  static TripStatusBannerContent? forStatus(TripStatus status) {
    switch (status) {
      case TripStatus.awaitingAdminAcceptance:
        return TripStatusBannerContent(
          icon: FontAwesomeIcons.carSide,
          title: AppStrings.activeTripSearchingDriverTitle,
          bodyLines: [
            AppStrings.activeTripSearchingDriverBody,
            AppStrings.activeTripSearchingDriverConfirmSoon,
            AppStrings.activeTripSearchingDriverThanksPatience,
          ],
        );
      case TripStatus.accepted:
        return TripStatusBannerContent(
          icon: FontAwesomeIcons.carSide,
          title: AppStrings.activeTripDriverAssignedTitle,
          bodyLines: [AppStrings.activeTripComfortableTripSoon],
        );
      case TripStatus.arrived:
        return TripStatusBannerContent(
          icon: FontAwesomeIcons.carSide,
          title: AppStrings.activeTripDriverArrivedTitle,
          bodyLines: [AppStrings.activeTripDriverWaitingAtPickup],
        );
      case TripStatus.inProgress:
        return TripStatusBannerContent(
          icon: FontAwesomeIcons.route,
          title: AppStrings.activeTripInProgressTitle,
          bodyLines: [AppStrings.activeTripInProgressSubtitle],
        );
      // En-route shows the plain live driver→pickup map (no banner).
      case TripStatus.enRoute:
      case TripStatus.pendingQuote:
      case TripStatus.completed:
      case TripStatus.cancelled:
      case TripStatus.awaitingPayment:
      case TripStatus.paymentFailed:
      case TripStatus.refunded:
      case TripStatus.unknown:
        return null;
    }
  }
}

/// Dark rounded card (icon + title + body lines) shown above the status sheet
/// and reused by the full-screen overlays. Always pinned physically left and
/// LTR-laid-out regardless of app locale/RTL.
class TripStatusOverlayCard extends StatelessWidget {
  const TripStatusOverlayCard({
    required this.icon,
    required this.title,
    required this.bodyLines,
    this.highlightBrand = false,
    super.key,
  });

  final FaIconData icon;
  final String title;
  final List<String> bodyLines;

  /// When true, the "Fat7i" brand word inside any body line is split-
  /// coloured — "Fat7i" branding (legacy color-split comment).
  final bool highlightBrand;

  /// Renders [line], colouring the "Fat7i" brand word when
  /// [highlightBrand] is set; otherwise a plain [Text].
  Widget _bodyLine(String line, TextStyle baseStyle) {
    const brand = 'Fat7i';
    final idx = highlightBrand
        ? line.toLowerCase().indexOf(brand.toLowerCase())
        : -1;
    if (idx < 0) {
      return Text(line, textAlign: TextAlign.left, style: baseStyle);
    }

    final before = line.substring(0, idx);
    final match = line.substring(idx, idx + brand.length); // keep original case
    final after = line.substring(idx + brand.length);

    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        style: baseStyle,
        children: [
          if (before.isNotEmpty) TextSpan(text: before),
          TextSpan(
            text: match.substring(0, 6), // "Fat7i"
            style: const TextStyle(
              color: AppColors.tripOrange,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: match.substring(6), // "Trip"
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (after.isNotEmpty) TextSpan(text: after),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 260.w),
        child: Container(
          padding: REdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: const Color(0xCC1C1C1E),
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 8.r,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: REdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.tripOrange.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: FaIcon(icon, color: AppColors.tripOrange, size: 20.r),
              ),
              AppSpacing.md.horizontalSpace,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.left,
                      style: AppTextStyles.s14w700.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    for (final line in bodyLines) ...[
                      AppSpacing.xs.verticalSpace,
                      _bodyLine(
                        line,
                        AppTextStyles.s12w400.copyWith(
                          color: Colors.white.withValues(alpha: 0.75),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
