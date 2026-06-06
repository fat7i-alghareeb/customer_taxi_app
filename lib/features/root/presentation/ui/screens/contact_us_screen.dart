import 'package:customertaxi/common/imports/imports.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  static const String pagePath = '/contact-us';
  static const String pageName = 'ContactUsScreen';

  static const String _whatsAppUrl = 'https://wa.me/31639550352';

  Future<void> _openWhatsApp() async {
    final uri = Uri.parse(_whatsAppUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

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
                  title: 'contactUsWhatsApp'.tr(),
                  icon: FontAwesomeIcons.whatsapp,
                  onTap: _openWhatsApp,
                  children: [
                    _ContactItem(value: 'contactUsWhatsAppCta'.tr()),
                  ],
                )
                .animate()
                .fadeIn(duration: AppDurations.normal)
                .slideX(begin: -0.1, end: 0),
            AppSpacing.lg.verticalSpace,
            _ContactSection(
                  title: AppStrings.contactUsEmail,
                  icon: FontAwesomeIcons.solidEnvelope,
                  children: const [
                    _ContactItem(value: 'admin@fat7i.dev'),
                  ],
                )
                .animate()
                .fadeIn(delay: 150.ms, duration: AppDurations.normal)
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
    this.onTap,
  });

  final String title;
  final FaIconData icon;
  final List<Widget> children;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppRadii.xl.r);
    final content = Container(
      width: double.infinity,
      padding: REdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.surface.withValues(alpha: 0.5),
        borderRadius: borderRadius,
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

    if (onTap == null) return content;

    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: content,
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  // ignore: unused_element_parameter
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
