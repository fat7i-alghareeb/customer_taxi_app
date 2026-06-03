import 'package:customertaxi/common/imports/imports.dart';

class PolicySection extends StatelessWidget {
  const PolicySection({
    super.key,
    required this.title,
    required this.body,
    this.index = 0,
  });

  final String title;
  final String body;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: REdgeInsets.only(top: 2),
                  child: FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: 16.sp,
                    color: context.primary,
                  ),
                ),
                AppSpacing.md.horizontalSpace,
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.s16w600.copyWith(
                      color: context.onSurface,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
            AppSpacing.sm.verticalSpace,
            Padding(
              padding: REdgeInsets.only(left: AppSpacing.xl.w),
              child: Text(
                body,
                style: AppTextStyles.s14w400.copyWith(
                  color: context.onSurfaceVariant,
                  height: 1.55,
                ),
              ),
            ),
          ],
        )
        .animate(delay: (index * 60).ms)
        .fadeIn(duration: AppDurations.normal)
        .slideY(begin: 0.06, end: 0);
  }
}
