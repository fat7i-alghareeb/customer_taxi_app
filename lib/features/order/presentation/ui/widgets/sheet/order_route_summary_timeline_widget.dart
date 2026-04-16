import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customertaxi/common/imports/imports.dart';

class OrderRouteSummaryTimelineWidget extends StatelessWidget {
  const OrderRouteSummaryTimelineWidget({
    super.key,
    required this.fromLabel,
    required this.toLabel,
  });

  final String fromLabel;
  final String toLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _buildPin(context, context.primary, FontAwesomeIcons.circleArrowUp),
              Container(
                width: 2.w,
                height: 32.h,
                margin: REdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      context.primary,
                      Colors.redAccent,
                    ],
                  ),
                ),
              ),
              _buildPin(context, Colors.redAccent, FontAwesomeIcons.locationDot),
            ],
          ),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLocationText(
                  context,
                  AppStrings.from,
                  fromLabel,
                  isPrimary: true,
                ),
                32.h.verticalSpace,
                _buildLocationText(
                  context,
                  AppStrings.to,
                  toLabel,
                  isPrimary: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPin(BuildContext context, Color color, IconData icon) {
    return Container(
      width: 28.r,
      height: 28.r,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: FaIcon(
          icon,
          size: 14.r,
          color: color,
        ),
      ),
    );
  }

  Widget _buildLocationText(
    BuildContext context,
    String title,
    String label, {
    required bool isPrimary,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.s11w500.copyWith(
            color: context.onSurface.withValues(alpha: 0.5),
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.s14w600.copyWith(
            color: context.onSurface,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
