import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_status.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_arrival_stepper.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_cancel_button.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_chat_button.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_editable_details.dart';

/// Sheet for `TripStatus.enRoute`, also reused for the brief "arrived" handoff
/// (see `GlassmorphicTripStatusSheet`) where all three stepper steps render
/// checked just before the dedicated arrived sheet takes over. Shows the same
/// address / passengers / bags block as the confirmation sheet (editable while
/// the status allows repricing), plus the progress stepper.
///
/// No arrival ETA here: it lives in the `LiveArrivalBadge` over the map, so
/// repeating it inside the sheet was duplicate information.
class TripEnRouteStatusSheet extends StatelessWidget {
  const TripEnRouteStatusSheet({
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
        // Progress stepper card.
        Container(
          padding: REdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: colors.onSurface.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            border: Border.all(
              color: colors.onSurface.withValues(alpha: 0.06),
              width: 1.r,
            ),
          ),
          // En-route: step 2 active. Arrived handoff: all three checked before
          // the dedicated arrived sheet takes over.
          child: TripArrivalStepper(
            activeIndex: trip.status == TripStatus.arrived ? 3 : 1,
          ),
        ),
        AppSpacing.md.verticalSpace,

        // Address, passengers and bags — identical to the confirmation sheet so
        // the rider sees the same details (and edit affordances) as before.
        TripEditableDetails(trip: trip),
        AppSpacing.sm.verticalSpace,

        const TripChatButton(),
        AppSpacing.sm.verticalSpace,

        TripCancelButton(
          isLoading: cancelStatus.isLoading,
          onTap: onCancelPressed,
        ),
      ],
    );
  }
}
