import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> connection() async {
final Firestore firestore = Firestore();
  await firestore.settings(timestampsInSnapshotsEnabled: true);
}

class Login extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final formregKey = GlobalKey<FormState>();
  String _name;
  String _email;
  String _password;
  String _rpassword;

void _validadeAndsave(Key){
  final form = Key.currentState;
  if (form.validate()){
    form.save();
  }
}

  Widget initPage(){
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.lightBlueAccent]
        ),
        
          // BACKGROUND IMAGE WITH TRANSPARENCY

          image: DecorationImage(
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.dstATop),
          image: AssetImage('assets/back.jpg'),
          fit: BoxFit.cover
        )  
      ),

      child: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 26.0, right: 26.0),
          children: <Widget>[
            Hero(
              tag: 'hero',
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 48.0,
                child: Image.asset('assets/logo3.png'),
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[ 
                Text(
                  "Welcome to Planit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  )
                ),
                ]
              ),
            ),
            
            SizedBox(height: 110.0),  

            RaisedButton(
              padding: EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
              splashColor: Colors.white30,
              onPressed: () {
                gotoLogin();
              },
              elevation: 2.0,
              color: Colors.lightBlueAccent,
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              child: Text('LOGIN', style: TextStyle(color: Colors.white)),
            ),

            SizedBox(height: 15.0),

            OutlineButton(
              padding: EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 16.0),
              splashColor: Colors.lightBlueAccent[200],
              onPressed: () {
                gotoSignup();
              },
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              child: Text('SIGN UP', style: TextStyle(color: Colors.white)) 
            ),
          ]
        ),
      )
    );
  }

  Widget loginPage(){
    return Container(
     /* decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.1), BlendMode.dstATop),
          image: AssetImage('assets/back.jpg'),
          fit: BoxFit.cover,
        ),
      ), */
      child:Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 26.0, right: 26.0),
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[ 
                Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 45.0,
                  )
                ),
                ]
              ),
            ),
            
            SizedBox(height: 55.0),
            
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    initialValue: '',
                    decoration: InputDecoration(
                      hintText: 'Email',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                    validator: (value) => value.contains('@') ? null : 'Email invalid',
                    onSaved: (value) => _email = value
                    ),
                  
                  SizedBox(height: 10.0),
          
                  TextFormField(
                    autofocus: false,
                    initialValue: '',
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                    validator: (value) => value.length < 6 ? 'Password too short.' : null,
                    onSaved: (value) => _password = value
                    )
                  ]
                ),
              ),

            Row(
            mainAxisAlignment: MainAxisAlignment.end,  
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 4.0, bottom: 8.0),
                  child: FlatButton(
                    child: Text(
                    'Forgot password?',
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    ),
                    onPressed: () {},
                  )
                )
              ]
            ),

            RaisedButton(
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              splashColor: Colors.lightBlueAccent[200],
              onPressed: () {
                _validadeAndsave(formKey);
                _handleEmailSignIn(_name, _password, context);
                //_handleEmailSignIn(_email, _password, context); 
              },
              elevation: 4.0,
              color: Colors.lightBlueAccent,
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              child: Text('LOGIN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),

            SizedBox(height: 22.0),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[ 
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(border: Border.all(width: 0.30)),
                    )
                  ),
                  Text(
                    'OR CONNECT WITH',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 15.0
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(border: Border.all(width: 0.30)),
                    )
                  )
                ]
              ),
            ),

            Container(
              margin: EdgeInsets.only(top:15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      splashColor: Colors.lightBlueAccent[200],
                      onPressed: () {
                        _handleGoogleSignIn(context);
                      },
                      elevation: 4.0,
                      color: Color(0Xffdb3236),
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                        children: <Widget>[
                          Icon( const IconData(0xea88,
                                                fontFamily: 'IcoMoon'),
                                            color: Colors.white,
                                            size: 15.0,),
                          Text('GOOGLE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                        ]
                      )
                      )
                    ),

                  SizedBox(
                    width: 10.0,
                  ),

                  Expanded(
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      splashColor: Colors.lightBlueAccent[200],
                      onPressed: () {
                        _handleGoogleSignIn(context);
                      },
                      elevation: 4.0,
                      color: Color(0Xff3B5998),
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                        children: <Widget>[
                          Icon( const IconData(0xea90,
                                                fontFamily: 'IcoMoon'),
                                            color: Colors.white,
                                            size: 15.0,),
                          Text('FACEBOOK', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                        ]
                      )
                    )
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }

  Widget signupPage(){
    return Container(
      child:Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[ 
                Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 45.0,
                  )
                ),
                ]
              ),
            ),
            
            SizedBox(height: 55.0),
            
            Form(
              key: formregKey,
              child: Column(
                children: [
                  
                  TextFormField(
                    autofocus: false,
                    initialValue: '',
                    decoration: InputDecoration(
                      hintText: 'Name',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                    validator: (value) => value.length < 3 ? 'Name invalid' : null,
                    onSaved: (value) => _name = value
                    ),

                  SizedBox(height: 12.0),  

                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    initialValue: '',
                    decoration: InputDecoration(
                      hintText: 'Email',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                    validator: (value) => value.contains('@') ? null : 'Email invalid',
                    onSaved: (value) => _email = value
                    ),
                  
                  SizedBox(height: 12.0),

                  TextFormField(
                    autofocus: false,
                    obscureText: true,
                    initialValue: '',
                    decoration: InputDecoration(
                      hintText: 'Password',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                    validator: (value) => value.length < 6 ? 'Password invalid' : null,
                    onSaved: (value) => _password = value
                    ),

                  SizedBox(height: 12.0),

                  TextFormField(
                    autofocus: false,
                    obscureText: true,
                    initialValue: '',
                    decoration: InputDecoration(
                      hintText: 'Repeat your Password',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                    validator: (value) => value.length < 6 ? 'Password invalid' : null,
                    onSaved: (value) => _rpassword = value
                    ),  

                ]
              )
            ),

            SizedBox(height: 15.0),
            
            RaisedButton(
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              splashColor: Colors.lightBlueAccent[200],
              onPressed: () {
                _validadeAndsave(formregKey);

                _handleRegister(_name, _email, _password, context);              
              },
              elevation: 4.0,
              color: Colors.lightBlueAccent,
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              child: Text('SIGN UP', style: TextStyle(color: Colors.white)),
            ),

          ]
        )
      )  
    );
  }  

  gotoLogin() {
    //controller_0To1.forward(from: 0.0);
    _controller.animateToPage(
      1,
      duration: Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
    );
  }

  gotoSignup() {
    //controller_minus1To0.reverse(from: 0.0);
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
    );
  }

  PageController _controller = new PageController(initialPage: 0, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.dstATop),
          image: AssetImage('assets/back.jpg'),
          fit: BoxFit.cover
          ) 
        ),
        child: PageView(
          controller: _controller,
          physics: AlwaysScrollableScrollPhysics(),
          children: <Widget>[initPage(), loginPage(), signupPage()],
          scrollDirection: Axis.horizontal,
        ),
      )
    ); 
  }
}

final CollectionReference collectionReference = Firestore.instance.collection('users');
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<FirebaseUser> _handleGoogleSignIn(context) async {
  try {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  print("signed in " + user.displayName);
  collectionReference.document('${user.uid}').get().then((datasnapshot){
    if(!datasnapshot.exists){
      collectionReference.document('${user.uid}')
   .setData({'email': '${user.email}', 'name': '${user.displayName}', 'groups': [''], 'photoID': '${user.photoUrl}'});
    }
  });
  Navigator.of(context).pushNamed('/home');
  return user;
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

Future<FirebaseUser> _handleEmailSignIn(String _email, String _password, context) async {
    try {
      final FirebaseUser user = await _auth.signInWithEmailAndPassword(
      email: _email, 
      password: _password
      );
      print("signed in " + user.email);
      Navigator.of(context).pushNamed('/home');
      return user;  
    } catch (e) {
      print('Error: $e');
      return null;
    }
}

Future<FirebaseUser> _handleRegister(String _name, String _email, String _password, context) async{
    try {
      final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
      email: _email,
      password: _password
      );
      Firestore.instance.collection('users').document()
        .setData({'email': '$_email', 'name': '$_name', 'groups': [''], 'photoID': ''});
      Navigator.of(context).pushNamed('/home');
      return user;
    } catch (e) {
    print('Error: $e');
    return null;
    }
}