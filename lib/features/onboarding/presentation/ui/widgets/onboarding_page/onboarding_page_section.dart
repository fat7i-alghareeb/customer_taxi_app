import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:customertaxi/features/onboarding/presentation/ui/widgets/onboarding_page/onboarding_background_widget.dart';
import 'package:customertaxi/features/onboarding/presentation/ui/widgets/onboarding_page/onboarding_content_widget.dart';

class OnboardingPageSection extends StatelessWidget {
  const OnboardingPageSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  final String title;
  final String subtitle;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        OnboardingBackgroundWidget(imagePath: imagePath),

        Positioned(
          left: 0,
          right: 0,
          bottom: 140.h, // Consistent space for indicator and buttons
          child: OnboardingContentWidget(title: title, subtitle: subtitle),
        ),
      ],
    );
  }
}
