import 'dart:async';
import 'dart:io';
import 'package:login_auth_model/model/auth/login_auth_model/login_model.dart';
import 'package:login_auth_model/services/auth_service/auth_services.dart';
import '../model/auth/auth_response.dart';
import '../model/auth/registration_auth_model/registration_model.dart';
import '../model/auth/reset_password_model/reset_password_model.dart';
import '../model/auth/user_response.dart';
import '../model/auth/verify_otp/verify_otp_model.dart';

abstract class AuthRepository{

  Future<AuthResponse> login(LoginModel loginData);
  Future<AuthResponse> registration(RegistrationModel registrationModel);
  Future<AuthResponse> verifyOTP ( VerifyOTPModel verifyOtpModel);
  Future<AuthResponse> resendOTP(String email);
  Future<AuthResponse> forgetPasswordResetOtp(String email);
  Future<AuthResponse> requestPasswordReset({required String resetOtp,required String email});
  Future<AuthResponse> passwordWithToken(ResetPasswordModel resetPassModel);


  Future<UserResponse?> getUser(String userToken);


}
