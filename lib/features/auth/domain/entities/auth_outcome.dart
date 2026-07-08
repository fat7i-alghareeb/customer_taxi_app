import 'auth_session.dart';

/// Outcome of Google / email-signup verification: an authenticated [session],
/// a [registration] challenge (needs name + phone), or a user [cancelled] flow.
sealed class AuthOutcome {
  const AuthOutcome();
}

class SessionOutcome extends AuthOutcome {
  const SessionOutcome(this.session);
  final AuthSession session;
}

class RegistrationOutcome extends AuthOutcome {
  const RegistrationOutcome({
    required this.registrationToken,
    this.email,
    this.name,
  });

  final String registrationToken;
  final String? email;
  final String? name;
}

class CancelledOutcome extends AuthOutcome {
  const CancelledOutcome();
}
