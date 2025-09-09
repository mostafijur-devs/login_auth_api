import 'package:flutter/material.dart';
import 'package:login_auth_model/provider/auth/auth_provider.dart';
import 'package:login_auth_model/widgets/custom_input_text_field.dart';
import 'package:provider/provider.dart';

import 'forget_password_send_otp_verification_screen.dart';

class ForgetPasswordOtpSendScreen extends StatefulWidget {
   const ForgetPasswordOtpSendScreen({super.key});

  @override
  State<ForgetPasswordOtpSendScreen> createState() => _ForgetPasswordOtpSendScreenState();
}

class _ForgetPasswordOtpSendScreenState extends State<ForgetPasswordOtpSendScreen> {
  final TextEditingController _emailController = TextEditingController();

  final  _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Forget password OTP send screen'),
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
                Text('Type your registered email or phone number to receive OTP'),
                SizedBox(height: 20,),
                CustomInputTextField(
                  textEditingController: _emailController,
                    hintText: 'Please input your valid email or phone number',
                    labelText: 'Email or Phone Number',
                  keyboardType: TextInputType.emailAddress,
                  validationError: (value) {
                    return validation(value,authProvider);
                  },

                ),
                SizedBox(height: 20,),
               authProvider.isForgetPasswordResendLoading ? CircularProgressIndicator(): ElevatedButton(onPressed: () async {
                 await _save( context);
                }, child: Text('Continue'))

              ],
            ),
          ),
        ),
      ),
    );
  }

   _save(BuildContext context) async{
     if(_formKey.currentState!.validate()){
       final success = await context.read<AuthProvider>().forgetPasswordResendOtp(_emailController.text.trim());

       final  provider =  context.read<AuthProvider>().forgetResendOtpResponse;
       print(success);

       print(_emailController.text);
       if(success){
         Navigator.push(context, MaterialPageRoute(builder: (context) =>ForgetPasswordSendOtpVerificationScreen(email: _emailController.text.trim(),) ,));
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text( provider?.message ?? 'Success')));
       }else{

         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text( provider?.message ?? ' failed')));
       }


     }
   }

   //  validation(String? value, AuthProvider authProvider) {
   String? validation(String? value, AuthProvider authProvider) {
     if (value == null || value.trim().isEmpty) {
       return 'Email is required';
     }
     if (value.length < 5) {
       return 'Email is too short';
     }
     final emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
     if (!emailRegExp.hasMatch(value.trim())) {
       return 'Please enter a valid email address';
     }
     return null;
   }
}
