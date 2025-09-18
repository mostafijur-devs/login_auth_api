import 'package:flutter/material.dart';
import 'package:login_auth_model/screen/auth/forget_password/new_password_create_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../../provider/auth/auth_provider.dart';

class ForgetPasswordSendOtpVerificationScreen extends StatefulWidget {
   const ForgetPasswordSendOtpVerificationScreen({
    super.key,
    required this.email,
  });

  final String? email;

  @override
  State<ForgetPasswordSendOtpVerificationScreen> createState() => _ForgetPasswordSendOtpVerificationScreenState();
}

class _ForgetPasswordSendOtpVerificationScreenState extends State<ForgetPasswordSendOtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


@override
  void initState() {
    super.initState();

    context.read<ApiAuthProvider>().startResendOTP(() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Timer finished! You can resend OTP now."),
          duration: Duration(seconds: 2),
        ),
      );

    },);
  }
  @override
  Widget build(BuildContext context) {
    print('Forget password send OTP  verification Screen');

    return Scaffold(
      appBar: AppBar(
        title: Text('Forget password Verification OTP'),
        centerTitle: true,
      ),

      body: Consumer<ApiAuthProvider>(
        builder: (context, authProvider, child) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterLogo(),
                Text(
                  'Verification OTP',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text('Please submit your OTP'),
                SizedBox(height: 20),
                // CustomInputTextField(
                //   textEditingController: _otpController,
                //   hintText: 'Please input your valid email or phone number',
                //   labelText: 'Email or Phone Number',
                //   keyboardType: TextInputType.emailAddress,
                //   validationError: (value) {
                //     return validation(value,authProvider);
                //   },
                //
                // ),
                PinCodeTextField(
                  controller: _otpController,
                  appContext: context,
                  length: 6,
                  // OTP length
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  errorTextMargin: EdgeInsets.all(20),
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

                  onChanged: (value) {},
                  onCompleted: (value) {},
                ),
                SizedBox(height: 20),
                authProvider.isForgetPasswordVarifyLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final success = await authProvider
                                .forgetPasswordVarify(
                                  resetOtp: _otpController.text.trim(),
                                  email: widget.email ?? '',
                                );
                            if (success) {
                              if (!context.mounted) return;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      NewPasswordCreateScreen(),
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    authProvider
                                            .forgetPasswordVarifyResponse
                                            ?.message ??
                                        'Success',
                                  ),
                                ),
                              );
                            } else {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    authProvider
                                            .forgetPasswordVarifyResponse
                                            ?.message ??
                                        ' failed',
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        child: Text('Continue'),
                      ),
                SizedBox(height: 20),

                if (!authProvider.isResend)
                  Text('Resend your OTP in this time ${authProvider.resendTime}'),
                if (authProvider.isResend)
                 authProvider.isForgetPasswordResendLoading?CircularProgressIndicator(): ElevatedButton(
                    onPressed: () async {
                      _resendOtp(context);
                    },
                    child: Text('Resend OTP'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  validation(String? value, ApiAuthProvider authProvider) {
    if (value == null || value.trim().isEmpty) {
      return authProvider.forgetResendOtpResponse?.errors?.email?.first ??
          'Email is required';
    }
    // Step 2: Length check
    if (value.length <= 5) {
      return authProvider.forgetResendOtpResponse?.errors?.email?.first ??
          'Email is too short';
    }
    if (value.length >= 7) {
      return authProvider.forgetResendOtpResponse?.errors?.email?.first ??
          'Email is too long';
    }

    return null;
  }

  void _resendOtp( BuildContext context) async {
    final success =  await context.read<ApiAuthProvider>().forgetPasswordResendOtp(widget.email.toString());
    if(!context.mounted) return;

    final response = context.read<ApiAuthProvider>().forgetResendOtpResponse;
    if(success){
      if(!context.mounted) return;
      if(context.read<ApiAuthProvider>().isResend){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response?.message ?? 'successfully send OTP')));
      context.read<ApiAuthProvider>().startResendOTP(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Timer finished! You can resend OTP now."),
            duration: Duration(seconds: 2),
          ),
        );

      },);
    }}
    else{
      if(!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response?.message ?? ' unSuccessfully send OTP')));

    }
  }
}
