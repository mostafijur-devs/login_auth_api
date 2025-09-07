import 'package:flutter/material.dart';
import 'package:login_auth_model/model/auth/verify_otp/verify_otp_model.dart';
import 'package:login_auth_model/provider/auth/auth_provider.dart';
import 'package:login_auth_model/screen/home_page.dart';
import 'package:login_auth_model/widgets/custom_input_text_field.dart';
import 'package:provider/provider.dart';

class VerifyOtpScreen extends StatefulWidget {

  final String email ;
  const VerifyOtpScreen({super.key, required this.email});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController verifyOtpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP verify'),
      ),
      body: Form(
        child: Builder(
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomInputTextField(
                    hintText: 'Please input your otp', labelText: 'OTP',
                  keyboardType: TextInputType.number,
                  textEditingController: verifyOtpController,
                  // validationError: ,
                ),
                SizedBox(height: 20,),
               context.read<AuthProvider>().isLoading ? CircularProgressIndicator(): ElevatedButton(onPressed: () async{
                 print(widget.email);
                  await _verifyOPT(context);
                }, child: Text('Verify OTP')),
                SizedBox(height: 20,),
                context.read<AuthProvider>().isResendLoading ? CircularProgressIndicator(): ElevatedButton(onPressed: ()async {
                  await _resendOTP(context);
                }, child: Text('Resend OTP'))
              ],
            );
          }
        ),
      ),
    );
  }

  Future<void> _verifyOPT(BuildContext context) async {

    final provider = Provider.of<AuthProvider>(context,listen: false);

    if(Form.of(context).validate()){
      final verifyOtoModel =VerifyOTPModel(
        email: widget.email,
        otp: verifyOtpController.text
      );

      bool isSuccess = await provider.otpVerify(verifyOtoModel);

      // final result = provider.loginAuth;

      if(isSuccess){
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(provider.otpVarification?.message ?? '')));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(provider.otpVarification?.message ?? '')));

      }




    }
  }

  Future<void> _resendOTP(BuildContext context) async {
    final provider = Provider.of<AuthProvider>(context,listen: false);
    if(Form.of(context).validate()) {
      bool isSuccess = await provider.resendOtp(widget.email);

      // final result = provider.loginAuth;

      if (isSuccess) {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => HomePage(),));
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(provider.otpResendVarification?.message ?? '')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(provider.otpResendVarification?.message ?? '')));
      }
    }


  }
}
