import 'package:SmartGarden/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
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
    if (value.length < 6) {
      return 'Password must be longer than 6 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Login"),
      // ),
      resizeToAvoidBottomInset: true,
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: h / 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // height: h / 3,
                  // width: h / 3,
                  height: 9 * h / 24,
                  width: 9 * h / 24,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/LoginImg.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: h / 24,
            // ),
            Expanded(
              // child: Align(
              //   alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff97daa5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100),
                  ),
                ),
                //height: h / 2,
                //height: 13 * h / 24,
                child: Form(
                  key: _loginFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 35,
                        ),
                        Text(
                          'LOGIN',
                          style: TextStyle(
                              fontFamily: 'Playfair',
                              color: Colors.white,
                              fontSize: 30),
                        ),
                        SizedBox(
                          height: 30,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]),
                                ),
                                filled: true,
                                fillColor: Colors.grey[100],
                                hintText: "Email ID",
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 13.0, horizontal: 20.0),
                              ),
                              controller: emailInputController,
                              keyboardType: TextInputType.emailAddress,
                              validator: emailValidator,
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
                              keyboardType: TextInputType.visiblePassword,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]),
                                ),
                                filled: true,
                                fillColor: Colors.grey[100],
                                hintText: "Password",
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 13.0, horizontal: 20.0),
                              ),
                              controller: pwdInputController,
                              obscureText: true,
                              validator: pwdValidator,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 40,
                          width: 110,
                          child: RaisedButton(
                            padding: EdgeInsets.all(4),
                            child: Text('Login'),
                            color: Color(0xff414040),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23.0),
                            ),
                            onPressed: () {
                              if (_loginFormKey.currentState.validate()) {
                                FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: emailInputController.text,
                                        password: pwdInputController.text)
                                    .then((currentUser) => Firestore.instance
                                        .collection("Users")
                                        .document(currentUser.uid)
                                        .get()
                                        .then((DocumentSnapshot result) =>
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomePage(
                                                          uid: currentUser.uid,
                                                        ))))
                                        .catchError((err) => print(err)))
                                    .catchError((err) => print(err));
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Don't have an account yet?"),
                        FlatButton(
                          child: Text(
                            "Click here to Register!",
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, "/register");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }
}
