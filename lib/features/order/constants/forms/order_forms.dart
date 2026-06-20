import 'package:reactive_forms/reactive_forms.dart';

abstract class OrderForms {
  static const String stopsArray = 'stops';
  static const String passengerNoteField = 'passengerNote';
  static const String flightNumberField = 'flightNumber';

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

  static FormGroup flightNumberFormGroup({String? value}) {
    return FormGroup({
      flightNumberField: FormControl<String>(
        value: value,
        validators: [
          Validators.required,
          Validators.minLength(2),
          Validators.maxLength(15),
          Validators.pattern(
            RegExp(r'^[A-Za-z0-9](?:[A-Za-z0-9 -]{0,13}[A-Za-z0-9])?$'),
          ),
        ],
      ),
    });
  }
}
