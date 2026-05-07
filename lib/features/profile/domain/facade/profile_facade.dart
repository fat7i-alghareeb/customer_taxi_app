import 'package:injectable/injectable.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/utils/result.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';
import '../../data/params/profile_params.dart';

@lazySingleton
class ProfileFacade {
  const ProfileFacade(this._repository);

  final ProfileRepository _repository;

  Future<Result<ProfileEntity>> getCurrentUser() {
    printC('[ProfileFacade] getCurrentUser');
    return _repository.getCurrentUser();
  }

  Future<Result<ProfileEntity>> updateProfile(UpdateProfileParam param) {
    printC('[ProfileFacade] updateProfile name="${param.name}"');
    return _repository.updateProfile(param);
  }

  Future<Result<String>> uploadPhoto(UpdateProfilePhotoParam param) {
    printC('[ProfileFacade] uploadPhoto path="${param.photo.path}"');
    return _repository.uploadPhoto(param);
  }
}
