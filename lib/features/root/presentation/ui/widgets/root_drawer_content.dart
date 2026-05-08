import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/sheets/selection_list_sheet.dart';
import 'package:customertaxi/core/config/localization_config.dart';
import 'package:customertaxi/core/services/localization/locale_service.dart';
import 'package:customertaxi/core/services/session/auth_manager.dart';
import 'package:customertaxi/core/theme/theme_controller.dart';
import 'package:customertaxi/features/root/presentation/ui/screens/about_us_screen.dart';
import 'package:customertaxi/features/root/presentation/ui/screens/contact_us_screen.dart';
import 'package:customertaxi/features/trip/presentation/ui/screens/trip_history_screen.dart';

import 'package:customertaxi/common/widgets/show_overlay.dart';

import 'drawer/drawer_balance_card.dart';
import 'drawer/drawer_header_section.dart';
import 'drawer/drawer_logout_footer.dart';
import 'drawer/drawer_menu_item.dart';

class RootDrawerContent extends StatelessWidget {
  const RootDrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.surface,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: REdgeInsets.only(bottom: AppSpacing.xl),
              children: [
                const DrawerHeaderSection(),
                AppSpacing.md.verticalSpace,
                DrawerBalanceCard(
                  balance: '€ 28,50', // Mock data as per image
                  onAddTap: () =>
                      showSuccessOverlay(context, AppStrings.comingSoon),
                ),
                AppSpacing.xl.verticalSpace,

                // Primary Menu
                DrawerMenuItem(
                  icon: FontAwesomeIcons.carSide,
                  label: AppStrings.drawerTrips,
                  onTap: () => context.pushNamed(TripHistoryScreen.pageName),
                ),
                DrawerMenuItem(
                  icon: FontAwesomeIcons.wallet,
                  label: AppStrings.drawerPayments,
                  onTap: () =>
                      showSuccessOverlay(context, AppStrings.comingSoon),
                ),
                DrawerMenuItem(
                  icon: FontAwesomeIcons.percent,
                  label: AppStrings.drawerPromotions,
                  onTap: () =>
                      showSuccessOverlay(context, AppStrings.comingSoon),
                ),
                DrawerMenuItem(
                  icon: FontAwesomeIcons.locationDot,
                  label: AppStrings.drawerFavorites,
                  onTap: () =>
                      showSuccessOverlay(context, AppStrings.comingSoon),
                ),

                AppSpacing.xl.verticalSpace,

                // Support Section
                _buildSectionHeader(context, AppStrings.drawerSupport),
                DrawerMenuItem(
                  icon: FontAwesomeIcons.circleInfo,
                  label: AppStrings.profileAboutUs,
                  onTap: () => context.pushNamed(AboutUsScreen.pageName),
                ),
                DrawerMenuItem(
                  icon: FontAwesomeIcons.headset,
                  label: AppStrings.profileContactUs,
                  onTap: () => context.pushNamed(ContactUsScreen.pageName),
                ),

                AppSpacing.xl.verticalSpace,

                // Settings Section
                _buildSectionHeader(context, AppStrings.settings),
                _buildLanguageSelector(context),
                _buildThemeSelector(context),
                DrawerMenuItem(
                  icon: FontAwesomeIcons.gear,
                  label: AppStrings.settings,
                  onTap: () =>
                      showSuccessOverlay(context, AppStrings.comingSoon),
                ),
              ],
            ),
          ),
          DrawerLogoutFooter(onLogoutTap: () => _handleLogout(context)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.sm,
      ),
      child: Text(
        title,
        style: AppTextStyles.s14w400.copyWith(
          color: context.onSurface.withValues(alpha: 0.4),
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
        return DrawerMenuItem(
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

    return DrawerMenuItem(
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

  Future<void> _handleLogout(BuildContext context) async {
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
  }
}
