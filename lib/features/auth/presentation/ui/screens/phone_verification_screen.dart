import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';
import 'package:pinput/pinput.dart';

import 'package:customertaxi/core/services/session/auth_manager.dart';
import 'package:customertaxi/features/auth/constants/auth_strings.dart';
import 'package:customertaxi/features/auth/constants/forms/auth_forms.dart';
import 'package:customertaxi/features/auth/presentation/states/phone_verification_cubit.dart';

class PhoneVerificationScreen extends StatelessWidget {
  const PhoneVerificationScreen({super.key});
  static const String pagePath = '/phone_verification';
  static const String pageName = 'PhoneVerificationScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PhoneVerificationCubit>(),
      child: const _PhoneVerificationBody(),
    );
  }
}

class _PhoneVerificationBody extends StatefulWidget {
  const _PhoneVerificationBody();

  @override
  State<_PhoneVerificationBody> createState() => _PhoneVerificationBodyState();
}

class _PhoneVerificationBodyState extends State<_PhoneVerificationBody> {
  final _form = AuthForms.phoneVerifyFormGroup();

  @override
  void initState() {
    super.initState();
    final phone = getIt<AuthManager>().state.user?.phone;
    if (phone != null && phone.isNotEmpty) {
      _form.control(AuthForms.phoneField).value = phone;
    }
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 52.w,
      height: 56.h,
      textStyle: AppTextStyles.s24w700.copyWith(color: context.onSurface),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.md.r),
        border: Border.all(color: context.grey),
      ),
    );

    return BlocConsumer<PhoneVerificationCubit, PhoneVerificationState>(
      listenWhen: (p, c) =>
          p.requestStatus != c.requestStatus || p.verifyStatus != c.verifyStatus,
      listener: (context, state) {
        if (state.requestStatus.isFailed) {
          showErrorOverlay(context,
              state.requestStatus.errorMessage ?? AppStrings.somethingWentWrong);
        }
        if (state.verifyStatus.isFailed) {
          showErrorOverlay(context,
              state.verifyStatus.errorMessage ?? AppStrings.somethingWentWrong);
        }
        if (state.verifyStatus.isSuccess) {
          showSuccessOverlay(context, AuthStrings.authPhoneVerified);
          if (context.canPop()) context.pop();
        }
      },
      builder: (context, state) {
        return ReactiveForm(
          formGroup: _form,
          child: AppScaffold.appBar(
            appBarConfig: AppScaffoldAppBarConfig(
              title: AuthStrings.authVerifyYourPhone,
            ),
            scaffoldConfig: AppScaffoldConfig(
              backgroundColor: context.surface,
            ),
            child: Padding(
              padding: REdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppSpacing.xl.verticalSpace,
                  if (!state.otpSent) ...[
                    AppReactiveTextField.phone(
                      formControlName: AuthForms.phoneField,
                      title: AppStrings.phoneNumber,
                      hintText: AppStrings.enterPhone,
                      phoneDefaultIsoCode: 'NL',
                    ),
                    AppSpacing.xl.verticalSpace,
                    ReactiveFormConsumer(
                      builder: (context, form, _) => AppButton.primaryGradient(
                        child: AppButtonChild.label(AppStrings.sendOtp),
                        isActive: form.control(AuthForms.phoneField).valid,
                        isLoading: state.requestStatus.isLoading,
                        onTap: () => context.read<PhoneVerificationCubit>().requestOtp(
                              form.control(AuthForms.phoneField).value as String,
                            ),
                      ),
                    ),
                  ] else ...[
                    Text(
                      AuthStrings.authOtpSentPhone,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.s14w400
                          .copyWith(color: context.onSurfaceVariant),
                    ),
                    AppSpacing.xl.verticalSpace,
                    Center(
                      child: Pinput(
                        length: 6,
                        autofocus: true,
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
                        forceErrorState: state.verifyStatus.isFailed,
                        onCompleted: (pin) =>
                            context.read<PhoneVerificationCubit>().verify(pin),
                      ),
                    ),
                    AppSpacing.lg.verticalSpace,
                    Center(
                      child: state.resendSeconds > 0
                          ? Text(
                              '${AuthStrings.authResendCode} (${state.resendSeconds}s)',
                              style: AppTextStyles.s14w400
                                  .copyWith(color: context.onSurfaceVariant),
                            )
                          : TextButton(
                              onPressed: () =>
                                  context.read<PhoneVerificationCubit>().resend(),
                              child: Text(
                                AuthStrings.authResendCode,
                                style: AppTextStyles.s14w600
                                    .copyWith(color: context.primary),
                              ),
                            ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
