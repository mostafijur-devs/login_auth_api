import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:login_auth_model/model/auth/verify_otp/verify_otp_model.dart';
import 'package:login_auth_model/services/auth_service/auth_services.dart';
import '../../model/auth/auth_response.dart';
import '../../model/auth/login_auth_model/login_model.dart';
import '../../model/auth/registration_auth_model/registration_model.dart';
import '../../model/auth/reset_password_model/reset_password_model.dart';
import '../../model/auth/user_response.dart';
import '../../repository/auth_repository.dart';

class ApiAuthProvider extends ChangeNotifier {
  /// Repository call
  final AuthRepository _authRepository = AuthServices();
  final int _resendTimeCount = 10;

  /// login auth API response models
  UserResponse? _userResponse;
  AuthResponse? _loginAuth;
  AuthResponse? _otpVarification;
  AuthResponse? _otpResendVarification;
  AuthResponse? _registrationResponse;
  AuthResponse? _forgetPasswordResendOtpResponse;
  AuthResponse? _forgetPasswordVarifyResponse;
  AuthResponse? _passwordWithTokenResponse;

  /// API request waiting loading private variable
  bool _isLoginLoading = false;
  bool _isRegistrationLoading = false;
  bool _isRegistrationOtpVarifyLoading = false;
  bool _isRegistrationResendLoading = false;
  bool _isForgetPasswordResendLoading = false;
  bool _isForgetPasswordVarifyLoading = false;
  bool _isChangingConformPasswordLoading = false;
  bool _isResend = false;
  late int _resendTime;
  Timer? _timer;

  /// obscure password calling private variable
  bool _obscurePasswordTextValue = true;
  bool _obscureConformPasswordValue = true;


  /// login auth API response models getter methods
  AuthResponse? get loginAuth => _loginAuth;

  UserResponse? get userResponse => _userResponse;

  AuthResponse? get otpVarification => _otpVarification;

  AuthResponse? get otpResendVarification => _otpResendVarification;

  AuthResponse? get registrationResponse => _registrationResponse;

  AuthResponse? get forgetResendOtpResponse => _forgetPasswordResendOtpResponse;

  AuthResponse? get forgetPasswordVarifyResponse =>
      _forgetPasswordVarifyResponse;

  AuthResponse? get passwordWithToken => _passwordWithTokenResponse;

  /// resend verify Timer setting

  bool get isResend => _isResend;
  int get resendTime => _resendTime;

  /// API request waiting loading private variable getter methods
  bool get isLoginLoading => _isLoginLoading;

  bool get isRegistrationLoading => _isRegistrationLoading;

  bool get isOtpVarifyLoading => _isRegistrationOtpVarifyLoading;

  bool get isResendLoading => _isRegistrationResendLoading;

  bool get isForgetPasswordResendLoading => _isForgetPasswordResendLoading;

  bool get isForgetPasswordVarifyLoading => _isForgetPasswordVarifyLoading;

  bool get isChangingConformPasswordLoading =>
      _isChangingConformPasswordLoading;

  /// obscure password calling private variable getter methods
  bool get obscureConformPasswordTextValue => _obscureConformPasswordValue;

  bool get obscurePasswordTextValue => _obscurePasswordTextValue;

  /// obscure password calling function
  obscurePasswordValue() {
    _obscurePasswordTextValue = !_obscurePasswordTextValue;
    notifyListeners();
  }

  obscureConformPasswordValue() {
    _obscureConformPasswordValue = !_obscureConformPasswordValue;
    notifyListeners();
  }

  Future<UserResponse?> getUser(String userToken) async {
    _isRegistrationLoading = true;
    notifyListeners();

    try {
      final result = await _authRepository.getUser(userToken);
      _userResponse = result;

      // Debugging
      print("Provider data call: ${result?.status}, ${result?.message}");

      return _userResponse;
    } catch (error) {
      debugPrint('REGISTRATION error: $error');
      return null;
    } finally {
      _isRegistrationLoading = false;
      notifyListeners(); // ✅ UI update
    }
  }




  void startResendOTP( VoidCallback? onTimerFinish ){
    _isResend = false;
    notifyListeners();
    _resendTime = _resendTimeCount;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(_resendTime > 0){
        _resendTime--;
        notifyListeners();
      }
      else{
        timer.cancel();
        _isResend = true;
        _resendTime = _resendTimeCount;
        notifyListeners();
        if(onTimerFinish != null){
          onTimerFinish();
        }
      }

    },);

  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  /// Login API call to repository
  Future<bool> login(LoginModel loginData) async {
    _isLoginLoading = true;
    notifyListeners();

    try {
      final result = await _authRepository.login(loginData);
      _loginAuth = result;
      notifyListeners();
      return result.status ?? false;
    } catch (error) {
      _isLoginLoading = true;
      if (kDebugMode) {
        print('this is your LOGIN error $error');
      }

      notifyListeners();
      return false;
    } finally {
      _isLoginLoading = false;
    }
  }

  /// Registration API call to repository

  Future<bool> registration(RegistrationModel registrationModel) async {
    _isRegistrationLoading = true;
    notifyListeners();

    try {
      final result = await _authRepository.registration(registrationModel);
      _registrationResponse = result;
      notifyListeners();
      return result.status ?? false;
    } catch (error) {
      _isRegistrationLoading = false;

      debugPrint('this is your REGISTRATION error $error');

      notifyListeners();

      return false;
    } finally {
      _isRegistrationLoading = false;
      notifyListeners();

    }
  }

  /// OTP Verify API call to repository

  Future<bool> registrationOtpVerify(VerifyOTPModel verifyOtoModel) async {
    _isRegistrationOtpVarifyLoading = true;
    notifyListeners();

    try {
      final result = await _authRepository.verifyOTP(verifyOtoModel);
      _otpVarification = result;
      notifyListeners();
      return result.status ?? false;
    } catch (error) {
      _isRegistrationOtpVarifyLoading = false;

      if (kDebugMode) {
        print('this is your OTP Verification error $error');
      }
      notifyListeners();

      return false;
    } finally {
      _isRegistrationOtpVarifyLoading = false;
    }
  }

  /// Re-send OTP API call to repository
  Future<bool> registrationResendOtp(String email) async {
    _isRegistrationResendLoading = true;
    notifyListeners();

    try {
      final result = await _authRepository.resendOTP(email);
      _otpResendVarification = result;
      notifyListeners();
      return result.status ?? false;
    } catch (error) {
      _isRegistrationResendLoading = false;

      if (kDebugMode) {
        print('this is your Resend OTP error $error');
      }
      notifyListeners();

      return false;
    } finally {
      _isRegistrationResendLoading = false;
      notifyListeners();
    }
  }

  Future<bool> forgetPasswordResendOtp(String email) async {
    _isForgetPasswordResendLoading = true;
    notifyListeners();

    try {
      final result = await _authRepository.forgetPasswordResetOtp(email);
      _forgetPasswordResendOtpResponse = result;
      notifyListeners();
      return result.status ?? false;
    } catch (error) {
      _isForgetPasswordResendLoading = false;

      notifyListeners();

      return false;
    } finally {
      _isForgetPasswordResendLoading = false;
      notifyListeners();
    }
  }

  Future<bool> forgetPasswordVarify({required String resetOtp, required String email,}) async {
    _isForgetPasswordVarifyLoading = true;
    notifyListeners();

    try {
      final result = await _authRepository.requestPasswordReset(
        resetOtp: resetOtp,
        email: email,
      );
      _forgetPasswordVarifyResponse= result;
      notifyListeners();
      return result.status ?? false;
    } catch (error) {
      _isForgetPasswordVarifyLoading = false;

      if (kDebugMode) {
        print('this is your(*** ForgetPasswordVarify ***) error $error');
      }
      notifyListeners();

      return false;
    } finally {
      _isForgetPasswordVarifyLoading = false;
      notifyListeners();
    }
  }

  Future<bool> changingConformPassword( ResetPasswordModel resetPasswordModel) async {
    _isChangingConformPasswordLoading = true;
    notifyListeners();

    try {
      final result = await _authRepository.passwordWithToken(resetPasswordModel);
      _passwordWithTokenResponse = result;
      notifyListeners();
      return result.status ?? false;
    } catch (error) {
      _isChangingConformPasswordLoading = false;

      if (kDebugMode) {
        print('this is your (***ChangingConformPassword***) error $error');
      }
      notifyListeners();

      return false;
    } finally {
      _isChangingConformPasswordLoading = false;
      notifyListeners();
    }
  }
}
