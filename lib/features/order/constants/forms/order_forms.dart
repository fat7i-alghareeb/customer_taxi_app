import 'package:reactive_forms/reactive_forms.dart';

abstract class OrderForms {
  static const String stopsArray = 'stops';
  static const String pickupStreetField = 'pickupStreet';
  static const String pickupHouseNumberField = 'pickupHouseNumber';

  static FormGroup formGroup() {
    return FormGroup({
      stopsArray: FormArray<String>([
        FormControl<String>(validators: [Validators.required]),
        FormControl<String>(validators: [Validators.required]),
      ]),
      pickupStreetField: FormControl<String>(),
      pickupHouseNumberField: FormControl<String>(),
    });
  }
}
