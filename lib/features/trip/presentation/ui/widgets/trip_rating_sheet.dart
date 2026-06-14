import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/facade/trip_facade.dart';
import 'package:url_launcher/url_launcher.dart';

/// Public Google review link for Fat7i / Taxi Service. Offered to riders
/// who give a high (4-5 star) rating.
const String _googleReviewUrl = 'https://g.page/r/CVnGS4OWfBvSEBM/review';

/// High vs low rating threshold. 4-5 stars => offer Google review,
/// 1-3 stars => thank-you only (no redirect).
const int _highRatingThreshold = 4;

/// Shows the post-trip rating sheet. Returns once the rider dismisses it.
/// Pass [initialStars] (the existing rating) to pre-select the stars when the
/// rider is editing an earlier rating.
Future<void> showTripRatingSheet(
  BuildContext context, {
  required String tripId,
  int initialStars = 0,
  FutureOr<void> Function()? onClosed,
}) async {
  try {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          _TripRatingSheet(tripId: tripId, initialStars: initialStars),
    );
  } finally {
    await onClosed?.call();
  }
}

class _TripRatingSheet extends StatefulWidget {
  const _TripRatingSheet({required this.tripId, this.initialStars = 0});

  final String tripId;
  final int initialStars;

  @override
  State<_TripRatingSheet> createState() => _TripRatingSheetState();
}

class _TripRatingSheetState extends State<_TripRatingSheet> {
  late int _selected = widget.initialStars.clamp(0, 5);
  bool _submitting = false;
  bool _submitted = false;

  Future<void> _submit() async {
    if (_selected < 1 || _submitting) return;
    setState(() => _submitting = true);

    final result = await getIt<TripFacade>().rateTrip(
      tripId: widget.tripId,
      stars: _selected,
    );

    if (!mounted) return;
    setState(() {
      _submitting = false;
      _submitted = true;
    });

    result.whenOrNull(
      failure: (msg) => printR('[TripRatingSheet] rateTrip failed: $msg'),
    );
  }

  Future<void> _openGoogleReview() async {
    try {
      await launchUrl(
        Uri.parse(_googleReviewUrl),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      printR('[TripRatingSheet] could not open Google review: $e');
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Container(
      padding: REdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.xl,
      ).copyWith(bottom: AppSpacing.xl.h + bottomInset),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadii.xl.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: colors.onSurface.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppRadii.sm.r),
              ),
            ),
          ),
          AppSpacing.lg.verticalSpace,
          if (_submitted)
            ..._buildResult(context)
          else
            ..._buildSelector(context),
        ],
      ),
    );
  }

  List<Widget> _buildSelector(BuildContext context) {
    final colors = context.colorScheme;
    return [
      Center(
        child: Text(
          AppStrings.ratingHeaderTitle,
          style: AppTextStyles.s20w700.copyWith(color: colors.onSurface),
          textAlign: TextAlign.center,
        ),
      ),
      AppSpacing.sm.verticalSpace,
      Center(
        child: Text(
          AppStrings.ratingSubtitle,
          style: AppTextStyles.s14w400.copyWith(
            color: colors.onSurface.withValues(alpha: 0.6),
          ),
          textAlign: TextAlign.center,
        ),
      ),
      AppSpacing.xl.verticalSpace,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (i) {
          final star = i + 1;
          final isFilled = star <= _selected;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => setState(() => _selected = star),
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: AppSpacing.xs),
              child: FaIcon(
                isFilled ? FontAwesomeIcons.solidStar : FontAwesomeIcons.star,
                size: 36.r,
                color: isFilled
                    ? AppColors.warning
                    : colors.onSurface.withValues(alpha: 0.25),
              ),
            ),
          );
        }),
      ),
      AppSpacing.xl.verticalSpace,
      AppButton.primaryGradient(
        isLoading: _submitting,
        onTap: _selected >= 1 ? _submit : null,
        child: AppButtonChild.label(AppStrings.ratingSubmit),
      ),
    ];
  }

  List<Widget> _buildResult(BuildContext context) {
    final colors = context.colorScheme;
    final isHigh = _selected >= _highRatingThreshold;

    if (!isHigh) {
      return [
        _iconBadge(context, FontAwesomeIcons.check),
        AppSpacing.lg.verticalSpace,
        Center(
          child: Text(
            AppStrings.ratingThanksHeading,
            style: AppTextStyles.s20w700.copyWith(color: colors.onSurface),
            textAlign: TextAlign.center,
          ),
        ),
        AppSpacing.sm.verticalSpace,
        Center(
          child: Text(
            AppStrings.ratingLowThanks,
            style: AppTextStyles.s14w400.copyWith(
              color: colors.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        AppSpacing.lg.verticalSpace,
        // Car illustration stand-in (a branded PNG can replace this later).
        Center(
          child: FaIcon(
            FontAwesomeIcons.taxi,
            size: 56.r,
            color: colors.primary.withValues(alpha: 0.18),
          ),
        ),
        AppSpacing.xl.verticalSpace,
        AppButton.primaryGradient(
          onTap: () => Navigator.of(context).pop(),
          child: AppButtonChild.label(AppStrings.done),
        ),
      ];
    }

    return [
      _iconBadge(context, FontAwesomeIcons.solidHeart),
      AppSpacing.lg.verticalSpace,
      Center(
        child: Text(
          AppStrings.ratingHighTitle,
          style: AppTextStyles.s20w700.copyWith(color: colors.primary),
          textAlign: TextAlign.center,
        ),
      ),
      AppSpacing.md.verticalSpace,
      Center(
        child: Text(
          AppStrings.ratingHighPrompt,
          style: AppTextStyles.s14w400.copyWith(
            color: colors.onSurface.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ),
      AppSpacing.xl.verticalSpace,
      AppButton.primaryGradient(
        onTap: _openGoogleReview,
        child: AppButtonChild.label(AppStrings.ratingShareYes),
      ),
      AppSpacing.md.verticalSpace,
      AppButton.outline(
        onTap: () => Navigator.of(context).pop(),
        child: AppButtonChild.label(AppStrings.ratingShareNo),
      ),
    ];
  }

  /// A circular, brand-tinted badge holding [icon] — used on the result screens.
  Widget _iconBadge(BuildContext context, FaIconData icon) {
    final colors = context.colorScheme;
    return Center(
      child: Container(
        width: 76.r,
        height: 76.r,
        decoration: BoxDecoration(
          color: colors.primary.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: FaIcon(icon, size: 34.r, color: colors.primary),
        ),
      ),
    );
  }
}
