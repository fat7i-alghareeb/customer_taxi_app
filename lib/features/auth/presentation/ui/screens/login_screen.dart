// cspell:ignore oranje
import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';
import 'package:customertaxi/features/auth/domain/facade/auth_facade.dart';

import 'package:customertaxi/features/auth/constants/auth_strings.dart';
import 'package:customertaxi/features/auth/constants/forms/auth_forms.dart';
import 'package:customertaxi/features/auth/presentation/states/auth_bloc.dart';
import 'package:customertaxi/features/auth/presentation/ui/widgets/login/login_landing_section.dart';
import 'package:customertaxi/features/auth/presentation/ui/widgets/auth_landing_section.dart';
import 'package:customertaxi/features/auth/presentation/ui/widgets/auth_input_section.dart';
import 'package:customertaxi/features/auth/presentation/ui/widgets/auth_otp_section.dart';
import 'package:customertaxi/features/auth/presentation/ui/widgets/auth_registration_section.dart';
import 'package:customertaxi/features/auth/presentation/ui/screens/phone_verification_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String pagePath = '/login_screen';
  static const String pageName = 'LoginScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>()..add(const AuthEvent.started()),
      child: const _LoginScreenBody(),
    );
  }
}

class _LoginScreenBody extends StatefulWidget {
  const _LoginScreenBody();

  @override
  State<_LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<_LoginScreenBody> {
  final _form = AuthForms.loginFormGroup();

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      // Only rebuild the chrome/step on navigation changes; per-status rebuilds
      // happen inside each section (so entrance animations don't replay).
      buildWhen: (p, c) => p.step != c.step || p.mode != c.mode,
      listenWhen: (p, c) =>
          p.requestStatus != c.requestStatus ||
          p.sessionStatus != c.sessionStatus ||
          p.step != c.step,
      listener: (context, state) {
        if (state.requestStatus.isFailed) {
          showErrorOverlay(
            context,
            state.requestStatus.errorMessage ?? AppStrings.somethingWentWrong,
          );
        }
        if (state.sessionStatus.isFailed) {
          showErrorOverlay(
            context,
            state.sessionStatus.errorMessage ?? AppStrings.somethingWentWrong,
          );
        }
        if (state.sessionStatus.isSuccess) {
          final session = state.sessionStatus.getDataWhenSuccess;
          if (session != null && session.accountAlreadyExists) {
            showDialog(
              context: context,
              barrierDismissible: false,
              useRootNavigator: true,
              builder: (_) => const _ExistingAccountDialog(),
            );
          }
          // AuthManager persisted the session → the router redirects into the app.
          // For a "Verify now" registration, jump to phone verification on top.
          if (state.routeToPhoneVerification) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                context.pushNamed(PhoneVerificationScreen.pageName);
              }
            });
          }
        }
      },
      builder: (context, state) {
        final isIntro = state.step == AuthStep.intro;
        return PopScope(
          canPop: isIntro,
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) return;
            context.read<AuthBloc>().add(const AuthEvent.backRequested());
          },
          child: ReactiveForm(
            formGroup: _form,
            child: isIntro ? _buildIntro(context) : _buildSteps(context, state),
          ),
        );
      },
    );
  }

  /// The original branded landing (bg image + tagline + discount + Aanmelden/Inloggen).
  Widget _buildIntro(BuildContext context) {
    return AppScaffold.body(
      scaffoldConfig: const AppScaffoldConfig(
        backgroundColor: Colors.black,
        safeArea: [],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Assets.images.loginLandingBg.image(fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.4),
                  ],
                ),
              ),
            ),
          ),
          SizedBox.expand(
            child: Padding(
              padding: REdgeInsets.only(
                left: AppSpacing.xl,
                right: AppSpacing.xl,
                top: AppSpacing.lg,
                bottom: AppSpacing.xxl,
              ),
              child: const LoginLandingSection(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSteps(BuildContext context, AuthState state) {
    return AppScaffold.body(
      scaffoldConfig: AppScaffoldConfig(
        backgroundColor: context.surface,
        safeArea: const [],
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: REdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.xl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _TopBar(step: state.step),
                    AppSpacing.md.verticalSpace,
                    Center(
                      child: Assets.images.oranjeLogo.image(
                        height: 96.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                    AppSpacing.xl.verticalSpace,
                    _Header(state: state)
                        .animate(key: ValueKey('h_${state.step}_${state.mode}'))
                        .fadeIn(duration: 400.ms, curve: Curves.easeOut)
                        .slideY(begin: 0.25, curve: Curves.easeOutCubic),
                    (AppSpacing.xxl).verticalSpace,
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeIn,
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.12, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: _buildStep(context, state),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context, AuthState state) {
    switch (state.step) {
      case AuthStep.intro:
        return const SizedBox.shrink();
      case AuthStep.landing:
        return AuthLandingSection(key: const ValueKey('landing'), form: _form);
      case AuthStep.phoneInput:
      case AuthStep.emailInput:
        return AuthInputSection(key: const ValueKey('input'), form: _form);
      case AuthStep.otp:
        return AuthOtpSection(key: const ValueKey('otp'), form: _form);
      case AuthStep.registration:
        return AuthRegistrationSection(
          key: const ValueKey('registration'),
          form: _form,
        );
    }
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.step});
  final AuthStep step;

  @override
  Widget build(BuildContext context) {
    if (step == AuthStep.intro) return const SizedBox.shrink();
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () =>
            context.read<AuthBloc>().add(const AuthEvent.backRequested()),
        icon: FaIcon(context.chevronStart, size: 20.r, color: context.onSurface),
      ),
    );
  }
}

class _ExistingAccountDialog extends StatefulWidget {
  const _ExistingAccountDialog();

  @override
  State<_ExistingAccountDialog> createState() => _ExistingAccountDialogState();
}

class _ExistingAccountDialogState extends State<_ExistingAccountDialog> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AuthStrings.authAlreadyHaveAccount),
      content: Text(AuthStrings.authExistingAccountBody),
      actions: [
        TextButton(
          onPressed: _loading ? null : () => Navigator.pop(context),
          child: Text(AuthStrings.authContinue),
        ),
        FilledButton(
          onPressed: _loading ? null : _onFreshStart,
          child: _loading
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(AuthStrings.authStartFresh),
        ),
      ],
    );
  }

  Future<void> _onFreshStart() async {
    setState(() => _loading = true);
    await getIt<AuthFacade>().freshStart();
    if (mounted) Navigator.pop(context);
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.state});
  final AuthState state;

  /// OTP subtitle showing exactly where the code was sent, when known.
  String _otpSubtitle(AuthState state) {
    final destination = state.pendingPhone ?? state.pendingEmail;
    if (destination != null && destination.isNotEmpty) {
      return AppStrings.authOtpSentTo.replaceFirst('{destination}', destination);
    }
    final isEmail = state.otpContext == OtpContext.emailLogin ||
        state.otpContext == OtpContext.emailSignup;
    return isEmail ? AppStrings.authOtpSentEmail : AppStrings.authOtpSentPhone;
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = state.mode == AuthMode.login;
    final (title, subtitle) = switch (state.step) {
      AuthStep.intro => ('', ''),
      AuthStep.landing => (
          isLogin
              ? AppStrings.authWelcomeBack
              : AppStrings.authCreateAccountTitle,
          isLogin ? AppStrings.authLoginSubtitle : AppStrings.authSignupSubtitle,
        ),
      AuthStep.phoneInput => (AppStrings.phoneNumber, AppStrings.enterPhone),
      AuthStep.emailInput => (AppStrings.authEmail, AppStrings.authEnterEmail),
      AuthStep.otp => (AppStrings.otp, _otpSubtitle(state)),
      AuthStep.registration => (
          AppStrings.authNameStepTitle,
          AppStrings.authRegistrationSubtitle,
        ),
    };

    return Column(
      children: [
        if (state.step == AuthStep.landing) ...[
          _ModeBadge(mode: state.mode),
          AppSpacing.md.verticalSpace,
        ],
        Text(
          title,
          style: AppTextStyles.s28w700.copyWith(color: context.onSurface),
          textAlign: TextAlign.center,
        ),
        AppSpacing.xs.verticalSpace,
        Text(
          subtitle,
          style: AppTextStyles.s14w400.copyWith(color: context.onSurfaceVariant),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// A prominent pill showing the current mode. Login is outlined, Sign-up is
/// filled — an unmistakable visual difference between the two flows.
class _ModeBadge extends StatelessWidget {
  const _ModeBadge({required this.mode});
  final AuthMode mode;

  @override
  Widget build(BuildContext context) {
    final isLogin = mode == AuthMode.login;
    final label = isLogin ? AppStrings.authLogIn : AppStrings.authSignUp;
    final icon =
        isLogin ? FontAwesomeIcons.rightToBracket : FontAwesomeIcons.userPlus;
    final fg = isLogin ? context.primary : context.onPrimary;
    final bg = isLogin
        ? context.primary.withValues(alpha: 0.10)
        : context.primary;
    final border =
        isLogin ? Border.all(color: context.primary, width: 1.5) : null;

    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: border,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(icon, size: 13.r, color: fg),
          AppSpacing.sm.horizontalSpace,
          Text(
            label.toUpperCase(),
            style: AppTextStyles.s12w700
                .copyWith(color: fg, letterSpacing: 0.6),
          ),
        ],
      ),
    );
  }
}
