import 'package:customertaxi/common/imports/imports.dart';

class RootMapZoomButtonsWidget extends StatelessWidget {
  const RootMapZoomButtonsWidget({
    super.key,
    required this.onZoomInTap,
    required this.onZoomOutTap,
  });

  final VoidCallback onZoomInTap;
  final VoidCallback onZoomOutTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.sp,
      decoration: BoxDecoration(
        color: context.primary,
        borderRadius: BorderRadius.circular(AppRadii.md.r),
        // gradient: context.gradients.primary,
        boxShadow: context.shadows.grey,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ZoomButton(onTap: onZoomInTap, icon: FontAwesomeIcons.plus),
          VerticalDivider(
            color: context.background.withValues(alpha: 0.2),
            width: 1,
            indent: AppSpacing.sm.h,
            endIndent: AppSpacing.sm.h,
          ),
          _ZoomButton(onTap: onZoomOutTap, icon: FontAwesomeIcons.minus),
        ],
      ),
    );
  }
}

class _ZoomButton extends StatelessWidget {
  const _ZoomButton({required this.onTap, required this.icon});

  final VoidCallback onTap;
  final FaIconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.md.r),
      child: Container(
        width: 40,
        alignment: Alignment.center,
        child: FaIcon(icon, size: 16.r, color: context.background),
      ),
    );
  }
}
