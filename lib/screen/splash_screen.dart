import 'package:flutter/material.dart';
import 'package:login_auth_model/provider/local_database_provider/local_bd_provider.dart';
import 'package:login_auth_model/screen/auth/login_screen.dart';
import 'package:login_auth_model/screen/home_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _chackLogin();
  }

  void _chackLogin() async {
    await Future.delayed(Duration(seconds: 2)).then((value) {
      if (!mounted) return;
      if (context.read<LocalDbProvider>().userToken != null &&
          context.read<LocalDbProvider>().userToken!.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            duration: Duration(seconds: 1),
            child: HomePage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.rotate,
            alignment: Alignment.center,
            duration: Duration(milliseconds: 3000),

            child: LoginScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: FlutterLogo())),
    );
  }
}
