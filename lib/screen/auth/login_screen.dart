import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:login_auth_model/provider/auth/google_sign_provider.dart';
import 'package:login_auth_model/provider/local_database_provider/local_bd_provider.dart';
import 'package:login_auth_model/screen/auth/firebase_phone_number_login/phone_auth_screen.dart';
import 'package:login_auth_model/screen/auth/forget_password/forget_password_otp_send_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:login_auth_model/model/auth/login_auth_model/login_model.dart';
import 'package:login_auth_model/provider/auth/auth_provider.dart';
import 'package:login_auth_model/screen/auth/registration_screen.dart';
import 'package:login_auth_model/screen/home_page.dart';
import 'package:login_auth_model/widgets/custom_input_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  /// Form Key
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<AuthProvider>(context);

    return Scaffold(
      // backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey, // এখানে key অ্যাড করা হলো
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  const Text(
                    'Login Screen',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),

                  FlutterLogo(size: 100),

                  const SizedBox(height: 30),

                  /// Email Field
                  CustomInputTextField(
                    hintText: 'Enter your email',
                    labelText: "Email",
                    textEditingController: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    suffixIcon: const Icon(Icons.email),
                    validationError: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(
                        r'^[^@]+@[^@]+\.[^@]+',
                      ).hasMatch(value.trim())) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  /// Password Field
                  CustomInputTextField(
                    hintText: 'Enter your password',
                    labelText: "Password",
                    textEditingController: _passwordController,
                    obscureTextValue: true,
                    suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                    validationError: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.trim().length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ForgetPasswordOtpSendScreen(),
                            ),
                          );
                        },
                        child: Text('Forget your password'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// Login Button
                  Consumer<ApiAuthProvider>(
                    builder: (context, authProvider, child) =>
                        authProvider.isLoginLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () async {
                              await _loginFunction(context);
                            },
                            child: const Text('Login'),
                          ),
                  ),

                  const SizedBox(height: 20),

                  /// Registration Button
                  SizedBox(height: 20),

                  // Consumer<GoogleSignProvider>(
                  //   builder: (context, googleProvider, child) =>
                  //       googleProvider.isLoading
                  //       ? CircularProgressIndicator(
                  //           backgroundColor: Colors.black,
                  //         )
                  //       : ElevatedButton.icon(
                  //           onPressed: () async {
                  //             await context
                  //                 .read<GoogleSignProvider>()
                  //                 .googleSingIn();
                  //             User? user = googleProvider.currentUser;
                  //
                  //             if (user != null) {
                  //               Navigator.pushReplacement(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                   builder: (context) => HomePage(),
                  //                 ),
                  //               );
                  //             }
                  //           },
                  //           icon: Icon(Icons.g_mobiledata, size: 20),
                  //           label: Text('Google sign in'),
                  //         ),
                  // ),

                  // const SizedBox(height: 20),

                  // /// Registration Button
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     await signInWithFacebook().then((value) {
                  //       Navigator.push(
                  //         context,
                  //         PageTransition(
                  //           type: PageTransitionType.leftToRight,
                  //           child: HomePage(),
                  //         ),
                  //       );
                  //     });
                  //   },
                  //   child: const Text('Facebook Login'),
                  // ),
                  Row(
                    // spacing: 30 ,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.leftToRight,
                              child: RegistrationScreen(),
                            ),
                          );
                        },
                        child: const Text('Go to Registration'),
                      ),
                      // const SizedBox(height: 20),

                      // const SizedBox(height: 20),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                    child: Row(
                      children: [
                        Expanded(
                          child: Consumer<GoogleSignProvider>(
                            builder: (context, googleProvider, child) =>
                                TextButton(
                                  onPressed: () async {
                                      await context
                                          .read<GoogleSignProvider>()
                                          .googleSingIn();
                                      User? user = googleProvider.currentUser;

                                      if (user != null) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomePage(),
                                          ),
                                        );
                                      }
                                    },
                                    child: Image.asset(
                                      'assets/images/google.png',
                                      height: 60,
                                      // color: Colors.red,
                                    ),
                                  ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () async {
                              await signInWithFacebook().then((value) {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    child: HomePage(),
                                  ),
                                );
                              });
                            },
                            child: Image.asset(
                              'assets/images/facebook.png',
                              height: 90,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () async { Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: PhoneAuthScreen(),
                              ),
                            );
                            },
                            child: Image.asset(
                              'assets/images/phone.png',
                              height: 60,
                            ),
                          ),
                        ),
                        // Expanded(
                        //   child:
                        // ),
                      ],
                    ),
                  ),

                  // Spacer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();



    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(
          '${loginResult.accessToken?.tokenString}'
          ,
        );

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<void> _loginFunction(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final loginData = LoginModel(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    final isSuccess = await context.read<ApiAuthProvider>().login(loginData);

    /// widget  tree তে আছে কিনা তা এখানে একবার চেক করলেই যথেষ্ট
    if (!context.mounted) return;

    final authResponse = context.read<ApiAuthProvider>().loginAuth;

    if (isSuccess) {
      if (!context.mounted) return;
      await context.read<LocalDbProvider>().setLoginToken(
        authResponse!.data!.token!,
      );
      print(authResponse.data!.token!);
      Navigator.pushReplacement(
        context,
        PageTransition(type: PageTransitionType.leftToRight, child: HomePage()),
      );

      _showSnackBar(authResponse.message ?? 'Login Successful');
    } else {
      _showSnackBar(authResponse?.message ?? 'Login Failed');
    }
  }

  /// SnackBar আলাদা ফাংশনে রাখা হলো
  void _showSnackBar(String message) {
    if (!mounted) return; // নিরাপদ
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
