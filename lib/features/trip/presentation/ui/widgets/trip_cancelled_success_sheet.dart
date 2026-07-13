import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';

/// Bottom sheet shown when a trip is cancelled. When [cancellation] is provided
/// it also shows a brief "who cancelled + when" report (mirrors the admin
/// dashboard) and stays open until the rider dismisses it; otherwise it keeps
/// the original auto-dismiss success behaviour.
class TripCancelledSuccessSheet extends StatefulWidget {
  const TripCancelledSuccessSheet({super.key, this.cancellation});

  final TripCancellationEntity? cancellation;

  /// Shows the cancellation sheet.
  static Future<void> show(
    BuildContext context, {
    TripCancellationEntity? cancellation,
  }) {
    return AppBottomSheet.show<void>(
      context,
      sheet: AppBottomSheet.basic(
        child: TripCancelledSuccessSheet(cancellation: cancellation),
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
    // Keep the report on screen when we have cancellation details to show.
    if (widget.cancellation == null) {
      _autoCloseTimer = Timer(const Duration(milliseconds: 2500), () {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    }
  }

  @override
  void dispose() {
    _autoCloseTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final cancellation = widget.cancellation;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSpacing.xl.verticalSpace,
        Center(
          child:
              FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    color: AppColors.success,
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
              AppStrings.tripCancelledSuccess,
              textAlign: TextAlign.center,
              style: AppTextStyles.s20w700.copyWith(color: colors.onSurface),
            )
            .animate()
            .fadeIn(delay: AppDurations.fast, duration: AppDurations.normal)
            .slideY(begin: 0.1, end: 0.0),
        AppSpacing.sm.verticalSpace,
        Text(
              AppStrings.tripCancelledSuccessDesc,
              textAlign: TextAlign.center,
              style: AppTextStyles.s14w400.copyWith(
                color: colors.onSurface.withValues(alpha: 0.6),
              ),
            )
            .animate()
            .fadeIn(delay: AppDurations.normal, duration: AppDurations.normal)
            .slideY(begin: 0.1, end: 0.0),
        if (cancellation != null) ...[
          AppSpacing.lg.verticalSpace,
          _CancellationReport(cancellation: cancellation),
        ],
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

/// Brief "cancelled by {actor} on {datetime}" card.
class _CancellationReport extends StatelessWidget {
  const _CancellationReport({required this.cancellation});

  final TripCancellationEntity cancellation;

  static String _actorLabel(String actor) {
    switch (actor.toLowerCase()) {
      case 'passenger':
        return AppStrings.cancellationActorPassenger;
      case 'driver':
        return AppStrings.cancellationActorDriver;
      case 'admin':
        return AppStrings.cancellationActorAdmin;
      default:
        return actor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final createdAt = cancellation.createdAtUtc?.toLocal();

    return Container(
      width: double.infinity,
      padding: REdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.error.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(AppRadii.md.r),
        border: Border.all(color: colors.error.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FaIcon(
                FontAwesomeIcons.circleXmark,
                size: 14.r,
                color: colors.error,
              ),
              AppSpacing.sm.horizontalSpace,
              Expanded(
                child: Text(
                  '${AppStrings.cancellationCancelledByLabel}: '
                  '${_actorLabel(cancellation.actor)}',
                  style: AppTextStyles.s14w600.copyWith(
                    color: colors.onSurface,
                  ),
                ),
              ),
            ],
          ),
          if (createdAt != null) ...[
            AppSpacing.xs.verticalSpace,
            Text(
              createdAt.toSmartDateTime(),
              style: AppTextStyles.s12w400.copyWith(
                color: colors.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
