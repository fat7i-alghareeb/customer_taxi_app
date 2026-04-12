import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:customertaxi/core/theme/app_text_styles.dart';
import 'package:customertaxi/utils/constants/design_constants.dart';

class OnboardingContentWidget extends StatelessWidget {
  const OnboardingContentWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppTextStyles.s28w700.copyWith(
              color: Colors.white,
              fontSize: 32.sp,
            ),
          ),
          AppSpacing.md.verticalSpace,
          Text(
            subtitle,
            style: AppTextStyles.s16w400.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
