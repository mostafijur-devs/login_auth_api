import 'package:flutter/material.dart';
import 'package:login_auth_model/provider/auth/google_sign_provider.dart';
import 'package:login_auth_model/screen/auth/login_screen.dart';
import 'package:login_auth_model/screen/user_page.dart';
import 'package:provider/provider.dart';
import '../provider/local_database_provider/local_bd_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<GoogleSignProvider>().currentUser;
    return Scaffold(
      appBar: AppBar(title: Text('Home page'), centerTitle: true),
      drawer: Drawer(
       backgroundColor: Colors.blueGrey,
        child: Column(
           children: [
             DrawerHeader(
                 child: FlutterLogo(size: 100,)),
             SizedBox(height: 20,),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
               children: [
                 Icon(Icons.person_rounded),
                 SizedBox(width: 10,),
                 TextButton(onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage(),));
                 }, child: Text('Profile',style: TextStyle(color: Colors.black,fontSize: 18),))

               ],
                            ),
             ),
           ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [FlutterLogo(size: 100)]),
        ),
      ),
    );
  }
}
