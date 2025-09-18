import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_auth_model/model/auth/auth_response.dart';
import 'package:login_auth_model/provider/auth/auth_provider.dart';
import 'package:login_auth_model/provider/local_database_provider/local_bd_provider.dart';
import 'package:provider/provider.dart';

import '../provider/auth/google_sign_provider.dart';
import 'auth/login_screen.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = context.read<GoogleSignProvider>().currentUser;
    final Users? emailUser = context.read<ApiAuthProvider>().loginAuth?.data?.user;




    return Scaffold(
      appBar: AppBar(
          title: Text('Profile page'),
        actions: [
          Consumer<GoogleSignProvider>(
            builder: (context, googleProvider, child) =>
            googleProvider.isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              style:ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.grey)
              ) ,
              onPressed: () {

                  context.read<GoogleSignProvider>().googleSingOut();
                  context.read<LocalDbProvider>().deleteToken();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('LogOut Success')));

                // else if(emailUser != null){
                //   context.read<LocalDbProvider>().deleteToken();
                //   Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => LoginScreen(),
                //     ),
                //   );
                // }else{
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Login First')));
                // }
               
              },
              child: Icon(Icons.logout),
            ),
          ),
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: user != null
            ? Column(
                children: [
                  SizedBox(height: 20),

                  user.photoURL != null
                      ? Image.network(user.photoURL!, height: 100, width: 100)
                      : Icon(Icons.person_rounded,size: 100,),
                  SizedBox(height: 20),

                  Text(
                    user.displayName ?? 'No email',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    user.email ?? 'No email',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    user.phoneNumber ?? 'No email',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 20),

                  // Consumer<GoogleSignProvider>(
                  //   builder: (context, googleProvider, child) =>
                  //       googleProvider.isLoading
                  //       ? CircularProgressIndicator()


                  // ),
                ],
              )
            : Column(
                children: [
                  SizedBox(height: 20),

                  emailUser?.profileImage != null
                      ? Image.network(
                          emailUser!.profileImage!,
                          height: 100,
                          width: 100,
                        )
                      : Icon(Icons.person_rounded, size: 100),

                  SizedBox(height: 20),

                  Text(
                    emailUser?.name ?? 'No email',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    emailUser?.email ?? 'No email',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    emailUser?.createdAt ?? 'No email',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      context.read<GoogleSignProvider>().googleSingOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text('Google LogOut'),
                  ),

                ],
              ),
      ),
    );
  }
}
