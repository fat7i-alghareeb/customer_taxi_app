import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';
import 'package:customertaxi/core/services/media/media_picker_service.dart';
import '../../states/profile_bloc.dart';

class ProfilePhotoPicker extends StatelessWidget {
  const ProfilePhotoPicker({
    super.key,
    this.currentPhotoUrl,
    this.pendingPhoto,
  });

  final String? currentPhotoUrl;
  final File? pendingPhoto;

  Future<void> _pickImage(BuildContext context) async {
    final result = await appMediaPickerService.pickSingle(ImageSource.gallery);
    if (!context.mounted) return;
    if (result.failure != null) {
      showErrorOverlay(context, AppStrings.profilePhotoUploadError);
      return;
    }
    if (result.isSuccess) {
      context.read<ProfileBloc>().add(
        ProfileEvent.photoSelected(File(result.files.single.path)),
      );
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
              width: 120.r,
              height: 120.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.surface,
                border: Border.all(color: context.primary, width: 3.r),
                boxShadow: context.shadows.primary,
              ),
              child: ClipOval(
                child: pendingPhoto != null
                    ? Image.file(pendingPhoto!, fit: BoxFit.cover)
                    : (currentPhotoUrl != null
                          ? AppImageViewer.network(
                              currentPhotoUrl!,
                              borderRadius: 0,
                            )
                          : Center(
                              child: FaIcon(
                                FontAwesomeIcons.user,
                                size: 48.r,
                                color: context.primary.withValues(alpha: 0.3),
                              ),
                            )),
              ),
            ),
            Positioned(
              bottom: 4.r,
              right: 4.r,
              child: Container(
                padding: REdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: context.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: context.surface, width: 2.r),
                ),
                child: FaIcon(
                  FontAwesomeIcons.camera,
                  size: 16.r,
                  color: context.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().scale(delay: 200.ms);
  }
}
