import 'package:customertaxi/common/imports/imports.dart';

import '../../../domain/entities/trip_entity.dart';
import '../../states/trip_bloc.dart';
import '../widgets/completed_action_chips.dart';
import '../widgets/trip_fare_summary_card.dart';
import '../widgets/trip_stops_timeline.dart';

/// Post-trip details screen — replicates the Uber "تفاصيل المشوار" reference
/// image. Reached by tapping a completed trip card in trip history; renders
/// the same chips and timeline used by the inline completion sheet.
class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({super.key});

  static const String pagePath = '/trip_details';
  static const String pageName = 'TripDetailsScreen';

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final tripId =
        (state.extra as String?) ?? state.uri.queryParameters['id'] ?? '';

    return BlocProvider<TripBloc>(
      create: (_) => getIt<TripBloc>()..add(TripEvent.started(tripId)),
      child: AppScaffold.appBar(
        appBarConfig: AppScaffoldAppBarConfig(
          title: AppStrings.tripDetailsTitle,
        ),
        child: _TripDetailsBody(tripId: tripId),
      ),
    );
  }
}

class _TripDetailsBody extends StatelessWidget {
  const _TripDetailsBody({required this.tripId});

  final String tripId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripBloc, TripState>(
      buildWhen: (a, b) => a.tripStatus != b.tripStatus,
      builder: (context, state) {
        return StatusBuilder<TripEntity>(
          state: state.tripStatus,
          onError: () =>
              context.read<TripBloc>().add(TripEvent.started(tripId)),
          success: (trip) => _DetailsContent(trip: trip),
        );
      },
    );
  }
}

class _DetailsContent extends StatelessWidget {
  const _DetailsContent({required this.trip});

  final TripEntity trip;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final completedAt = trip.stops.isNotEmpty
        ? trip.stops.last.completedAtUtc
        : null;

    return SingleChildScrollView(
      padding: REdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Chips row — exactly matches the Uber reference image
          CompletedActionChips(tripId: trip.id),
          AppSpacing.xl.verticalSpace,

          // Stops timeline (pickup, intermediate, destination)
          if (trip.stops.isNotEmpty) ...[
            TripStopsTimeline(stops: trip.stops),
            AppSpacing.lg.verticalSpace,
          ],

          // Fare card
          TripFareSummaryCard(
            amount: trip.quotedFare,
            currencyCode: trip.currencyCode,
            referenceCode: trip.referenceCode,
          ),

          AppSpacing.lg.verticalSpace,
          _DetailsMetaRow(
            icon: FontAwesomeIcons.carSide,
            label: trip.vehicleTypeName ?? '',
          ),
          if (completedAt != null) ...[
            AppSpacing.md.verticalSpace,
            _DetailsMetaRow(
              icon: FontAwesomeIcons.clock,
              label:
                  '${completedAt.toLocal().toYmd()} • ${completedAt.toLocal().toTime12Compact()}',
            ),
          ],
          AppSpacing.md.verticalSpace,
          Text(
            AppStrings.tripReferenceCode.replaceAll(
              '#{code}',
              trip.referenceCode,
            ),
            style: AppTextStyles.s12w400.copyWith(
              color: colors.onSurface.withValues(alpha: 0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _DetailsMetaRow extends StatelessWidget {
  const _DetailsMetaRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    if (label.isEmpty) return const SizedBox.shrink();
    return Row(
      children: [
        FaIcon(icon, size: 16.r, color: colors.onSurface.withValues(alpha: 0.6)),
        AppSpacing.md.horizontalSpace,
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.s14w400.copyWith(color: colors.onSurface),
          ),
        ),
      ],
    );
  }
}
