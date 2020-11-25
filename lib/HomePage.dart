import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'MyGarden/MyGarden.dart';
import 'Watering Remainders/WateringRemainders.dart';
import 'rainprediction.dart';

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
      body: Container(
        padding: EdgeInsets.only(left: 50, top: 100, bottom: 100, right: 0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadowColor: Colors.black,
          color: Colors.greenAccent,
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 40, left: 40, bottom: 10),
                      child: ListTile(
                        title: Text(
                          "My" "\n" "Garden",
                          style: GoogleFonts.roboto(
                              fontSize: 40, fontWeight: FontWeight.normal),
                        ),
                         onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyGarden(uid: currentUser.uid)),
                        );
                      },
                        trailing: Icon(
                          Icons.emoji_nature_sharp,
                          size: 72,
                          color: Colors.pinkAccent,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 300, top: 0, bottom: 0, right: 30),
                    ),
                  ],
                ),
               
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.wb_cloudy_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      width: 250,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: ListTile(
                            title: Text(
                              "Rain Prediction",
                              style: GoogleFonts.roboto(fontSize: 20),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WeatherApp()),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.check_box_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      width: 250,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: ListTile(
                            title: Text(
                              "Tips & Tricks",
                              style: GoogleFonts.roboto(fontSize: 20),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.local_drink_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      width: 250,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: ListTile(
                            title: Text(
                              "Watering Remainder",
                              style: GoogleFonts.roboto(fontSize: 18),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Notifications(uid: currentUser.uid)),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
