import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:login_auth_model/repository/google_sinIn/google_sing_in_repo.dart';
import 'package:login_auth_model/services/google_sign_service/sign_in_google_service.dart';

class GoogleSignProvider extends ChangeNotifier{

  final GoogleSingInRepo _googleSingInRepo = SignInGoogleService();

   User? _googleUser;
   bool _isLoading = false;

  User? get currentUser => FirebaseAuth.instance.currentUser;

  User? get googleUser => _googleUser;
  bool get isLoading => _isLoading;


  googleSingIn()async{
    try{
      _isLoading = true;
      notifyListeners();
      _googleUser = await _googleSingInRepo.googleSingIn();
    }catch(e){
      throw '$e';
    }finally{
      _isLoading = false;
      notifyListeners();
    }

  }

  Future<void> googleSingOut()async{
    try{
      _isLoading = true;
      notifyListeners();
    await _googleSingInRepo.googleSingOut();

  }catch(error){
      throw '$error';

    }
    finally{
      _isLoading = false;
      notifyListeners();
    }
  }



}