import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_mate/Screens/admin_login.dart';
import 'package:hostel_mate/Screens/bill_calculator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:intl/intl.dart';

final _firestore = Firestore.instance;

class AdminDashboard extends StatefulWidget {
  static const String id = 'Admin_Screen';
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String now;
  int elecBill = 0;
  int rent = 0;
  int grocery = 0;
  int wages = 0;
  int others = 0;
  String password;
  int amount = 0;
  bool spinner = false;
  String result = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return BillCalculator();
          }));
        },
        mini: false,
        child: Icon(Icons.add),
        backgroundColor: Colors.teal[400],
      ),
      appBar: AppBar(
        title: new Text('Admin Panel'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pushNamed(context, AdminLoginScreen.id);
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: ModalProgressHUD(
          inAsyncCall: spinner,
          child: Container(
            width: 380,
            padding: EdgeInsets.all(35),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFF0D5A6C),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SingleChildScrollView(
                      child: Column(
                    children: <Widget>[
                      Text(
                        'Hostel Expenses',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            elecBill = int.parse(value);
                          });
                        },
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                          labelText: 'Electricity bill',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        obscureText: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            rent = int.parse(value);
                          });
                        },
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                          labelText: 'Rent',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        obscureText: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            grocery = int.parse(value);
                          });
                        },
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                          labelText: 'Grocery',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        obscureText: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            wages = int.parse(value);
                          });
                        },
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                          labelText: 'Wages',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        obscureText: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            others = int.parse(value);
                          });
                        },
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                          labelText: 'Others',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        obscureText: false,
                      ),
                      new SizedBox(
                        height: 20,
                      ),
                      new SizedBox(
                        height: 20,
                      ),
                      new MaterialButton(
                        elevation: 5,
                        onPressed: () async {
                          setState(() {
                            amount = elecBill + rent + grocery + wages + others;
                          });
                          setState(() {
                            spinner = true;
                          });
                          _firestore.collection('expenses').add({
                            'electricitybill': elecBill,
                            'rent': rent,
                            'grocery': grocery,
                            'wages': wages,
                            'others': others,
                            'totalexpense': amount,
                            'month': now =
                                DateFormat("dd-MM-yyyy").format(DateTime.now()),
                          });
                          setState(() {
                            spinner = false;
                          });
                          setState(() {
                            amount = 0;
                            elecBill = 0;
                            rent = 0;
                            grocery = 0;
                            wages = 0;
                          });
                          setState(() {
                            result = "Successfully added";
                          });
                        },
                        child: Text('Submit'),
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      // Text('Total Expense = ${amount}'),
                      SizedBox(
                        height: 10,
                      ),
                      Text('${result}'),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
