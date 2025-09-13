import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_auth_model/model/auth/reset_password_model/reset_password_model.dart';
import 'package:login_auth_model/services/api_uri.dart';
import '../../model/auth/auth_response.dart';
import '../../model/auth/login_auth_model/login_model.dart';
import '../../model/auth/registration_auth_model/registration_model.dart';
import '../../model/auth/verify_otp/verify_otp_model.dart';
import '../../repository/auth_repository.dart';

class AuthServices extends AuthRepository {




  @override
  Future<AuthResponse> login(LoginModel loginData) async {
    final response = await http.post(
      Uri.parse(ApiUri.loginUri),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(loginData.toJson()),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(data);
    } else {
      return AuthResponse.fromJson(data);
    }
  }

  @override
  Future<AuthResponse> registration(RegistrationModel registrationModel,) async {
    final response = await http.post(
      Uri.parse(ApiUri.registrationUri),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(registrationModel.toJson()),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {

      return AuthResponse.fromJson(data);
    } else {

      return AuthResponse.fromJson(data);
    }
  }

  @override
  Future<AuthResponse> verifyOTP(VerifyOTPModel verifyOtpModel) async {
    final response =await http.post(Uri.parse(ApiUri.verifyUri),
    headers:{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode(verifyOtpModel.toJson()));
    final data = jsonDecode(response.body);


    if(response.statusCode == 200){

      return AuthResponse.fromJson(data);
    }
    else{
      return AuthResponse.fromJson(data);
    }



  }

  @override
  Future<AuthResponse> resendOTP(String email) async {

    final response =await http.post(Uri.parse(ApiUri.resendOTP),
        headers:{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "email":email
        }));
    final data = jsonDecode(response.body);

    if(response.statusCode == 200){
      return AuthResponse.fromJson(data);
    }
    else{

      return AuthResponse.fromJson(data);
    }


  }

  @override
  Future<AuthResponse> forgetPasswordResetOtp(String email) async{
    final response =await http.post(Uri.parse(ApiUri.forgetPasswordOTPSend),
        headers:{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "email":email
        }));
    final data = jsonDecode(response.body);
    if(response.statusCode == 200){
      return AuthResponse.fromJson(data);
    }
    else{

      return AuthResponse.fromJson(data);
    }


  }

  @override
  Future<AuthResponse> passwordWithToken(ResetPasswordModel resetPassModel) async{
    final response =await http.post(Uri.parse(ApiUri.resetPassword),
        headers:{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(resetPassModel.toJson()));
    final data = jsonDecode(response.body);


    if(response.statusCode == 200){
      return AuthResponse.fromJson(data);
    }
    else{

      return AuthResponse.fromJson(data);
    }


  }

  @override
  Future<AuthResponse> requestPasswordReset({required String resetOtp, required String email}) async{
    final response =await http.post(Uri.parse(ApiUri.verifyForgetPasswordOtp),
        headers:{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "email":email,
          "otp": resetOtp
        }));
    final data = jsonDecode(response.body);


    if(response.statusCode == 200){
      return AuthResponse.fromJson(data);
    }
    else{

      return AuthResponse.fromJson(data);
    }
  }

}
