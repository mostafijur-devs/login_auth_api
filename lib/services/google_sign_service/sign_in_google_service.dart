import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../repository/google_sinIn/google_sing_in_repo.dart';

class SignInGoogleService extends GoogleSingInRepo {
  final String webClientId =
      "148341878787-udj78jdq1q5p6ctb9e27p9qurd8tt2me.apps.googleusercontent.com";

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn singIn = GoogleSignIn.instance;

  User? get user => FirebaseAuth.instance.currentUser;

  @override
  Future<User?> googleSingIn() async {
    await singIn.initialize(serverClientId: webClientId);
    GoogleSignInAccount account = await singIn.authenticate();
    GoogleSignInAuthentication googleAuth = account.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,

    );
    final userCadential = await firebaseAuth.signInWithCredential(credential);
    return userCadential.user;
  }

  @override
  Future<void> googleSingOut() async {
    await singIn.signOut();
    await firebaseAuth.signOut();
  }
}


