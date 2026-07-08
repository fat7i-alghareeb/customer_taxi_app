import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';

/// Live waiting-time card shown on the arrived sheet. A countdown to the
/// scheduled start (if the driver is early), then the boarding grace-period
/// countdown, then the accruing per-minute fee once the free window is over.
///
/// This is a pure render of `DateTime.now()` vs. the trip's waiting session —
/// the parent owns a 1-second ticker that rebuilds this widget to keep the
/// clock live.
class TripWaitingCard extends StatelessWidget {
  const TripWaitingCard({required this.trip, super.key});

  final TripEntity trip;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final session = trip.activeWaitingSession;
    final startUtc = session?.startedAtUtc ?? trip.arrivedAtUtc;
    if (startUtc == null) return const SizedBox.shrink();

    final graceMinutes = session?.graceMinutes ?? 10;
    final ratePerMinute = session?.ratePerMinute ?? 0;
    final now = DateTime.now();

    // Grace window is over → accruing per-minute fee (warning design).
    if (now.isAfter(startUtc)) {
      final elapsed = now.difference(startUtc);
      final graceRemaining = Duration(minutes: graceMinutes) - elapsed;
      if (graceRemaining <= Duration.zero) {
        final overdueSeconds = elapsed.inSeconds - graceMinutes * 60;
        final billableMinutes = (overdueSeconds / 60).ceil();
        final fee = billableMinutes * ratePerMinute;
        final amount = '${fee.toStringAsFixed(2)} ${trip.currencyCode}';
        return Padding(
          padding: REdgeInsets.only(bottom: AppSpacing.md),
          child: Container(
            width: double.infinity,
            padding: REdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(AppRadii.lg.r),
              border: Border.all(
                color: AppColors.warning.withValues(alpha: 0.30),
                width: 1.r,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.triangleExclamation,
                      color: AppColors.warning,
                      size: 18.r,
                    ),
                    AppSpacing.md.horizontalSpace,
                    Expanded(
                      child: Text(
                        AppStrings.tripWaitingGraceOver,
                        style: AppTextStyles.s12w500.copyWith(
                          color: colors.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  AppStrings.waitingLateMinutes.replaceAll(
                    '{minutes}',
                    billableMinutes.toString(),
                  ),
                  style: AppTextStyles.s14w700.copyWith(
                    color: AppColors.warning,
                  ),
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  AppStrings.tripWaitingFeeAccruing.replaceAll(
                    '{amount}',
                    amount,
                  ),
                  style: AppTextStyles.s16w700.copyWith(
                    color: AppColors.warning,
                  ),
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  AppStrings.waitingPayDriverNotice,
                  style: AppTextStyles.s12w500.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.72),
                  ),
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  AppStrings.tripConfirmedBoardingWarning,
                  style: AppTextStyles.s12w400.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.65),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }

    // Pre-scheduled (driver early) or still within the free grace window →
    // countdown card (clock + MM:SS + spinner).
    final Duration remaining = now.isBefore(startUtc)
        ? startUtc.difference(now)
        : Duration(minutes: graceMinutes) - now.difference(startUtc);
    final mm = remaining.inMinutes.remainder(60).toString().padLeft(2, '0');
    final ss = remaining.inSeconds.remainder(60).toString().padLeft(2, '0');

    return Padding(
      padding: REdgeInsets.only(bottom: AppSpacing.md),
      child: Container(
        width: double.infinity,
        padding: REdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: colors.onSurface.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          border: Border.all(
            color: colors.onSurface.withValues(alpha: 0.06),
            width: 1.r,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FaIcon(FontAwesomeIcons.clock, color: colors.primary, size: 26.r),
                AppSpacing.md.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.activeTripWaitingTime,
                        style: AppTextStyles.s12w400.copyWith(
                          color: colors.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                      AppSpacing.xs.verticalSpace,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '$mm:$ss',
                            style: AppTextStyles.s24w700.copyWith(
                              color: colors.primary,
                            ),
                          ),
                          AppSpacing.xs.horizontalSpace,
                          Text(
                            AppStrings.activeTripMinShort,
                            style: AppTextStyles.s12w400.copyWith(
                              color: colors.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AppSpacing.md.verticalSpace,
            Text(
              AppStrings.tripConfirmedBoardingWarning,
              style: AppTextStyles.s12w400.copyWith(
                color: colors.onSurface.withValues(alpha: 0.65),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
