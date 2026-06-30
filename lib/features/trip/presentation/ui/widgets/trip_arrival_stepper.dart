import 'package:customertaxi/common/imports/imports.dart';

/// 3-step vertical timeline — Ride accepted / Driver on the way / Driver
/// arrived. [activeIndex] is the current step; earlier steps render as
/// completed (an [activeIndex] past the last step marks all three done).
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
        final isCompleted = index < activeIndex;
        final isActive = index == activeIndex;
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
                        color: isCompleted
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

/// A single stepper marker: filled+check when completed, an orange ring when
/// active, and a muted ring when still pending.
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
          color: isActive
              ? colors.primary
              : colors.onSurface.withValues(alpha: 0.3),
          width: isActive ? 2.5.r : 2.r,
        ),
      ),
    );
  }
}
