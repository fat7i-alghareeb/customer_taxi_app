import '../../../../core/domain/user_entity.dart';
import '../../../../core/utils/result.dart';

abstract class AuthRepository {
  Future<Result<String>> sendOtp(String phone);
  Future<Result<UserEntity>> verifyOtp({
    required String phone,
    required String sessionToken,
    required String code,
  });
}
