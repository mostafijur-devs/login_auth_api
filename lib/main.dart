import 'package:flutter/material.dart';
import 'package:login_auth_model/provider/auth/auth_provider.dart';
import 'package:login_auth_model/screen/auth/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider(),)
    ],child: const MyApp()),);


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoginScreen() ,
    );
  }
}

