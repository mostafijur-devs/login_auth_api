import 'package:flutter/material.dart';
import 'package:login_auth_model/model/auth/verify_otp/verify_otp_model.dart';
import 'package:login_auth_model/provider/auth/auth_provider.dart';
import 'package:login_auth_model/screen/home_page.dart';
import 'package:login_auth_model/widgets/custom_input_text_field.dart';
import 'package:provider/provider.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;

  const VerifyOtpScreen({super.key, required this.email});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController verifyOtpController = TextEditingController();

  /// Form Key for Validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// OTP Input Field
              CustomInputTextField(
                hintText: 'Please input your OTP',
                labelText: 'OTP',
                keyboardType: TextInputType.number,
                textEditingController: verifyOtpController,
                validationError: (value) {
                  if (value == null || value.isEmpty) {
                    return 'OTP is required';
                  } else if (value.length < 4) {
                    return 'OTP must be at least 4 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              /// Verify OTP Button
              provider.isOtpVarifyLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () async {
                  await _verifyOTP(context);
                },
                child: const Text('Verify OTP'),
              ),

              const SizedBox(height: 20),

              /// Resend OTP Button
              provider.isResendLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () async {
                  await _resendOTP(context);
                },
                child: const Text('Resend OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Verify OTP Method
  Future<void> _verifyOTP(BuildContext context) async {
    final provider = Provider.of<AuthProvider>(context, listen: false);

    /// Validate Form
    if (!_formKey.currentState!.validate()) return;

    final verifyOtpModel = VerifyOTPModel(
      email: widget.email,
      otp: verifyOtpController.text.trim(),
    );

    final isSuccess = await provider.registrationOtpVerify(verifyOtpModel);

    if (!context.mounted) return;

    if (isSuccess) {
      /// Navigate to Home Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.otpVarification?.message ?? 'OTP Verified Successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.otpVarification?.message ?? 'OTP Verification Failed')),
      );
    }
  }

  /// Resend OTP Method
  Future<void> _resendOTP(BuildContext context) async {
    final provider = Provider.of<AuthProvider>(context, listen: false);

    final isSuccess = await provider.registrationResendOtp(widget.email);

    if (!context.mounted) return;

    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.otpResendVarification?.message ?? 'OTP Resent Successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.otpResendVarification?.message ?? 'OTP Resend Failed')),
      );
    }
  }
}
