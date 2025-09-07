class ApiUri{
  ApiUri ._();
  static const String baseUri = "http://10.61.10.192/light_of_deen/api/v1.0";

  static const String loginUri = "$baseUri/auth/login";
  static const String registrationUri = "$baseUri/auth/register";
  static const String verifyUri = "$baseUri/auth/verify-otp";
  static const String resendOTP = "$baseUri/auth/resend-otp";

}