import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_auth_model/model/auth/verify_otp/verify_otp_model.dart';
import 'package:login_auth_model/provider/auth/auth_provider.dart';
import 'package:login_auth_model/screen/home_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:provider/provider.dart';

import '../../provider/local_database_provider/local_bd_provider.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;

  const VerifyOtpScreen({super.key, required this.email});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {

  final TextEditingController _verifyOtpController = TextEditingController();
  /// Form Key for Validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    super.initState();
    context.read<AuthProvider>().startResendOTP(
      () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Timer finished! You can resend OTP now."),
            duration: Duration(seconds: 2),
          ),
        );

      },
    );
  }


  @override
  Widget build(BuildContext context) {
    print('Registration OTP varification Screen');

    final provider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// OTP Input Field
                Text('Registration OTP Verification',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.green),),
                const SizedBox(height: 20),
                Text('Please submit your sending OTP',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.blueAccent),),
                const SizedBox(height: 20),
                PinCodeTextField(
                  controller:_verifyOtpController ,
                  appContext: context,
                  length: 6, // OTP length
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  errorTextMargin:  EdgeInsets.all(20),
                  scrollPadding: EdgeInsets.all(20),
                  errorTextSpace: 2,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(6),
                    fieldHeight: 50,
                    fieldWidth: 45,
                    activeFillColor: Colors.white,
                    activeColor: Colors.green,
                    selectedColor: Colors.blue,
                    inactiveColor: Colors.grey,
                  ),

                  onChanged: (value) {
                  },
                  onCompleted: (value) {
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

                if(!authProvider.isResend)
                Consumer<AuthProvider>(
                  builder: (context, value, child) =>Text('Resend otp ${value.resendTime}')),

                /// Resend OTP Button
                if(authProvider.isResend)
                provider.isResendLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: () async {
                    await _resendOTP(context);
                  },
                  child: const Text('Resend OTP'),
                ),
                // CustomInputTextField(
                //   hintText: 'Please input your OTP',
                //   labelText: 'OTP',
                //   keyboardType: TextInputType.number,
                //   textEditingController: verifyOtpController,
                //   validationError: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'OTP is required';
                //     } else if (value.length < 4) {
                //       return 'OTP must be at least 4 digits';
                //     }
                //     return null;
                //   },
                // ),
                // OtpTextField(
                //   keyboardType: TextInputType.number,
                //   numberOfFields: 6,
                //   borderColor: Colors.green,
                //   contentPadding: EdgeInsets.zero,
                //   showFieldAsBox: true,
                //   // readOnly: true,
                //   cursorColor: Colors.red,
                //   enabledBorderColor: Colors.redAccent,
                //   showCursor: false,
                //
                // ),

              ],
            ),
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
      otp: _verifyOtpController.text.trim(),
    );

    final isSuccess = await provider.registrationOtpVerify(verifyOtpModel);

    if (!context.mounted) return;

    if (isSuccess) {
      /// Navigate to Home Page
      context.read<LocalDbProvider>().setLoginToken(provider.otpVarification?.data?.token ?? '');

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
      context.read<AuthProvider>().startResendOTP(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Timer finished! You can resend OTP now."),
            duration: Duration(seconds: 2),
          ),
        );

      },);
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
