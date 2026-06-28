import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/chat/presentation/states/chat_bloc.dart';
import 'package:customertaxi/features/chat/presentation/ui/widgets/chat_sheet.dart';

class ChatFloatingAction extends StatelessWidget {
  const ChatFloatingAction({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        final unread = state.unreadCount;
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () =>
                ChatSheet.show(context, bloc: context.read<ChatBloc>()),
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            child: Ink(
              padding: REdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: colors.surface.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(AppRadii.lg.r),
                border: Border.all(
                  color: colors.primary.withValues(alpha: 0.3),
                  width: 1.r,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 18.r,
                    offset: Offset(0, 8.h),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.solidComments,
                        size: 18.r,
                        color: colors.primary,
                      ),
                      if (unread > 0)
                        PositionedDirectional(
                          top: -6.h,
                          end: -8.w,
                          child: Container(
                            padding: REdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 1,
                            ),
                            constraints: BoxConstraints(minWidth: 16.w),
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              borderRadius: BorderRadius.circular(
                                AppRadii.lg.r,
                              ),
                            ),
                            child: Text(
                              unread > 99 ? '99+' : '$unread',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.s11w500.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  AppSpacing.sm.horizontalSpace,
                  Text(
                    'chatTitle'.tr(),
                    style: AppTextStyles.s12w700.copyWith(
                      color: colors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
