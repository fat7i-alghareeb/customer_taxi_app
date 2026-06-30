import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/chat/presentation/states/chat_bloc.dart';
import 'package:customertaxi/features/chat/presentation/ui/widgets/chat_sheet.dart';

/// Full-width "Chat met chauffeur" card used inside the active-trip status
/// sheets. Replaces the old floating chat pill ([ChatFloatingAction]); it must
/// be rendered within a [BlocProvider]<[ChatBloc]> so it can open the chat
/// sheet and reflect the unread count.
class TripChatButton extends StatelessWidget {
  const TripChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        final unread = state.unreadCount;
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => ChatSheet.show(context, bloc: context.read<ChatBloc>()),
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            child: Ink(
              padding: REdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: colors.onSurface.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(AppRadii.lg.r),
                border: Border.all(
                  color: colors.onSurface.withValues(alpha: 0.06),
                  width: 1.r,
                ),
              ),
              child: Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: REdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.solidComments,
                          color: colors.primary,
                          size: 18.r,
                        ),
                      ),
                      if (unread > 0)
                        PositionedDirectional(
                          top: -4.h,
                          end: -4.w,
                          child: Container(
                            padding: REdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 1,
                            ),
                            constraints: BoxConstraints(minWidth: 16.w),
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              borderRadius: BorderRadius.circular(AppRadii.lg.r),
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
                  AppSpacing.md.horizontalSpace,
                  Expanded(
                    child: Text(
                      AppStrings.activeTripChatWithDriver,
                      style: AppTextStyles.s14w600.copyWith(
                        color: colors.onSurface,
                      ),
                    ),
                  ),
                  FaIcon(
                    context.chevronEnd,
                    color: colors.onSurface.withValues(alpha: 0.4),
                    size: 14.r,
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
