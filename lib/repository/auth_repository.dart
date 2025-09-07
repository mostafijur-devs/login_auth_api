import 'dart:async';

import 'package:login_auth_model/model/auth/login_auth_model/login_model.dart';
import 'package:login_auth_model/model/auth/login_auth_model/login_response_model.dart';
import 'package:login_auth_model/model/auth/registration_auth_model/registration_response.dart';

import '../model/auth/registration_auth_model/registration_model.dart';
import '../model/auth/verify_otp/verify_otp_model.dart';

abstract class AuthRepository{

  Future<LoginAuth> login(LoginModel loginData);
  Future<RegistrationResponse> registration(RegistrationModel registrationModel);
  Future<LoginAuth> verifyOTP ( VerifyOTPModel verifyOtpModel);
  Future<LoginAuth> resendOTP(String email);

}