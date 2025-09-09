import 'package:flutter/material.dart';
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
    final provider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey, // এখানে key অ্যাড করা হলো
            child: Column(
              children: [
                const Spacer(),
                const Text(
                  'Login Screen',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),

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
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
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
                  suffixIcon: const Icon(Icons.lock),
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
                const SizedBox(height: 20),

                /// Login Button
                provider.isLoginLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: () async {
                    await _loginFunction(context);
                  },
                  child: const Text('Login'),
                ),

                const SizedBox(height: 20),

                /// Registration Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationScreen(),
                      ),
                    );
                  },
                  child: const Text('Go to Registration'),
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Login Function
  // Future<void> _loginFunction(BuildContext context) async {
  //   if (_formKey.currentState!.validate()) {
  //     /// Create login data
  //     final loginData = LoginModel(
  //       email: _emailController.text.trim(),
  //       password: _passwordController.text.trim(),
  //     );
  //
  //     /// Call provider method
  //     if (!mounted) return;
  //     ///
  //     final isSuccess = await context.read<AuthProvider>().login(loginData);
  //     final authResponse = context.read<AuthProvider>().loginAuth;
  //
  //     if (isSuccess) {
  //       if (!mounted) return;
  //
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => const HomePage()),
  //       );
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(authResponse?.message ?? 'Login Successful')),
  //       );
  //     } else {
  //       // if (!mounted) return;
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(authResponse?.message ?? 'Login Failed')),
  //       );
  //     }
  //   }
  // }
  Future<void> _loginFunction(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final loginData = LoginModel(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    final isSuccess = await context.read<AuthProvider>().login(loginData);

    /// widget  tree তে আছে কিনা তা এখানে একবার চেক করলেই যথেষ্ট
    if (!context.mounted) return;

    final authResponse = context.read<AuthProvider>().loginAuth;

    if (isSuccess) {
      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
      _showSnackBar(authResponse?.message ?? 'Login Successful');
    } else {
      _showSnackBar(authResponse?.message ?? 'Login Failed');
    }
  }

  /// SnackBar আলাদা ফাংশনে রাখা হলো
  void _showSnackBar(String message) {
    if (!mounted) return; // নিরাপদ
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

}
