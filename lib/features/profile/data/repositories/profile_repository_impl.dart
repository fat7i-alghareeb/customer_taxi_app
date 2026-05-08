import 'package:injectable/injectable.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/domain/user_entity.dart';
import '../../../../core/error/global_error_handler.dart';
import '../../../../core/injection/injectable.dart' show getIt;
import '../../../../core/services/session/auth_manager.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';
import '../mappers/profile_model_mapper.dart';
import '../params/profile_params.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._remote);

  final ProfileRemoteDataSource _remote;

  Future<void> _syncAuthUser(ProfileEntity profile) async {
    final authManager = getIt<AuthManager>();

    // We pass a partial UserEntity with the new data; AuthManager.updateUser 
    // will merge this with existing cached data (preserving any fields not 
    // present in ProfileEntity).
    final update = UserEntity(
      id: profile.id,
      name: profile.name,
      phone: profile.phone,
      profilePhotoUrl: profile.profilePhotoUrl,
    );

    await authManager.updateUser(update);
  }

  @override
  Future<Result<ProfileEntity>> getCurrentUser() {
    return runAsResult(() async {
      printM('[ProfileRepository] getCurrentUser');
      final model = await _remote.getCurrentUser();
      printG('[ProfileRepository] getCurrentUser success id=${model.id}');
      final entity = model.toEntity;
      await _syncAuthUser(entity);
      return entity;
    });
  }

  @override
  Future<Result<ProfileEntity>> updateProfile(UpdateProfileParam param) {
    return runAsResult(() async {
      printM('[ProfileRepository] updateProfile name="${param.name}"');
      final model = await _remote.updateProfile(param);
      printG('[ProfileRepository] updateProfile success id=${model.id}');
      final entity = model.toEntity;
      await _syncAuthUser(entity);
      return entity;
    });
  }

  @override
  Future<Result<String>> uploadPhoto(UpdateProfilePhotoParam param) {
    return runAsResult(() async {
      printM('[ProfileRepository] uploadPhoto path="${param.photo.path}"');
      final photoUrl = await _remote.uploadPhoto(param);
      printG('[ProfileRepository] uploadPhoto success url=$photoUrl');
      return photoUrl;
    });
  }
}
