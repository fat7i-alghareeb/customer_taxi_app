// cspell:ignore oranje
import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/auth/presentation/states/auth_bloc.dart';

class LoginLandingSection extends StatelessWidget {
  const LoginLandingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Top Image (Logo + Tagline usually in these designs)
        Center(
          child: Assets.images.topText.image(
            height: context.screenHeight * 0.18,
            fit: BoxFit.contain,
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2),

        AppSpacing.xs.verticalSpace,

        // Tagline text
        Builder(
          builder: (context) {
            final parts = AppStrings.loginLandingTagline.split(' ');
            if (parts.length < 2) {
              return Text(
                AppStrings.loginLandingTagline,
                style: AppTextStyles.s32w700.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              );
            }
            final lastWord = parts.removeLast();
            final remainingText = parts.join(' ');

            return Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '$remainingText '),
                  TextSpan(
                    text: lastWord,
                    style: const TextStyle(color: AppColors.landingGold),
                  ),
                ],
              ),
              style: AppTextStyles.s32w700.copyWith(
                color: Colors.white,
                height: 1.1,
              ),
              textAlign: TextAlign.center,
            );
          },
        ).animate().fadeIn(delay: 200.ms),

        AppSpacing.md.verticalSpace,

        // Shield Icon
        Center(
          child: Container(
            padding: REdgeInsets.all(AppSpacing.xs),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.landingGold, width: 1.r),
            ),
            child: FaIcon(
              FontAwesomeIcons.shield,
              color: AppColors.landingGold,
              size: 14.r,
            ),
          ),
        ).animate().fadeIn(delay: 300.ms).scale(),

        AppSpacing.lg.verticalSpace,

        // Discount Section
        Column(
          children: [
            Text(
              AppStrings.loginLandingDiscountTitle,
              style: AppTextStyles.s16w400.copyWith(color: Colors.white70),
            ),
            Text(
              AppStrings.loginLandingDiscountSubtitle,
              style: AppTextStyles.s40w700.copyWith(
                color: AppColors.landingGold,
                height: 1.1,
              ),
            ),
            Text(
              AppStrings.loginLandingDiscountFooter,
              style: AppTextStyles.s16w400.copyWith(color: Colors.white70),
            ),
          ],
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),

        AppSpacing.xl.verticalSpace,

        // Car imagery placeholder
        Center(
          child: SizedBox(width: 330.w, height: 180.h),
        ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),

        const Spacer(),

        AppSpacing.md.verticalSpace,

        // Buttons
        Padding(
          padding: REdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: Column(
            children: [
              AppButton.variant(
                variant: CustomButtonVariant(
                  color: AppColors.landingGold,
                  foregroundColor: Colors.black,
                  gradientColor: LinearGradient(
                    colors: [
                      AppColors.landingGold,
                      AppColors.landingGold.withValues(alpha: 0.8),
                    ],
                  ),
                ),
                fill: AppButtonFill.gradient,
                layout: const AppButtonLayout(percentageWidth: 1.0),
                child: AppButtonChild.labelIcon(
                  label: AppStrings.loginLandingRegister,
                  icon: IconSource.faIcon(context.chevronEnd),
                  position: AppButtonIconPosition.trailing,
                ),
                onTap: () {
                  context.read<AuthBloc>().add(
                    const AuthEvent.landingProceedRequested(),
                  );
                },
              ),
              AppSpacing.md.verticalSpace,
              AppButton.outline(
                child: AppButtonChild.labelIcon(
                  label: AppStrings.loginLandingLogin,
                  icon: IconSource.faIcon(context.chevronEnd),
                  position: AppButtonIconPosition.trailing,
                ),
                onTap: () {
                  context.read<AuthBloc>().add(
                    const AuthEvent.landingProceedRequested(),
                  );
                },
                layout: const AppButtonLayout(percentageWidth: 1.0),
                variant: const CustomButtonVariant(
                  color: AppColors.landingGold,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.3),

        AppSpacing.xl.verticalSpace,

        // Footer
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.shield,
              color: AppColors.landingGold,
              size: 14.r,
            ),
            AppSpacing.sm.horizontalSpace,
            Text(
              AppStrings.loginLandingFooter,
              style: AppTextStyles.s14w400.copyWith(color: Colors.white54),
            ),
          ],
        ).animate().fadeIn(delay: 900.ms),

        AppSpacing.lg.verticalSpace,
      ],
    );
  }
}
