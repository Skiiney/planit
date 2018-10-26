import 'routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Initial',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Krub',
      ),
      routes: routes,
    );
  }
}

