import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/app_update/presentation/ui/widgets/force_update_actions_widget.dart';
import 'package:customertaxi/features/app_update/presentation/ui/widgets/force_update_illustration_widget.dart';
import 'package:customertaxi/features/app_update/presentation/ui/widgets/force_update_version_chips.dart';

class ForceUpdateBodySection extends StatelessWidget {
  const ForceUpdateBodySection({
    super.key,
    required this.installedVersion,
    required this.latestVersion,
    required this.hasStoreUrl,
    required this.isChecking,
    required this.onUpdate,
    required this.onRecheck,
  });

  final String installedVersion;
  final String latestVersion;
  final bool hasStoreUrl;
  final bool isChecking;
  final VoidCallback onUpdate;
  final VoidCallback onRecheck;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.xxl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(child: ForceUpdateIllustrationWidget()),
          AppSpacing.xxl.verticalSpace,
          Text(
            AppStrings.forceUpdateTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.s28w700.copyWith(color: context.onSurface),
          ),
          AppSpacing.md.verticalSpace,
          Text(
            AppStrings.forceUpdateMessage,
            textAlign: TextAlign.center,
            style: AppTextStyles.s14w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.65),
            ),
          ),
          if (installedVersion.isNotEmpty && latestVersion.isNotEmpty) ...[
            AppSpacing.lg.verticalSpace,
            ForceUpdateVersionChips(
              installedVersion: installedVersion,
              latestVersion: latestVersion,
            ),
          ],
          AppSpacing.xxl.verticalSpace,
          ForceUpdateActionsWidget(
            hasStoreUrl: hasStoreUrl,
            isChecking: isChecking,
            onUpdate: onUpdate,
            onRecheck: onRecheck,
          ),
        ],
      ),
    ).animate().fadeIn(duration: AppDurations.normal).slideY(
      begin: 0.06,
      end: 0,
      curve: Curves.easeOut,
    );
  }
}
