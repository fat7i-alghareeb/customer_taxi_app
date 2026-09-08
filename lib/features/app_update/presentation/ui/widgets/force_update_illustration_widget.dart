import 'package:customertaxi/common/imports/imports.dart';

/// Glowing circular badge anchoring the force-update screen.
///
/// The slow breathing pulse reads as "waiting on you" without a spinner's false
/// implication that something is loading. It is the only looping animation on
/// the screen, and it stops under `prefers-reduced-motion` via
/// [Animate.defaultTargetPlatform]-independent disabling below.
class ForceUpdateIllustrationWidget extends StatelessWidget {
  const ForceUpdateIllustrationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    final badge = Container(
      height: 140.r,
      width: 140.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: context.gradients.auroraSoft,
        boxShadow: context.shadows.auroraGlow,
      ),
      child: Center(
        child: FaIcon(
          FontAwesomeIcons.cloudArrowDown,
          size: 56.r,
          color: context.primary,
        ),
      ),
    );

    if (reduceMotion) return badge;

    return badge
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scaleXY(
          begin: 1,
          end: 1.04,
          duration: 1600.ms,
          curve: Curves.easeInOut,
        );
  }
}
