import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';

/// Result of the cancel sheet. Returned only when the rider confirms the
/// cancellation; [note] is the (optional) reason, or null when none was picked.
class CancelTripResult {
  const CancelTripResult(this.note);

  final String? note;
}

/// One selectable cancellation reason. [canonical] is a stable English string
/// stored as the cancellation note (admin-readable, language-independent);
/// [label] is the localized text shown to the rider.
class _CancelReason {
  const _CancelReason(this.key, this.canonical, this.label, this.icon);

  final String key;
  final String canonical;
  final String label;
  final FaIconData icon;
}

/// Lightweight cancel sheet shown whenever the rider cancels a trip.
/// Displays a contextual banner showing the actual refund outcome for the
/// current trip state before asking the rider to confirm.
class CancelTripSheet extends StatefulWidget {
  const CancelTripSheet({super.key, required this.trip});

  final TripEntity trip;

  static Future<CancelTripResult?> show(BuildContext context, TripEntity trip) {
    return AppBottomSheet.show<CancelTripResult>(
      context,
      sheet: AppBottomSheet.basic(
        title: AppStrings.cancelSheetTitle,
        // Pushed on the root navigator, so it does not inherit the active-trip
        // accent from the subtree that opened it — apply it here.
        child: tripAccentTheme(context, child: CancelTripSheet(trip: trip)),
      ),
    );
  }

  @override
  State<CancelTripSheet> createState() => _CancelTripSheetState();
}

class _CancelTripSheetState extends State<CancelTripSheet> {
  static const String _otherKey = 'other';

  final TextEditingController _otherController = TextEditingController();
  String? _selectedKey;

  TripEntity get _trip => widget.trip;

  List<_CancelReason> _reasons() => [
    _CancelReason(
      'driverTooLong',
      'Driver too far or taking too long',
      AppStrings.cancelReasonDriverTooLong,
      FontAwesomeIcons.clock,
    ),
    _CancelReason(
      'bookedByMistake',
      'Booked by mistake',
      AppStrings.cancelReasonBookedByMistake,
      FontAwesomeIcons.penToSquare,
    ),
    _CancelReason(
      'plansChanged',
      'Plans changed',
      AppStrings.cancelReasonPlansChanged,
      FontAwesomeIcons.arrowsRotate,
    ),
    _CancelReason(
      'foundAnother',
      'Found another ride',
      AppStrings.cancelReasonFoundAnother,
      FontAwesomeIcons.carSide,
    ),
    _CancelReason(
      _otherKey,
      'Other',
      AppStrings.cancelReasonOther,
      FontAwesomeIcons.ellipsis,
    ),
  ];

  @override
  void dispose() {
    _otherController.dispose();
    super.dispose();
  }

  void _confirm() {
    String? note;
    if (_selectedKey == _otherKey) {
      final typed = _otherController.text.trim();
      note = typed.isEmpty ? null : typed;
    } else if (_selectedKey != null) {
      note = _reasons().firstWhere((r) => r.key == _selectedKey).canonical;
    }
    Navigator.pop(context, CancelTripResult(note));
  }

  /// Returns true if the passenger is still inside the free cancellation window.
  /// Mirrors CancellationPolicy.IsWithinFreeWindow on the backend (inclusive: now <= createdAt + 5 min).
  static bool _isWithinFreeWindow(TripEntity trip) {
    final now = DateTime.now().toUtc();
    final booking = trip.createdAtUtc.toUtc();
    return !now.isAfter(booking.add(const Duration(minutes: 5)));
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _RefundBanner(trip: _trip),
        AppSpacing.lg.verticalSpace,
        Text(
          AppStrings.cancelSheetReasonLabel,
          style: AppTextStyles.s16w700.copyWith(color: colors.onSurface),
        ),
        AppSpacing.md.verticalSpace,
        ..._reasons().map(
          (r) => Padding(
            padding: REdgeInsets.only(bottom: AppSpacing.sm),
            child: _ReasonTile(
              label: r.label,
              icon: r.icon,
              selected: _selectedKey == r.key,
              onTap: () => setState(() => _selectedKey = r.key),
            ),
          ),
        ),
        if (_selectedKey == _otherKey) ...[
          AppSpacing.xs.verticalSpace,
          TextField(
            controller: _otherController,
            minLines: 2,
            maxLines: 4,
            maxLength: 500,
            decoration: InputDecoration(
              hintText: AppStrings.cancelReasonOtherHint,
              // The character counter is chrome the rider does not need; the
              // limit still applies.
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.md.r),
              ),
            ),
          ),
        ],
        AppSpacing.md.verticalSpace,
        // Static policy note (free window + arrived fee + after-window rule),
        // kept as a quiet footnote so the reason cards stay the focus.
        Text(
          AppStrings.cancelSheetRefundNote,
          style: AppTextStyles.s12w400.copyWith(
            color: colors.onSurface.withValues(alpha: 0.55),
          ),
        ),
        AppSpacing.lg.verticalSpace,
        Row(
          children: [
            Expanded(
              child: AppButton.outline(
                onTap: () => Navigator.pop(context),
                child: AppButtonChild.label(AppStrings.cancelKeep),
              ),
            ),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: AppButton.error(
                onTap: _confirm,
                child: AppButtonChild.label(AppStrings.cancelConfirm),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Contextual banner showing the actual refund outcome for the current trip state.
class _RefundBanner extends StatelessWidget {
  const _RefundBanner({required this.trip});

  final TripEntity trip;

  @override
  Widget build(BuildContext context) {
    final isWithinWindow = _CancelTripSheetState._isWithinFreeWindow(trip);

    if (isWithinWindow) {
      return _BannerTile(
        icon: FontAwesomeIcons.circleCheck,
        color: const Color(0xFF2E7D32),
        text: AppStrings.cancelBannerFreeWindow,
      );
    } else {
      return _BannerTile(
        icon: FontAwesomeIcons.triangleExclamation,
        color: const Color(0xFFE65100),
        text: AppStrings.cancelBannerAfterWindow,
      );
    }
  }
}

/// Compact one-line pill carrying the refund outcome. Deliberately slimmer than
/// the reason cards below it: it reports state, it is not a choice.
class _BannerTile extends StatelessWidget {
  const _BannerTile({
    required this.icon,
    required this.color,
    required this.text,
  });

  final FaIconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadii.md.r),
      ),
      child: Row(
        children: [
          Container(
            padding: REdgeInsets.all(AppSpacing.xs),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: FaIcon(icon, size: 12.r, color: color),
          ),
          AppSpacing.sm.horizontalSpace,
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.s12w700.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

/// Full-width selectable reason card. Selection is carried by the fill, the
/// border and a trailing check — not by a radio glyph alone, which read as an
/// unstyled form on the old sheet.
class _ReasonTile extends StatelessWidget {
  const _ReasonTile({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final FaIconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.md.r),
        child: Container(
          padding: REdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: selected
                ? colors.primary.withValues(alpha: 0.10)
                : colors.onSurface.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(AppRadii.md.r),
            border: Border.all(
              color: selected
                  ? colors.primary
                  : colors.onSurface.withValues(alpha: 0.10),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: REdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
                child: FaIcon(icon, size: 14.r, color: colors.primary),
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Text(
                  label,
                  style:
                      (selected ? AppTextStyles.s14w600 : AppTextStyles.s14w500)
                          .copyWith(
                            color: selected ? colors.primary : colors.onSurface,
                          ),
                ),
              ),
              if (selected) ...[
                AppSpacing.sm.horizontalSpace,
                FaIcon(
                  FontAwesomeIcons.circleCheck,
                  size: 16.r,
                  color: colors.primary,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
