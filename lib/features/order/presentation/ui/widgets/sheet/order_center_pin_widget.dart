import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:customertaxi/common/imports/imports.dart';

class OrderCenterPinWidget extends StatelessWidget {
  const OrderCenterPinWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Transform.translate(
        offset: Offset(0, -22.h), // Adjusted for better centering feel
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              FontAwesomeIcons.locationDot,
              size: 42.r,
              color: context.primary,
            ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(
                  begin: 0,
                  end: -6.h,
                  duration: 1200.ms,
                  curve: Curves.easeInOut,
                ),
            Container(
              width: 12.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.2),
                borderRadius: BorderRadius.all(Radius.elliptical(6.w, 2.h)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                  begin: const Offset(1, 1),
                  end: const Offset(0.7, 0.7),
                  duration: 1200.ms,
                  curve: Curves.easeInOut,
                ),
          ],
        ),
      ),
    );
  }
}

