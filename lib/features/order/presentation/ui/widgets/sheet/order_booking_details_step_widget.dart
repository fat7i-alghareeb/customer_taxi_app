import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/order/presentation/states/order_bloc.dart';
import 'package:intl/intl.dart';

class OrderBookingDetailsStepWidget extends StatelessWidget {
  const OrderBookingDetailsStepWidget({super.key, required this.state});

  final OrderState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(title: AppStrings.scheduleTime),
        AppSpacing.md.verticalSpace,
        _ScheduleSelector(
          scheduledAt: state.scheduledAt,
          onTap: () => _selectDateTime(context),
        ),
        AppSpacing.xl.verticalSpace,
        _SectionHeader(title: AppStrings.paymentMethod),
        AppSpacing.md.verticalSpace,
        _PaymentMethodSelector(
          selectedMethodId: state.paymentMethodId,
          onMethodSelected: (id) {
            context.read<OrderBloc>().add(OrderEvent.paymentMethodChanged(id));
          },
        ),
        const Spacer(),
        AppButton.primary(
          onTap: () {
            context.read<OrderBloc>().add(
              const OrderEvent.confirmBookingDetailsPressed(),
            );
          },
          layout: AppButtonLayout(height: 56.h, borderRadius: AppRadii.lg),
          child: AppButtonChild.label(AppStrings.confirmBooking),
        ),
      ],
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
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
      initialTime: TimeOfDay.now(),
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

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.s16w600.copyWith(
        color: context.onSurface,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class _ScheduleSelector extends StatelessWidget {
  const _ScheduleSelector({this.scheduledAt, required this.onTap});

  final DateTime? scheduledAt;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isNow = scheduledAt == null;
    final label = isNow
        ? AppStrings.now
        : DateFormat('EEE, MMM d, HH:mm').format(scheduledAt!);

    return Material(
      color: context.surface,
      borderRadius: BorderRadius.circular(AppRadii.lg.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        child: AnimatedContainer(
          duration: AppDurations.normal,
          padding: REdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            border: Border.all(
              color: isNow
                  ? context.onSurface.withValues(alpha: 0.1)
                  : context.primary,
              width: isNow ? 1.r : 2.r,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: REdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: isNow
                      ? context.onSurface.withValues(alpha: 0.05)
                      : context.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: FaIcon(
                  FontAwesomeIcons.clock,
                  size: 18.r,
                  color: isNow ? context.onSurface : context.primary,
                ),
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isNow ? AppStrings.now : AppStrings.timeSelected,
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

class _PaymentMethodSelector extends StatelessWidget {
  const _PaymentMethodSelector({
    this.selectedMethodId,
    required this.onMethodSelected,
  });

  final String? selectedMethodId;
  final ValueChanged<String> onMethodSelected;

  @override
  Widget build(BuildContext context) {
    final methods = [
      _PaymentMethod(
        id: 'visa',
        icon: FontAwesomeIcons.ccVisa,
        label: 'Visa',
        color: const Color(0xFF1A1F71),
      ),
      _PaymentMethod(
        id: 'mastercard',
        icon: FontAwesomeIcons.ccMastercard,
        label: 'Mastercard',
        color: const Color(0xFFEB001B),
      ),
      _PaymentMethod(
        id: 'apple_pay',
        icon: FontAwesomeIcons.applePay,
        label: 'Apple Pay',
        color: Colors.black,
      ),
      _PaymentMethod(
        id: 'google_pay',
        icon: FontAwesomeIcons.googlePay,
        label: 'Google Pay',
        color: const Color(0xFF4285F4),
      ),
      _PaymentMethod(
        id: 'paypal',
        icon: FontAwesomeIcons.paypal,
        label: 'PayPal',
        color: const Color(0xFF003087),
      ),
    ];

    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: REdgeInsets.symmetric(vertical: AppSpacing.xs),
        itemCount: methods.length,
        separatorBuilder: (context, index) => AppSpacing.md.horizontalSpace,
        itemBuilder: (context, index) {
          final method = methods[index];
          final isSelected = selectedMethodId == method.id;

          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onMethodSelected(method.id),
              borderRadius: BorderRadius.circular(AppRadii.lg.r),
              child: AnimatedContainer(
                duration: AppDurations.normal,
                width: 110.w,
                padding: REdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: isSelected
                      ? context.primary.withValues(alpha: 0.08)
                      : context.surface,
                  borderRadius: BorderRadius.circular(AppRadii.lg.r),
                  boxShadow: isSelected ? context.shadows.primary : null,
                  border: Border.all(
                    color: isSelected
                        ? context.primary
                        : context.onSurface.withValues(alpha: 0.1),
                    width: isSelected ? 2.5.r : 1.r,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      method.icon,
                      size: 32.r,
                      color: isSelected ? context.primary : method.color,
                    ),
                    AppSpacing.sm.verticalSpace,
                    Text(
                      method.label,
                      style: AppTextStyles.s12w700.copyWith(
                        color: isSelected ? context.primary : context.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PaymentMethod {
  final String id;
  final IconData icon;
  final String label;
  final Color color;

  _PaymentMethod({
    required this.id,
    required this.icon,
    required this.label,
    required this.color,
  });
}
