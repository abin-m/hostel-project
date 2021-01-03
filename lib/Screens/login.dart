import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_mate/Screens/Register.dart';
import 'package:hostel_mate/Screens/admin_login.dart';
import 'package:hostel_mate/Screens/dashboard.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'Login_Screen';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showspinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 125,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Text(
                      'Log In',
                      style:
                          TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: new InputDecoration(
                      labelText: 'Enter Email',
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    validator: (val) {
                      if (val.length == 0) {
                        return "Email cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    decoration: new InputDecoration(
                      labelText: 'Password',
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: new MaterialButton(
                      onPressed: () async {
                        setState(() {
                          showspinner = true;
                        });
                        final user = await auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          Navigator.pushNamed(context, DashBoard.id);
                        }
                        setState(() {
                          showspinner = false;
                        });
                      },
                      child: Text(
                        '      Sign in      ',
                        style: TextStyle(fontSize: 20),
                      ),
                      textColor: Colors.white,
                      color: Colors.teal,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      elevation: 5,
                      height: 50,
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.id);
                      },
                      child: Text("Don't have an account? create one")),
                  SizedBox(
                    height: 8,
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AdminLoginScreen.id);
                      },
                      child: Text("Admin login"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
