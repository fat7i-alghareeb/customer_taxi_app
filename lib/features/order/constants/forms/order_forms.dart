import 'package:reactive_forms/reactive_forms.dart';

abstract class OrderForms {
  static const String fromField = 'from';
  static const String toField = 'to';
  static const String pickupStreetField = 'pickupStreet';
  static const String pickupHouseNumberField = 'pickupHouseNumber';

  static FormGroup formGroup() {
    return FormGroup({
      fromField: FormControl<String>(validators: [Validators.required]),
      toField: FormControl<String>(validators: [Validators.required]),
      pickupStreetField: FormControl<String>(),
      pickupHouseNumberField: FormControl<String>(),
    });
  }
}
