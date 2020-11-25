import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/cupertino.dart';

import '../HomePage.dart';


class Notifications extends StatefulWidget {
  const Notifications({Key key, this.uid}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
  final String uid;
}

class _NotificationsState extends State<Notifications> with TickerProviderStateMixin {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;
  TabController tb;
  int hour=0;
  int min=0;
  int sec=0;
  int prehr=0;
  int prem=0;
  int pres=0;
  @override
  void initState(){

    tb=TabController(length: 2,
    vsync: this,
    );
    super.initState();
    initializing();
  }
  void initializing()async{
    androidInitializationSettings = AndroidInitializationSettings("icon");
    iosInitializationSettings =IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings= InitializationSettings(android: androidInitializationSettings , iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings , onSelectNotification: onSelectNotification);
}
void _showNotificationsAfterSecond()async{
   await notificationAfterSec();
}
Future<void> notificationAfterSec() async{
  var timeDelayed =DateTime.now().add(Duration(seconds: hour*60*60+min*60+sec));
  AndroidNotificationDetails androidNotificationDetails= AndroidNotificationDetails(
    'Second channel_ID',
    'Second channel title',
    'Second channel body',
    priority: Priority.high,
    importance: Importance.max,
    ticker:'test');
    IOSNotificationDetails iosNotificationDetails =IOSNotificationDetails();
    NotificationDetails notificationDetails =NotificationDetails(android:androidNotificationDetails,iOS: iosNotificationDetails);
    // ignore: deprecated_member_use
    await flutterLocalNotificationsPlugin.schedule(1, 'Water me', 'MyGarden App',timeDelayed, notificationDetails);

}
Future onSelectNotification(String payLoad){
   if(payLoad != null){
      print("payload");
   } 

  }
 
Future onDidReceiveLocalNotification(
  int id ,String title, String body , String payLoad)async{
    return CupertinoAlertDialog(
    title: Text(title),
    content: Text (body),
    actions: < Widget>[
      CupertinoDialogAction(
        isDefaultAction: true,
        onPressed: (){
          print("");
        },
        
        child:Text("okay")),
      
      
        ],

);
}

  Widget water(){
    return Container(
      child:
      Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget>[
          Expanded(
            flex:6,
       child:
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children :<Widget>[
          Column(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[ 

            Padding(padding:EdgeInsets.only(bottom:10.0,),child:Text("HH",style :TextStyle(fontSize: 25,color: Colors.green),),),
               NumberPicker.integer(initialValue:hour , minValue: 0, maxValue: 23, listViewWidth:60 ,onChanged: (val){setState(() {
                prehr=hour; hour=val;
               });},),],),
               
        Column(mainAxisAlignment: MainAxisAlignment.center,
        
            children: <Widget>[
            Padding(padding:EdgeInsets.only(bottom:10.0,),child:Text("MM", style :TextStyle(fontSize: 25,color: Colors.green),),),
               NumberPicker.integer(initialValue:min, minValue: 0, maxValue: 60, listViewWidth:60,onChanged: (val){setState(() {
                 prem=min ;min=val;});},),
               ],),
        Column(mainAxisAlignment: MainAxisAlignment.center,
          
            children: <Widget>[
            Padding(padding:EdgeInsets.only(bottom:10.0,),child:Text("SS",style: TextStyle(fontSize: 25,color: Colors.green),),),
               NumberPicker.integer(initialValue:sec , minValue: 0, maxValue: 60,listViewWidth:60, onChanged: (val){setState(() {
                 pres=sec ;sec=val;});},),
               ],),],),),
         Expanded(flex:1,
         child:
          Row(mainAxisAlignment: MainAxisAlignment.center,
             
            children:<Widget> [
          FlatButton(
          color: Colors.greenAccent,
          onPressed:_showNotificationsAfterSecond,
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text
              ("Show Notification ",style: TextStyle(fontSize: 20.0,color: Colors.black),
              ),
             ),
        ) ],),),
         //),
         // Expanded(flex:3,
          //child: Text("3",),
         //),
      
          ],
      ) ,
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
                }),
        backgroundColor: Colors.greenAccent,
        title:Text("Watering Remainder",
      ),
      bottom: TabBar(
        tabs:<Widget>[Text("water",),
        Text("last_watering",
        ),
        ],
        labelPadding: EdgeInsets.only(bottom:10,
        ),labelStyle: TextStyle(fontSize: 18,
        ),
        unselectedLabelColor: Colors.white60,
        controller :tb,
    )
    ),
    body: TabBarView(children: <Widget>[
      water(),
    
      Center(
        child: Text("last_watering",style: TextStyle(color: Colors.pink),
        ),
      ),
    ],
    controller :tb,
    ),
    );
  }
}
