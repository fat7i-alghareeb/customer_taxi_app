import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_status.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_status_indicator.dart';

/// Icon + text content for the status banner shown above the map. `null` from
/// [forStatus] means the given status keeps the plain map with no banner.
class TripStatusBannerContent {
  const TripStatusBannerContent({
    required this.icon,
    required this.title,
    required this.bodyLines,
    this.image,
    this.bodyColor,
    this.indicator,
  });

  final FaIconData icon;
  final String title;
  final List<String> bodyLines;

  /// When set, the card renders this illustration in place of [icon] — used to
  /// show the branded car image for the ride/trip statuses.
  final AssetGenImage? image;

  /// Overrides the muted white body colour. Set for the in-progress banner so
  /// "Fijne rit!" carries the trip accent instead of reading as fine print.
  final Color? bodyColor;

  /// Ring drawn around the leading chip. Null for statuses where the chip is
  /// just an illustration and there is nothing in flight.
  final TripStatusIndicatorMode? indicator;

  static TripStatusBannerContent? forStatus(TripStatus status) {
    switch (status) {
      case TripStatus.awaitingAdminAcceptance:
        // Kept short and distinct from the sheet's own headline/subtitle so the
        // floating card doesn't echo it (and stays clear of the status bar).
        return TripStatusBannerContent(
          icon: FontAwesomeIcons.carSide,
          image: Assets.images.tripCarImage,
          title: AppStrings.activeTripSearchingDriverTitle,
          bodyLines: [AppStrings.activeTripSearchingDriverBody],
          indicator: TripStatusIndicatorMode.searching,
        );
      case TripStatus.accepted:
        return TripStatusBannerContent(
          icon: FontAwesomeIcons.carSide,
          image: Assets.images.tripCarImage,
          title: AppStrings.activeTripDriverAssignedTitle,
          bodyLines: [AppStrings.activeTripComfortableTripSoon],
          // The search ring closes into a tick — same object, resolved.
          indicator: TripStatusIndicatorMode.done,
        );
      case TripStatus.arrived:
        return TripStatusBannerContent(
          icon: FontAwesomeIcons.carSide,
          image: Assets.images.tripCarImage,
          title: AppStrings.activeTripDriverArrivedTitle,
          bodyLines: [AppStrings.activeTripDriverWaitingAtPickup],
        );
      case TripStatus.inProgress:
        return TripStatusBannerContent(
          icon: FontAwesomeIcons.route,
          image: Assets.images.tripCarImage,
          title: AppStrings.activeTripInProgressTitle,
          bodyLines: [AppStrings.activeTripInProgressSubtitle],
          bodyColor: AppColors.tripOrange,
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
    this.image,
    this.bodyColor,
    this.indicator,
    this.highlightBrand = false,
    super.key,
  });

  final FaIconData icon;
  final String title;
  final List<String> bodyLines;

  /// Optional illustration shown in the leading chip instead of [icon].
  final AssetGenImage? image;

  /// Overrides the muted white body colour.
  final Color? bodyColor;

  /// Optional progress ring drawn around the leading chip.
  final TripStatusIndicatorMode? indicator;

  /// When true, the "Fat7i" brand word inside any body line is split-
  /// coloured — "Fat7i" branding (legacy color-split comment).
  final bool highlightBrand;

  /// The circular leading slot: the illustration (or [icon]) on the tinted chip,
  /// wrapped in the status ring when [indicator] is set. The ring is drawn
  /// outside the chip so the artwork keeps its full size in both states.
  Widget _leadingChip() {
    final chip = Container(
      padding: REdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.tripOrange.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: image != null
          ? image!.image(width: 20.r, height: 20.r, fit: BoxFit.contain)
          : FaIcon(icon, color: AppColors.tripOrange, size: 20.r),
    );

    if (indicator case final mode?) {
      return TripStatusIndicator(mode: mode, size: 46.r, child: chip);
    }
    return chip;
  }

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
              _leadingChip(),
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
                          color:
                              bodyColor ??
                              Colors.white.withValues(alpha: 0.75),
                          fontWeight: bodyColor != null
                              ? FontWeight.w600
                              : null,
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
