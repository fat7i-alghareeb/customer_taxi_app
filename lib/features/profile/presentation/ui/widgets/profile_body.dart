import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/profile/domain/entities/profile_entity.dart';
import '../../../../root/presentation/ui/screens/root_screen.dart';
import '../../states/profile_bloc.dart';
import '../../../constants/forms/profile_forms.dart';
import 'profile_photo_picker.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key, required this.isSetupMode});

  final bool isSetupMode;

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  late FormGroup _form;

  @override
  void initState() {
    super.initState();
    _form = ProfileForms.formGroup();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        final nameControl = _form.control(ProfileForms.nameField);
        final remoteName = state.currentUser?.name;

        // * Only sync form with state if the value is different and we are NOT saving.
        // This prevents overwriting user input during the loading phase of a save request.
        if (remoteName != null &&
            remoteName != nameControl.value &&
            !state.saveStatus.isLoading) {
          printM('[ProfileBody] Syncing form name from state: "$remoteName"');
          nameControl.updateValue(remoteName, emitEvent: false);
        }

        state.saveStatus.whenOrNull(
          success: (_) {
            if (widget.isSetupMode) {
              context.goNamed(RootScreen.pageName);
            } else if (context.canPop()) {
              context.pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppStrings.profileSaveSuccess),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          failure: (message) => ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message))),
        );
      },
      builder: (context, state) {
        return StatusBuilder<ProfileEntity>(
          state: state.loadStatus,
          success: (user) {
            return ReactiveForm(
              formGroup: _form,
              child: SingleChildScrollView(
                padding: REdgeInsets.all(AppSpacing.xl),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppSpacing.xl.verticalSpace,
                    ProfilePhotoPicker(
                      currentPhotoUrl: user.profilePhotoUrl,
                      pendingPhoto: state.pendingPhoto,
                    ),
                    AppSpacing.xxl.verticalSpace,
                    AppReactiveTextField.text(
                      formControlName: ProfileForms.nameField,
                      title: AppStrings.profileName,
                      hintText: AppStrings.profileNamePlaceholder,
                      onChangedDebounced: (value, _) {
                        context.read<ProfileBloc>().add(
                          ProfileEvent.nameSaved(value),
                        );
                      },
                    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.05),
                    AppSpacing.xxl.verticalSpace,
                    AppButton.primary(
                      onTap: () {
                        if (_form.valid) {
                          context.read<ProfileBloc>().add(
                            const ProfileEvent.saveRequested(),
                          );
                        } else {
                          _form.markAllAsTouched();
                        }
                      },
                      isLoading: state.saveStatus.isLoading,
                      child: AppButtonChild.label(
                        widget.isSetupMode
                            ? AppStrings.profileSaveAndContinue
                            : AppStrings.profileSave,
                      ),
                    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.05),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
