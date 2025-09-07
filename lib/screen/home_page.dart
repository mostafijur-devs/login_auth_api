import 'package:flutter/material.dart';

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
        child:ExpansionTile(title: Text('Home page'),children: [
          Text('kdsfjnw'),
          Text('kdsfjnw'),
          Text('kdsfjnw'),
          Text('kdsfjnw'),
        ],) ,
      ),
    );
  }
}
