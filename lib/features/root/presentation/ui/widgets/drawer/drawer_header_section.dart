import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/core/services/session/auth_manager.dart';

class DrawerHeaderSection extends StatelessWidget {
  const DrawerHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = getIt<AuthManager>().currentUser;
    final nameText = currentUser?.name ?? 'Adam';
    final phoneText = currentUser?.phone ?? '+31 6 12345678';


    return Padding(
      padding: REdgeInsets.fromLTRB(
        AppSpacing.xl,
        context.topPadding + AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.lg,
      ),
      child: Row(
        children: [
          // Profile Image
          currentUser?.profilePhotoUrl != null
              ? ClipOval(
                  child: AppImageViewer.network(
                    currentUser!.profilePhotoUrl!,
                    width: 80,
                    height: 80,
                    borderRadius: 0,
                  ),
                )
              : Container(
                  width: 80.r,
                  height: 80.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.primary.withValues(alpha: 0.1),
                  ),
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.solidUser,
                      size: 32.r,
                      color: context.primary,
                    ),
                  ),
                ),
          AppSpacing.md.horizontalSpace,
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      nameText,
                      style: AppTextStyles.s24w700.copyWith(
                        color: context.onSurface,
                      ),
                    ),
                  ],
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  phoneText,
                  style: AppTextStyles.s16w400.copyWith(
                    color: context.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: -0.1);
  }
}
