class SendOtpParams {
  const SendOtpParams({required this.phone});

  final String phone;

  Map<String, dynamic> toJson() => {'phone': phone};
}

class VerifyOtpParams {
  const VerifyOtpParams({
    required this.phone,
    required this.sessionToken,
    required this.code,
  });

  final String phone;
  final String sessionToken;
  final String code;

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'sessionToken': sessionToken,
        'code': code,
      };
}
