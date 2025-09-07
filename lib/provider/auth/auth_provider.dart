import 'package:flutter/foundation.dart';
import 'package:login_auth_model/model/auth/login_auth_model/login_response_model.dart';
import 'package:login_auth_model/model/auth/verify_otp/verify_otp_model.dart';
import 'package:login_auth_model/services/auth_service/auth_services.dart';
import '../../model/auth/login_auth_model/login_model.dart';
import '../../model/auth/registration_auth_model/registration_model.dart';
import '../../model/auth/registration_auth_model/registration_response.dart';
import '../../repository/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthServices();

  LoginAuth? _loginAuth;
  LoginAuth? _otpVarification;
  LoginAuth? _otpResendVarification;
  RegistrationResponse? _registrationResponse;
  bool _isLoading = false;
  bool _isResendLoading = false;
  bool _obscurePasswordTextValue = true;
  bool _obscureConformPasswordValue = true;



  LoginAuth? get loginAuth => _loginAuth;
  LoginAuth? get otpVarification => _otpVarification;
  LoginAuth? get otpResendVarification => _otpResendVarification;
  RegistrationResponse? get registrationResponse => _registrationResponse;
  bool get isLoading => _isLoading;
  bool get isResendLoading => _isResendLoading;
  bool get obscureConformPasswordTextValue => _obscureConformPasswordValue;
  bool get obscurePasswordTextValue => _obscurePasswordTextValue;

  obscurePasswordValue(){
    _obscurePasswordTextValue = !_obscurePasswordTextValue;
    notifyListeners();
  }
   obscureConformPasswordValue(){
    _obscureConformPasswordValue = !_obscureConformPasswordValue;
    notifyListeners();
  }


  Future<bool> login(LoginModel loginData) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _authRepository.login(loginData);
      print(result);
      _loginAuth = result;
      notifyListeners();
      return result.status ?? false;
    }
    catch (error) {
      _isLoading = true;
      print('this is your error $error');

      notifyListeners();
      return false;
    }
    finally{
      _isLoading = false;
    }
  }

 Future<bool> registration( RegistrationModel registrationModel) async{
    _isLoading = true;
    notifyListeners();

    try{
      final result = await _authRepository.registration(registrationModel);
      _registrationResponse = result;
      notifyListeners();
      return result.status ?? false;
    }catch(error){
      _isLoading = false;

      print('this is your error $error');
      notifyListeners();

      return false;
    }finally{
      _isLoading = false;

    }
  }

 Future<bool> otpVerify( VerifyOTPModel verifyOtoModel) async{
    _isLoading = true;
    notifyListeners();

    try{
      final result = await _authRepository.verifyOTP(verifyOtoModel);
      _otpVarification = result;
      notifyListeners();
      return result.status ?? false;
    }catch(error){
      _isLoading = false;

      print('this is your error $error');
      notifyListeners();

      return false;
    }finally{
      _isLoading = false;

    }
  }

 Future<bool> resendOtp( String email) async{
   _isResendLoading = true;
    notifyListeners();

    try{
      final result = await _authRepository.resendOTP(email);
      _otpResendVarification = result;
      notifyListeners();
      return result.status ?? false;
    }catch(error){
      _isResendLoading = false;

      print('this is your error $error');
      notifyListeners();

      return false;
    }finally{
      _isResendLoading = false;
      notifyListeners();

    }
  }



}
