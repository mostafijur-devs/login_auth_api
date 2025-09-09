import 'package:flutter/material.dart';
import 'package:login_auth_model/screen/auth/new_password_create_screen.dart';
import 'package:login_auth_model/screen/home_page.dart';
import 'package:provider/provider.dart';

import '../../provider/auth/auth_provider.dart';
import '../../widgets/custom_input_text_field.dart';

class ForgetPasswordSendOtpVerificationScreen extends StatelessWidget {
   ForgetPasswordSendOtpVerificationScreen({super.key ,required this.email});
   final String? email;

  final TextEditingController _otpController = TextEditingController();
  final  _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget password OTP varification screen'),
        centerTitle: true,
      ),

      body:Consumer<AuthProvider>(
        builder: (context, authProvider, child) =>Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterLogo(),
                Text('Forgot your password?',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text('Please send your OTP'),
                SizedBox(height: 20,),
                CustomInputTextField(
                  textEditingController: _otpController,
                  hintText: 'Please input your valid email or phone number',
                  labelText: 'Email or Phone Number',
                  keyboardType: TextInputType.emailAddress,
                  validationError: (value) {
                    return validation(value,authProvider);
                  },

                ),
                SizedBox(height: 20,),
                authProvider.isForgetPasswordVarifyLoading ? CircularProgressIndicator(): ElevatedButton(onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    final success = await authProvider.forgetPasswordVarify(resetOtp: _otpController.text.trim(), email: email ?? '');
                    if(success){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>NewPasswordCreateScreen()));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text( authProvider.forgetPasswordVarifyResponse?.message ?? 'Success')));
                      print(authProvider.forgetPasswordVarifyResponse?.data?.resetToken ?? '');
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text( authProvider.forgetPasswordVarifyResponse?.message ?? ' failed')));

                      
                    }
                  }
                }, child: Text('Continue'))

              ],
            ),
          ),
        ),
      ),
    );
  }
   validation(String? value, AuthProvider authProvider) {
     if (value == null || value.trim().isEmpty) {
       return authProvider.forgetResendOtpResponse?.errors?.email?.first ?? 'Email is required';
     }
     // Step 2: Length check
     if (value.length <= 5) {
       return authProvider.forgetResendOtpResponse?.errors?.email?.first ?? 'Email is too short';
     }
     if (value.length >= 7) {
       return authProvider.forgetResendOtpResponse?.errors?.email?.first ?? 'Email is too long';
     }

     return null;
   }
}
