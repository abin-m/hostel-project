import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_mate/Screens/bill.dart';
import 'package:hostel_mate/Screens/login.dart';
import 'package:hostel_mate/main.dart';

final _firestore = Firestore.instance;

class DashBoard extends StatefulWidget {
  static const String id = 'Dashboard_Screen';
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel Expense Details'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.message),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Bill();
                }));
              }),
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                auth.signOut();
                Navigator.pushNamed(context, LoginPage.id);
              })
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: _firestore
                  .collection('expenses')
                  .orderBy('month')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.green,
                    ),
                  );
                }
                final expenses = snapshot.data.documents;
                List<ExpenseDetails> getexpenses = [];
                for (var expense in expenses) {
                  final total_expenses =
                      expense.data['totalexpense'].toString();
                  final electricity =
                      expense.data['electricitybill'].toString();
                  final grocery = expense.data['grocery'].toString();
                  final month = expense.data['month'].toString();
                  final others = expense.data['others'].toString();
                  final wages = expense.data['wages'].toString();
                  final rent = expense.data['rent'].toString();
                  final getexpens = ExpenseDetails(
                    electricity: electricity,
                    grocery: grocery,
                    month: month,
                    wages: wages,
                    rent: rent,
                    others: others,
                    totalexpenses: total_expenses,
                  );
                  getexpenses.add(getexpens);
                }
                return Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    children: getexpenses,
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

class ExpenseDetails extends StatelessWidget {
  ExpenseDetails(
      {this.electricity,
      this.grocery,
      this.month,
      this.wages,
      this.others,
      this.rent,
      this.totalexpenses});
  final String electricity;
  final String grocery;
  final String month;
  final String wages;
  final String rent;
  final String others;
  final String totalexpenses;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        elevation: 5.0,
        color: Color(0xFF0D5A8C),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            ' Expense  \t${month}\n\n ElectricityBill :\t${electricity}\n Grocery :\t${grocery}\n Wages :\t${wages}\n Rent :\t${rent}\n Others :\t${others}\n\n Total Expenses :${totalexpenses}',
            style: TextStyle(letterSpacing: 1, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
