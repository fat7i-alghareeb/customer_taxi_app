import 'package:reactive_forms/reactive_forms.dart';

abstract class ProfileForms {
  static const String nameField = 'name';

  static FormGroup formGroup({String? initialName}) {
    return FormGroup({
      nameField: FormControl<String>(
        value: initialName,
        validators: [
          Validators.required,
          Validators.minLength(3),
        ],
      ),
    });
  }
}
