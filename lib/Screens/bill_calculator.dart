import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final _firestore = Firestore.instance;

class BillCalculator extends StatefulWidget {
  @override
  _BillCalculatorState createState() => _BillCalculatorState();
}

class _BillCalculatorState extends State<BillCalculator> {
  String month;
  String messcutstudents;
  int messbill = 0;
  int messcutamount = 0;
  String result = "";
  String others;
  int other = 0;
  String description = "  ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Add Bills'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Container(
          width: 380,
          padding: EdgeInsets.all(35),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFF0D5A4C),
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
                      'Enter Bill Details',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          month = value;
                        });
                      },
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      decoration: new InputDecoration(
                        labelText: 'Month',
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
                          messbill = int.parse(value);
                        });
                      },
                      cursorColor: Colors.black,
                      decoration: new InputDecoration(
                        labelText: 'Mess Bill Amount',
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
                          messcutamount = int.parse(value);
                        });
                      },
                      cursorColor: Colors.black,
                      decoration: new InputDecoration(
                        labelText: 'Lower mess cut',
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
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        setState(() {
                          messcutstudents = value;
                        });
                      },
                      cursorColor: Colors.black,
                      decoration: new InputDecoration(
                        labelText: 'Students who got lower mess cut',
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
                          other = int.parse(value);
                        });
                      },
                      cursorColor: Colors.black,
                      decoration: new InputDecoration(
                        labelText: 'Higher mess cut',
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
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        setState(() {
                          others = value;
                        });
                      },
                      cursorColor: Colors.black,
                      decoration: new InputDecoration(
                        labelText: 'Students Eligible for Higher messcut ',
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
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                      cursorColor: Colors.black,
                      decoration: new InputDecoration(
                        labelText: 'Description ',
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
                    new MaterialButton(
                      elevation: 5,
                      onPressed: () async {
                        _firestore.collection('bill').add({
                          'month': month,
                          'messbill': messbill,
                          'messcutamount': messcutamount,
                          'messcutstudents': messcutstudents,
                          'time': DateTime.now().toString(),
                          'messcut>10': other,
                          'messcut>10students': others,
                          'description': description
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
                    Text('${result}'),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
