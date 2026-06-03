import 'package:reactive_forms/reactive_forms.dart';

abstract class AuthForms {
  static const String phoneField = 'phone';
  static const String otpField = 'otp';
  static const String privacyConsentField = 'privacyConsent';
  static const String termsConsentField = 'termsConsent';

  static FormGroup loginFormGroup() => FormGroup({
        phoneField: FormControl<String>(
          validators: [Validators.required],
        ),
        otpField: FormControl<String>(
          validators: [
            Validators.required,
            Validators.minLength(6),
            Validators.maxLength(6),
          ],
        ),
        privacyConsentField: FormControl<bool>(
          value: false,
          validators: [Validators.requiredTrue],
        ),
        termsConsentField: FormControl<bool>(
          value: false,
          validators: [Validators.requiredTrue],
        ),
      });
}
