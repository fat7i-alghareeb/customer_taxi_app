import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:customertaxi/common/imports/imports.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
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
              width: 120.r,
              height: 120.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.surface,
                border: Border.all(color: context.primary, width: 3.r),
                boxShadow: context.shadows.primary,
                image: pendingPhoto != null
                    ? DecorationImage(image: FileImage(pendingPhoto!), fit: BoxFit.cover)
                    : (currentPhotoUrl != null
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(currentPhotoUrl!),
                            fit: BoxFit.cover,
                          )
                        : null),
              ),
              child: (pendingPhoto == null && currentPhotoUrl == null)
                  ? Center(
                      child: FaIcon(
                        FontAwesomeIcons.user,
                        size: 48.r,
                        color: context.primary.withValues(alpha: 0.3),
                      ),
                    )
                  : null,
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
                  color: context.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().scale(delay: 200.ms);
  }
}
