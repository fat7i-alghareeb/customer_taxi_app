import 'package:customertaxi/common/imports/imports.dart';
import '../../../../domain/entities/order_location_entity.dart';

class OrderRouteSummaryTimelineWidget extends StatelessWidget {
  const OrderRouteSummaryTimelineWidget({
    super.key,
    required this.stops,
    this.durationText,
    this.distanceKm = 0.0,
    this.onEditStop,
  });

  final List<OrderLocationEntity> stops;
  final String? durationText;
  final double distanceKm;
  final ValueChanged<int>? onEditStop;

  @override
  Widget build(BuildContext context) {
    if (stops.length < 2) return const SizedBox.shrink();

    return Container(
      padding: REdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        boxShadow: context.shadows.grey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if ((durationText ?? '').isNotEmpty || distanceKm > 0) ...[
            Row(
              children: [
                if ((durationText ?? '').isNotEmpty) ...[
                  FaIcon(
                    FontAwesomeIcons.clock,
                    size: 12.r,
                    color: context.primary,
                  ),
                  AppSpacing.xs.horizontalSpace,
                  Text(
                    durationText!,
                    style: AppTextStyles.s12w500.copyWith(color: context.primary),
                  ),
                ],
                if ((durationText ?? '').isNotEmpty && distanceKm > 0) ...[
                  AppSpacing.sm.horizontalSpace,
                  Text(
                    '•',
                    style: AppTextStyles.s12w500.copyWith(
                      color: context.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                  AppSpacing.sm.horizontalSpace,
                ],
                if (distanceKm > 0) ...[
                  FaIcon(
                    FontAwesomeIcons.route,
                    size: 12.r,
                    color: context.primary,
                  ),
                  AppSpacing.xs.horizontalSpace,
                  Text(
                    '${distanceKm.toStringAsFixed(1)} km',
                    style: AppTextStyles.s12w500.copyWith(color: context.primary),
                  ),
                ],
              ],
            ),
            AppSpacing.md.verticalSpace,
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  for (var i = 0; i < stops.length; i++) ...[
                    _buildPin(
                      context,
                      _getPinColor(context, i, stops.length),
                      _getPinIcon(i, stops.length),
                    ),
                    if (i < stops.length - 1)
                      Container(
                        width: 2.w,
                        height: 44.h,
                        margin: REdgeInsets.symmetric(vertical: 2),
                        decoration: BoxDecoration(
                          color: context.onSurface.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(1.r),
                        ),
                      ),
                  ],
                ],
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < stops.length; i++) ...[
                      Row(
                        children: [
                          Expanded(
                            child: _buildLocationText(
                              context,
                              _getTitle(i, stops.length),
                              stops[i],
                            ),
                          ),
                          if (onEditStop != null) ...[
                            AppSpacing.sm.horizontalSpace,
                            GestureDetector(
                              onTap: () => onEditStop!(i),
                              behavior: HitTestBehavior.opaque,
                              child: Padding(
                                padding: REdgeInsets.all(AppSpacing.sm),
                                child: FaIcon(
                                  FontAwesomeIcons.penToSquare,
                                  size: 16.r,
                                  color: context.primary.withValues(alpha: 0.7),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (i < stops.length - 1) 28.h.verticalSpace,
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getPinColor(BuildContext context, int index, int total) {
    if (index == 0) return context.primary;
    if (index == total - 1) return Colors.redAccent;
    return context.onSurface.withValues(alpha: 0.4);
  }

  FaIconData _getPinIcon(int index, int total) {
    if (index == 0) return FontAwesomeIcons.circleArrowUp;
    if (index == total - 1) return FontAwesomeIcons.locationDot;
    return FontAwesomeIcons.circleDot;
  }

  String _getTitle(int index, int total) {
    if (index == 0) return AppStrings.from;
    if (index == total - 1) return AppStrings.to;
    return AppStrings.orderStopLabel.replaceAll('{n}', index.toString());
  }

  Widget _buildPin(BuildContext context, Color color, FaIconData icon) {
    return Container(
      width: 28.r,
      height: 28.r,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: FaIcon(icon, size: 14.r, color: color),
      ),
    );
  }

  Widget _buildLocationText(
    BuildContext context,
    String title,
    OrderLocationEntity location,
  ) {
    final primaryName = location.primaryName ?? location.label;
    final secondaryAddress = location.secondaryAddress;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.s11w500.copyWith(
            color: context.primary,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        Text(
          primaryName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.s14w600.copyWith(
            color: context.onSurface,
            fontWeight: FontWeight.w800,
          ),
        ),
        if ((secondaryAddress ?? '').isNotEmpty)
          Text(
            secondaryAddress!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.s12w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.5),
            ),
          ),
      ],
    );
  }
}
