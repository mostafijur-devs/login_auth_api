import 'package:firebase_auth/firebase_auth.dart';

abstract class GoogleSingInRepo{

  Future<User?> googleSingIn();
  Future<void> googleSingOut();
}