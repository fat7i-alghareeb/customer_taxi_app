import 'package:reactive_forms/reactive_forms.dart';

abstract class OrderForms {
  static const String stopsArray = 'stops';
  static const String passengerNoteField = 'passengerNote';

  static FormGroup formGroup() {
    return FormGroup({
      stopsArray: FormArray<String>([
        FormControl<String>(validators: [Validators.required]),
        FormControl<String>(validators: [Validators.required]),
      ]),
    });
  }

  static FormGroup passengerNoteFormGroup({String? value}) {
    return FormGroup({
      passengerNoteField: FormControl<String>(
        value: value,
        validators: [Validators.maxLength(500)],
      ),
    });
  }
}
