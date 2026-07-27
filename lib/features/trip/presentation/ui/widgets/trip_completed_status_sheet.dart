import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/presentation/states/active_trip_cubit.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/completed_action_chips.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_fare_summary_card.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_rating_sheet.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_stops_timeline.dart';

/// Sheet shown while `TripStatus.completed` — receipt/invoice chips, fare
/// summary, stops timeline, and the rate/done actions.
class TripCompletedStatusSheet extends StatelessWidget {
  const TripCompletedStatusSheet({required this.trip, super.key});

  final TripEntity trip;

  Future<void> _refreshActiveTripGate() async {
    await getIt<ActiveTripCubit>().refresh();
  }

  Future<void> _clearActiveTripGate() async {
    final cubit = getIt<ActiveTripCubit>();
    cubit.clearTrip(trip.id);
    await cubit.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: FaIcon(
            FontAwesomeIcons.circleCheck,
            color: AppColors.success,
            size: 40.r,
          ),
        ),
        AppSpacing.sm.verticalSpace,
        Center(
          child: Text(
            AppStrings.tripStatusCompleted,
            style: AppTextStyles.s20w700.copyWith(color: colors.onSurface),
          ),
        ),
        AppSpacing.sm.verticalSpace,

        // Uber-style receipt / invoice chips
        CompletedActionChips(tripId: trip.id),
        AppSpacing.sm.verticalSpace,

        // Fare Summary Card
        TripFareSummaryCard(
          amount: trip.quotedFare,
          currencyCode: trip.currencyCode,
          referenceCode: trip.referenceCode,
        ),
        AppSpacing.md.verticalSpace,

        // Stops Timeline
        if (trip.stops.isNotEmpty) ...[
          TripStopsTimeline(stops: trip.stops),
          AppSpacing.md.verticalSpace,
        ],

        // Rate the trip (also auto-shown once on completion).
        AppButton.outline(
          onTap: () => showTripRatingSheet(
            context,
            tripId: trip.id,
            onClosed: _refreshActiveTripGate,
          ),
          child: AppButtonChild.label(AppStrings.ratingTitle),
        ),
        AppSpacing.sm.verticalSpace,

        // Done button to route home (explicit dismiss — no auto-redirect)
        AppButton.primaryGradient(
          onTap: () async {
            await _clearActiveTripGate();
            if (context.mounted) context.goNamed('RootScreen');
          },
          child: AppButtonChild.label(AppStrings.done),
        ),
      ],
    );
  }
}
