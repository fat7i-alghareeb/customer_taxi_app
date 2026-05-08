import 'package:customertaxi/common/imports/imports.dart';
import '../../../domain/entities/trip_entity.dart';
import '../../states/trip_bloc.dart';
import 'trip_info_row.dart';
import 'trip_status_chip.dart';

class ActiveTripBody extends StatelessWidget {
  const ActiveTripBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TripBloc, TripState>(
      listenWhen: (prev, curr) =>
          prev.cancelStatus != curr.cancelStatus ||
          prev.tripStatus != curr.tripStatus,
      listener: (context, state) {
        state.cancelStatus.whenOrNull(
          failure: (msg) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg)),
          ),
        );
        state.tripStatus.whenOrNull(
          success: (trip) {
            if (trip.status.isTerminal) {
              Future.delayed(AppDurations.slow * 4, () {
                if (context.mounted) context.goNamed('RootScreen');
              });
            }
          },
        );
      },
      builder: (context, state) {
        return StatusBuilder<TripEntity>(
          state: state.tripStatus,
          success: (trip) => _ActiveTripDetail(
            trip: trip,
            cancelStatus: state.cancelStatus,
          ),
        );
      },
    );
  }
}

class _ActiveTripDetail extends StatelessWidget {
  const _ActiveTripDetail({
    required this.trip,
    required this.cancelStatus,
  });

  final TripEntity trip;
  final BlocStatus<void> cancelStatus;

  @override
  Widget build(BuildContext context) {
    final dateStr = trip.createdAtUtc.toLocal().toYmd();

    return SingleChildScrollView(
      padding: REdgeInsets.all(AppSpacing.xl),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppSpacing.md.verticalSpace,
          TripStatusChip(status: trip.status).animate().fadeIn().scale(),
          AppSpacing.xl.verticalSpace,
          TripInfoRow(label: AppStrings.tripReferenceCode, value: trip.referenceCode),
          TripInfoRow(
            label: AppStrings.tripFare,
            value: '${trip.quotedFare.toStringAsFixed(2)} ${trip.currencyCode}',
            valueColor: context.primary,
          ),
          TripInfoRow(label: AppStrings.tripCreatedAt, value: dateStr),
          if (trip.scheduledAtUtc != null)
            TripInfoRow(
              label: AppStrings.tripScheduledFor,
              value: trip.scheduledAtUtc!.toLocal().toYmd(),
            ),
          AppSpacing.xxl.verticalSpace,
          if (trip.status.canCancel)
            AppButton.primary(
              onTap: () => _showCancelDialog(context),
              isLoading: cancelStatus.isLoading,
              child: AppButtonChild.label(AppStrings.tripCancelButton),
            ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppStrings.tripCancelButton),
        content: Text(AppStrings.tripCancelConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              AppStrings.confirm,
              style: TextStyle(color: context.error),
            ),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed == true && context.mounted) {
        context.read<TripBloc>().add(const TripEvent.cancelRequested());
      }
    });
  }
}
