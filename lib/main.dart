import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_mate/Screens/Register.dart';
import 'package:hostel_mate/Screens/admin_dashboard.dart';
import 'package:hostel_mate/Screens/admin_login.dart';
import 'package:hostel_mate/Screens/bill.dart';
import 'package:hostel_mate/Screens/dashboard.dart';
import 'package:hostel_mate/Screens/login.dart';
import 'package:hostel_mate/Screens/welcome_scren.dart';

FirebaseAuth auth = FirebaseAuth.instance;

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    initialRoute: WelcomeScreen.id,
    routes: {
      WelcomeScreen.id: (context) => WelcomeScreen(),
      LoginPage.id: (context) => LoginPage(),
      RegisterScreen.id: (context) => RegisterScreen(),
      DashBoard.id: (context) => DashBoard(),
      AdminDashboard.id: (context) => AdminDashboard(),
      AdminLoginScreen.id: (context) => AdminLoginScreen(),
      Bill.id: (context) => Bill(),
    },
  ));
}
