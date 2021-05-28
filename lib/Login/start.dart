import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:sample_database/Login/login.dart';
import 'package:sample_database/Login/register.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  navigateToLogin() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  navigateToRegiste() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Register()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 45.0),
            Container(
              height: 300,
              child: Image(
                image: AssetImage("images/start.jpg"),
              ),
            ),
            SizedBox(
              height: 45.0,
            ),
            RichText(
              text: TextSpan(
                text: "Welcome to ",
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: "Todo List",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow.shade600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Make Yourself More Disciplined With This App",
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // ignore: deprecated_member_use
                RaisedButton(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  onPressed: navigateToLogin,
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.yellow,
                ),
                SizedBox(
                  width: 20.0,
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  onPressed: navigateToRegiste,
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.yellow,
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
