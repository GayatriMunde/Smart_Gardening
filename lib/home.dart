import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  final String uid;

  HomePage({this.uid});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseUser currentUser;

  @override
  initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME'),
        actions: <Widget>[
          
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: (w * 0.25) - 20,
                    height: 80,
                  ),
                  SizedBox(
                    width: (w * 0.75) - 20,
                    height: 80,
                    child: Card(
                      child: ListTile(
                        title: Text('Money Manager'),
                        leading: Icon(Icons.monetization_on),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      elevation: 5,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: (w * 0.75) - 20,
                    height: 80,
                    child: Card(
                      child: ListTile(
                        title: Text('Money Tracker'),
                        leading: Icon(Icons.arrow_back_ios),
                        trailing: Icon(Icons.account_balance_wallet),
                      ),
                      elevation: 5,
                    ),
                  ),
                  SizedBox(
                    width: (w * 0.25) - 20,
                    height: 80,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: (w * 0.25) - 20,
                    height: 80,
                  ),
                  SizedBox(
                    width: (w * 0.75) - 20,
                    height: 80,
                    child: Card(
                      child: ListTile(
                        title: Text('Health'),
                        leading: Icon(Icons.healing),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      elevation: 5,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: (w * 0.75) - 20,
                    height: 80,
                    child: Card(
                      child: ListTile(
                        title: Text('Monthly reminders'),
                        leading: Icon(Icons.arrow_back_ios),
                        trailing: Icon(Icons.alarm_on),
                      ),
                      elevation: 5,
                    ),
                  ),
                  SizedBox(
                    width: (w * 0.25) - 20,
                    height: 80,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
