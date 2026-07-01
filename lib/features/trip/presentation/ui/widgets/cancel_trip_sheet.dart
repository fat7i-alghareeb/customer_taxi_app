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
  const _CancelReason(this.key, this.canonical, this.label);

  final String key;
  final String canonical;
  final String label;
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
        child: CancelTripSheet(trip: trip),
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
    ),
    _CancelReason(
      'bookedByMistake',
      'Booked by mistake',
      AppStrings.cancelReasonBookedByMistake,
    ),
    _CancelReason(
      'plansChanged',
      'Plans changed',
      AppStrings.cancelReasonPlansChanged,
    ),
    _CancelReason(
      'foundAnother',
      'Found another ride',
      AppStrings.cancelReasonFoundAnother,
    ),
    _CancelReason(_otherKey, 'Other', AppStrings.cancelReasonOther),
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
        AppSpacing.md.verticalSpace,
        // Static policy note (free window + arrived fee + after-window rule).
        Container(
          padding: REdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(AppRadii.md.r),
          ),
          child: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.circleInfo,
                size: 16.r,
                color: colors.primary,
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Text(
                  AppStrings.cancelSheetRefundNote,
                  style: AppTextStyles.s14w400.copyWith(color: colors.onSurface),
                ),
              ),
            ],
          ),
        ),
        AppSpacing.lg.verticalSpace,
        Text(
          AppStrings.cancelSheetReasonLabel,
          style: AppTextStyles.s14w600.copyWith(color: colors.onSurface),
        ),
        AppSpacing.sm.verticalSpace,
        ..._reasons().map(
          (r) => _ReasonTile(
            label: r.label,
            selected: _selectedKey == r.key,
            onTap: () => setState(() => _selectedKey = r.key),
          ),
        ),
        if (_selectedKey == _otherKey) ...[
          AppSpacing.sm.verticalSpace,
          TextField(
            controller: _otherController,
            minLines: 2,
            maxLines: 4,
            maxLength: 500,
            decoration: InputDecoration(
              hintText: AppStrings.cancelReasonOtherHint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.md.r),
              ),
            ),
          ),
        ],
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
      const color = Color(0xFF2E7D32);
      return _BannerTile(
        icon: FaIcon(FontAwesomeIcons.circleCheck, size: 16.r, color: color),
        color: color,
        text: AppStrings.cancelBannerFreeWindow,
      );
    } else {
      const color = Color(0xFFE65100);
      return _BannerTile(
        icon: FaIcon(FontAwesomeIcons.triangleExclamation, size: 16.r, color: color),
        color: color,
        text: AppStrings.cancelBannerAfterWindow,
      );
    }
  }
}

class _BannerTile extends StatelessWidget {
  const _BannerTile({
    required this.icon,
    required this.color,
    required this.text,
  });

  final Widget icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadii.md.r),
        border: Border.all(color: color.withValues(alpha: 0.30)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: REdgeInsets.only(top: 2),
            child: icon,
          ),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.s14w500.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReasonTile extends StatelessWidget {
  const _ReasonTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.sm.r),
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: 20.r,
              color: selected
                  ? colors.primary
                  : colors.onSurface.withValues(alpha: 0.4),
            ),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.s14w400.copyWith(color: colors.onSurface),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
