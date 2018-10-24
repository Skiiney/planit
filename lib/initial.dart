import 'package:flutter/material.dart';

class Initial extends StatefulWidget {
  static String tag = 'init-page';
  @override
  _InitialState createState() => new _InitialState();
}

class _InitialState extends State<Initial> {
  @override
  Widget build(BuildContext context) {

  final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 78.0,
        child: Image.asset('assets/planit.png'),
      ),
  );  

  final loginButton = RaisedButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        splashColor: Colors.white30,
        onPressed: () {
        Navigator.of(context).pushNamed('/login'); 
        },
        elevation: 2.0,
        color: Colors.lightBlueAccent,
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        child: Text('LOGIN', style: TextStyle(color: Colors.white)),
          
  );
      
  final signinButton = OutlineButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        splashColor: Colors.lightBlueAccent[200],
        onPressed: () {

        },
                 
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        child: Text('SIGN UP', style: TextStyle(color: Colors.white)) 
  ); 

    return  Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent]
            )
          ),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              children: <Widget>[
                logo,
                SizedBox(height: 98.0),
                loginButton,
                SizedBox(height: 18.0),
                signinButton
              ],
            ) 
          )
        )
      );
  }
}

