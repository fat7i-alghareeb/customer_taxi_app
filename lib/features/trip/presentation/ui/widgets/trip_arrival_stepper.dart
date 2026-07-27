import 'package:customertaxi/common/imports/imports.dart';

/// 3-step vertical timeline — Ride accepted / Driver on the way / Driver
/// arrived. [activeIndex] is the step the trip has *reached*, and it renders as
/// done: a step is ticked as soon as it is happening, not once it is over. So
/// while the driver is en route, "Chauffeur onderweg" already carries a check
/// (and shows its sub-line); only steps still ahead stay muted. The connector
/// below the current step deliberately stays grey — the trip has not travelled
/// it yet.
class TripArrivalStepper extends StatelessWidget {
  const TripArrivalStepper({required this.activeIndex, super.key});

  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    final steps = <({String label, String? sub})>[
      (label: AppStrings.activeTripStepRideAccepted, sub: null),
      (
        label: AppStrings.activeTripStepDriverOnWay,
        sub: AppStrings.activeTripStepDriverOnWaySub,
      ),
      (
        label: AppStrings.activeTripStepDriverArrived,
        sub: AppStrings.activeTripDriverOutside,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(steps.length, (index) {
        final step = steps[index];
        final isLast = index == steps.length - 1;
        final isActive = index == activeIndex;
        final isCompleted = index <= activeIndex;
        // The connector only fills for steps the trip has already left behind,
        // so the line below the current step stays grey.
        final isConnectorFilled = index < activeIndex;
        final showSub = isActive && step.sub != null;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  _StepDot(isCompleted: isCompleted, isActive: isActive),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2.w,
                        margin: REdgeInsets.symmetric(vertical: 2),
                        color: isConnectorFilled
                            ? colors.primary
                            : colors.onSurface.withValues(alpha: 0.15),
                      ),
                    ),
                ],
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Padding(
                  padding: REdgeInsets.only(bottom: isLast ? 0 : AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.label,
                        style: AppTextStyles.s14w700.copyWith(
                          color: (isCompleted || isActive)
                              ? colors.onSurface
                              : colors.onSurface.withValues(alpha: 0.4),
                        ),
                      ),
                      if (showSub) ...[
                        AppSpacing.xs.verticalSpace,
                        Text(
                          step.sub!,
                          style: AppTextStyles.s12w400.copyWith(
                            color: colors.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

/// A single stepper marker: filled+check for every step the trip has reached
/// (including the one in progress), and a muted ring for steps still ahead. The
/// current step keeps its check but gains a soft halo, so "done" and "happening
/// now" stay distinguishable.
class _StepDot extends StatelessWidget {
  const _StepDot({required this.isCompleted, required this.isActive});

  final bool isCompleted;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    const size = 22.0;

    if (isCompleted) {
      return Container(
        width: size.r,
        height: size.r,
        decoration: BoxDecoration(
          color: colors.primary,
          shape: BoxShape.circle,
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: colors.primary.withValues(alpha: 0.25),
                    blurRadius: 6.r,
                    spreadRadius: 2.r,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: FaIcon(
            FontAwesomeIcons.check,
            color: Colors.white,
            size: 11.r,
          ),
        ),
      );
    }

    return Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: colors.onSurface.withValues(alpha: 0.3),
          width: 2.r,
        ),
      ),
    );
  }
}
