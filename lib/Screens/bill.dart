import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class Bill extends StatefulWidget {
  static const String id = 'bill_Screen';
  @override
  _BillState createState() => _BillState();
}

class _BillState extends State<Bill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill Details'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: _firestore.collection('bill').orderBy('time').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.green,
                    ),
                  );
                }
                final bill = snapshot.data.documents;
                List<BillDetails> getbill = [];
                for (var details in bill) {
                  final messbill = details.data['messbill'].toString();
                  final month = details.data['month'].toString();
                  final messcutamount =
                      details.data['messcutamount'].toString();
                  final messcutstudents =
                      details.data['messcutstudents'].toString();
                  final _time = details.data['time'].toString();
                  final messcutgtr = details.data['messcut>10'].toString();
                  final description = details.data['description'].toString();
                  final messcutgtrstudents =
                      details.data['messcut>10students'].toString();
                  final getexpens = BillDetails(
                    messbill: messbill,
                    month: month,
                    messcutamount: messcutamount,
                    time: _time,
                    messcutstudents: messcutstudents,
                    messcutgtr: messcutgtr,
                    messcutgtrstudents: messcutgtrstudents,
                    description: description,
                  );
                  getbill.add(getexpens);
                }
                return Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    children: getbill,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BillDetails extends StatelessWidget {
  BillDetails(
      {this.messbill,
      this.month,
      this.messcutamount,
      this.messcutstudents,
      this.time,
      this.description,
      this.messcutgtr,
      this.messcutgtrstudents});

  final String messbill;
  final String month;
  final String messcutamount;
  final String time;
  final String messcutstudents;
  final String messcutgtr;
  final String messcutgtrstudents;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        elevation: 5.0,
        color: Color(0xFF0D5A4C),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Bill Details\n\n Month:\t${month}\n\n MessBill:\t${messbill}\n Lower mess cut:\t${messcutamount}\n\nStudents entitled with lower mess cut(Absent for 10 days or more, but less than 15days )\t:\t${messcutstudents}\t\n\n Upper mess cut:\t${messcutgtr}\n\nStudents entitled with higher mess cut(Absent for 15 to 20 days or more)\t:\t\t${messcutgtrstudents}\t\n\nDescription:\t${description}',
              style: TextStyle(letterSpacing: 0.8, fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}
