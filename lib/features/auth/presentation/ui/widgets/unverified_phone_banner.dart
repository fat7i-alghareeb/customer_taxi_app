import 'package:customertaxi/common/imports/imports.dart';

import 'package:customertaxi/core/services/session/auth_manager.dart';
import 'package:customertaxi/features/auth/constants/auth_strings.dart';
import 'package:customertaxi/features/auth/presentation/ui/screens/phone_verification_screen.dart';

/// Persistent warning shown wherever phone reliability matters (home, Profile)
/// while the current account's phone is unverified. Tapping "Verify now" opens
/// the SMS OTP verification flow.
class UnverifiedPhoneBanner extends StatelessWidget {
  const UnverifiedPhoneBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = getIt<AuthManager>().state;
    return ListenableBuilder(
      listenable: authState,
      builder: (context, _) {
        final user = authState.user;
        if (user == null || user.isPhoneVerified) {
          return const SizedBox.shrink();
        }
        return Container(
          margin: REdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          padding: REdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.warning.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(AppRadii.md.r),
            border: Border.all(color: AppColors.warning.withValues(alpha: 0.4)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FaIcon(FontAwesomeIcons.triangleExclamation,
                      size: 18.r, color: AppColors.warning)
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scaleXY(
                      begin: 1, end: 1.12, duration: 900.ms, curve: Curves.easeInOut),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AuthStrings.authPhoneUnverifiedWarning,
                      style: AppTextStyles.s12w400
                          .copyWith(color: context.onSurface),
                    ),
                    AppSpacing.sm.verticalSpace,
                    GestureDetector(
                      onTap: () =>
                          context.pushNamed(PhoneVerificationScreen.pageName),
                      child: Text(
                        AuthStrings.authVerifyNow,
                        style: AppTextStyles.s14w600
                            .copyWith(color: context.primary),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 400.ms).slideY(
              begin: -0.2,
              curve: Curves.easeOutCubic,
            );
      },
    );
  }
}
