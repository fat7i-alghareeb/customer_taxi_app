import 'dart:ui' as ui;

import 'package:customertaxi/common/imports/imports.dart';

/// Every size the overlay derives from the height it was given.
///
/// The overlay never scrolls, so each element has to be a function of the
/// available height rather than a fixed constant. Keeping the numbers in one
/// place means the compression behaviour can be read at a glance instead of
/// being reverse-engineered from five widgets.
class _OverlayMetrics {
  const _OverlayMetrics({
    required this.badge,
    required this.gapXs,
    required this.gapSm,
    required this.gapMd,
    required this.buttonHeight,
    required this.cardRowPadding,
    required this.roundIcon,
    required this.carMaxHeight,
  });

  factory _OverlayMetrics.forHeight(double h) {
    return _OverlayMetrics(
      badge: (h * 0.115).clamp(72.0, 104.0),
      gapXs: (h * 0.008).clamp(2.0, 8.0),
      gapSm: (h * 0.014).clamp(4.0, 14.0),
      gapMd: (h * 0.022).clamp(8.0, 20.0),
      buttonHeight: (h * 0.072).clamp(46.0, 54.0),
      cardRowPadding: (h * 0.012).clamp(6.0, 12.0),
      roundIcon: (h * 0.05).clamp(32.0, 40.0),
      // The car is deliberately capped at the size it already renders at — it
      // absorbs leftover space downward, never upward.
      carMaxHeight: 150.0,
    );
  }

  final double badge;
  final double gapXs;
  final double gapSm;
  final double gapMd;
  final double buttonHeight;
  final double cardRowPadding;
  final double roundIcon;
  final double carMaxHeight;
}

/// Full-screen confirmation shown over the root map after a *scheduled* booking
/// succeeds. Immediate bookings keep the toast + live-trip flow instead.
///
/// It sits above the map and the booking sheet, blurring both with the same
/// treatment the active-trip status banner uses, and only the "Go to Home"
/// button dismisses it (back button blocked) so the three promised
/// notifications are always read.
///
/// The content lays out strictly inside the height it is given and never
/// scrolls: the car image is the single flexible element, absorbing surplus on
/// tall screens and giving way first on short ones, while everything else is
/// sized from the available height (see [_OverlayMetrics]).
class ReservationConfirmedOverlay extends StatelessWidget {
  const ReservationConfirmedOverlay({required this.onDismiss, super.key});

  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    // The whole overlay runs on the orange accent, so `AppButton.primary` and
    // every `context.primary` below pick it up without per-widget overrides.
    return tripAccentTheme(
      context,
      child: PopScope(
        canPop: false,
        child: MediaQuery(
          // Without a scroll view, an unbounded system font scale (up to 2.0 on
          // both platforms) would overflow the layout no matter how flexible
          // the artwork is. 1.2 still honours a font preference meaningfully.
          // Scoped to this subtree — the rest of the app keeps full scaling.
          data: MediaQuery.of(context).copyWith(
            textScaler: MediaQuery.textScalerOf(
              context,
            ).clamp(maxScaleFactor: 1.2),
          ),
          child: ClipRect(
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Same recipe as the active-trip status banner: blur the whole
                // screen with no clip, then a scrim so white text reads over
                // both the map and the sheet.
                BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                  child: Container(color: Colors.black.withValues(alpha: 0.55)),
                ),
                SafeArea(
                  child: Padding(
                    padding: REdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                      vertical: AppSpacing.md,
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final m = _OverlayMetrics.forHeight(
                          constraints.maxHeight,
                        );
                        return _Content(metrics: m, onDismiss: onDismiss);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(
      begin: 0.06,
      end: 0,
      curve: Curves.easeOutCubic,
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.metrics, required this.onDismiss});

  final _OverlayMetrics metrics;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Column(
      // Centred rather than stretched vertically: when the car image hits its
      // ceiling on a tall screen the residual surplus is split above and below
      // instead of being stranded at the bottom.
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SuccessBadge(size: metrics.badge),
        SizedBox(height: metrics.gapSm),
        _TwoToneText(
          template: AppStrings.reservationThanksTitle,
          placeholder: '{highlight}',
          highlight: AppStrings.reservationThanksHighlight,
          style: AppTextStyles.s28w700.copyWith(
            color: Colors.white,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: metrics.gapXs),
        Text(
          AppStrings.reservationConfirmedSubtitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.s14w400.copyWith(
            color: Colors.white.withValues(alpha: 0.75),
          ),
        ),
        SizedBox(height: metrics.gapMd),
        _NotificationsCard(metrics: metrics),
        // The single flexible element. Loose fit, so it shrinks below its
        // allocation on tight screens and disappears entirely when there is
        // nothing left to give.
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: metrics.gapXs),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: metrics.carMaxHeight.h),
              child: AppImageViewer.asset(
                Assets.images.tripCarImage.path,
                fit: BoxFit.contain,
                backgroundColor: Colors.transparent,
                borderRadius: 0,
                loading: AppImageViewerLoading.none,
              ),
            ),
          ),
        ),
        SizedBox(height: metrics.gapSm),
        AppButton.primary(
          layout: AppButtonLayout(height: metrics.buttonHeight),
          child: AppButtonChild.labelIcon(
            label: AppStrings.reservationGoHome,
            icon: IconSource.icon(Icons.home_outlined),
            iconSize: 20,
            textStyle: AppTextStyles.s16w700,
          ),
          onTap: onDismiss,
        ),
        SizedBox(height: metrics.gapSm),
        const _SecurityNote(),
      ],
    );
  }
}

/// The orange check badge with its halo ring and sparkles.
///
/// Every inner dimension is a fraction of [size], and the whole thing is fitted
/// so the `Stack` can never overflow its box when the layout squeezes it.
class _SuccessBadge extends StatelessWidget {
  const _SuccessBadge({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.h,
      child: FittedBox(
        child: SizedBox(
          width: 104,
          height: 104,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.tripOrange.withValues(alpha: 0.45),
                    width: 1.5,
                  ),
                ),
              ),
              Container(
                width: 68,
                height: 68,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.tripOrange,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 38,
                ),
              ),
              // Decorative sparkles, mirroring the four corners of the mockup.
              Positioned(top: 10, left: 12, child: _sparkle(11)),
              Positioned(top: 2, right: 18, child: _sparkle(8)),
              Positioned(bottom: 16, left: 6, child: _sparkle(7)),
              Positioned(bottom: 10, right: 8, child: _sparkle(10)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sparkle(double size) => Transform.rotate(
    angle: 0.785398, // 45°, turns the plus into the mockup's diamond
    child: Icon(Icons.add, color: AppColors.tripOrange, size: size),
  );
}

/// The dark card listing the three notifications the passenger will receive.
class _NotificationsCard extends StatelessWidget {
  const _NotificationsCard({required this.metrics});

  final _OverlayMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final divider = Container(
      height: 1,
      color: Colors.white.withValues(alpha: 0.08),
    );

    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: const Color(0xCC1C1C1E),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: metrics.cardRowPadding.h),
            child: Row(
              children: [
                _RoundIcon(
                  icon: Icons.notifications_none_rounded,
                  filled: false,
                  size: metrics.roundIcon,
                ),
                AppSpacing.md.horizontalSpace,
                Expanded(
                  child: _TwoToneText(
                    template: AppStrings.reservationNotificationsIntro,
                    placeholder: '{count}',
                    highlight: AppStrings.reservationNotificationsCount,
                    style: AppTextStyles.s14w500.copyWith(
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          divider,
          _NotificationRow(
            icon: Icons.schedule_rounded,
            title: AppStrings.reservationReminder30Title,
            body: AppStrings.reservationReminder30Body,
            metrics: metrics,
          ),
          divider,
          _NotificationRow(
            icon: Icons.schedule_rounded,
            title: AppStrings.reservationReminder15Title,
            body: AppStrings.reservationReminder15Body,
            metrics: metrics,
          ),
          divider,
          _NotificationRow(
            icon: Icons.local_taxi_rounded,
            title: AppStrings.reservationArrivalTitle,
            body: AppStrings.reservationArrivalBody,
            metrics: metrics,
          ),
        ],
      ),
    );
  }
}

class _NotificationRow extends StatelessWidget {
  const _NotificationRow({
    required this.icon,
    required this.title,
    required this.body,
    required this.metrics,
  });

  final IconData icon;
  final String title;
  final String body;
  final _OverlayMetrics metrics;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: metrics.cardRowPadding.h),
      child: Row(
        children: [
          _RoundIcon(icon: icon, filled: true, size: metrics.roundIcon),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppTextStyles.s14w700.copyWith(color: Colors.white),
                ),
                SizedBox(height: metrics.gapXs),
                Text(
                  body,
                  style: AppTextStyles.s12w400.copyWith(
                    color: Colors.white.withValues(alpha: 0.75),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.sm.horizontalSpace,
          Container(
            width: 8.r,
            height: 8.r,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.tripOrange,
            ),
          ),
        ],
      ),
    );
  }
}

/// Orange circular icon chip — filled for the notification rows, tinted for the
/// card header (matching `TripStatusOverlayCard`'s leading chip).
class _RoundIcon extends StatelessWidget {
  const _RoundIcon({
    required this.icon,
    required this.filled,
    required this.size,
  });

  final IconData icon;
  final bool filled;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled
            ? AppColors.tripOrange
            : AppColors.tripOrange.withValues(alpha: 0.15),
      ),
      child: Icon(
        icon,
        size: (size * 0.5).r,
        color: filled ? Colors.white : AppColors.tripOrange,
      ),
    );
  }
}

class _SecurityNote extends StatelessWidget {
  const _SecurityNote();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 34.r,
          height: 34.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.tripOrange.withValues(alpha: 0.15),
          ),
          child: Icon(
            Icons.shield_outlined,
            size: 17.r,
            color: AppColors.tripOrange,
          ),
        ),
        AppSpacing.sm.horizontalSpace,
        Flexible(
          child: _TwoToneText(
            template: AppStrings.reservationSecurityNote,
            placeholder: '{brand}',
            highlight: AppStrings.reservationBrandName,
            // "customertaxi" is split-coloured like the rest of the trip UI:
            // "customer" orange, "taxi" white.
            splitBrandAt: 8,
            style: AppTextStyles.s12w400.copyWith(
              color: Colors.white.withValues(alpha: 0.75),
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}

/// Renders [template] with [placeholder] replaced by [highlight] in the trip
/// accent colour.
///
/// The highlighted fragment is its own translation key rather than a hardcoded
/// prefix/suffix split, because the emphasised word does not sit in the same
/// position in every language (Arabic and German move it).
class _TwoToneText extends StatelessWidget {
  const _TwoToneText({
    required this.template,
    required this.placeholder,
    required this.highlight,
    required this.style,
    this.textAlign,
    this.splitBrandAt,
  });

  final String template;
  final String placeholder;
  final String highlight;
  final TextStyle style;
  final TextAlign? textAlign;

  /// When set, the highlight itself is two-toned at this character index —
  /// the leading part orange, the rest white (the "customertaxi" wordmark).
  final int? splitBrandAt;

  @override
  Widget build(BuildContext context) {
    final index = template.indexOf(placeholder);
    if (index < 0) {
      // Defensive: a translation that dropped the placeholder still renders.
      return Text(template, textAlign: textAlign, style: style);
    }

    final before = template.substring(0, index);
    final after = template.substring(index + placeholder.length);
    final accent = style.copyWith(
      color: AppColors.tripOrange,
      fontWeight: FontWeight.w700,
    );

    return RichText(
      textAlign: textAlign ?? TextAlign.start,
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
      text: TextSpan(
        style: style,
        children: [
          if (before.isNotEmpty) TextSpan(text: before),
          ..._highlightSpans(accent),
          if (after.isNotEmpty) TextSpan(text: after),
        ],
      ),
    );
  }

  List<TextSpan> _highlightSpans(TextStyle accent) {
    final splitAt = splitBrandAt;
    if (splitAt == null || splitAt >= highlight.length) {
      return [TextSpan(text: highlight, style: accent)];
    }
    return [
      TextSpan(text: highlight.substring(0, splitAt), style: accent),
      TextSpan(
        text: highlight.substring(splitAt),
        style: accent.copyWith(color: Colors.white),
      ),
    ];
  }
}
