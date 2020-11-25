import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:io';

void main() => runApp(WeatherApp());

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int temperature = 0;
  String location = 'Type Your Location';
  int humid = 0;
  String weather = "Load after entering location";
  String img = "";

  String searchApiUrl =
      'http://api.weatherapi.com/v1/current.json?key=27dff8c614b6454e846114200201510&q=';
  String errorMessage = "";

  void fetchSearch(String input) async {
    try {
      var searchResult = await http.get(searchApiUrl + input);
      var result = json.decode(searchResult.body);

      setState(() {
        location = result["location"]["name"];
        temperature = result["current"]["temp_c"].round();
        weather = result["current"]["condition"]["text"];
        img = result["current"]["condition"]["icon"];
        humid = result["current"]["humidity"];

        print(location);
        print(temperature);
        print(weather);

        errorMessage = "";
      });
    } catch (error) {
      setState(() {
        errorMessage =
            "Sorry, we ca't find data related to this city! Try another name!";
      });
    }
  }

  void onTextFieldSubmitted(String input) async {
    await fetchSearch(input);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: temperature == null
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 50, top: 100, bottom: 100, right: 0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadowColor: Colors.black,
                        color: HexColor("1ecc47"),
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
                                    child: Card(
                                      shadowColor: Colors.blueGrey,
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                              "Today's  Weather",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            trailing: Image(
                                                image: NetworkImage(
                                                    "https:" + img)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 300,
                                        top: 0,
                                        bottom: 0,
                                        right: 10),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: SizedBox(
                                  height: 50,
                                  width: 300,
                                  child: Card(
                                    shadowColor: Colors.black,
                                    child: Form(
                                      child: TextField(
                                        cursorColor: Colors.green,
                                        decoration: InputDecoration(
                                          fillColor: Colors.red,
                                          border: OutlineInputBorder(),
                                          labelText: 'Enter Location of Garden',
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onSubmitted: (String input) {
                                          onTextFieldSubmitted(input);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              errorMessage,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: Platform.isAndroid ? 15.0 : 20.0,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
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
                                              bottomRight:
                                                  Radius.circular(20))),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: ListTile(
                                          title: Text(
                                            weather,
                                            style: GoogleFonts.roboto(
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.wb_incandescent_outlined,
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
                                              bottomRight:
                                                  Radius.circular(20))),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: ListTile(
                                          title: Text(
                                            temperature.toString() + "°C",
                                            style: GoogleFonts.roboto(
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.dry,
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
                                              bottomRight:
                                                  Radius.circular(20))),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: ListTile(
                                          title: Text(
                                            humid.toString() + "g/kg",
                                            style: GoogleFonts.roboto(
                                                fontSize: 20),
                                          ),
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
                  ],
                ),
              ),
            ),
    );
  }
}
