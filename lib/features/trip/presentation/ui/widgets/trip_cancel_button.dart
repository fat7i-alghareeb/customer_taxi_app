import 'package:customertaxi/common/imports/imports.dart';

/// Shared "✕ Cancel ride" button reused across the cancellable status sheets.
class TripCancelButton extends StatelessWidget {
  const TripCancelButton({
    required this.isLoading,
    required this.onTap,
    super.key,
  });

  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        child: Container(
          width: double.infinity,
          padding: REdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            border: Border.all(color: colors.error, width: 1.r),
          ),
          // Scale the icon+label down to fit the (narrow, flex-1) slot rather
          // than clipping or ellipsizing — the "Cancel ride" text stays fully
          // readable at any width / locale.
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: isLoading
                  ? [
                      SizedBox(
                        width: 18.r,
                        height: 18.r,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colors.error,
                        ),
                      ),
                    ]
                  : [
                      FaIcon(
                        FontAwesomeIcons.xmark,
                        size: 16.r,
                        color: colors.error,
                      ),
                      AppSpacing.sm.horizontalSpace,
                      Text(
                        AppStrings.activeTripCancelRide,
                        style: AppTextStyles.s14w600.copyWith(
                          color: colors.error,
                        ),
                      ),
                    ],
            ),
          ),
        ),
      ),
    );
  }
}
