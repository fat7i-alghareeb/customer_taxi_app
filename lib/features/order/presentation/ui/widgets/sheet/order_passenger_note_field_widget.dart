import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/order/constants/forms/order_forms.dart';
import 'package:customertaxi/features/order/presentation/states/order_bloc.dart';

class OrderPassengerNoteFieldWidget extends StatefulWidget {
  const OrderPassengerNoteFieldWidget({super.key, required this.note});

  final String note;

  @override
  State<OrderPassengerNoteFieldWidget> createState() =>
      _OrderPassengerNoteFieldWidgetState();
}

class _OrderPassengerNoteFieldWidgetState
    extends State<OrderPassengerNoteFieldWidget> {
  late final FormGroup _form;

  @override
  void initState() {
    super.initState();
    _form = OrderForms.passengerNoteFormGroup(value: widget.note);
  }

  @override
  void didUpdateWidget(covariant OrderPassengerNoteFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final control = _form.control(OrderForms.passengerNoteField);
    if (oldWidget.note != widget.note && control.value != widget.note) {
      control.value = widget.note;
    }
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppReactiveTextField.text(
      formGroup: _form,
      formControlName: OrderForms.passengerNoteField,
      title: AppStrings.passengerNoteToDriver,
      hintText: AppStrings.passengerNoteToDriverHint,
      minLines: 2,
      maxLines: 4,
      textInputAction: TextInputAction.newline,
      onChangedDebounced: (value, _) {
        context.read<OrderBloc>().add(OrderEvent.passengerNoteChanged(value));
      },
    );
  }
}
