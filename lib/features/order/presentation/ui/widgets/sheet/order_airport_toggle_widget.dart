import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/order/constants/forms/order_forms.dart';
import 'package:customertaxi/features/order/presentation/states/order_bloc.dart';

/// Read-only airport pickup indicator with the required flight-number field.
class OrderAirportToggleWidget extends StatefulWidget {
  const OrderAirportToggleWidget({super.key, required this.flightNumber});

  final String flightNumber;

  @override
  State<OrderAirportToggleWidget> createState() =>
      _OrderAirportToggleWidgetState();
}

class _OrderAirportToggleWidgetState extends State<OrderAirportToggleWidget> {
  late final FormGroup _form;

  @override
  void initState() {
    super.initState();
    _form = OrderForms.flightNumberFormGroup(value: widget.flightNumber);
  }

  @override
  void didUpdateWidget(covariant OrderAirportToggleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final control = _form.control(OrderForms.flightNumberField);
    if (oldWidget.flightNumber != widget.flightNumber &&
        control.value != widget.flightNumber) {
      control.value = widget.flightNumber;
    }
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return Container(
      padding: REdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(AppRadii.md.r),
        border: Border.all(color: colors.primary.withValues(alpha: 0.22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              FaIcon(FontAwesomeIcons.plane, size: 16.r, color: colors.primary),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.orderAirportDetectedTitle,
                      style: AppTextStyles.s14w600.copyWith(
                        color: colors.onSurface,
                      ),
                    ),
                    Text(
                      AppStrings.orderAirportDetectedSubtitle,
                      style: AppTextStyles.s12w400.copyWith(
                        color: colors.onSurface.withValues(alpha: 0.65),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.md.verticalSpace,
          AppReactiveTextField.text(
            formGroup: _form,
            formControlName: OrderForms.flightNumberField,
            title: AppStrings.flightNumber,
            hintText: AppStrings.flightNumberHint,
            isRequired: true,
            textInputAction: TextInputAction.done,
            textDirectionMode: AppFieldTextDirectionMode.ltr,
            validation: AppTextFieldValidation(
              messages: {
                ValidationMessage.required: (_) =>
                    AppStrings.flightNumberRequired,
                ValidationMessage.minLength: (_) =>
                    AppStrings.flightNumberInvalid,
                ValidationMessage.maxLength: (_) =>
                    AppStrings.flightNumberInvalid,
                ValidationMessage.pattern: (_) =>
                    AppStrings.flightNumberInvalid,
              },
            ),
            onChanged: (value, _) {
              context.read<OrderBloc>().add(
                OrderEvent.flightNumberChanged(value.toUpperCase()),
              );
            },
          ),
        ],
      ),
    );
  }
}
