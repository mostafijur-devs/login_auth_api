import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_auth_model/model/auth/login_auth_model/login_model.dart';
import 'package:login_auth_model/model/auth/login_auth_model/login_response_model.dart';
import 'package:login_auth_model/provider/auth/auth_provider.dart';
import 'package:login_auth_model/screen/auth/registration_screen.dart';
import 'package:login_auth_model/screen/home_page.dart';
import 'package:login_auth_model/widgets/custom_input_text_field.dart';
import 'package:provider/provider.dart';

import '../../model/auth/registration_auth_model/error_registration.dart';
import '../../services/api_uri.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            child: Builder(
              builder: (context) {
                return Column(
                  children: [
                    Spacer(),
                    Text('Login Screen'),
                    Spacer(),
                    CustomInputTextField(
                      hintText: 'Enter your email',
                      labelText: "Email",
                      textEditingController: _emailController,
                      validationError:provider.loginAuth?.message ??'Please enter your email' ,
                    ),
                    SizedBox(height: 20),
                    CustomInputTextField(
                      hintText: 'Enter your password',
                      labelText: "Password",
                      textEditingController: _passwordController,
                      validationError:provider.loginAuth?.message ??'Please enter your password ' ,
                    ),
                    SizedBox(height: 20),

                    provider.isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () async {
                              await _loginFunction(context);
                            },
                            child: Text('Login'),
                          ),

                    SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegistrationScreen(),
                          ),
                        );
                      },
                      child: Text('registrstion buton'),
                    ),

                    Spacer(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  _loginFunction(BuildContext context) async {
    if (Form.of(context).validate()) {
      final login = LoginModel(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      final isSuccess = await context.read<AuthProvider>().login(login);
      final authResponse = context.read<AuthProvider>().loginAuth;

      if (isSuccess) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(authResponse?.message ?? '')));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(authResponse?.message ?? '')));
      }
    }
  }
}
