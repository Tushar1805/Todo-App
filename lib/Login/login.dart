import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sample_database/Login/auth.dart';
import 'package:sample_database/Login/register.dart';
import 'package:sample_database/Pages/home_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final AuthService _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        UserCredential result = await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
        User user = result.user;
        if (user == null) {
          print('sign in failed');
        } else {
          print('sign in successfully');
          print(user);
          //Navigator.of(context).dispose();
        }
      } catch (e) {
        showError(e.toString());
      }
    }
  }

  showError(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errorMessage),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }

  navigateToRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Register()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(40.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                child: Image(
                  image: AssetImage("images/login.png"),
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) return 'Enter Email';
                          },
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email),
                          ),
                          onSaved: (input) => _email = input,
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          validator: (input) {
                            if (input.length < 6)
                              return 'Provide Minimum 6 characters';
                          },
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                          onSaved: (input) => _password = input,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPressed: login,

                        // () async {
                        //   dynamic result = await _auth.signInAnon();
                        //   if (result == null) {
                        //     print('error signing in');
                        //   } else {
                        //     print('signed in');
                        //     print(result);
                        //   }
                        // },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        color: Colors.yellow,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                child: Text(
                  "Create an Account",
                  style: TextStyle(fontSize: 16, color: Colors.green),
                ),
                onTap: navigateToRegister,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
