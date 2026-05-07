import 'package:injectable/injectable.dart';

import '../../../../core/domain/user_entity.dart';
import '../../../../core/utils/result.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class AuthFacade {
  const AuthFacade(this._repository);

  final AuthRepository _repository;

  Future<Result<String>> sendOtp(String phone) => _repository.sendOtp(phone);

  Future<Result<UserEntity>> verifyOtp({
    required String phone,
    required String sessionToken,
    required String code,
  }) =>
      _repository.verifyOtp(
        phone: phone,
        sessionToken: sessionToken,
        code: code,
      );
}
