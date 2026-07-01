import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_refund_status.dart';

/// Prominent, self-contained refund-status card shown on the trip details
/// screen. Makes the refund outcome (completed / in progress / failed)
/// unmistakable, tinted by [TripRefundStatus.color].
class TripRefundStatusCard extends StatelessWidget {
  const TripRefundStatusCard({super.key, required this.refund});

  final TripRefundEntity refund;

  @override
  Widget build(BuildContext context) {
    final status = refund.status;
    if (status == TripRefundStatus.unknown) return const SizedBox.shrink();

    final accent = status.color;

    return Container(
      padding: REdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.16),
                  shape: BoxShape.circle,
                ),
                child: FaIcon(status.icon, size: 20.r, color: accent),
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status.title,
                      style: AppTextStyles.s16w700.copyWith(color: accent),
                    ),
                    AppSpacing.xs.verticalSpace,
                    Text(
                      _formatAmount(refund.amount, refund.currencyCode),
                      style: AppTextStyles.s14w700.copyWith(
                        color: context.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.md.verticalSpace,
          Text(
            status.description,
            style: AppTextStyles.s12w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.78),
            ),
          ),
          if (status == TripRefundStatus.completed &&
              refund.completedAtUtc != null) ...[
            AppSpacing.sm.verticalSpace,
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.calendarCheck,
                  size: 12.r,
                  color: context.onSurface.withValues(alpha: 0.5),
                ),
                AppSpacing.xs.horizontalSpace,
                Text(
                  '${refund.completedAtUtc!.toLocal().toYmd()} ${refund.completedAtUtc!.toLocal().toTime12Compact()}',
                  style: AppTextStyles.s12w400.copyWith(
                    color: context.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: AppDurations.normal).slideY(begin: 0.08);
  }

  String _formatAmount(double value, String currencyCode) =>
      '${value.toStringAsFixed(2)} $currencyCode';
}
