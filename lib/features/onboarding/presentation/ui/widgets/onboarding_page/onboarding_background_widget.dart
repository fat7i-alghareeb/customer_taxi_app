import 'package:flutter/material.dart';
import 'package:customertaxi/common/widgets/app_image_viewer.dart';

class OnboardingBackgroundWidget extends StatelessWidget {
  const OnboardingBackgroundWidget({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image
        AppImageViewer.asset(imagePath),

        // Gradient Shadow (Multi-stop for premium feel)
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.4, 0.7, 1.0],
                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.6),
                  Colors.black.withValues(alpha: 0.9),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
