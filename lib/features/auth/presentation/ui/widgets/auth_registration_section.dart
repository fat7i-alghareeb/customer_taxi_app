import 'package:customertaxi/common/imports/imports.dart';

import 'package:customertaxi/features/auth/constants/auth_strings.dart';
import 'package:customertaxi/features/auth/constants/forms/auth_forms.dart';
import 'package:customertaxi/features/auth/presentation/states/auth_bloc.dart';

class AuthRegistrationSection extends StatefulWidget {
  const AuthRegistrationSection({super.key, required this.form});

  final FormGroup form;

  @override
  State<AuthRegistrationSection> createState() =>
      _AuthRegistrationSectionState();
}

class _AuthRegistrationSectionState extends State<AuthRegistrationSection> {
  @override
  void initState() {
    super.initState();
    // Prefill name from the Google display name when available.
    final prefill = context.read<AuthBloc>().state.registrationName;
    if (prefill != null && prefill.isNotEmpty) {
      widget.form.control(AuthForms.nameField).value = prefill;
    }
  }

  void _submit({required bool verifyNow}) {
    final name = widget.form.control(AuthForms.nameField).value as String;
    final phone = widget.form.control(AuthForms.regPhoneField).value as String;
    context.read<AuthBloc>().add(
          AuthEvent.registrationSubmitted(
            name: name,
            phone: phone,
            verifyNow: verifyNow,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppReactiveTextField.text(
          formControlName: AuthForms.nameField,
          title: AuthStrings.authName,
          hintText: AuthStrings.authEnterName,
        )
            .animate()
            .fadeIn(delay: 80.ms, duration: 350.ms)
            .slideY(begin: 0.2, curve: Curves.easeOutCubic),
        AppSpacing.lg.verticalSpace,
        AppReactiveTextField.phone(
          formControlName: AuthForms.regPhoneField,
          title: AuthStrings.authAddPhone,
          hintText: AppStrings.enterPhone,
          phoneDefaultIsoCode: 'NL',
        )
            .animate()
            .fadeIn(delay: 170.ms, duration: 350.ms)
            .slideY(begin: 0.2, curve: Curves.easeOutCubic),
        AppSpacing.sm.verticalSpace,
        Text(
          AuthStrings.authPhoneUnverifiedInline,
          style:
              AppTextStyles.s12w400.copyWith(color: context.onSurfaceVariant),
        ).animate().fadeIn(delay: 240.ms, duration: 300.ms),
        AppSpacing.xl.verticalSpace,
        ReactiveFormConsumer(
          builder: (context, form, _) {
            final valid = form.control(AuthForms.nameField).valid &&
                form.control(AuthForms.regPhoneField).valid;
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final loading = state.sessionStatus.isLoading;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppButton.primaryGradient(
                      child: AppButtonChild.label(AppStrings.authVerifyNow),
                      isActive: valid && !loading,
                      isLoading: loading,
                      onTap: () => _submit(verifyNow: true),
                    ),
                    AppSpacing.lg.verticalSpace,
                    Center(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (valid && !loading)
                            ? () => _submit(verifyNow: false)
                            : null,
                        child: Text(
                          AppStrings.authSkipForNow,
                          style: AppTextStyles.s14w600.copyWith(
                            color: (valid && !loading)
                                ? context.onSurfaceVariant
                                : context.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
