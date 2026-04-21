import 'package:customertaxi/common/imports/imports.dart';

class RootMapMenuButton extends StatelessWidget {
  const RootMapMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: context.topPadding + AppSpacing.md.h,
      left: AppSpacing.md.w,
      child: GestureDetector(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: Container(
          width: 48.r,
          height: 48.r,
          decoration: BoxDecoration(
            color: context.surface,
            shape: BoxShape.circle,
            boxShadow: context.shadows.grey,
          ),
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.bars,
              size: 20.r,
              color: context.onSurface,
            ),
          ),
        ),
      ).animate().fadeIn().scale(
            duration: AppDurations.normal,
            curve: Curves.easeOutBack,
          ),
    );
  }
}
