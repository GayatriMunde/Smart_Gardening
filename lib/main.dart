import 'package:SmartGarden/HomePage.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'splash.dart';
import 'login.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hostel',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashPage(),
        routes: <String, WidgetBuilder>{
          // '/task': (BuildContext context) => TaskPage(title: 'Task'),
          '/home': (BuildContext context) => HomePage(),
          '/login': (BuildContext context) => LoginPage(),
          '/register': (BuildContext context) => RegisterPage(),
        });
  }
}
