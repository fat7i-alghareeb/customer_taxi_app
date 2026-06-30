import 'package:reactive_forms/reactive_forms.dart';

abstract class RefundIssueForms {
  static const String noteField = 'note';

  static FormGroup formGroup() => FormGroup({noteField: FormControl<String>()});
}
