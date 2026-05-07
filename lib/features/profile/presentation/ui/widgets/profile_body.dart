import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:customertaxi/common/imports/imports.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:customertaxi/features/profile/domain/entities/profile_entity.dart';
import '../../states/profile_bloc.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, required this.isSetup});

  final bool isSetup;

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listenWhen: (prev, curr) => prev.saveStatus != curr.saveStatus,
        listener: (context, state) {
          state.saveStatus.whenOrNull(
            success: (_) {
              if (isSetup) {
                context.goNamed('RootScreen');
              } else {
                context.pop();
              }
            },
            failure: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            },
          );
        },
        builder: (context, state) {
          return StatusBuilder<ProfileEntity>(
            state: state.loadStatus,
            success: (user) => SafeArea(
              child: Padding(
                padding: REdgeInsets.all(AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppSpacing.xl.verticalSpace,
                    Text(
                      isSetup
                          ? AppStrings.profileSetupTitle
                          : AppStrings.profileEditTitle,
                      style: AppTextStyles.s24w700,
                      textAlign: TextAlign.center,
                    ),
                    AppSpacing.xl.verticalSpace,
                    _PhotoPicker(
                      currentPhotoUrl: user.profilePhotoUrl,
                      pendingPhoto: state.pendingPhoto,
                    ),
                    AppSpacing.xl.verticalSpace,
                    _NameField(initialName: user.name ?? ''),
                    AppSpacing.xl.verticalSpace,
                    AppButton.primary(
                      child: AppButtonChild.label(
                        isSetup
                            ? AppStrings.profileSaveAndContinue
                            : AppStrings.profileSave,
                      ),
                      isLoading: state.saveStatus.isLoading,
                      onTap: () => context.read<ProfileBloc>().add(
                            const ProfileEvent.saveRequested(),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NameField extends StatefulWidget {
  const _NameField({required this.initialName});
  final String initialName;

  @override
  State<_NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<_NameField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (value) => context.read<ProfileBloc>().add(
        ProfileEvent.nameSaved(value),
      ),
      decoration: InputDecoration(
        labelText: AppStrings.profileName,
        hintText: AppStrings.profileNamePlaceholder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
      ),
    );
  }
}

class _PhotoPicker extends StatelessWidget {
  const _PhotoPicker({this.currentPhotoUrl, this.pendingPhoto});
  final String? currentPhotoUrl;
  final File? pendingPhoto;

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null && context.mounted) {
      context.read<ProfileBloc>().add(ProfileEvent.photoSelected(File(image.path)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => _pickImage(context),
        child: Stack(
          children: [
            Container(
              width: 100.r,
              height: 100.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.surface,
                border: Border.all(color: context.primary, width: 2.r),
                image: pendingPhoto != null
                    ? DecorationImage(image: FileImage(pendingPhoto!), fit: BoxFit.cover)
                    : (currentPhotoUrl != null
                        ? DecorationImage(image: CachedNetworkImageProvider(currentPhotoUrl!), fit: BoxFit.cover)
                        : null),
              ),
              child: (pendingPhoto == null && currentPhotoUrl == null)
                  ? Center(child: FaIcon(FontAwesomeIcons.user, size: 40.r, color: context.primary.withValues(alpha: 0.5)))
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: REdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: context.primary,
                  shape: BoxShape.circle,
                ),
                child: FaIcon(FontAwesomeIcons.camera, size: 16.r, color: context.onPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
