import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_mate/Screens/admin_dashboard.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class AdminLoginScreen extends StatefulWidget {
  static const String id = 'Admin_login_screen';
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final auth = FirebaseAuth.instance;

  String email = "email@gmail.com";
  String password = "11111";
  String msg = "   ";
  bool showspinner = false;
  String username = "test@gmail.com";
  String passwrd = '123456'; //from firestore

  // void getData() async {
  //   final _admindata = await _firestore.collection('admin').getDocuments();
  //   for (var _alldata in _admindata.documents) {
  //     print(_alldata);
  //   }
  // }

  void adminstream() async {
    await for (var snapshot in _firestore.collection('admin').snapshots()) {
      for (var datas in snapshot.documents) {
        setState(() {
          username = datas.data['username'];
          passwrd = datas.data['password'];
        });
      }
    }
  }

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
                    height: 60,
                  ),
                  new Text(
                    'Welcome    Admin',
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
                        adminstream();
                        if (email == username && password == passwrd) {
                          Navigator.pushNamed(context, AdminDashboard.id);
                        } else {
                          setState(() {
                            msg = 'Permission Denied';
                          });
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
                  new Text(
                    '${msg}',
                    style: TextStyle(color: Colors.red),
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
