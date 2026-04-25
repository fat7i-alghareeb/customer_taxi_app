import 'package:customertaxi/common/imports/imports.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  static const String pagePath = '/contact-us';
  static const String pageName = 'ContactUsScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold.appBar(
      appBarConfig: AppScaffoldAppBarConfig(title: AppStrings.contactUsTitle),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            AppSpacing.xl.verticalSpace,
            Text(
              AppStrings.contactUsTitle,
              style: AppTextStyles.s24w700.copyWith(color: context.primary),
              textAlign: TextAlign.center,
            ),
            AppSpacing.sm.verticalSpace,
            Text(
              AppStrings.contactUsSubtitle,
              style: AppTextStyles.s16w600.copyWith(
                color: context.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.lg.verticalSpace,
            Text(
              AppStrings.contactUsDescription,
              style: AppTextStyles.s14w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.6),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.xl.verticalSpace,
            _ContactSection(
                  title: AppStrings.contactUsPhone,
                  icon: FontAwesomeIcons.phone,
                  children: const [_ContactItem(value: '(06) 39 55 03 52')],
                )
                .animate()
                .fadeIn(duration: AppDurations.normal)
                .slideX(begin: -0.1, end: 0),
            AppSpacing.lg.verticalSpace,
            _ContactSection(
                  title: AppStrings.contactUsEmail,
                  icon: FontAwesomeIcons.solidEnvelope,
                  children: const [
                    _ContactItem(value: 'info@admtaxitours.com'),
                  ],
                )
                .animate()
                .fadeIn(delay: 150.ms, duration: AppDurations.normal)
                .slideX(begin: -0.1, end: 0),
            AppSpacing.lg.verticalSpace,
            _ContactSection(
                  title: AppStrings.contactUsAddress,
                  icon: FontAwesomeIcons.locationDot,
                  children: [_ContactItem(value: AppStrings.contactUsTak1)],
                )
                .animate()
                .fadeIn(delay: 300.ms, duration: AppDurations.normal)
                .slideX(begin: -0.1, end: 0),
            AppSpacing.xxl.verticalSpace,
          ],
        ).standardHorizontalPadding,
      ),
    );
  }
}

class _ContactSection extends StatelessWidget {
  const _ContactSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: REdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppRadii.xl.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FaIcon(icon, size: 18.r, color: context.primary),
              12.horizontalSpace,
              Text(
                title,
                style: AppTextStyles.s16w600.copyWith(color: context.primary),
              ),
            ],
          ),
          AppSpacing.lg.verticalSpace,
          ...children,
        ],
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  const _ContactItem({this.label, required this.value});

  final String? label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Text(
              label!,
              style: AppTextStyles.s12w500.copyWith(
                color: context.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
        SelectableText(
          value,
          style: AppTextStyles.s14w400.copyWith(color: context.onSurface),
        ),
      ],
    );
  }
}
