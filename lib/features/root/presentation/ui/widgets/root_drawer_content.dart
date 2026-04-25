import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/sheets/selection_list_sheet.dart';
import 'package:customertaxi/core/config/localization_config.dart';
import 'package:customertaxi/core/services/localization/locale_service.dart';
import 'package:customertaxi/core/services/session/auth_manager.dart';
import 'package:customertaxi/core/theme/theme_controller.dart';
import 'package:customertaxi/features/root/presentation/ui/screens/about_us_screen.dart';
import 'package:customertaxi/features/root/presentation/ui/screens/contact_us_screen.dart';

import 'drawer/drawer_option_card.dart';

class RootDrawerContent extends StatelessWidget {
  const RootDrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        AppSpacing.lg.verticalSpace,
        Expanded(
          child: ListView(
            padding: REdgeInsets.symmetric(horizontal: AppSpacing.md),
            children: [
              _buildSectionHeader(context, AppStrings.settings),
              _buildLanguageSelector(context),
              _buildThemeSelector(context),
              AppSpacing.md.verticalSpace,
              _buildSectionHeader(context, AppStrings.drawerSupport),
              _buildAboutUsTile(context),
              _buildContactUsTile(context),
              const Divider().standardVerticalPadding,
              _buildLogoutButton(context),
            ],
          ),
        ),
        _buildFooter(context),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: REdgeInsets.only(
        left: AppSpacing.sm,
        right: AppSpacing.sm,
        bottom: AppSpacing.md,
      ),
      child: Text(
        title.toUpperCase(),
        style: AppTextStyles.s12w700.copyWith(
          color: context.onSurface.withValues(alpha: 0.4),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final currentUser = getIt<AuthManager>().currentUser;
    // Default to the dummy phone if user currently has no phone
    final phoneText = currentUser?.phone ?? '+31 6 87608841';

    return ClipRect(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.primary.withValues(alpha: 0.05),
          border: Border(
            bottom: BorderSide(
              color: context.theme.dividerColor.withValues(alpha: 0.1),
            ),
          ),
        ),
        child: Stack(
          children: [
            // Rich Shapes
            Positioned(
              top: -30.r,
              right: -30.r,
              child: Container(
                width: 140.r,
                height: 140.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      context.primary.withValues(alpha: 0.15),
                      context.primary.withValues(alpha: 0.0),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -50.r,
              left: -50.r,
              child: Container(
                width: 180.r,
                height: 180.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.primary.withValues(alpha: 0.05),
                    width: 20.w,
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: REdgeInsets.fromLTRB(
                AppSpacing.xl,
                context.topPadding + AppSpacing.xl,
                AppSpacing.xl,
                AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: REdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: context.surface,
                          borderRadius: BorderRadius.circular(AppRadii.xl.r),
                          boxShadow: context.shadows.grey,
                        ),
                        child: Image.asset(
                          Assets.images.legacyLogo.path,
                          height: 80.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        width: 64.r,
                        height: 64.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.surface,
                          boxShadow: context.shadows.grey,
                        ),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.solidUser,
                            size: 28.r,
                            color: context.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.xl.verticalSpace,
                  Text(
                    phoneText,
                    style: AppTextStyles.s24w700.copyWith(
                      fontWeight: FontWeight.w900,
                      color: context.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSelector(BuildContext context) {
    final themeController = getIt<ThemeController>();
    return ListenableBuilder(
      listenable: themeController,
      builder: (context, _) {
        final isDark = themeController.isDarkMode;
        return DrawerOptionCard(
          icon: isDark ? FontAwesomeIcons.moon : FontAwesomeIcons.sun,
          label: AppStrings.selectTheme,
          value: isDark ? AppStrings.dark : AppStrings.light,
          onTap: () async {
            final result = await SelectionListSheet.show<bool>(
              context,
              title: AppStrings.selectTheme,
              selectedValue: isDark,
              items: [
                SelectionItem(
                  label: AppStrings.light,
                  value: false,
                  icon: FontAwesomeIcons.sun,
                ),
                SelectionItem(
                  label: AppStrings.dark,
                  value: true,
                  icon: FontAwesomeIcons.moon,
                ),
              ],
            );

            if (result != null && result != isDark) {
              themeController.toggleTheme();
            }
          },
        );
      },
    );
  }

  Widget _buildLanguageSelector(BuildContext context) {
    final currentLocale = context.locale;

    return DrawerOptionCard(
      icon: FontAwesomeIcons.globe,
      label: AppStrings.selectLanguage,
      value: _getLanguageName(currentLocale),
      onTap: () async {
        final result = await SelectionListSheet.show<AppLanguage>(
          context,
          title: AppStrings.selectLanguage,
          selectedValue: _getAppLanguageFromLocale(currentLocale),
          items: [
            SelectionItem(label: AppStrings.languageEN, value: AppLanguage.en),
            SelectionItem(label: AppStrings.languageAR, value: AppLanguage.ar),
            SelectionItem(label: AppStrings.languageNL, value: AppLanguage.nl),
          ],
        );

        if (result != null && context.mounted) {
          await getIt<LocaleService>().changeLanguage(result, context);
        }
      },
    );
  }

  Widget _buildAboutUsTile(BuildContext context) {
    return DrawerOptionCard(
      icon: FontAwesomeIcons.circleInfo,
      label: AppStrings.profileAboutUs,
      // value: 'https://admtaxitours.com/',
      onTap: () => context.pushNamed(AboutUsScreen.pageName),
    );
  }

  Widget _buildContactUsTile(BuildContext context) {
    return DrawerOptionCard(
      icon: FontAwesomeIcons.headset,
      label: AppStrings.profileContactUs,
      // value: '(06) 39 55 03 52',
      onTap: () => context.pushNamed(ContactUsScreen.pageName),
    );
  }

  String _getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return AppStrings.languageEN;
      case 'ar':
        return AppStrings.languageAR;
      case 'nl':
        return AppStrings.languageNL;
      default:
        return AppStrings.languageEN;
    }
  }

  AppLanguage _getAppLanguageFromLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return AppLanguage.en;
      case 'ar':
        return AppLanguage.ar;
      case 'nl':
        return AppLanguage.nl;
      default:
        return AppLanguage.en;
    }
  }

  Widget _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        final confirm = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(AppStrings.logout),
            content: Text(AppStrings.logout),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(AppStrings.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  AppStrings.logout,
                  style: TextStyle(color: context.error),
                ),
              ),
            ],
          ),
        );

        if (confirm == true) {
          await getIt<AuthManager>().logout();
        }
      },
      borderRadius: BorderRadius.circular(AppRadii.md.r),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            FaIcon(
              FontAwesomeIcons.rightFromBracket,
              size: 20.r,
              color: context.error,
            ),
            AppSpacing.md.horizontalSpace,
            Text(
              AppStrings.logout,
              style: AppTextStyles.s16w600.copyWith(color: context.error),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(AppSpacing.xl),
      child: Text(
        'v1.0.0',
        style: AppTextStyles.s12w400.copyWith(
          color: context.onSurface.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
