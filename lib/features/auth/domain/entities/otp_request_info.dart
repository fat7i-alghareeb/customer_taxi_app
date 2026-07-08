/// Info returned when an OTP is issued; drives the resend countdown.
class OtpRequestInfo {
  const OtpRequestInfo({
    required this.otpRequestId,
    required this.expiresInSeconds,
    required this.resendAvailableInSeconds,
  });

  final String otpRequestId;
  final int expiresInSeconds;
  final int resendAvailableInSeconds;
}
