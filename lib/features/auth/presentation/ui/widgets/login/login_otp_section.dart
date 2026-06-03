import 'package:customertaxi/common/imports/imports.dart';
import 'package:pinput/pinput.dart';

import 'package:customertaxi/features/auth/constants/forms/auth_forms.dart';
import 'package:customertaxi/features/auth/presentation/states/auth_bloc.dart';
import 'package:customertaxi/features/root/presentation/ui/screens/privacy_policy_screen.dart';
import 'package:customertaxi/features/root/presentation/ui/screens/terms_and_conditions_screen.dart';

class LoginOtpSection extends StatelessWidget {
  const LoginOtpSection({
    super.key,
    required this.form,
  });

  final FormGroup form;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: AppTextStyles.s24w700.copyWith(color: context.onSurface),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.md.r),
        border: Border.all(color: context.grey),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Column(
                children: [
                  Pinput(
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(color: context.primary),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(color: context.error),
                      ),
                    ),
                    forceErrorState: state.otpStatus.isFailed,
                    onCompleted: (pin) {
                      form.control(AuthForms.otpField).value = pin;
                      final privacyOk =
                          (form.control(AuthForms.privacyConsentField).value
                                  as bool?) ??
                              false;
                      final termsOk =
                          (form.control(AuthForms.termsConsentField).value
                                  as bool?) ??
                              false;
                      if (privacyOk && termsOk) {
                        context
                            .read<AuthBloc>()
                            .add(AuthEvent.verifyOtpRequested(pin));
                      }
                    },
                    onChanged: (pin) {
                      form.control(AuthForms.otpField).value = pin;
                    },
                  ),
                  if (state.otpStatus.isFailed) ...[
                    AppSpacing.sm.verticalSpace,
                    Text(
                      AppStrings.invalidOtp,
                      style:
                          AppTextStyles.s14w400.copyWith(color: context.error),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
        AppSpacing.xl.verticalSpace,
        ConsentCheckbox(
          formControlName: AuthForms.privacyConsentField,
          prefixLabel: AppStrings.consentPrivacyPrefix,
          linkLabel: AppStrings.consentPrivacyLinkLabel,
          onLinkTap: () =>
              context.pushNamed(PrivacyPolicyScreen.pageName),
        ),
        AppSpacing.sm.verticalSpace,
        ConsentCheckbox(
          formControlName: AuthForms.termsConsentField,
          prefixLabel: AppStrings.consentTermsPrefix,
          linkLabel: AppStrings.consentTermsLinkLabel,
          onLinkTap: () =>
              context.pushNamed(TermsAndConditionsScreen.pageName),
        ),
        AppSpacing.xl.verticalSpace,
        ReactiveFormConsumer(
          builder: (context, form, child) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final otpValid = form.control(AuthForms.otpField).valid;
                final privacyAccepted =
                    (form.control(AuthForms.privacyConsentField).value as bool?) ??
                        false;
                final termsAccepted =
                    (form.control(AuthForms.termsConsentField).value as bool?) ??
                        false;
                return AppButton.primaryGradient(
                  child: AppButtonChild.label(AppStrings.verifyOtp),
                  isActive: otpValid && privacyAccepted && termsAccepted,
                  isLoading: state.otpStatus.isLoading,
                  onTap: () {
                    final otp =
                        form.control(AuthForms.otpField).value as String;
                    context
                        .read<AuthBloc>()
                        .add(AuthEvent.verifyOtpRequested(otp));
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
