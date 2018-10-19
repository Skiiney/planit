import 'package:flutter/material.dart';
import 'loader/color_loader.dart';

class Home extends StatelessWidget {
  static String tag = 'home';

  @override
  Widget build(BuildContext context) {

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.lightBlueAccent]
        )
      ),
      child:
        ColorLoader(
        colors: [Colors.blue, Colors.red, Colors.yellow],
        duration: Duration(milliseconds: 1200)
        )
      
    );
    
    return Scaffold(
      body: body
           
    );
  }
}