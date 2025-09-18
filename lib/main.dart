import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_auth_model/firebase_options.dart';
import 'package:login_auth_model/provider/auth/auth_provider.dart';
import 'package:login_auth_model/provider/auth/google_sign_provider.dart';
import 'package:login_auth_model/provider/local_database_provider/local_bd_provider.dart';
import 'package:login_auth_model/screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ApiAuthProvider(),),
      ChangeNotifierProvider(create: (context) => LocalDbProvider(),),
      ChangeNotifierProvider(create: (context) => GoogleSignProvider(),),
    ],child: const MyApp()),);

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen() ,
    );
  }
}

