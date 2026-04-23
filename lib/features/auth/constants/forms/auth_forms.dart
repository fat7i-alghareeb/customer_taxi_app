import 'package:reactive_forms/reactive_forms.dart';

abstract class AuthForms {
  static const String phoneField = 'phone';
  static const String otpField = 'otp';

  static FormGroup loginFormGroup() => FormGroup({
        phoneField: FormControl<String>(
          validators: [Validators.required],
        ),
        otpField: FormControl<String>(
          validators: [
            Validators.required,
            Validators.minLength(4),
            Validators.maxLength(4),
          ],
        ),
      });
}
