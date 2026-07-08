import 'dart:math' as math;

import 'package:customertaxi/common/imports/imports.dart';
import 'package:pinput/pinput.dart';

import 'package:customertaxi/features/auth/constants/auth_strings.dart';
import 'package:customertaxi/features/auth/constants/forms/auth_forms.dart';
import 'package:customertaxi/features/auth/presentation/states/auth_bloc.dart';

class AuthOtpSection extends StatefulWidget {
  const AuthOtpSection({super.key, required this.form});

  final FormGroup form;

  @override
  State<AuthOtpSection> createState() => _AuthOtpSectionState();
}

class _AuthOtpSectionState extends State<AuthOtpSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shake = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
  );

  @override
  void dispose() {
    _shake.dispose();
    super.dispose();
  }

  double get _shakeOffset {
    // Damped horizontal oscillation.
    final t = _shake.value;
    return math.sin(t * math.pi * 4) * 10 * (1 - t);
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

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (p, c) =>
          !p.sessionStatus.isFailed && c.sessionStatus.isFailed,
      listener: (_, _) => _shake.forward(from: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Pinput reacts only to session status (loading/failed), never to the
          // per-second resend tick.
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (p, c) => p.sessionStatus != c.sessionStatus,
            builder: (context, state) {
              return Center(
                child: AnimatedBuilder(
                  animation: _shake,
                  builder: (context, child) => Transform.translate(
                    offset: Offset(_shakeOffset, 0),
                    child: child,
                  ),
                  child: Pinput(
                    length: 6,
                    autofocus: true,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(color: context.primary, width: 1.5),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(color: context.error),
                      ),
                    ),
                    forceErrorState: state.sessionStatus.isFailed,
                    onCompleted: (pin) {
                      widget.form.control(AuthForms.otpField).value = pin;
                      context.read<AuthBloc>().add(AuthEvent.otpSubmitted(pin));
                    },
                    onChanged: (pin) =>
                        widget.form.control(AuthForms.otpField).value = pin,
                  ),
                ),
              );
            },
          ),
          AppSpacing.xl.verticalSpace,
          ReactiveFormConsumer(
            builder: (context, form, _) {
              return BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (p, c) => p.sessionStatus != c.sessionStatus,
                builder: (context, state) => AppButton.primaryGradient(
                  child: AppButtonChild.label(AppStrings.verifyOtp),
                  isActive: form.control(AuthForms.otpField).valid,
                  isLoading: state.sessionStatus.isLoading,
                  onTap: () {
                    final otp =
                        form.control(AuthForms.otpField).value as String;
                    context.read<AuthBloc>().add(AuthEvent.otpSubmitted(otp));
                  },
                ),
              );
            },
          ),
          AppSpacing.md.verticalSpace,
          // Only this row rebuilds every second.
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (p, c) => p.resendSeconds != c.resendSeconds,
            builder: (context, state) => Center(
              child: state.resendSeconds > 0
                  ? Text(
                      '${AuthStrings.authResendCode} (${state.resendSeconds}s)',
                      style: AppTextStyles.s14w400
                          .copyWith(color: context.onSurfaceVariant),
                    )
                  : TextButton(
                      onPressed: () => context
                          .read<AuthBloc>()
                          .add(const AuthEvent.resendRequested()),
                      child: Text(
                        AuthStrings.authResendCode,
                        style: AppTextStyles.s14w600
                            .copyWith(color: context.primary),
                      ),
                    ).animate().fadeIn(duration: 250.ms),
            ),
          ),
          AppSpacing.md.verticalSpace,
          Center(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () =>
                  context.read<AuthBloc>().add(const AuthEvent.backRequested()),
              child: Text(
                AppStrings.authOtpChangeDestination,
                style: AppTextStyles.s14w400
                    .copyWith(color: context.onSurfaceVariant),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
