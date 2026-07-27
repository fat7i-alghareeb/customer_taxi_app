import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_status.dart';
import 'package:customertaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_editable_details.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_sheet_actions.dart';

/// Confirmation sheet covering the `awaitingAdminAcceptance` → `accepted`
/// transition. Both statuses share the same layout (headline, booking time,
/// pickup / drop-off timeline, passengers, bags, chat, cancel); only the
/// headline differs — "Uw rit is **in afwachting**" while awaiting, "Uw rit is
/// **bevestigd**" once accepted — and cross-fades in place as the status flips.
/// The destination, passenger count and bag count stay editable within the
/// 1-hour edit window.
class TripConfirmationStatusSheet extends StatefulWidget {
  const TripConfirmationStatusSheet({
    required this.trip,
    required this.cancelStatus,
    required this.onCancelPressed,
    super.key,
  });

  final TripEntity trip;
  final BlocStatus<void> cancelStatus;
  final VoidCallback onCancelPressed;

  @override
  State<TripConfirmationStatusSheet> createState() =>
      _TripConfirmationStatusSheetState();
}

class _TripConfirmationStatusSheetState
    extends State<TripConfirmationStatusSheet> {
  TripEntity get trip => widget.trip;

  String _formatDateTime(DateTime dt) {
    return dt.formatDateTime(
      "d MMMM yyyy '•' HH:mm",
      locale: context.locale.languageCode,
    );
  }

  Future<void> _editScheduledTime() async {
    if (!trip.canEditSchedule) {
      showErrorOverlay(context, AppStrings.tripEditNotAllowed);
      return;
    }
    final initial = (trip.scheduledAtUtc ?? trip.createdAtUtc).toLocal();
    final picked = await _pickDateTime(initial);
    if (picked == null || !mounted) return;
    context.read<TripBloc>().add(
      TripEvent.scheduledTimeUpdateRequested(picked.toUtc()),
    );
  }

  Future<DateTime?> _pickDateTime(DateTime initial) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initial.isBefore(now) ? now : initial,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      builder: _pickerTheme,
    );
    if (date == null || !mounted) return null;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
      builder: _pickerTheme,
    );
    if (time == null || !mounted) return null;
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  Widget _pickerTheme(BuildContext context, Widget? child) => Theme(
    data: Theme.of(context).copyWith(
      colorScheme: ColorScheme.light(
        primary: context.primary,
        onPrimary: context.onPrimary,
        surface: context.surface,
        onSurface: context.onSurface,
      ),
    ),
    child: child!,
  );

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final isAccepted = trip.status == TripStatus.accepted;
    return BlocListener<TripBloc, TripState>(
      listenWhen: (prev, curr) => prev.tripEditStatus != curr.tripEditStatus,
      listener: (context, state) {
        final status = state.tripEditStatus;
        if (status.isFailed && status.errorMessage == 'tripEditNotAllowed') {
          showErrorOverlay(context, AppStrings.tripEditNotAllowed);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Headline: pending shows "Bedankt voor uw ritaanvraag" + reassurance
          // subtitle, accepted cross-fades to "Uw rit is bevestigd".
          AnimatedSwitcher(
            duration: AppDurations.slow,
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.25),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            ),
            child: _Headline(key: ValueKey(isAccepted), isAccepted: isAccepted),
          ),

          // Once accepted, remind the rider to board within 10 minutes.
          if (isAccepted) ...[
            AppSpacing.xs.verticalSpace,
            Text(
              AppStrings.tripConfirmedBoardingWarning,
              style: AppTextStyles.s12w400.copyWith(
                color: colors.onSurface.withValues(alpha: 0.7),
                height: 1.35,
              ),
            ),
          ],
          AppSpacing.sm.verticalSpace,

          // Booking / schedule time. Editable pencil only within 5 minutes of
          // booking — the same window as every other customer edit.
          if (trip.isScheduled && trip.scheduledAtUtc != null) ...[
            _InfoTimeRow(
              icon: FontAwesomeIcons.calendarDays,
              text:
                  '${AppStrings.tripInfoScheduledTrip}: '
                  '${_formatDateTime(trip.scheduledAtUtc!.toLocal())}',
              onEdit: trip.canEditSchedule ? _editScheduledTime : null,
            ),
            AppSpacing.xs.verticalSpace,
            _InfoTimeRow(
              icon: FontAwesomeIcons.solidClock,
              text: AppStrings.activeTripBookingRequestedAt.replaceAll(
                '{datetime}',
                _formatDateTime(trip.createdAtUtc.toLocal()),
              ),
            ),
          ] else
            _InfoTimeRow(
              icon: FontAwesomeIcons.solidClock,
              text: AppStrings.activeTripBookedOn.replaceAll(
                '{datetime}',
                _formatDateTime(trip.createdAtUtc.toLocal()),
              ),
              onEdit: trip.canEditSchedule ? _editScheduledTime : null,
            ),

          AppSpacing.sm.verticalSpace,

          // Address, passengers and bags — the same block reused on the en-route
          // sheet; editable while the status still allows repricing.
          TripEditableDetails(trip: trip),

          AppSpacing.sm.verticalSpace,
          TripSheetActions(
            showCancel: trip.status.canCancel,
            cancelIsLoading: widget.cancelStatus.isLoading,
            onCancelPressed: widget.onCancelPressed,
          ),
        ],
      ),
    );
  }
}

/// Pending shows "Bedankt voor uw ritaanvraag" (in [AppColors.tripOrange]) plus
/// a muted reassurance subtitle; once accepted it becomes "Uw rit is
/// **bevestigd**" (keyword in the primary colour).
class _Headline extends StatelessWidget {
  const _Headline({required this.isAccepted, super.key});

  final bool isAccepted;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    if (!isAccepted) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.activeTripRequestProcessing,
            style: AppTextStyles.s24w700.copyWith(
              color: AppColors.tripOrange,
            ),
          ),
          AppSpacing.xs.verticalSpace,
          Text(
            AppStrings.activeTripRequestProcessingSubtitle,
            style: AppTextStyles.s14w400.copyWith(
              color: colors.onSurface.withValues(alpha: 0.7),
              height: 1.35,
            ),
          ),
        ],
      );
    }

    return RichText(
      text: TextSpan(
        style: AppTextStyles.s24w700.copyWith(color: colors.onSurface),
        children: [
          TextSpan(text: '${AppStrings.activeTripRideIsPrefix} '),
          TextSpan(
            text: AppStrings.activeTripConfirmedKeyword,
            style: TextStyle(color: colors.primary),
          ),
        ],
      ),
    );
  }
}

/// A muted icon + text row (booking / scheduled time) with an optional edit
/// pencil shown on the right while the time is still editable.
class _InfoTimeRow extends StatelessWidget {
  const _InfoTimeRow({required this.icon, required this.text, this.onEdit});

  final FaIconData icon;
  final String text;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return Row(
      children: [
        FaIcon(
          icon,
          color: colors.onSurface.withValues(alpha: 0.45),
          size: 13.r,
        ),
        AppSpacing.xs.horizontalSpace,
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.s12w400.copyWith(
              color: colors.onSurface.withValues(alpha: 0.55),
            ),
          ),
        ),
        if (onEdit != null)
          SizedBox(
            width: 32.r,
            height: 32.r,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: onEdit,
              icon: FaIcon(
                FontAwesomeIcons.penToSquare,
                size: 14.r,
                color: colors.primary,
              ),
            ),
          ),
      ],
    );
  }
}
