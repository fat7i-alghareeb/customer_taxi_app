import 'package:customertaxi/common/imports/imports.dart';

class TripInfoRowWidget extends StatelessWidget {
  const TripInfoRowWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onEditTap,
    this.disabledReason,
    this.showEditAffordance = true,
  });

  final FaIconData icon;
  final String label;
  final String value;
  final VoidCallback? onEditTap;

  /// Why this row can't be edited right now. Shown under the value so a greyed-out pencil
  /// reads as a rule rather than a broken button.
  final String? disabledReason;

  /// False for rows that are never editable (fare, vehicle), so they don't reserve space
  /// for a pencil that will never do anything.
  final bool showEditAffordance;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final canEdit = onEditTap != null;

    return Padding(
      padding: REdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          FaIcon(
            icon,
            size: 16.r,
            color: colors.primary.withValues(alpha: 0.7),
          ),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.s12w400.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  value,
                  style: AppTextStyles.s14w600.copyWith(
                    color: colors.onSurface,
                  ),
                ),
                if (!canEdit && disabledReason != null) ...[
                  AppSpacing.xs.verticalSpace,
                  Text(
                    disabledReason!,
                    style: AppTextStyles.s12w400.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.45),
                      height: 1.3,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (showEditAffordance)
            SizedBox(
              width: 36.r,
              height: 36.r,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: onEditTap,
                icon: FaIcon(
                  FontAwesomeIcons.penToSquare,
                  size: 16.r,
                  color: canEdit
                      ? colors.primary
                      : colors.onSurface.withValues(alpha: 0.25),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
