/* import 'package:SmartGarden/HomePage.dart';
import 'package:SmartGarden/Watering%20Remainders/notification.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class Remainder extends StatefulWidget {
  const Remainder({Key key, this.uid}) : super(key: key);

  @override
  _RemainderState createState() => _RemainderState();
  final String uid;
}

class _RemainderState extends State<Remainder> with TickerProviderStateMixin {
  TabController tb;
  int hour = 0;
  int min = 0;
  int sec = 0;
  @override
  void initState() {
    tb = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  Widget water() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text(
                        "HH",
                        style:
                            TextStyle(fontSize: 25, color: Colors.greenAccent),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: hour,
                      minValue: 0,
                      maxValue: 23,
                      listViewWidth: 60,
                      onChanged: (val) {
                        setState(() {
                          hour = val;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text(
                        "MM",
                        style:
                            TextStyle(fontSize: 25, color: Colors.greenAccent),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: min,
                      minValue: 0,
                      maxValue: 60,
                      onChanged: (val) {
                        setState(() {
                          min = val;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text(
                        "SS",
                        style:
                            TextStyle(fontSize: 25, color: Colors.greenAccent),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: sec,
                      minValue: 0,
                      maxValue: 60,
                      onChanged: (val) {
                        setState(() {
                          sec = val;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Expanded(flex:1,
          // child: Text("1",style:TextStyle(fontSize: 35.0,fontWeight: FontWeight.w600,),),
          //),
          // Expanded(flex:3,
          //child: Text("3",),
          //),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      uid: widget.uid,
                    ),
                  ),
                );
              },
            ),
            title: Text(
              "Watering Remainder",
            ),
            backgroundColor: Colors.gree,
            bottom: TabBar(
              tabs: <Widget>[
                Text(
                  "water",
                ),
                Text(
                  "last_watering",
                ),
              ],
              labelPadding: EdgeInsets.only(
                bottom: 10,
              ),
              labelStyle: TextStyle(
                fontSize: 18,
              ),
              unselectedLabelColor: Colors.white60,
              controller: tb,
            )),
       body: TabBarView(children: <Widget>[
         Column(
          children: <Widget>[
              water()
         ],),

       ])
   ) );
}
    */   
       
       
       
       
       
       
       
       


