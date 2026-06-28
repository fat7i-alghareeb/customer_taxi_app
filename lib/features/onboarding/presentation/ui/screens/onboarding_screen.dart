import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:customertaxi/common/widgets/button/app_button.dart';
import 'package:customertaxi/common/widgets/button/app_button_child.dart';
import 'package:customertaxi/common/widgets/button/app_button_variants.dart';
import 'package:customertaxi/common/widgets/custom_scaffold/app_scaffold.dart';
import 'package:customertaxi/core/injection/injectable.dart';
import 'package:customertaxi/core/services/onboarding/onboarding_service.dart';
import 'package:customertaxi/core/services/permissions/permissions_coordinator.dart';
import 'package:customertaxi/utils/constants/design_constants.dart';
import 'package:customertaxi/utils/helpers/app_strings.dart';
import 'package:customertaxi/utils/gen/assets.gen.dart';
import 'package:customertaxi/features/onboarding/presentation/ui/widgets/onboarding_page/onboarding_page_section.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const String pagePath = '/onboarding_screen';
  static const String pageName = 'OnboardingScreen';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    // Check permissions natively without a dedicated loading screen
    await getIt<PermissionsCoordinator>().ensurePostSplashPermissions();
    await getIt<OnboardingService>().setOnboardingFinished();
  }

  Future<void> _next() async {
    if (_index >= 1) {
      await _finish();
      return;
    }
    await _controller.nextPage(
      duration: AppDurations.normal,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(
      scaffoldConfig: const AppScaffoldConfig(
        safeArea: [], // IMERSSIVE FULL SCREEN
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (value) => setState(() => _index = value),
            children: [
              OnboardingPageSection(
                title: AppStrings.onboardingTitle1,
                subtitle: AppStrings.onboardingSubtitle1,
                imagePath: Assets.images.onboarding1.path,
              ),
              OnboardingPageSection(
                title: AppStrings.onboardingTitle2,
                subtitle: AppStrings.onboardingSubtitle2,
                imagePath: Assets.images.onboarding2.path,
              ),
            ],
          ),

          // Skip Button
          if (_index < 1)
            Positioned(
              top: MediaQuery.paddingOf(context).top + AppSpacing.sm.h,
              right: AppSpacing.xl.w,
              child: AppButton.grey(
                layout: const AppButtonLayout(height: 40),
                noShadow: true,
                child: AppButtonChild.label(AppStrings.onboardingSkip),
                onTap: _finish,
              ),
            ),

          // Bottom Controls Section
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.paddingOf(context).bottom + AppSpacing.xl.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Page Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    2,
                    (index) => AnimatedContainer(
                      duration: AppDurations.normal,
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      height: 8.h,
                      width: _index == index ? 24.w : 8.w,
                      decoration: BoxDecoration(
                        color: _index == index
                            ? Theme.of(context).primaryColor
                            : Colors.white.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ),
                AppSpacing.xl.verticalSpace,

                // Primary Action Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl.w),
                  child: AppButton.primary(
                    // noShadow: true,
                    shadowVariant: AppButtonShadowVariant.primary,
                    child: AppButtonChild.label(
                      _index < 1
                          ? AppStrings.onboardingContinue
                          : AppStrings.onboardingGetStarted,
                    ),
                    onTap: _next,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
