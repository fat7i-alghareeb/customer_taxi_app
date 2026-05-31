import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/core/services/session/auth_state_notifier.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';
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
    final user = getIt<AuthStateNotifier>().user;
    _form = ProfileForms.formGroup();

    // * Pre-populate form with current local user data
    if (user != null) {
      printG(
        '[ProfileBody] initState pre-populating name: "${user.name}" phone: "${user.phone}"',
      );
      _form.control(ProfileForms.nameField).updateValue(user.name);
      _form.control(ProfileForms.phoneField).updateValue(user.phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authUser = context.watch<AuthStateNotifier>().user;

    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        final nameControl = _form.control(ProfileForms.nameField);

        // * Sync form with AuthStateNotifier data if needed (only if field hasn't been touched by user)
        final currentAuthUser = context.read<AuthStateNotifier>().user;
        final currentName = currentAuthUser?.name;
        if (currentName != null &&
            currentName != nameControl.value &&
            (nameControl.pristine || nameControl.value == null) &&
            !state.saveStatus.isLoading) {
          printG(
            '[ProfileBody] Syncing form name from AuthStateNotifier: "$currentName"',
          );
          nameControl.updateValue(currentName);
        }

        final phoneControl = _form.control(ProfileForms.phoneField);
        final currentPhone = currentAuthUser?.phone;
        if (currentPhone != null && currentPhone != phoneControl.value) {
          phoneControl.updateValue(currentPhone);
        }

        state.saveStatus.whenOrNull(
          loading: () => showLoadingOverlay(context, AppStrings.loading),
          success: (_) {
            showSuccessOverlay(context, AppStrings.profileSaveSuccess);
            if (widget.isSetupMode) {
              context.goNamed(RootScreen.pageName);
            } else if (context.canPop()) {
              context.pop();
            }
          },
          failure: (message) => showErrorOverlay(context, message),
        );
      },
      builder: (context, state) {
        // If we don't have a user yet (e.g. initial load), we can show a minimal loader
        // or just the empty fields. Given the "implicit" requirement, we show the UI
        // immediately with whatever data we have.
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
                  currentPhotoUrl: authUser?.profilePhotoUrl,
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
                AppSpacing.lg.verticalSpace,
                AppReactiveTextField.text(
                  formControlName: ProfileForms.phoneField,
                  title: AppStrings.phoneNumber,
                  enabled: false,
                ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.05),
                AppSpacing.xxl.verticalSpace,
                ReactiveFormConsumer(
                  builder: (context, form, _) {
                    final currentName =
                        (form.control(ProfileForms.nameField).value as String?)
                                ?.trim() ??
                            '';
                    final authName = (authUser?.name ?? '').trim();
                    final nameChanged = currentName != authName;
                    final photoChanged = state.pendingPhoto != null;
                    final hasChanges = nameChanged || photoChanged;

                    if (!widget.isSetupMode && !hasChanges) {
                      return const SizedBox.shrink();
                    }

                    return AppButton.primary(
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
                    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.05);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
