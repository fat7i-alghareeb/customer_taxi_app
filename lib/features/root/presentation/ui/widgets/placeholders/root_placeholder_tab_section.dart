import 'package:customertaxi/common/imports/imports.dart';

class RootPlaceholderTabSection extends StatelessWidget {
  const RootPlaceholderTabSection({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            AppSpacing.xxl.verticalSpace,
            Text(
              title,
              style: AppTextStyles.s24w700.copyWith(color: context.onSurface),
            ),
            AppSpacing.lg.verticalSpace,
            Expanded(
              child: EmptyStateWidget(
                text: AppStrings.emptyStateNoData,
                icon: IconSource.builder(
                  (_) => FaIcon(
                    icon,
                    size: 52.r,
                    color: context.onSurface.withValues(alpha: 0.45),
                  ),
                ),
              ),
            ),
          ],
        )
        .animate()
        .fadeIn(duration: AppDurations.normal)
        .slideY(begin: 0.04, end: 0, curve: Curves.easeOutCubic);
  }
}
