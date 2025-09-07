import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_auth_model/model/auth/login_auth_model/login_response_model.dart';
import 'package:login_auth_model/services/api_uri.dart';
import '../../model/auth/login_auth_model/login_model.dart';
import '../../model/auth/registration_auth_model/registration_model.dart';
import '../../model/auth/registration_auth_model/registration_response.dart';
import '../../model/auth/verify_otp/verify_otp_model.dart';
import '../../repository/auth_repository.dart';

class AuthServices extends AuthRepository {
  @override
  Future<LoginAuth> login(LoginModel loginData) async {
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
      print(data);
      return LoginAuth.fromJson(data);
    } else {
      print(data);

      return LoginAuth.fromJson(data);
    }
  }

  @override
  Future<RegistrationResponse> registration(
    RegistrationModel registrationModel,
  ) async {
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

      return RegistrationResponse.fromJson(data);
    } else {

      return RegistrationResponse.fromJson(data);
    }
  }

  @override
  Future<LoginAuth> verifyOTP(
      VerifyOTPModel verifyOtpModel
      ) async {
    final response =await http.post(Uri.parse(ApiUri.verifyUri),
    headers:{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode(verifyOtpModel.toJson()));
    final data = jsonDecode(response.body);


    if(response.statusCode == 200){
      print(" this is success response $data");

      return LoginAuth.fromJson(data);
    }
    else{
      print(" this is error response $data");

      return LoginAuth.fromJson(data);
    }



  }

  @override
  Future<LoginAuth> resendOTP(String email) async {

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
      print(" this is success response $data");
      return LoginAuth.fromJson(data);
    }
    else{
      print(" this is error response $data");


      return LoginAuth.fromJson(data);
    }


  }


}
