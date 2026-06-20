import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/core/services/session/auth_state_notifier.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';
import 'package:customertaxi/features/order/domain/entities/order_location_entity.dart';
import 'package:customertaxi/features/order/presentation/ui/screens/location_picker_screen.dart';
import '../../../../root/presentation/ui/screens/root_screen.dart';
import '../../states/profile_bloc.dart';
import '../../../constants/forms/profile_forms.dart';
import 'profile_photo_picker.dart';
import 'profile_delete_account_button.dart';

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
      _form.control(ProfileForms.emailField).updateValue(user.email);
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

        final emailControl = _form.control(ProfileForms.emailField);
        final currentEmail = currentAuthUser?.email;
        if (currentEmail != null &&
            currentEmail != emailControl.value &&
            emailControl.pristine &&
            !state.saveStatus.isLoading) {
          emailControl.updateValue(currentEmail);
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
                AppSpacing.lg.verticalSpace,
                AppReactiveTextField.email(
                  formControlName: ProfileForms.emailField,
                  title: AppStrings.contactUsEmail,
                  onChangedDebounced: (value, _) {
                    context.read<ProfileBloc>().add(
                      ProfileEvent.emailSaved(value),
                    );
                  },
                ).animate().fadeIn(delay: 365.ms).slideY(begin: 0.05),
                AppSpacing.lg.verticalSpace,
                _HomeAddressField(
                  label: state.homeAddressTouched
                      ? state.pendingHomeAddressLabel
                      : state.currentUser?.homeAddressLabel,
                  onPick: () async {
                    final location = await context
                        .pushNamed<OrderLocationEntity>(
                          LocationPickerScreen.pageName,
                        );
                    if (location != null && context.mounted) {
                      context.read<ProfileBloc>().add(
                        ProfileEvent.homeAddressSelected(
                          label: location.label,
                          latitude: location.latitude,
                          longitude: location.longitude,
                        ),
                      );
                    }
                  },
                  onClear: () => context.read<ProfileBloc>().add(
                    const ProfileEvent.homeAddressSelected(),
                  ),
                ).animate().fadeIn(delay: 375.ms).slideY(begin: 0.05),
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
                    final addressChanged = state.homeAddressTouched;
                    final currentEmail =
                        (form.control(ProfileForms.emailField).value as String?)
                            ?.trim() ??
                        '';
                    final emailChanged =
                        currentEmail != (authUser?.email ?? '').trim();
                    final hasChanges =
                        nameChanged ||
                        emailChanged ||
                        photoChanged ||
                        addressChanged;

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
                if (!widget.isSetupMode) ...[
                  AppSpacing.xl.verticalSpace,
                  const ProfileDeleteAccountButton(),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Optional home-address row. Tapping opens the map picker; when a value is set
/// it shows the label with a clear button (keeps the field optional).
class _HomeAddressField extends StatelessWidget {
  const _HomeAddressField({
    required this.label,
    required this.onPick,
    required this.onClear,
  });

  final String? label;
  final VoidCallback onPick;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final hasValue = label != null && label!.trim().isNotEmpty;
    final onSurface = context.colorScheme.onSurface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.profileHomeAddress,
          style: AppTextStyles.s14w400.copyWith(
            color: onSurface.withValues(alpha: 0.7),
          ),
        ),
        AppSpacing.sm.verticalSpace,
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPick,
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            child: Container(
              padding: REdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(AppRadii.lg.r),
                border: Border.all(
                  color: onSurface.withValues(alpha: 0.12),
                  width: 1.r,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.home_outlined,
                    size: 20.r,
                    color: hasValue
                        ? context.primary
                        : onSurface.withValues(alpha: 0.5),
                  ),
                  AppSpacing.md.horizontalSpace,
                  Expanded(
                    child: Text(
                      hasValue ? label! : AppStrings.profileHomeAddressHint,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.s14w400.copyWith(
                        color: hasValue
                            ? onSurface
                            : onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                  if (hasValue)
                    IconButton(
                      onPressed: onClear,
                      visualDensity: VisualDensity.compact,
                      icon: Icon(Icons.close, size: 18.r, color: onSurface),
                    )
                  else
                    Icon(
                      Icons.map_outlined,
                      size: 20.r,
                      color: onSurface.withValues(alpha: 0.5),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
