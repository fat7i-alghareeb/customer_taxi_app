import '../../../../core/utils/result.dart';
import '../entities/profile_entity.dart';
import '../../data/params/profile_params.dart';

abstract class ProfileRepository {
  Future<Result<ProfileEntity>> getCurrentUser();
  Future<Result<ProfileEntity>> updateProfile(UpdateUserProfileRequest param);
  Future<Result<void>> deleteAccount();
}
