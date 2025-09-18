import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_auth_model/widgets/custom_input_text_field.dart';

class OtpVarificationPhone extends StatelessWidget {
  OtpVarificationPhone({super.key , required this.verificationId});

  final String verificationId;
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login to phone number '), centerTitle: true),
      body: Form(
        key: _formKey,
        child: Column(

          children: [
            Image.asset('assets/images/phone.png',height: 100,),
            SizedBox(height: 20,),
            Text('Please input your OTP code',style: TextStyle(fontSize: 22),),
            SizedBox(height: 40,),
            CustomInputTextField(

              textEditingController: _otpController,
              hintText: 'Please enter your OTP',
              labelText: 'OTP Number',
              validationError: (value) {
                if(value == null || value.isEmpty){
                  return ' Please input your OTP number';
                }
                return null ;
              },
            ),

            ElevatedButton(onPressed: ()async {

              await verifyOTP(context);

            }, child: Text('Send otp')),
          ],
        ),
      ),
    );
  }
  Future<void> verifyOTP(BuildContext context) async {
    if(_formKey.currentState!.validate()){

      try {

        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: _otpController.text,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Phone Login Successful!")),
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OtpVarificationPhone( verificationId: verificationId,),));

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }

  }
}
