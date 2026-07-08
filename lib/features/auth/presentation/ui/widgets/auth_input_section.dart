import 'package:customertaxi/common/imports/imports.dart';

import 'package:customertaxi/features/auth/constants/auth_strings.dart';
import 'package:customertaxi/features/auth/constants/forms/auth_forms.dart';
import 'package:customertaxi/features/auth/presentation/states/auth_bloc.dart';

class AuthInputSection extends StatelessWidget {
  const AuthInputSection({super.key, required this.form});

  final FormGroup form;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (p, c) => p.method != c.method,
      builder: (context, state) {
        final isEmail = state.method == AuthMethod.email;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            (isEmail
                    ? AppReactiveTextField.email(
                        formControlName: AuthForms.emailField,
                        title: AuthStrings.authEmail,
                        hintText: AuthStrings.authEnterEmail,
                      )
                    : AppReactiveTextField.phone(
                        formControlName: AuthForms.phoneField,
                        title: AppStrings.phoneNumber,
                        hintText: AppStrings.enterPhone,
                        phoneDefaultIsoCode: 'NL',
                      ))
                .animate()
                .fadeIn(delay: 80.ms, duration: 350.ms)
                .slideY(begin: 0.2, curve: Curves.easeOutCubic),
            AppSpacing.sm.verticalSpace,
            Text(
              isEmail
                  ? AppStrings.authEmailInputHelper
                  : AppStrings.authPhoneInputHelper,
              style: AppTextStyles.s12w400
                  .copyWith(color: context.onSurfaceVariant),
            ).animate().fadeIn(delay: 160.ms, duration: 300.ms),
            AppSpacing.lg.verticalSpace,
            // Own consumer so submit-loading rebuilds only the button.
            ReactiveFormConsumer(
              builder: (context, form, _) {
                final field =
                    isEmail ? AuthForms.emailField : AuthForms.phoneField;
                return BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (p, c) => p.requestStatus != c.requestStatus,
                  builder: (context, s) => AppButton.primaryGradient(
                    child: AppButtonChild.label(AuthStrings.authContinue),
                    isActive: form.control(field).valid,
                    isLoading: s.requestStatus.isLoading,
                    onTap: () {
                      final value = form.control(field).value as String;
                      context.read<AuthBloc>().add(
                            isEmail
                                ? AuthEvent.emailSubmitted(value)
                                : AuthEvent.phoneSubmitted(value),
                          );
                    },
                  ),
                );
              },
            ).animate().fadeIn(delay: 200.ms, duration: 350.ms),
          ],
        );
      },
    );
  }
}
