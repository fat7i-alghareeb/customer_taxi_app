import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';

/// Fallback sheet for statuses without a dedicated design (pendingQuote,
/// awaitingAdminAcceptance, awaitingPayment, paymentFailed, refunded, unknown).
class TripGeneralStatusSheet extends StatelessWidget {
  const TripGeneralStatusSheet({
    required this.trip,
    required this.cancelStatus,
    required this.onCancelPressed,
    super.key,
  });

  final TripEntity trip;
  final BlocStatus<void> cancelStatus;
  final VoidCallback onCancelPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            FaIcon(
              FontAwesomeIcons.circleInfo,
              color: colors.primary,
              size: 24.r,
            ),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Text(
                trip.status.title,
                style: AppTextStyles.s20w700.copyWith(color: colors.onSurface),
              ),
            ),
          ],
        ),
        AppSpacing.xl.verticalSpace,

        if (trip.status.canCancel)
          AppButton.outline(
            variant: AppButtonVariant.error,
            isLoading: cancelStatus.isLoading,
            onTap: onCancelPressed,
            child: AppButtonChild.label(AppStrings.activeTripCancelRide),
          ),
      ],
    );
  }
}
