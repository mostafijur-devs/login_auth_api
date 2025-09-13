import 'package:flutter/material.dart';
import 'package:login_auth_model/screen/auth/login_screen.dart';
import 'package:provider/provider.dart';
import '../provider/local_database_provider/local_bd_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Home page'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            FlutterLogo(size: 100,),
            ElevatedButton(
              onPressed: ()  {
                context.read<LocalDbProvider>().deleteToken();
                Navigator.push(context,  MaterialPageRoute(builder: (context) => LoginScreen(),));
              },
              child: Text('LogOut'),
            ),

          ],
        ),) ,
    );
  }
}
