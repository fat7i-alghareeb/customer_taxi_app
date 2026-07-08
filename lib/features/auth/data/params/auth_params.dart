/// Legacy Firebase phone-session params (kept for backward compatibility).
class LoginParams {
  const LoginParams({
    required this.phone,
    required this.firebaseIdToken,
    this.fcmToken,
  });

  final String phone;
  final String firebaseIdToken;
  final String? fcmToken;

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'firebaseIdToken': firebaseIdToken,
        if (fcmToken != null) 'fcmToken': fcmToken,
      };
}

/// Request an SMS OTP for phone login/signup.
class PhoneOtpParams {
  const PhoneOtpParams({required this.phone, this.deviceId});

  final String phone;
  final String? deviceId;

  Map<String, dynamic> toJson() => {
        'phone': phone,
        if (deviceId != null) 'deviceId': deviceId,
      };
}

/// Request an email OTP for email login/signup.
class EmailOtpParams {
  const EmailOtpParams({required this.email, this.deviceId});

  final String email;
  final String? deviceId;

  Map<String, dynamic> toJson() => {
        'email': email,
        if (deviceId != null) 'deviceId': deviceId,
      };
}

/// Verify an issued OTP (phone/email login/signup + phone verify).
class VerifyOtpParams {
  const VerifyOtpParams({
    required this.otpRequestId,
    required this.code,
    this.fcmToken,
  });

  final String otpRequestId;
  final String code;
  final String? fcmToken;

  Map<String, dynamic> toJson() => {
        'otpRequestId': otpRequestId,
        'code': code,
        if (fcmToken != null) 'fcmToken': fcmToken,
      };
}

/// Google sign-in/up: a verified Firebase (Google) ID token.
class GoogleAuthParams {
  const GoogleAuthParams({
    required this.firebaseIdToken,
    this.fcmToken,
    this.deviceId,
  });

  final String firebaseIdToken;
  final String? fcmToken;
  final String? deviceId;

  Map<String, dynamic> toJson() => {
        'firebaseIdToken': firebaseIdToken,
        if (fcmToken != null) 'fcmToken': fcmToken,
        if (deviceId != null) 'deviceId': deviceId,
      };
}

/// Finalize a Google/email sign-up with name + (unverified) phone.
class CompleteRegistrationParams {
  const CompleteRegistrationParams({
    required this.registrationToken,
    required this.name,
    required this.phone,
    this.fcmToken,
  });

  final String registrationToken;
  final String name;
  final String phone;
  final String? fcmToken;

  Map<String, dynamic> toJson() => {
        'registrationToken': registrationToken,
        'name': name,
        'phone': phone,
        if (fcmToken != null) 'fcmToken': fcmToken,
      };
}
