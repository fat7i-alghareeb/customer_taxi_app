import 'package:customertaxi/common/imports/imports.dart';

import '../../../states/order_bloc.dart';

class OrderSchedulePickerWidget extends StatelessWidget {
  const OrderSchedulePickerWidget({super.key, required this.state});

  final OrderState state;

  @override
  Widget build(BuildContext context) {
    final isLater = state.booking.scheduleMode == OrderScheduleMode.later;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ModeToggle(isLater: isLater),
        AnimatedSize(
          duration: AppDurations.normal,
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: isLater
              ? Padding(
                  padding: REdgeInsets.only(top: AppSpacing.sm),
                  child: _DateTimeField(
                    scheduledAt: state.booking.scheduledAt,
                    onTap: () => _selectDateTime(context),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final initial = state.booking.scheduledAt ?? DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: context.primary,
              onPrimary: context.onPrimary,
              surface: context.surface,
              onSurface: context.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date == null || !context.mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: context.primary,
              onPrimary: context.onPrimary,
              surface: context.surface,
              onSurface: context.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (time == null || !context.mounted) return;

    final scheduledAt = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    context.read<OrderBloc>().add(OrderEvent.scheduleTimeChanged(scheduledAt));
  }
}

class _ModeToggle extends StatelessWidget {
  const _ModeToggle({required this.isLater});

  final bool isLater;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: context.onSurface.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ModeChip(
              label: AppStrings.now,
              icon: FontAwesomeIcons.bolt,
              isSelected: !isLater,
              onTap: () => context.read<OrderBloc>().add(
                    const OrderEvent.scheduleModeChanged(OrderScheduleMode.now),
                  ),
            ),
          ),
          AppSpacing.xs.horizontalSpace,
          Expanded(
            child: _ModeChip(
              label: AppStrings.later,
              icon: FontAwesomeIcons.clock,
              isSelected: isLater,
              onTap: () => context.read<OrderBloc>().add(
                    const OrderEvent.scheduleModeChanged(
                      OrderScheduleMode.later,
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeChip extends StatelessWidget {
  const _ModeChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? context.primary : Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadii.md.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.md.r),
        child: Padding(
          padding: REdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                icon,
                size: 14.r,
                color: isSelected ? context.onPrimary : context.onSurface,
              ),
              AppSpacing.xs.horizontalSpace,
              Text(
                label,
                style: AppTextStyles.s14w600.copyWith(
                  color: isSelected ? context.onPrimary : context.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateTimeField extends StatelessWidget {
  const _DateTimeField({required this.scheduledAt, required this.onTap});

  final DateTime? scheduledAt;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasTime = scheduledAt != null;
    final label = hasTime
        ? DateFormat('EEE, MMM d, HH:mm').format(scheduledAt!)
        : AppStrings.selectDateTime;

    return Material(
      color: context.surface,
      borderRadius: BorderRadius.circular(AppRadii.lg.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        child: Container(
          padding: REdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            border: Border.all(
              color: hasTime
                  ? context.primary
                  : context.onSurface.withValues(alpha: 0.15),
              width: hasTime ? 2.r : 1.r,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: REdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: context.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: FaIcon(
                  FontAwesomeIcons.calendarDay,
                  size: 16.r,
                  color: context.primary,
                ),
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hasTime
                          ? AppStrings.timeSelected
                          : AppStrings.selectDateTime,
                      style: AppTextStyles.s12w400.copyWith(
                        color: context.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    Text(
                      label,
                      style: AppTextStyles.s16w600.copyWith(
                        color: context.onSurface,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              FaIcon(
                FontAwesomeIcons.chevronRight,
                size: 14.r,
                color: context.onSurface.withValues(alpha: 0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
