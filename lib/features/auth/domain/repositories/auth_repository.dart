import '../../../../core/domain/user_entity.dart';
import '../../../../core/utils/result.dart';

abstract class AuthRepository {
  /// Triggers Firebase Phone Auth and returns the verificationId on success.
  Future<Result<String>> requestSmsCode(String phone);

  /// Verifies the SMS code with Firebase, exchanges the resulting Firebase
  /// ID token for the system JWT via the backend `/auth/login` endpoint,
  /// and persists the session via [AuthManager].
  Future<Result<UserEntity>> verifyAndLogin({
    required String phone,
    required String verificationId,
    required String smsCode,
  });
}
