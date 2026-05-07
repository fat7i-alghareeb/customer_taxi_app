import 'package:customertaxi/common/imports/imports.dart';

import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import '../../states/trip_bloc.dart';

import 'package:customertaxi/features/trip/domain/entities/trip_status.dart';

class TripBody extends StatelessWidget {
  const TripBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(
      child: BlocConsumer<TripBloc, TripState>(
        listenWhen: (prev, curr) =>
            prev.cancelStatus != curr.cancelStatus ||
            prev.tripStatus != curr.tripStatus,
        listener: (context, state) {
          state.cancelStatus.whenOrNull(
            failure: (msg) => ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(msg))),
          );
          state.tripStatus.whenOrNull(
            success: (trip) {
              if (trip.status.isTerminal) {
                Future.delayed(const Duration(seconds: 3), () {
                  if (context.mounted) context.goNamed('RootScreen');
                });
              }
            },
          );
        },
        builder: (context, state) {
          return StatusBuilder<TripEntity>(
            state: state.tripStatus,
            success: (trip) => _TripDetail(
              trip: trip,
              cancelStatus: state.cancelStatus,
            ),
          );
        },
      ),
    );
  }
}

class _TripDetail extends StatelessWidget {
  const _TripDetail({
    required this.trip,
    required this.cancelStatus,
  });

  final TripEntity trip;
  final BlocStatus<void> cancelStatus;

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('dd MMM yyyy, HH:mm').format(trip.createdAtUtc.toLocal());

    return SafeArea(
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppSpacing.md.verticalSpace,
            Text(
              AppStrings.tripActiveTitle,
              style: AppTextStyles.s24w700,
              textAlign: TextAlign.center,
            ),
            AppSpacing.xl.verticalSpace,
            _InfoRow(label: AppStrings.tripReferenceCode, value: trip.referenceCode),
            Padding(
              padding: REdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppStrings.tripStatus, style: AppTextStyles.s14w400.copyWith(color: context.onSurface.withValues(alpha: 0.6))),
                  _StatusChip(status: trip.status),
                ],
              ),
            ),
            _InfoRow(
              label: AppStrings.tripFare,
              value: '${trip.quotedFare.toStringAsFixed(2)} ${trip.currencyCode}',
            ),
            _InfoRow(label: AppStrings.tripCreatedAt, value: dateStr),
            if (trip.scheduledAtUtc != null)
              _InfoRow(
                label: AppStrings.tripScheduledFor,
                value: DateFormat('dd MMM yyyy, HH:mm').format(trip.scheduledAtUtc!.toLocal()),
              ),
            const Spacer(),
            if (trip.status.canCancel)
              AppButton.primary(
                child: AppButtonChild.label(AppStrings.tripCancelButton),
                isLoading: cancelStatus.isLoading,
                onTap: () => _showCancelDialog(context),
              ),
          ],
        ),
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
            child: Text(AppStrings.tripCancelConfirmNo),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              AppStrings.tripCancelConfirmYes,
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.s14w400.copyWith(color: context.onSurface.withValues(alpha: 0.6))),
          Flexible(child: Text(value, style: AppTextStyles.s14w700, textAlign: TextAlign.end)),
        ],
      ),
    );
  }
}

class TripHistoryBody extends StatelessWidget {
  const TripHistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(
      child: BlocBuilder<TripBloc, TripState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: REdgeInsets.all(AppSpacing.xl),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(AppStrings.tripHistoryTitle, style: AppTextStyles.s24w700),
                ),
              ),
              Expanded(
                child: StatusBuilder<List<TripSummaryEntity>>(
                  state: state.historyStatus,
                  success: (_) => _TripList(
                    trips: state.trips,
                    hasMore: state.hasMore,
                    isLoadingMore: state.historyStatus.isLoading,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TripList extends StatelessWidget {
  const _TripList({
    required this.trips,
    required this.hasMore,
    required this.isLoadingMore,
  });

  final List<TripSummaryEntity> trips;
  final bool hasMore;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    if (trips.isEmpty) {
      return Center(child: Text(AppStrings.tripHistoryEmpty));
    }
    return ListView.builder(
      padding: REdgeInsets.all(AppSpacing.xl),
      itemCount: trips.length + (hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == trips.length) {
          return Padding(
            padding: REdgeInsets.symmetric(vertical: AppSpacing.md),
            child: isLoadingMore
                ? Center(child: LoadingDots(color: context.primary))
                : AppButton.primary(
                    child: AppButtonChild.label(AppStrings.tripHistoryLoadMore),
                    onTap: () => context.read<TripBloc>().add(const TripEvent.nextPageRequested()),
                  ),
          );
        }
        final trip = trips[index];
        return _TripSummaryCard(trip: trip);
      },
    );
  }
}

class _TripSummaryCard extends StatelessWidget {
  const _TripSummaryCard({required this.trip});
  final TripSummaryEntity trip;

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('dd MMM yyyy, HH:mm').format(trip.createdAtUtc.toLocal());
    return Card(
      margin: REdgeInsets.only(bottom: AppSpacing.md),
      child: InkWell(
        onTap: () => context.pushNamed(
          'ActiveTripScreen',
          pathParameters: {'id': trip.id},
        ),
        borderRadius: BorderRadius.circular(AppRadii.md),
        child: Padding(
          padding: REdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(trip.referenceCode, style: AppTextStyles.s14w700),
                  _StatusChip(status: trip.status),
                ],
              ),
              AppSpacing.sm.verticalSpace,
              Text(dateStr, style: AppTextStyles.s12w400.copyWith(color: context.onSurface.withValues(alpha: 0.6))),
              AppSpacing.sm.verticalSpace,
              Text(
                '${trip.quotedFare.toStringAsFixed(2)} ${trip.currencyCode}',
                style: AppTextStyles.s14w700.copyWith(color: context.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final TripStatus status;

  @override
  Widget build(BuildContext context) {
    final color = status.color(context);
    return Container(
      padding: REdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadii.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(status.icon, size: 10.r, color: color),
          AppSpacing.xs.horizontalSpace,
          Text(
            status.title,
            style: AppTextStyles.s12w700.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
