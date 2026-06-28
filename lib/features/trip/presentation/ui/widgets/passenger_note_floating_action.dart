import 'package:customertaxi/common/imports/imports.dart';

class PassengerNoteFloatingAction extends StatelessWidget {
  const PassengerNoteFloatingAction({
    required this.hasNote,
    required this.isLoading,
    required this.onTap,
    super.key,
  });

  final bool hasNote;
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
        child: Ink(
          padding: REdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            boxShadow: [
              BoxShadow(
                color: colors.primary.withValues(alpha: 0.25),
                blurRadius: 18.r,
                offset: Offset(0, 8.h),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLoading)
                SizedBox(
                  width: 16.r,
                  height: 16.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.r,
                    valueColor: AlwaysStoppedAnimation<Color>(colors.onPrimary),
                  ),
                )
              else
                FaIcon(
                  hasNote
                      ? FontAwesomeIcons.solidComment
                      : FontAwesomeIcons.message,
                  size: 16.r,
                  color: colors.onPrimary,
                ),
              AppSpacing.sm.horizontalSpace,
              Text(
                AppStrings.passengerNoteEdit,
                style: AppTextStyles.s12w700.copyWith(color: colors.onPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
