import 'package:customertaxi/common/imports/imports.dart';

/// Bottom sheet showing a premium success message when a trip is successfully cancelled.
/// Auto-dismisses after 2.5 seconds or can be manually dismissed via the "Done" button.
class TripCancelledSuccessSheet extends StatefulWidget {
  const TripCancelledSuccessSheet({super.key});

  /// Shows the success bottom sheet.
  static Future<void> show(BuildContext context) {
    return AppBottomSheet.show<void>(
      context,
      sheet: AppBottomSheet.basic(
        child: const TripCancelledSuccessSheet(),
      ),
    );
  }

  @override
  State<TripCancelledSuccessSheet> createState() =>
      _TripCancelledSuccessSheetState();
}

class _TripCancelledSuccessSheetState extends State<TripCancelledSuccessSheet> {
  Timer? _autoCloseTimer;

  @override
  void initState() {
    super.initState();
    _autoCloseTimer = Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _autoCloseTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSpacing.xl.verticalSpace,
        Center(
          child: FaIcon(
            FontAwesomeIcons.solidCircleCheck,
            color: AppColors.success,
            size: 72.r,
          )
              .animate()
              .scale(
                duration: AppDurations.slow * 1.5,
                curve: Curves.easeOutBack,
              )
              .fadeIn(
                duration: AppDurations.normal,
              ),
        ),
        AppSpacing.xl.verticalSpace,
        Text(
          AppStrings.tripCancelledSuccess,
          textAlign: TextAlign.center,
          style: AppTextStyles.s20w700.copyWith(
            color: colors.onSurface,
          ),
        )
            .animate()
            .fadeIn(
              delay: AppDurations.fast,
              duration: AppDurations.normal,
            )
            .slideY(
              begin: 0.1,
              end: 0.0,
            ),
        AppSpacing.sm.verticalSpace,
        Text(
          AppStrings.tripCancelledSuccessDesc,
          textAlign: TextAlign.center,
          style: AppTextStyles.s14w400.copyWith(
            color: colors.onSurface.withValues(alpha: 0.6),
          ),
        )
            .animate()
            .fadeIn(
              delay: AppDurations.normal,
              duration: AppDurations.normal,
            )
            .slideY(
              begin: 0.1,
              end: 0.0,
            ),
        AppSpacing.xl.verticalSpace,
        AppButton.primaryGradient(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: AppButtonChild.label(AppStrings.done),
        ),
        AppSpacing.lg.verticalSpace,
      ],
    );
  }
}
