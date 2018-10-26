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
  String _nome;
  String _email;
  String _password;
  String _rpassword;

void _validadeAndsave(){
  final form = formKey.currentState;
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
        
          // IMAGE BACKGROUND WITH TRANSPARENCY

       /* image: DecorationImage(
          colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.1), BlendMode.dstATop),
          image: AssetImage('assets/'),
          fit: BoxFit.cover
        ) */
      ),

      child: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 25.0, right: 25.0),
          children: <Widget>[
            Hero(
              tag: 'hero',
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 78.0,
                child: Image.asset('assets/planit.png'),
              ),
            ),

            Container(
              //xpadding: EdgeInsets.only(top: 5.0),
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
                    validator: (value) => value.contains('@') ? 'Emais invalid' : null,
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
              ),

            SizedBox(height: 9.0),

            RaisedButton(
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              splashColor: Colors.lightBlueAccent[200],
              onPressed: () {
                _validadeAndsave();
                // print("email: $_email senha2: $_password");
                _handleEmailSignIn(_email, _password);
              },
              elevation: 4.0,
              color: Colors.lightBlueAccent,
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              child: Text('LOGIN', style: TextStyle(color: Colors.white)),
            ),

            FlatButton(
              child: Text(
              'Forgot password?',
              style: TextStyle(color: Colors.black54),
            ),
            onPressed: () {},
            ),
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
                    onSaved: (value) => _nome = value
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
                    validator: (value) => value.contains('@') ? 'Emais invalid' : null,
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
                              
              },
              elevation: 4.0,
              color: Colors.lightBlueAccent,
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              child: Text('Sign Up', style: TextStyle(color: Colors.white)),
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
      curve: Curves.bounceOut,
    );
  }

  gotoSignup() {
    //controller_minus1To0.reverse(from: 0.0);
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  PageController _controller = new PageController(initialPage: 0, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
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
    final FirebaseUser user = await _auth.signInWithEmailAndPassword(
      email: _email, 
      password: _password
      );
  print("signed in " + user.displayName);  
  return user;
}