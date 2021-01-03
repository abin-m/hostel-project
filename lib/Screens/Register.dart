import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_mate/Screens/login.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'Register_Screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final auth = FirebaseAuth.instance;
  String email;
  String password;
  String pass2;
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
                    height: 35,
                  ),
                  new Text(
                    'Create An Account',
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
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
                  SizedBox(height: 20),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        pass2 = value;
                      });
                    },
                    decoration: new InputDecoration(
                      labelText: 'Re enter Password',
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: new MaterialButton(
                      onPressed: () async {
                        setState(() {
                          showspinner = true;
                        });
                        final user = await auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          Navigator.pushNamed(context, LoginPage.id);
                        }
                        setState(() {
                          showspinner = false;
                        });
                      },
                      child: Text(
                        '      Sign Up      ',
                        style: TextStyle(fontSize: 20),
                      ),
                      textColor: Colors.white,
                      color: Colors.teal,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      elevation: 5,
                      height: 50,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
