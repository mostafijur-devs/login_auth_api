import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    print('Home Screen');

    return Scaffold(

      appBar: AppBar(
        title: Text('Home page'),
        centerTitle: true,
      ),
      body: Center(
        child: FlutterLogo(size: 100,),) ,
    );
  }
}
