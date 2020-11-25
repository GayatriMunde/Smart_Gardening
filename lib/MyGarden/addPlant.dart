import 'package:SmartGarden/MyGarden/MyGarden.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPlant extends StatefulWidget {
  @override
  _AddPlantState createState() => _AddPlantState();

  final String uid;
  AddPlant({@required this.uid});
}

class _AddPlantState extends State<AddPlant> {
  TextEditingController titleController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController dopController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  int _value = 1;
  bool important = false;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Add Plant to my Garden'),
        backgroundColor: Colors.greenAccent,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyGarden(
                    uid: widget.uid,
                  ),
                ),
              );
            }),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 45),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.grey[400]),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.grey[400]),
                      ),
                      filled: true,
                      fillColor: Colors.greenAccent,
                      hintText: "Plant Name",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 13.0, horizontal: 20.0),
                    ),
                    controller: titleController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 45),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.grey[400]),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.grey[400]),
                      ),
                      filled: true,
                      fillColor: Colors.greenAccent,
                      hintText: "Nick Name",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 13.0, horizontal: 20.0),
                    ),
                    controller: nickNameController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 70),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.greenAccent,
                  child: DropdownButton(
                      dropdownColor: Colors.greenAccent[100],
                      autofocus: true,
                      focusColor: Colors.greenAccent,
                      value: _value,
                      items: [
                        DropdownMenuItem(
                          child: Container(
                              alignment: Alignment.center,
                              width: 200,
                              height: 25,

                              child: Text("Fruit bearing Plant")),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Container(
                              alignment: Alignment.center,
                              width: 200,
                              height: 25,
                              child: Text("Flowering Plant")),
                          value: 2,
                        ),
                        DropdownMenuItem(
                            child: Container(
                                alignment: Alignment.center,
                                width: 200,
                                height: 25,
                                child: Text("Bonecye")),
                            value: 3),
                        DropdownMenuItem(
                            child: Container(
                                alignment: Alignment.center,
                                width: 200,
                                height: 25,
                                child: Text("Cactus Plant")),
                            value: 4),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      }),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              // StatefulBuilder(
              //   builder: (BuildContext context,
              //       StateSetter setState) {
              //     return CheckboxListTile(
              //       title: Text('Status'),
              //       value: status,
              //       onChanged: (bool value) {
              //         setState(() {
              //           status = value;
              //         });
              //       },
              //     );
              //   },
              // ),
              Center(
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    var switchListTile = SwitchListTile(
                      title: Center(
                          child: Text('\t \t \t \t \t \t \t Potted Plant')),
                      value: important,
                      onChanged: (bool value) {
                        setState(() {
                          important = value;
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    );
                    return Center(
                      child: switchListTile,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text('\t Add Plant \t'),
                padding: EdgeInsets.all(4),
                color: Color(0xff414040),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23.0),
                ),
                onPressed: () {
                  Firestore.instance
                      .collection("Users")
                      .document(widget.uid)
                      .collection('MyGarden')
                      .add({
                    'PlantName': titleController.text.trim(),
                    'NickName': nickNameController.text.trim(),
                    'dop': dopController.text.trim(),
                    'category': categoryController.text.trim(),
                    'important': important,
                    'Status': false,
                    'TimeStamp': FieldValue.serverTimestamp()
                  }).then((result) => {});
                  titleController = TextEditingController();
                  nickNameController = TextEditingController();
                  FocusScope.of(context).unfocus();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyGarden(
                        uid: widget.uid,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
