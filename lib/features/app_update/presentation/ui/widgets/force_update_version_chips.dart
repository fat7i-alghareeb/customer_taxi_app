import 'package:customertaxi/common/imports/imports.dart';

/// Installed and required versions side by side.
///
/// Each chip carries its own label, so the comparison still reads without
/// relying on colour alone.
class ForceUpdateVersionChips extends StatelessWidget {
  const ForceUpdateVersionChips({
    super.key,
    required this.installedVersion,
    required this.latestVersion,
  });

  final String installedVersion;
  final String latestVersion;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: _VersionChip(
            value: installedVersion,
            color: context.onSurface.withValues(alpha: 0.55),
            background: context.onSurface.withValues(alpha: 0.05),
          ),
        ),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: FaIcon(
            context.isRtl
                ? FontAwesomeIcons.arrowLeft
                : FontAwesomeIcons.arrowRight,
            size: 12.r,
            color: context.onSurface.withValues(alpha: 0.4),
          ),
        ),
        Flexible(
          child: _VersionChip(
            value: latestVersion,
            color: context.primary,
            background: context.primary.withValues(alpha: 0.12),
          ),
        ),
      ],
    );
  }
}

class _VersionChip extends StatelessWidget {
  const _VersionChip({
    required this.value,
    required this.color,
    required this.background,
  });

  final String value;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadii.xl.r),
      ),
      child: Text(
        '${AppStrings.forceUpdateCurrentVersionLabel} $value',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: AppTextStyles.s12w500.copyWith(color: color),
      ),
    );
  }
}
