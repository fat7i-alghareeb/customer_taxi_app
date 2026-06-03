import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';

import '../../states/profile_bloc.dart';

class ProfileDeleteAccountButton extends StatelessWidget {
  const ProfileDeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listenWhen: (prev, curr) =>
          prev.deleteAccountStatus != curr.deleteAccountStatus,
      listener: (context, state) {
        state.deleteAccountStatus.whenOrNull(
          success: (_) =>
              showSuccessOverlay(context, AppStrings.profileDeleteAccountSuccess),
          failure: (message) => showErrorOverlay(
            context,
            message.isNotEmpty ? message : AppStrings.profileDeleteAccountFailure,
          ),
        );
      },
      builder: (context, state) {
        return AppButton.variant(
          variant: AppButtonVariant.error,
          fill: AppButtonFill.solid,
          isLoading: state.deleteAccountStatus.isLoading,
          onTap: () => _confirmAndDelete(context),
          child: AppButtonChild.labelIcon(
            label: AppStrings.profileDeleteAccount,
            icon: IconSource.icon(FontAwesomeIcons.trashCan),
          ),
        ).animate().fadeIn(delay: 450.ms).slideY(begin: 0.05);
      },
    );
  }

  Future<void> _confirmAndDelete(BuildContext context) async {
    final bloc = context.read<ProfileBloc>();
    final confirmed = await AppDialog.show<bool>(
      context,
      dialog: AppDialog.basic(
        icon: IconSource.icon(FontAwesomeIcons.triangleExclamation),
        title: AppStrings.profileDeleteAccountDialogTitle,
        message: AppStrings.profileDeleteAccountDialogMessage,
        primaryAction: AppDialogAction.danger(
          label: AppStrings.profileDeleteAccountConfirm,
          onPressed: () => Navigator.pop(context, true),
        ),
        secondaryAction: AppDialogAction.secondary(
          label: AppStrings.cancel,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
    );

    if (confirmed == true) {
      bloc.add(const ProfileEvent.deleteAccountRequested());
    }
  }
}
