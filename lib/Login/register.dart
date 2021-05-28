import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sample_database/Login/database.dart';
import 'package:sample_database/Login/login.dart';
import 'package:sample_database/Pages/home_page.dart';
import 'package:sample_database/api/firebase_api.dart';

String _name;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  register() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        UserCredential result = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        User user = result.user;
        if (user != null) {
          await DatabaseService(uid: user.uid)
              .updateUserData(_name, _email, _password);
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

  navigateToLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                child: Image(
                  image: AssetImage("images/register.png"),
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
                            if (input.isEmpty) return 'Enter Name';
                          },
                          decoration: InputDecoration(
                            labelText: "Name",
                            prefixIcon: Icon(Icons.person),
                          ),
                          onSaved: (input) => _name = input,
                        ),
                      ),
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
                        // ignore: unnecessary_statements
                        onPressed: register,
                        child: Text(
                          'Register',
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
                  "Already Have an Account | Login",
                  style: TextStyle(color: Colors.green, fontSize: 16),
                ),
                onTap: navigateToLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
