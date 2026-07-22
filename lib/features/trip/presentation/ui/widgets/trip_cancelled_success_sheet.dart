import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';

/// Action the rider picked on the cancelled-trip sheet. `null` (sheet dismissed
/// without a choice) means "just close".
enum CancelledSheetAction { bookAgain, changeTime }

/// Bottom sheet shown when a trip is cancelled. Offers two next steps — book a
/// fresh ride now, or book one with a chosen (later) departure time. The tone
/// adapts to who cancelled: a success confirmation for the rider's own cancel,
/// an apology otherwise (admin/driver).
class TripCancelledSuccessSheet extends StatelessWidget {
  const TripCancelledSuccessSheet({super.key, this.cancellation});

  final TripCancellationEntity? cancellation;

  /// Shows the cancellation sheet and resolves with the rider's chosen action.
  static Future<CancelledSheetAction?> show(
    BuildContext context, {
    TripCancellationEntity? cancellation,
  }) {
    return AppBottomSheet.show<CancelledSheetAction>(
      context,
      sheet: AppBottomSheet.basic(
        // Pushed on the root navigator, so it does not inherit the active-trip
        // accent from the subtree that opened it — apply it here (see
        // tripAccentTheme doc), same as CancelTripSheet.
        child: tripAccentTheme(
          context,
          child: TripCancelledSuccessSheet(cancellation: cancellation),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    // Only the rider cancelling their own trip gets the success tone; every
    // other actor (admin/driver) — or an unknown one — gets the apology.
    final isSelfCancel =
        cancellation?.actor.toLowerCase() == 'passenger';

    final title = isSelfCancel
        ? AppStrings.tripCancelledSuccess
        : AppStrings.noDriverCancelledTitle;
    final body = isSelfCancel
        ? AppStrings.tripCancelledSuccessDesc
        : AppStrings.tripCancelledByOperatorBody;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSpacing.xl.verticalSpace,
        Center(
          child:
              FaIcon(
                    isSelfCancel
                        ? FontAwesomeIcons.solidCircleCheck
                        : FontAwesomeIcons.circleXmark,
                    color: AppColors.tripOrange,
                    size: 72.r,
                  )
                  .animate()
                  .scale(
                    duration: AppDurations.slow * 1.5,
                    curve: Curves.easeOutBack,
                  )
                  .fadeIn(duration: AppDurations.normal),
        ),
        AppSpacing.xl.verticalSpace,
        Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.s20w700.copyWith(color: colors.onSurface),
            )
            .animate()
            .fadeIn(delay: AppDurations.fast, duration: AppDurations.normal)
            .slideY(begin: 0.1, end: 0.0),
        AppSpacing.sm.verticalSpace,
        Text(
              body,
              textAlign: TextAlign.center,
              style: AppTextStyles.s14w400.copyWith(
                color: colors.onSurface.withValues(alpha: 0.6),
              ),
            )
            .animate()
            .fadeIn(delay: AppDurations.normal, duration: AppDurations.normal)
            .slideY(begin: 0.1, end: 0.0),
        AppSpacing.xl.verticalSpace,
        AppButton.primaryGradient(
          onTap: () =>
              Navigator.of(context).pop(CancelledSheetAction.bookAgain),
          child: AppButtonChild.label(AppStrings.bookAgain),
        ),
        AppSpacing.md.verticalSpace,
        AppButton.outline(
          onTap: () =>
              Navigator.of(context).pop(CancelledSheetAction.changeTime),
          child: AppButtonChild.label(AppStrings.changeDepartureTime),
        ),
        AppSpacing.lg.verticalSpace,
      ],
    );
  }
}
