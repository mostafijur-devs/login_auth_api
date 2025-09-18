import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_auth_model/screen/auth/firebase_phone_number_login/otp_varification_phone.dart';
import 'package:login_auth_model/widgets/custom_input_text_field.dart';

class PhoneAuthScreen extends StatefulWidget {
 const  PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final _formKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();

   // String verificationId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login to phone number '), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(

            children: [
              Image.asset('assets/images/phone.png',height: 100,),
              SizedBox(height: 20,),
              Text('Please input your Mobile Number',style: TextStyle(fontSize: 22),),
              SizedBox(height: 40,),
              CustomInputTextField(
                textEditingController: _phoneController,
                hintText: 'Please enter your number',
                labelText: 'Number',
                validationError: (value) {
                  if(value == null || value.isEmpty){
                    return ' Please input your Phone number';
                  }
                  return null ;
                },
              ),

              SizedBox(height: 20,),

              ElevatedButton(onPressed: () async{
                await sendOTP(context);
              }, child: Text('Send otp')),
            ],
          ),
        ),
      ),
    );
  }

   Future<void> sendOTP( BuildContext context) async {

     if (_formKey.currentState!.validate()) {
       await FirebaseAuth.instance.verifyPhoneNumber(
         phoneNumber: "+88${_phoneController.text}",
         verificationCompleted: (PhoneAuthCredential credential) async {

         },
         verificationFailed: (FirebaseAuthException e) {
           print('This is $e');
           ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text("Error: ${e.message}")),

           );
         },
         codeSent: (String verificationId, int? resendToken) {


           ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(content: Text("OTP Sent Successfully!")),
           );
           Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVarificationPhone( verificationId: verificationId,),));

         },
         codeAutoRetrievalTimeout: (String id) {

         },
       );
     }


   }

}
