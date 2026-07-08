import 'package:reactive_forms/reactive_forms.dart';

abstract class AuthForms {
  static const String phoneField = 'phone';
  static const String emailField = 'email';
  static const String nameField = 'name';
  static const String regPhoneField = 'regPhone';
  static const String otpField = 'otp';
  static const String privacyConsentField = 'privacyConsent';
  static const String termsConsentField = 'termsConsent';

  static FormGroup loginFormGroup() => FormGroup({
        phoneField: FormControl<String>(validators: [Validators.required]),
        emailField: FormControl<String>(
          validators: [Validators.required, Validators.email],
        ),
        nameField: FormControl<String>(validators: [Validators.required]),
        regPhoneField: FormControl<String>(validators: [Validators.required]),
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

  /// Form for the standalone phone-verification screen (post-login).
  static FormGroup phoneVerifyFormGroup() => FormGroup({
        phoneField: FormControl<String>(validators: [Validators.required]),
        otpField: FormControl<String>(
          validators: [
            Validators.required,
            Validators.minLength(6),
            Validators.maxLength(6),
          ],
        ),
      });
}
