import 'package:customertaxi/common/imports/imports.dart';
import '../../../domain/entities/trip_status.dart';

class TripStatusChip extends StatelessWidget {
  const TripStatusChip({super.key, required this.status});
  final TripStatus status;

  @override
  Widget build(BuildContext context) {
    final color = status.color(context);
    return Container(
      padding: REdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(status.icon, size: 10.r, color: color),
          AppSpacing.xs.horizontalSpace,
          Text(
            status.title,
            style: AppTextStyles.s12w700.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
