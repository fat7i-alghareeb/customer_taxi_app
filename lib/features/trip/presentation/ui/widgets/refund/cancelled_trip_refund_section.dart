import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/refund_issues/presentation/ui/screens/refund_issue_screen.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_refund_status.dart';

class CancelledTripRefundSection extends StatelessWidget {
  const CancelledTripRefundSection({super.key, required this.trip});

  final TripEntity trip;

  @override
  Widget build(BuildContext context) {
    final cancellation = trip.cancellation;
    if (cancellation == null) return const SizedBox.shrink();
    final refundStatus = trip.refund?.status ?? TripRefundStatus.preparing;

    return Container(
      padding: REdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
        boxShadow: context.shadows.primary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadii.lg.r),
                  border: Border.all(
                    color: AppColors.error.withValues(alpha: 0.28),
                  ),
                ),
                child: FaIcon(
                  FontAwesomeIcons.xmark,
                  size: 18.r,
                  color: AppColors.error,
                ),
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.cancelledRefundSectionTitle,
                      style: AppTextStyles.s16w700.copyWith(
                        color: context.onSurface,
                      ),
                    ),
                    AppSpacing.xs.verticalSpace,
                    Text(
                      AppStrings.cancelledRefundSectionSubtitle,
                      style: AppTextStyles.s12w400.copyWith(
                        color: context.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.lg.verticalSpace,
          CancelledTripRefundRow(
            label: AppStrings.refundIssueRefundAmount,
            value: _formatAmount(
              cancellation.refundAmount,
              cancellation.currencyCode,
            ),
            valueColor: AppColors.warning,
          ),
          AppSpacing.sm.verticalSpace,
          CancelledTripRefundRow(
            label: AppStrings.refundIssueRefundPercent,
            value: '${cancellation.refundPercent.toStringAsFixed(0)}%',
          ),
          if (cancellation.createdAtUtc != null) ...[
            AppSpacing.sm.verticalSpace,
            CancelledTripRefundRow(
              label: AppStrings.cancelledRefundCancelledAt,
              value:
                  '${cancellation.createdAtUtc!.toLocal().toYmd()} ${cancellation.createdAtUtc!.toLocal().toTime12Compact()}',
            ),
          ],
          AppSpacing.lg.verticalSpace,
          AppButton.warningGradient(
            onTap: () => context.pushNamed(
              RefundIssueScreen.pageName,
              extra: RefundIssueScreenArgs(
                tripId: trip.id,
                referenceCode: trip.referenceCode,
                refundAmount: cancellation.refundAmount,
                currencyCode: cancellation.currencyCode,
                refundPercent: cancellation.refundPercent,
                fromLabel: trip.stops.firstOrNull?.label ?? '',
                toLabel: trip.stops.lastOrNull?.label ?? '',
                cancelledAtUtc: cancellation.createdAtUtc,
                refundStatus: refundStatus,
                knownFailedRefund: refundStatus == TripRefundStatus.failed,
              ),
            ),
            child: AppButtonChild.labelIcon(
              label: AppStrings.refundIssueReviewCta,
              icon: IconSource.faIcon(FontAwesomeIcons.wallet),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: AppDurations.normal).slideY(begin: 0.08);
  }

  String _formatAmount(double value, String currencyCode) =>
      '${value.toStringAsFixed(2)} $currencyCode';
}

class CancelledTripRefundRow extends StatelessWidget {
  const CancelledTripRefundRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.s12w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.58),
            ),
          ),
        ),
        AppSpacing.md.horizontalSpace,
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: AppTextStyles.s12w700.copyWith(
              color: valueColor ?? context.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
