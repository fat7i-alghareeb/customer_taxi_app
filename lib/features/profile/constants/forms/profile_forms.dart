import 'package:reactive_forms/reactive_forms.dart';

abstract class ProfileForms {
  static const String nameField = 'name';
  static const String phoneField = 'phone';
  static const String emailField = 'email';

  static FormGroup formGroup({
    String? initialName,
    String? initialPhone,
    String? initialEmail,
  }) {
    return FormGroup({
      nameField: FormControl<String>(
        value: initialName,
        validators: [Validators.required, Validators.minLength(3)],
      ),
      phoneField: FormControl<String>(value: initialPhone),
      emailField: FormControl<String>(
        value: initialEmail,
        validators: [Validators.email],
      ),
    });
  }
}
