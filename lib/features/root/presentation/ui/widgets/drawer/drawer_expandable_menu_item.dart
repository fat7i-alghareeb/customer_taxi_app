import 'package:customertaxi/common/imports/imports.dart';

class DrawerExpandableMenuItem extends StatefulWidget {
  const DrawerExpandableMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.children,
    this.initiallyExpanded = false,
  });

  final FaIconData icon;
  final String label;
  final List<Widget> children;
  final bool initiallyExpanded;

  @override
  State<DrawerExpandableMenuItem> createState() =>
      _DrawerExpandableMenuItemState();
}

class _DrawerExpandableMenuItemState extends State<DrawerExpandableMenuItem> {
  late bool _expanded = widget.initiallyExpanded;

  void _toggle() => setState(() => _expanded = !_expanded);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.onSurface.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(
          color: context.onSurface.withValues(alpha: 0.05),
          width: 1.r,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: _toggle,
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            child: Padding(
              padding: REdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.lg,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 24.sp,
                    child: Center(
                      child: FaIcon(
                        widget.icon,
                        size: 18.r,
                        color: context.primary,
                      ),
                    ),
                  ),
                  AppSpacing.md.horizontalSpace,
                  Expanded(
                    child: Text(
                      widget.label,
                      style: AppTextStyles.s16w600.copyWith(
                        color: context.onSurface,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.25 : 0,
                    duration: AppDurations.normal,
                    child: FaIcon(
                      context.chevronEnd,
                      size: 12.r,
                      color: context.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: AppDurations.normal,
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: _expanded
                ? Padding(
                    padding: REdgeInsets.only(bottom: AppSpacing.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: widget.children,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: 0.05, duration: AppDurations.normal);
  }
}
