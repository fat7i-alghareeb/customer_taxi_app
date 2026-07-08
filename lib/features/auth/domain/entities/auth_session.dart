import '../../../../core/domain/user_entity.dart';

/// A successfully authenticated session (token already persisted by the repository).
class AuthSession {
  const AuthSession({
    required this.user,
    this.isNewAccount = false,
    this.accountAlreadyExists = false,
  });

  final UserEntity user;

  /// True for a freshly created account (client should run the name step).
  final bool isNewAccount;

  /// True when phone sign-up hit an existing account (offer Continue / Start fresh).
  final bool accountAlreadyExists;
}
