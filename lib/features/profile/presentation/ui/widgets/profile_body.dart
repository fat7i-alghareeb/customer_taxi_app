import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/core/domain/user_entity.dart';
import 'package:customertaxi/core/services/session/auth_state_notifier.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';
import 'package:customertaxi/features/order/domain/entities/order_location_entity.dart';
import 'package:customertaxi/features/order/presentation/ui/screens/location_picker_screen.dart';
import 'package:customertaxi/features/root/domain/entities/root_map_location_entity.dart';
import '../../../../root/presentation/ui/screens/root_screen.dart';
import '../../states/profile_bloc.dart';
import '../../../constants/forms/profile_forms.dart';
import 'profile_photo_picker.dart';
import 'profile_delete_account_button.dart';
import '../../../../auth/presentation/ui/widgets/unverified_phone_banner.dart';

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

    // Pre-populate form with current local user data
    if (user != null) {
      printC(
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
      listener: _handleStateChanges,
      builder: (context, state) {
        return ReactiveForm(
          formGroup: _form,
          child: SingleChildScrollView(
            padding: REdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.lg,
            ),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Avatar Section ──
                AppSpacing.lg.verticalSpace,
                ProfilePhotoPicker(
                  currentPhotoUrl: authUser?.profilePhotoUrl,
                  pendingPhoto: state.pendingPhoto,
                ),
                AppSpacing.xxl.verticalSpace,

                // ── Form Fields Section ──
                _buildFormSection(context, state, authUser),

                // ── Actions Section ──
                AppSpacing.xxl.verticalSpace,
                _buildSaveButton(context, state, authUser),
                if (!widget.isSetupMode) ...[
                  AppSpacing.xl.verticalSpace,
                  const ProfileDeleteAccountButton(),
                ],
                AppSpacing.lg.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }

  /// Accounts created via email/Google sign-in own a verified email that can't be
  /// changed in-app; phone accounts keep an unverified, editable email.
  bool _isEmailLocked(UserEntity? authUser) => authUser?.isEmailVerified == true;

  Widget _buildFormSection(
    BuildContext context,
    ProfileState state,
    UserEntity? authUser,
  ) {
    final emailLocked = _isEmailLocked(authUser);
    return Container(
      padding: REdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: context.onSurface.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(AppRadii.xl.r),
        border: Border.all(
          color: context.onSurface.withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section title
          Row(
            children: [
              FaIcon(
                FontAwesomeIcons.solidUser,
                size: 14.r,
                color: context.primary,
              ),
              AppSpacing.sm.horizontalSpace,
              Text(
                AppStrings.profileName,
                style: AppTextStyles.s14w700.copyWith(
                  color: context.onSurface,
                ),
              ),
            ],
          ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.05),
          AppSpacing.lg.verticalSpace,

          // Name field
          AppReactiveTextField.text(
            formControlName: ProfileForms.nameField,
            title: AppStrings.profileName,
            hintText: AppStrings.profileNamePlaceholder,
            onChangedDebounced: (value, _) {
              context.read<ProfileBloc>().add(
                ProfileEvent.nameSaved(value),
              );
            },
          ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.04),
          AppSpacing.lg.verticalSpace,

          // Phone field (read-only)
          AppReactiveTextField.text(
            formControlName: ProfileForms.phoneField,
            title: AppStrings.phoneNumber,
            enabled: false,
          ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.04),

          if (!widget.isSetupMode) const UnverifiedPhoneBanner(),
          AppSpacing.lg.verticalSpace,

          // Email field — read-only for email/Google accounts (verified email).
          AppReactiveTextField.email(
            formControlName: ProfileForms.emailField,
            title: AppStrings.contactUsEmail,
            enabled: !emailLocked,
            onChangedDebounced: (value, _) {
              context.read<ProfileBloc>().add(
                ProfileEvent.emailSaved(value),
              );
            },
          ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.04),
          if (emailLocked) _buildEmailLockedHint(context),
          AppSpacing.lg.verticalSpace,

          // Home address field with map picker
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: AppReactiveTextField.text(
                  formControlName: ProfileForms.homeAddressField,
                  title: AppStrings.profileHomeAddress,
                  hintText: AppStrings.profileHomeAddressHint,
                  onChangedDebounced: (value, _) {
                    context.read<ProfileBloc>().add(
                      ProfileEvent.homeAddressLabelChanged(
                        value.trim().isEmpty ? null : value.trim(),
                      ),
                    );
                  },
                ),
              ),
              AppSpacing.sm.horizontalSpace,
              AppButton.outline(
                layout: AppButtonLayout(
                  width: 52.w,
                  height: 52.h,
                  borderRadius: AppRadii.lg,
                ),
                onTap: () => _pickHomeAddress(context, state),
                child: AppButtonChild.icon(
                  IconSource.faIcon(
                    (state.pendingHomeAddressLatitude ??
                                state.currentUser?.homeAddressLatitude) !=
                            null
                        ? FontAwesomeIcons.locationCrosshairs
                        : FontAwesomeIcons.mapLocationDot,
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.04),
        ],
      ),
    );
  }

  Widget _buildEmailLockedHint(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(top: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FaIcon(
            FontAwesomeIcons.lock,
            size: 11.r,
            color: context.onSurface.withValues(alpha: 0.5),
          ),
          AppSpacing.sm.horizontalSpace,
          Expanded(
            child: Text(
              AppStrings.profileEmailLockedHint,
              style: AppTextStyles.s12w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(
    BuildContext context,
    ProfileState state,
    UserEntity? authUser,
  ) {
    // Locked (email/Google) accounts can't change email, so it never counts as a change.
    final emailLocked = _isEmailLocked(authUser);
    return ReactiveFormConsumer(
      builder: (context, form, _) {
        final currentName =
            (form.control(ProfileForms.nameField).value as String?)?.trim() ??
                '';
        final authName = (authUser?.name ?? '').trim();
        final nameChanged = currentName != authName;
        final photoChanged = state.pendingPhoto != null;
        final addressChanged = state.homeAddressTouched;
        final currentEmail =
            (form.control(ProfileForms.emailField).value as String?)?.trim() ??
                '';
        final emailChanged =
            !emailLocked && currentEmail != (authUser?.email ?? '').trim();
        final hasChanges =
            nameChanged || emailChanged || photoChanged || addressChanged;

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
        ).animate().fadeIn(delay: 450.ms).slideY(begin: 0.04);
      },
    );
  }

  Future<void> _pickHomeAddress(
    BuildContext context,
    ProfileState state,
  ) async {
    final existingLat =
        state.pendingHomeAddressLatitude ??
        state.currentUser?.homeAddressLatitude;
    final existingLng =
        state.pendingHomeAddressLongitude ??
        state.currentUser?.homeAddressLongitude;
    final initialLocation =
        existingLat != null && existingLng != null
        ? RootMapLocationEntity(
            latitude: existingLat,
            longitude: existingLng,
            zoom: 16,
          )
        : null;

    final location = await context.pushNamed<OrderLocationEntity>(
      LocationPickerScreen.pageName,
      extra: initialLocation,
    );
    if (location != null && context.mounted) {
      _form
          .control(ProfileForms.homeAddressField)
          .updateValue(location.label);
      context.read<ProfileBloc>().add(
        ProfileEvent.homeAddressMapPicked(
          label: location.label,
          latitude: location.latitude,
          longitude: location.longitude,
        ),
      );
    }
  }

  void _handleStateChanges(BuildContext context, ProfileState state) {
    final nameControl = _form.control(ProfileForms.nameField);

    // Sync form with AuthStateNotifier data if needed
    final currentAuthUser = context.read<AuthStateNotifier>().user;
    final currentName = currentAuthUser?.name;
    if (currentName != null &&
        currentName != nameControl.value &&
        (nameControl.pristine || nameControl.value == null) &&
        !state.saveStatus.isLoading) {
      printC(
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

    final addressControl = _form.control(ProfileForms.homeAddressField);
    final loadedAddress = state.currentUser?.homeAddressLabel;
    if (loadedAddress != null &&
        addressControl.pristine &&
        !state.homeAddressTouched &&
        addressControl.value != loadedAddress) {
      addressControl.updateValue(loadedAddress);
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
  }
}
