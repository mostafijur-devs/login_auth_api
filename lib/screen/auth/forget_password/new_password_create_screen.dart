
import 'package:flutter/material.dart';
import 'package:login_auth_model/model/auth/reset_password_model/reset_password_model.dart';
import 'package:login_auth_model/screen/auth/login_screen.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth/auth_provider.dart';
import '../../../widgets/custom_input_text_field.dart';

class NewPasswordCreateScreen extends StatelessWidget {
  NewPasswordCreateScreen({super.key });


  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _conformPasswordTextController = TextEditingController();
  final  _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print('Create new password screen Screen');

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
                /// Password Field
                CustomInputTextField(
                  textEditingController: _passwordTextController,
                  keyboardType: TextInputType.visiblePassword,
                  labelText: 'Password',
                  hintText: 'Please enter your password',
                  validationError: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return authProvider.forgetPasswordVarifyResponse?.errors?.password?.first.toString() ?? 'Please input your password';
                    }
                    if (value.length < 6) {
                      return authProvider.forgetPasswordVarifyResponse?.errors?.password?.first.toString()??'Password must be at least 6 characters';
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
                  labelText: 'Confirm Password',
                  hintText: 'Please re-enter your password',
                  validationError: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return authProvider.forgetPasswordVarifyResponse?.errors?.passwordConfirmation?.first.toString()??'Please confirm your password';
                    }
                    if (value != _conformPasswordTextController.text.trim()) {
                      return authProvider.forgetPasswordVarifyResponse?.errors?.passwordConfirmation?.first.toString()?? 'Passwords do not match';
                    }
                    return null;
                  },
                  // validationError: data?.errors?.passwordConfirmation?.first.toString(),
                ),
                const SizedBox(height: 20),
                authProvider.isChangingConformPasswordLoading ? CircularProgressIndicator():
                ElevatedButton(
                    onPressed: () async {
                     await _savePassword(context,authProvider);
                }, child: Text('Continue'))

              ],
            ),
          ),
        ),
      ),
    );
  }
  _savePassword(BuildContext context, AuthProvider authProvider) async{
    if(_formKey.currentState!.validate()){
     final resetPasswordModel = ResetPasswordModel(
       password: _passwordTextController.text.trim(),
       passwordConfirmation: _conformPasswordTextController.text.trim(),
       resetToken: authProvider.forgetPasswordVarifyResponse?.data?.resetToken ?? ''
     );
      final success = await authProvider.changingConformPassword(resetPasswordModel);
      if(success){
        if(!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text( authProvider.forgetPasswordVarifyResponse?.message ?? 'Success')));

        Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginScreen()));
      }else{
        if(!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text( authProvider.forgetPasswordVarifyResponse?.message ?? ' failed')));


      }
    }

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
