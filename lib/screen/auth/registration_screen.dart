import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_auth_model/model/auth/registration_auth_model/registration_model.dart';
import 'package:login_auth_model/provider/auth/auth_provider.dart';
import 'package:login_auth_model/screen/auth/verify_otp_screen.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_input_text_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  /// TextEditingControllers
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _conformPasswordTextController = TextEditingController();

  /// Global Form Key
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailTextController.dispose();
    _nameTextController.dispose();
    _passwordTextController.dispose();
    _conformPasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Registration Screen');

    return Scaffold(
      appBar: AppBar(title: const Text('Registration Page')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            bool obscurePasswordTextValue = authProvider.obscurePasswordTextValue;
            bool obscureConformPasswordTextValue =
                authProvider.obscureConformPasswordTextValue;

            final data = authProvider.registrationResponse;

            return SingleChildScrollView(
              child: Form(
                key: _formKey, // <-- Use form key here
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Name Field
                    CustomInputTextField(
                      textEditingController: _nameTextController,
                      labelText: 'Name',
                      hintText: 'Please enter your name',
                      suffixIcon: const Icon(Icons.person),
                      validationError: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return data?.errors?.name?.first.toString() ?? 'Please input your name';
                        }
                        return null;
                      },
                      // validationError: data?.errors?.name?.first.toString(),
                    ),
                    const SizedBox(height: 20),

                    /// Email Field
                    CustomInputTextField(
                      textEditingController: _emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      labelText: 'Email',
                      hintText: 'Please enter your email',
                      suffixIcon: const Icon(Icons.email),
                      validationError: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return data?.errors?.email?.first.toString()??'Please input your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return data?.errors?.email?.first.toString()??'Please enter a valid email';
                        }
                        return null;
                      },
                      // validationError: data?.errors?.email?.first.toString(),
                    ),
                    const SizedBox(height: 20),

                    /// Password Field
                    CustomInputTextField(
                      textEditingController: _passwordTextController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureTextValue: obscurePasswordTextValue,
                      labelText: 'Password',
                      hintText: 'Please enter your password',
                      suffixTconButton: IconButton(
                        onPressed: () {
                          authProvider.obscurePasswordValue();
                        },
                        icon: obscurePasswordTextValue
                            ? const Icon(CupertinoIcons.eye_slash)
                            : const Icon(CupertinoIcons.eye),
                      ),
                      validationError: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return data?.errors?.password?.first.toString() ?? 'Please input your password';
                        }
                        if (value.length < 6) {
                          return data?.errors?.password?.first.toString()??'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      // validationError: data?.errors?.password?.first.toString(),
                    ),
                    const SizedBox(height: 20),

                    /// Confirm Password Field
                    CustomInputTextField(
                      textEditingController: _conformPasswordTextController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureTextValue: obscureConformPasswordTextValue,
                      labelText: 'Confirm Password',
                      hintText: 'Please re-enter your password',
                      suffixTconButton: IconButton(
                        onPressed: () {
                          authProvider.obscureConformPasswordValue();
                        },
                        icon: obscureConformPasswordTextValue
                            ? const Icon(CupertinoIcons.eye_slash)
                            : const Icon(CupertinoIcons.eye_fill),
                      ),
                      validationError: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return data?.errors?.passwordConfirmation?.first.toString()??'Please confirm your password';
                        }
                        if (value != _passwordTextController.text.trim()) {
                          return data?.errors?.passwordConfirmation?.first.toString()?? 'Passwords do not match';
                        }
                        return null;
                      },
                      // validationError: data?.errors?.passwordConfirmation?.first.toString(),
                    ),
                    const SizedBox(height: 20),

                    /// Registration Button
                    authProvider.isRegistrationLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: () async {
                        await _saveRegistration(context);
                      },
                      child: const Text('Registration'),
                    ),
                    const SizedBox(height: 20),

                    /// Resend OTP Button
                    ElevatedButton(
                      onPressed: () {
                        debugPrint(_emailTextController.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerifyOtpScreen(
                              email: _emailTextController.text,
                            ),
                          ),
                        );
                      },
                      child: const Text('Resend OTP'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Save Registration Method
  Future<void> _saveRegistration(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final registrationData = RegistrationModel(
        name: _nameTextController.text.trim(),
        email: _emailTextController.text.trim(),
        password: _passwordTextController.text.trim(),
        passwordConfirmation: _conformPasswordTextController.text.trim(),
      );

      bool isSuccess =
      await context.read<AuthProvider>().registration(registrationData);

      if (!context.mounted) return;

      final registrationResponse =
          context.read<AuthProvider>().registrationResponse;

      if (isSuccess) {
        if (!context.mounted) return;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyOtpScreen(
              email: _emailTextController.text.trim(),
            ),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(registrationResponse?.message ?? 'Success')),
        );
      } else {
        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(registrationResponse?.message ?? 'Failed')),
        );
      }
    }
  }
}
