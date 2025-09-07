import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_auth_model/model/auth/registration_auth_model/registration_model.dart';
import 'package:login_auth_model/provider/auth/auth_provider.dart';
import 'package:login_auth_model/screen/auth/verify_otp_screen.dart';
import 'package:login_auth_model/screen/home_page.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_input_text_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _conformPasswordTextController =
      TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<AuthProvider>().registration(RegistrationModel());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration page')),
      body: Form(
        child: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  bool obscurePasswordTextValue =
                      authProvider.obscurePasswordTextValue;
                  bool obscureConformPasswordTextValue =
                      authProvider.obscureConformPasswordTextValue;
                  final data = authProvider.registrationResponse;
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomInputTextField(
                          textEditingController: _nameTextController,
                          labelText: 'Name',
                          hintText: 'Please enter your name',
                          suffixIcon: Icon(Icons.person),
                          validationError:
                              data?.errors?.email?.first.toString() ??
                              'Please input your name',
                        ),
                        SizedBox(height: 20),
                        CustomInputTextField(
                          textEditingController: _emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          labelText: 'Email',
                          hintText: 'Please enter your email',
                          suffixIcon: Icon(Icons.email),
                          validationError:
                              data?.errors?.email?.first.toString() ??
                              'Please input your email',
                        ),
                        SizedBox(height: 20),
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
                                ? Icon(CupertinoIcons.eye_slash)
                                : Icon(CupertinoIcons.eye),
                          ),
                          validationError:
                              data?.errors?.password?.first.toString() ??
                              'Please input your password',
                        ),
                        SizedBox(height: 20),
                    
                        CustomInputTextField(
                          textEditingController: _conformPasswordTextController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureTextValue: obscureConformPasswordTextValue,
                    
                          labelText: 'Conform password',
                          hintText: 'Please enter your conform password',
                          // suffixIcon: Icon(Icons.email),
                          suffixTconButton: IconButton(
                            onPressed: () {
                              authProvider.obscureConformPasswordValue();
                            },
                            icon: obscureConformPasswordTextValue
                                ? Icon(CupertinoIcons.eye_slash)
                                : Icon(CupertinoIcons.eye_fill),
                          ),
                          validationError:
                              data?.errors?.passwordConfirmation?.first.toString() ??
                              'Please input your conform password',
                        ),
                        SizedBox(height: 20),
                    
                        authProvider.isLoading? CircularProgressIndicator():ElevatedButton(
                          onPressed: () async {
                           await _saveRegistration(context);
                          },
                          child: Text('Registration'),
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(onPressed: () {
                          print(_emailTextController.text);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOtpScreen(email: _emailTextController.text,),));

                        }, child: Text('Resend'))
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  _saveRegistration(BuildContext context)async {
    if (Form.of(context).validate()) {
      final registrationData = RegistrationModel(
        name: _nameTextController.text.trim(),
        email: _emailTextController.text.trim(),
        password: _passwordTextController.text.trim(),
        passwordConfirmation: _conformPasswordTextController.text.trim(),
      );
     bool isSuccess = await context.read<AuthProvider>().registration(registrationData);


     if(isSuccess){
       final registrationResponse =  context.read<AuthProvider>().registrationResponse;

       Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOtpScreen(email: _emailTextController.text.trim(),),));

       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(registrationResponse?.message ?? '')));

     }else{
       final registrationResponse =  context.read<AuthProvider>().registrationResponse;

       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(registrationResponse?.message ?? '')));

     }


    }
  }
}


