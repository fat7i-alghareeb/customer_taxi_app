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
    this.titleAccentWord,
  });

  final FaIconData icon;
  final String title;
  final List<String> bodyLines;

  /// Substring of [title] painted in the trip accent while the rest stays white.
  /// Comes from a localized key rather than "the first word" because the phrase to
  /// highlight differs per language ("Onderweg", "On the way", "في الطريق").
  final String? titleAccentWord;

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
          // "Onderweg" carries the accent; the rest of the headline and the
          // "Fijne rit!" line below it stay plain white.
          titleAccentWord: AppStrings.activeTripInProgressTitleAccent,
          bodyLines: [AppStrings.activeTripInProgressSubtitle],
          bodyColor: Colors.white,
        );
      // TRACKING DISABLED: en-route used to keep the plain live driver→pickup map.
      // With the car gone there is nothing to watch, so it blurs and gets a card
      // like every other status. The en-route sheet below is unchanged.
      case TripStatus.enRoute:
        return TripStatusBannerContent(
          icon: FontAwesomeIcons.carSide,
          image: Assets.images.tripCarImage,
          title: AppStrings.activeTripStepDriverOnWay,
          bodyLines: [AppStrings.activeTripStepDriverOnWaySub],
          indicator: TripStatusIndicatorMode.searching,
        );
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
    this.titleAccentWord,
    super.key,
  });

  final FaIconData icon;
  final String title;
  final List<String> bodyLines;

  /// Substring of [title] painted in the trip accent, the rest staying white.
  final String? titleAccentWord;

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

  /// Case-insensitively locates [word] in [text] and rebuilds it as spans, handing
  /// the matched slice to [buildMatch] (which may split it further) while the
  /// surrounding text keeps [baseStyle]. Returns a plain [Text] when there is no
  /// match, so a mistranslated accent word degrades to the unstyled line.
  static Widget _highlightWord(
    String text,
    String word,
    TextStyle baseStyle,
    List<InlineSpan> Function(String match) buildMatch,
  ) {
    final idx = word.isEmpty
        ? -1
        : text.toLowerCase().indexOf(word.toLowerCase());
    if (idx < 0) {
      return Text(text, textAlign: TextAlign.left, style: baseStyle);
    }

    final before = text.substring(0, idx);
    final match = text.substring(idx, idx + word.length); // keep original case
    final after = text.substring(idx + word.length);

    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        style: baseStyle,
        children: [
          if (before.isNotEmpty) TextSpan(text: before),
          ...buildMatch(match),
          if (after.isNotEmpty) TextSpan(text: after),
        ],
      ),
    );
  }

  /// Renders [title], colouring [titleAccentWord] in the trip accent when set.
  Widget _titleLine(TextStyle baseStyle) {
    if (titleAccentWord case final accent? when accent.isNotEmpty) {
      return _highlightWord(title, accent, baseStyle, (match) {
        return [
          TextSpan(
            text: match,
            style: const TextStyle(
              color: AppColors.tripOrange,
              fontWeight: FontWeight.w700,
            ),
          ),
        ];
      });
    }
    return Text(title, textAlign: TextAlign.left, style: baseStyle);
  }

  /// Renders [line], colouring the "Fat7i" brand word when
  /// [highlightBrand] is set; otherwise a plain [Text].
  Widget _bodyLine(String line, TextStyle baseStyle) {
    const brand = 'Fat7i';
    if (!highlightBrand) {
      return Text(line, textAlign: TextAlign.left, style: baseStyle);
    }

    return _highlightWord(line, brand, baseStyle, (match) {
      return [
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
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ];
    });
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
                    _titleLine(
                      AppTextStyles.s14w700.copyWith(color: Colors.white),
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
