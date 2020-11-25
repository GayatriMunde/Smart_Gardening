import 'package:SmartGarden/MyGarden/addPlant.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../HomePage.dart';

class MyGarden extends StatefulWidget {
  @override
  _MyGardenState createState() => _MyGardenState();

  final String uid;
  MyGarden({@required this.uid});
}

class _MyGardenState extends State<MyGarden> {
  FirebaseUser currentUser;

  @override
  initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  Widget buildMyGardenList(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context, index) {
          DocumentSnapshot mygarden = snapshot.data.documents[index];
          bool status = mygarden.data['Status'];
          bool importance = mygarden.data['Important'];

          return Container(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: Card(
              elevation: 14,
              child: Container(
                height: 80,
                child: ListTile(
                  tileColor: Colors.greenAccent,

                  // isThreeLine: true,
                  // Access the fields as defined in FireStore
                  leading: Container(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.opacity_outlined),
                          onPressed: () {
                            setState(() {
                              Firestore.instance
                                  .collection("Users")
                                  .document(widget.uid)
                                  .collection('MyGarden')
                                  .document(mygarden.documentID)
                                  .setData({'Status': !status},
                                      merge: true).then((_) {
                                // importance = !importance;
                              });
                            });
                          },
                          color: status ? Colors.blue : Colors.grey,
                        ),
                        IconButton(
                          icon: Icon(Icons.spa_rounded),
                          color: Colors.green,
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                  title: Text(
                    '${mygarden.data['PlantName']}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ), // here we could use a column widget if we want to add a subtitle
                  ),
                  subtitle: Row(
                    children: [
                      Container(
                        height: 30,
                        child: SingleChildScrollView(
                          child: Text(
                            '${mygarden.data['NickName']}',
                            style: TextStyle(
                              // fontFamily: 'Lora',
                              // fontStyle: FontStyle.normal,
                              // fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: SingleChildScrollView(
                          child: Text(
                            '\n'
                            '${mygarden.data['category']}',
                            style: TextStyle(
                              // fontFamily: 'Lora',
                              // fontStyle: FontStyle.normal,
                              // fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_forever,
                    ),
                    onPressed: () {
                      setState(() {
                        Firestore.instance
                            .collection("Users")
                            .document(widget.uid)
                            .collection('MyGarden')
                            .document(mygarden.documentID)
                            .delete()
                            .then((_) {
                          // importance = !importance;
                        });
                      });
                    },
                    color: Colors.red,
                  ),
                  // onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             Display(work: work.data, id: workID)),
                  //   );
                  // },
                ),
              ),
            ),
          );
        },
      );
    } else if (snapshot.connectionState == ConnectionState.done &&
        !snapshot.hasData) {
      // Handle no data
      return Center(
        child: Text("No Users found."),
      );
    } else {
      // Still loading
      return Center(
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
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
              
            title: Text(
              "My Garden",
              style: TextStyle(fontFamily: 'Lora'),
            ),
            
            backgroundColor: Colors.greenAccent,
            bottom: TabBar(tabs: [
              Tab(
                text: 'All',
              ),
              Tab(
                text: 'Watered',
              ),
              Tab(
                text: 'Remaining',
              )
            ]),
          ),
          body: TabBarView(children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  width: w,
                  height: h * 0.65,
                  child: FutureBuilder(
                      builder: buildMyGardenList,
                      future: Firestore.instance
                          .collection("Users")
                          .document(widget.uid)
                          .collection('MyGarden')
                          .orderBy('TimeStamp', descending: true)
                          // .where("Hirer UID", isEqualTo: _uid)
                          .getDocuments()),
                ),
                Divider(
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // FloatingActionButton(
                      //   heroTag: "btn1",
                      //   onPressed: () {
                      //     Navigator.pushReplacement(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => HomePage(
                      //                   uid: currentUser.uid,
                      //                 )));
                      //   },
                      //   child: Icon(Icons.arrow_back),
                      // ),
                      FloatingActionButton(
                        heroTag: "btn2",
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddPlant(uid: widget.uid)));
                        },
                        child: Icon(
                          Icons.add,
                        ),
                        backgroundColor: Colors.greenAccent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: w,
                  height: h * 0.75,
                  child: FutureBuilder(
                      builder: buildMyGardenList,
                      future: Firestore.instance
                          .collection("Users")
                          .document(widget.uid)
                          .collection('MyGarden')
                          .where('Status', isEqualTo: true)
                          //.orderBy('TimeStamp', descending: true)
                          .getDocuments()),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: w,
                  height: h * 0.75,
                  child: FutureBuilder(
                      builder: buildMyGardenList,
                      future: Firestore.instance
                          .collection("Users")
                          .document(widget.uid)
                          .collection('MyGarden')
                          .where('Status', isEqualTo: false)
                          //.orderBy('TimeStamp', descending: true)
                          .getDocuments()),
                ),
              ],
            ),
          ]),
        ));
  }
}
