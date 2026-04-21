import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/sheets/selection_list_sheet.dart';
import 'package:customertaxi/core/config/localization_config.dart';
import 'package:customertaxi/core/services/localization/locale_service.dart';
import 'package:customertaxi/core/services/session/auth_manager.dart';
import 'package:customertaxi/core/theme/theme_controller.dart';

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
    return Container(
      width: double.infinity,
      padding: REdgeInsets.fromLTRB(
        AppSpacing.xl,
        context.topPadding + AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        color: context.primary.withValues(alpha: 0.05),
        border: Border(
          bottom: BorderSide(
            color: context.theme.dividerColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            Assets.images.legacyLogo.path,
            height: 60.h,
            fit: BoxFit.contain,
          ),
          AppSpacing.md.verticalSpace,
          Text(
            'customertaxi',
            style: AppTextStyles.s24w700.copyWith(color: context.primary),
          ),
        ],
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
            SelectionItem(
              label: AppStrings.languageEN,
              value: AppLanguage.en,
            ),
            SelectionItem(
              label: AppStrings.languageAR,
              value: AppLanguage.ar,
            ),
            SelectionItem(
              label: AppStrings.languageNL,
              value: AppLanguage.nl,
            ),
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
