import 'package:SmartGarden/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameInputController;
  TextEditingController lastNameInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;

  @override
  initState() {
    firstNameInputController = new TextEditingController();
    lastNameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Register"),
        // ),
        body: Container(
            decoration: BoxDecoration(
              color: Color(0xff97daa5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Form(
              key: _registerFormKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 45, left: 45),
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
                        fillColor: Colors.white,
                        hintText: "Full Name",
                        alignLabelWithHint: true,
                      ),
                      controller: firstNameInputController,
                      validator: (value) {
                        if (value.length < 3) {
                          return "Please enter Full Name.";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 45, left: 45),
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
                          fillColor: Colors.white,
                          hintText: "Email"),
                      controller: emailInputController,
                      keyboardType: TextInputType.emailAddress,
                      validator: emailValidator,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 45, left: 45),
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
                          fillColor: Colors.white,
                          hintText: "Password"),
                      controller: pwdInputController,
                      obscureText: true,
                      validator: pwdValidator,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 45, left: 45),
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
                          fillColor: Colors.white,
                          hintText: "Confirm Password"),
                      controller: confirmPwdInputController,
                      obscureText: true,
                      validator: pwdValidator,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  RaisedButton(
                    padding: EdgeInsets.all(4),
                    child: Text('Register'),
                    color: Color(0xff414040),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23.0),
                    ),
                    onPressed: () {
                      if (_registerFormKey.currentState.validate()) {
                        if (pwdInputController.text ==
                            confirmPwdInputController.text) {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailInputController.text,
                                  password: pwdInputController.text)
                              .then((currentUser) => Firestore.instance
                                  .collection("Users")
                                  .document(currentUser.uid)
                                  .setData({
                                    "uid": currentUser.uid,
                                    "fname": firstNameInputController.text,
                                    "email": emailInputController.text,
                                  })
                                  .then((result) => {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HomePage(
                                                      uid: currentUser.uid,
                                                    )),
                                            (_) => false),
                                        firstNameInputController.clear(),
                                        lastNameInputController.clear(),
                                        emailInputController.clear(),
                                        pwdInputController.clear(),
                                        confirmPwdInputController.clear()
                                      })
                                  .catchError((err) => print(err)))
                              .catchError((err) => print(err));
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text("The passwords do not match"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Already have an account?"),
                  FlatButton(
                    child: Text(
                      "Click here to Login!",
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ))));
  }
}