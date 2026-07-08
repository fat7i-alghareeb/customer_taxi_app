import 'package:flutter/services.dart';

import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';

import 'package:customertaxi/features/auth/constants/forms/auth_forms.dart';
import 'package:customertaxi/features/auth/presentation/states/auth_bloc.dart';
import 'package:customertaxi/features/root/presentation/ui/screens/privacy_policy_screen.dart';
import 'package:customertaxi/features/root/presentation/ui/screens/terms_and_conditions_screen.dart';

/// The method-chooser step (the "login / sign-up page").
///
/// Login vs. Sign-up mode is chosen on the branded intro and can be flipped
/// here via the bottom switch link. Methods are presented as tappable tiles
/// (no buttons); Google sits at the bottom under an "or continue with" divider.
class AuthLandingSection extends StatefulWidget {
  const AuthLandingSection({super.key, required this.form});

  final FormGroup form;

  @override
  State<AuthLandingSection> createState() => _AuthLandingSectionState();
}

class _AuthLandingSectionState extends State<AuthLandingSection> {
  /// Toggled when a muted (consent-gated) tile is tapped, to reveal the
  /// consent hint without rebuilding — and replaying the entrance of — the
  /// whole section.
  final ValueNotifier<bool> _showConsentHint = ValueNotifier(false);

  @override
  void dispose() {
    _showConsentHint.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _MethodTiles(
              onBlockedTap: () {
                _showConsentHint.value = true;
                showErrorOverlay(context, AppStrings.consentMustAcceptError);
              },
            )
            .animate()
            .fadeIn(delay: 150.ms, duration: 400.ms)
            .slideY(begin: 0.2, curve: Curves.easeOutCubic),
        AppSpacing.xl.verticalSpace,
        _ConsentGate(showHint: _showConsentHint)
            .animate()
            .fadeIn(delay: 280.ms, duration: 350.ms)
            .slideY(begin: 0.15, curve: Curves.easeOutCubic),
        AppSpacing.lg.verticalSpace,
        const _ModeSwitchLink().animate().fadeIn(
          delay: 380.ms,
          duration: 350.ms,
        ),
      ],
    );
  }
}

/// Phone / Email / Google as tiles. Owns its own form + bloc consumers so
/// consent toggles only rebuild here (no entrance replay).
class _MethodTiles extends StatelessWidget {
  const _MethodTiles({required this.onBlockedTap});

  final VoidCallback onBlockedTap;

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, _) {
        final consented =
            ((form.control(AuthForms.privacyConsentField).value as bool?) ??
                false) &&
            ((form.control(AuthForms.termsConsentField).value as bool?) ??
                false);
        return BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (p, c) =>
              p.requestStatus != c.requestStatus || p.method != c.method,
          builder: (context, state) {
            final loading = state.requestStatus.isLoading;
            final active = consented && !loading;

            void select(AuthMethod method) =>
                context.read<AuthBloc>().add(AuthEvent.methodSelected(method));

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _AuthMethodTile(
                  featured: true,
                  icon: IconSource.faIcon(FontAwesomeIcons.phone),
                  title: AppStrings.authContinueWithPhone,
                  subtitle: AppStrings.authMethodPhoneSubtitle,
                  enabled: active,
                  onTap: () => select(AuthMethod.phone),
                  onBlockedTap: onBlockedTap,
                ),
                AppSpacing.md.verticalSpace,
                _AuthMethodTile(
                  icon: IconSource.faIcon(FontAwesomeIcons.envelope),
                  title: AppStrings.authContinueWithEmail,
                  subtitle: AppStrings.authMethodEmailSubtitle,
                  enabled: active,
                  onTap: () => select(AuthMethod.email),
                  onBlockedTap: onBlockedTap,
                ),
                AppSpacing.lg.verticalSpace,
                const _OrDivider(),
                AppSpacing.lg.verticalSpace,
                _AuthMethodTile(
                  tintIcon: false,
                  icon: IconSource.asset(
                    Assets.images.googleIconeSymboleLogoPng.path,
                    size: 22,
                  ),
                  title: AppStrings.authContinueWithGoogle,
                  subtitle: AppStrings.authMethodGoogleSubtitle,
                  enabled: active,
                  loading: loading && state.method == AuthMethod.google,
                  onTap: () => select(AuthMethod.google),
                  onBlockedTap: onBlockedTap,
                ),
              ],
            );
          },
        );
      },
    );
  }
}

/// A single tappable auth-method row (card). Not a button.
class _AuthMethodTile extends StatelessWidget {
  const _AuthMethodTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.enabled,
    required this.onTap,
    required this.onBlockedTap,
    this.loading = false,
    this.featured = false,
    this.tintIcon = true,
  });

  final IconSource icon;
  final String title;
  final String subtitle;
  final bool enabled;
  final bool loading;
  final bool featured;

  /// When false, the icon keeps its own colors (e.g. the multicolor Google
  /// logo) instead of being tinted to match the foreground.
  final bool tintIcon;

  final VoidCallback onTap;
  final VoidCallback onBlockedTap;

  @override
  Widget build(BuildContext context) {
    final tappable = !loading;
    final bg = featured
        ? context.primary.withValues(alpha: 0.08)
        : context.surfaceContainer;
    final borderColor = featured
        ? context.primary.withValues(alpha: 0.45)
        : context.grey.withValues(alpha: 0.35);

    final badgeBg = featured
        ? context.primary.withValues(alpha: 0.15)
        : context.surface;
    final iconColor = featured ? context.primary : context.onSurface;

    final leading = SizedBox.square(
      dimension: 42.r,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: badgeBg,
          borderRadius: BorderRadius.circular(AppRadii.md.r),
        ),
        child: Center(
          child: tintIcon
              ? icon.build(context, size: 20, color: iconColor)
              : icon.build(context, size: 22),
        ),
      ),
    );

    final trailing = loading
        ? SizedBox.square(
            dimension: 18.r,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: context.onSurfaceVariant,
            ),
          )
        : FaIcon(
            context.chevronEnd,
            size: 16.r,
            color: context.onSurfaceVariant,
          );

    final radius = BorderRadius.circular(AppRadii.lg.r);

    return AnimatedOpacity(
      duration: AppDurations.fast,
      opacity: enabled || loading ? 1 : 0.5,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: radius,
            border: Border.all(color: borderColor),
          ),
          child: InkWell(
            borderRadius: radius,
            onTap: !tappable ? null : (enabled ? onTap : onBlockedTap),
            child: Padding(
              padding: REdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              child: Row(
                children: [
                  leading,
                  AppSpacing.md.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.s16w600.copyWith(
                            color: context.onSurface,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: AppTextStyles.s12w400.copyWith(
                            color: context.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.sm.horizontalSpace,
                  trailing,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// "─── or continue with ───"
class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    final line = Expanded(
      child: Divider(color: context.grey.withValues(alpha: 0.4), thickness: 1),
    );
    return Row(
      children: [
        line,
        Padding(
          padding: REdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            AppStrings.authOrContinueWith,
            style: AppTextStyles.s12w400.copyWith(
              color: context.onSurfaceVariant,
            ),
          ),
        ),
        line,
      ],
    );
  }
}

/// The two required consent checkboxes plus an inline hint shown when a
/// muted method tile is tapped before both are accepted.
class _ConsentGate extends StatelessWidget {
  const _ConsentGate({required this.showHint});

  final ValueNotifier<bool> showHint;

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, _) {
        final consented =
            ((form.control(AuthForms.privacyConsentField).value as bool?) ??
                false) &&
            ((form.control(AuthForms.termsConsentField).value as bool?) ??
                false);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ConsentCheckbox(
              formControlName: AuthForms.privacyConsentField,
              prefixLabel: AppStrings.consentPrivacyPrefix,
              linkLabel: AppStrings.consentPrivacyLinkLabel,
              onLinkTap: () => context.pushNamed(PrivacyPolicyScreen.pageName),
            ),
            AppSpacing.xs.verticalSpace,
            ConsentCheckbox(
              formControlName: AuthForms.termsConsentField,
              prefixLabel: AppStrings.consentTermsPrefix,
              linkLabel: AppStrings.consentTermsLinkLabel,
              onLinkTap: () =>
                  context.pushNamed(TermsAndConditionsScreen.pageName),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: showHint,
              builder: (context, show, _) {
                if (!show || consented) return const SizedBox.shrink();
                return Padding(
                  padding: REdgeInsets.only(
                    top: AppSpacing.xs,
                    left: AppSpacing.xs,
                  ),
                  child: Text(
                    AppStrings.consentMustAcceptError,
                    style: AppTextStyles.s12w400.copyWith(color: context.error),
                  ),
                ).animate().fadeIn(duration: 200.ms);
              },
            ),
          ],
        );
      },
    );
  }
}

/// "Don't have an account? Sign up" / "Already have an account? Log in".
class _ModeSwitchLink extends StatelessWidget {
  const _ModeSwitchLink();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (p, c) => p.mode != c.mode,
      builder: (context, state) {
        final isLogin = state.mode == AuthMode.login;
        final prompt = isLogin
            ? AppStrings.authDontHaveAccount
            : AppStrings.authAlreadyHaveAccountPrompt;
        final action = isLogin ? AppStrings.authSignUp : AppStrings.authLogIn;
        final target = isLogin ? AuthMode.signup : AuthMode.login;

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            HapticFeedback.selectionClick();
            context.read<AuthBloc>().add(AuthEvent.modeChanged(target));
          },
          child: Padding(
            padding: REdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 320),
              switchInCurve: Curves.easeOutCubic,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.35),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
              child: Row(
                // Keyed by mode so the whole line animates out/in on switch.
                key: ValueKey(isLogin),
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    prompt,
                    style: AppTextStyles.s14w400.copyWith(
                      color: context.onSurfaceVariant,
                    ),
                  ),
                  AppSpacing.xs.horizontalSpace,
                  Text(
                    action,
                    style:
                        AppTextStyles.s14w600.copyWith(color: context.primary),
                  ),
                  AppSpacing.xs.horizontalSpace,
                  FaIcon(
                    FontAwesomeIcons.arrowRightArrowLeft,
                    size: 12.r,
                    color: context.primary,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
