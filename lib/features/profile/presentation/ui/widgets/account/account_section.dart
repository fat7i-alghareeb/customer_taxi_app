import 'package:customertaxi/common/imports/imports.dart';

/// A titled, rounded card that groups related [AccountRow]s on the Account hub.
class AccountSection extends StatelessWidget {
  const AccountSection({
    super.key,
    this.title,
    required this.children,
  });

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Padding(
            padding: REdgeInsets.only(left: AppSpacing.sm, bottom: AppSpacing.sm),
            child: Text(
              title!.toUpperCase(),
              style: AppTextStyles.s12w700.copyWith(
                color: context.onSurfaceVariant,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ],
        Container(
          decoration: BoxDecoration(
            color: context.onSurface.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            border: Border.all(
              color: context.onSurface.withValues(alpha: 0.05),
            ),
          ),
          child: Column(
            children: [
              for (var i = 0; i < children.length; i++) ...[
                children[i],
                if (i != children.length - 1)
                  Padding(
                    padding: REdgeInsets.only(left: 56.w),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: context.onSurface.withValues(alpha: 0.05),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// A single tappable settings row: leading icon chip, label, optional trailing
/// value + chevron. Set [isDanger] for destructive actions (e.g. log out).
class AccountRow extends StatelessWidget {
  const AccountRow({
    super.key,
    required this.icon,
    required this.label,
    this.value,
    this.onTap,
    this.isDanger = false,
    this.showChevron = true,
    this.trailing,
  });

  final FaIconData icon;
  final String label;
  final String? value;
  final VoidCallback? onTap;
  final bool isDanger;
  final bool showChevron;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final accent = isDanger ? context.error : context.primary;
    final labelColor = isDanger ? context.error : context.onSurface;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        child: Padding(
          padding: REdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              Container(
                width: 34.r,
                height: 34.r,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadii.sm.r),
                ),
                child: Center(
                  child: FaIcon(icon, size: 15.r, color: accent),
                ),
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.s14w600.copyWith(color: labelColor),
                ),
              ),
              if (value != null) ...[
                AppSpacing.sm.horizontalSpace,
                Text(
                  value!,
                  style: AppTextStyles.s12w500.copyWith(
                    color: context.onSurfaceVariant,
                  ),
                ),
              ],
              if (trailing != null) ...[
                AppSpacing.sm.horizontalSpace,
                trailing!,
              ] else if (showChevron && !isDanger) ...[
                AppSpacing.sm.horizontalSpace,
                FaIcon(
                  context.chevronEnd,
                  size: 13.r,
                  color: context.onSurfaceVariant.withValues(alpha: 0.6),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
