import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:hostel_mate/Screens/admin_login.dart';
import 'package:hostel_mate/Screens/login.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'Welcome_Screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFEEED7),
        body: Column(
          children: <Widget>[
            Image(
              image: AssetImage('images/hostel.png'),
              alignment: Alignment.center,
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 25,
            ),
            new TypewriterAnimatedTextKit(
              text: ['Hostel Mate'],
              textStyle: TextStyle(
                  fontSize: 45,
                  color: Colors.black,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: new MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginPage.id);
                },
                child: Text(' Welcome '),
                textColor: Colors.white,
                color: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                height: 40,
              ),
            )
          ],
        ),
      ),
    );
  }
}
