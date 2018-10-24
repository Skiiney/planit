import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
 final formKey = GlobalKey<FormState>();

String _email;
String _password;

void _validadeAndsave(){
  final form = formKey.currentState;
  if (form.validate()){
    form.save();
  }
}
 
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/planit.png'),
      ),
    );
    
    final forms = Form(
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
      validator: (value) => value.length < 6 ? 'Emais invalid' : null,
      onSaved: (value) => _email = value
    ),
    SizedBox(height: 12.0),
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
    );

    

    final loginButton = RaisedButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        splashColor: Colors.lightBlueAccent[200],
        onPressed: () {
          _validadeAndsave();
          print("email: $_email senha2: $_password");
          _handleEmailSignIn(_email, _password);
          /*_handleEmailSignIn(_email, _password); */
        /* Navigator.of(context).pushNamed('/home'); */
        },
        elevation: 4.0,
        color: Colors.lightBlueAccent,
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
          child: Text('LOGIN', style: TextStyle(color: Colors.white)),
          
        );
      
    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return Scaffold(
      
      body:Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            forms,
            SizedBox(height: 9.0),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }
}

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<FirebaseUser> _handleGoogleSignIn() async {
  GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  FirebaseUser user = await _auth.signInWithGoogle(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  print("signed in " + user.displayName);
  return user;
}

Future<FirebaseUser> _handleEmailSignIn(String _email, String _password) async {
    final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
      email: _email, 
      password: _password
      );
  print("signed in " + user.displayName);  
  return user;
}