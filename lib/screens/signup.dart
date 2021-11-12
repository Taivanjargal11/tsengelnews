import 'package:CWCFlutter/api/food_api.dart';
import 'package:CWCFlutter/model/user.dart';
import 'package:CWCFlutter/notifier/auth_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'feed.dart';

enum AuthMode { Signup, Login }

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  User _user = User();
  AuthMode _authMode = AuthMode.Signup;
  String _email = "";
  String _password = "";
  String _userName = "";
  String _phoneNumber = "";
  String _txtvalue = "";
  final _auth = FirebaseAuth.instance;

  void _submitForm() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    if (_authMode == AuthMode.Signup) {
      signup(_user, authNotifier);
      Navigator.pushNamed(
        context,
        '/',
      );
    } else {
      null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("assets/image/bg.png"),
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Sign-up',
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      height: 100,
                                      width: 100,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      1000),
                                            ),
                                          ),
                                          onPressed: null,
                                          child: Icon(Icons.camera_alt))),
                                  Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(top: 20),
                                      child: Text(
                                        'Name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      )),
                                  TextFormField(
                                    onChanged: (String value) {
                                      _user.displayName = value;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    textAlign: TextAlign.justify,
                                    decoration:
                                        InputDecoration(hintText: 'Your name'),
                                  ),
                                  Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(top: 20),
                                      child: Text(
                                        'Email',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      )),
                                  TextFormField(
                                    onChanged: (String value) {
                                      _user.email = value;
                                    },
                                    textAlign: TextAlign.justify,
                                    decoration: InputDecoration(
                                        hintText: 'Your email-id'),
                                  ),
                                  Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(top: 20),
                                      child: Text(
                                        'Contact no.',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      )),
                                  TextFormField(
                                    onChanged: (value) {
                                      _phoneNumber = value;
                                    },
                                    textAlign: TextAlign.justify,
                                    decoration: InputDecoration(
                                        hintText: 'Your contact number'),
                                  ),
                                  Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(top: 20),
                                      child: Text(
                                        'Password',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      )),
                                  PasswordField(
                                    onChanged: (String value) {
                                      _user.password = value;
                                    },
                                    color: Colors.blue,
                                    passwordConstraint: r'.*[@$#.*].*',
                                    inputDecoration: PasswordDecoration(),
                                    hintText: 'Your password',
                                    errorMessage:
                                        'must contain special character either . * @ # \$',
                                  ),
                                  Container(
                                    width: 300,
                                    height: 50,
                                    margin: EdgeInsets.only(top: 15),
                                    child: OutlinedButton(
                                        onPressed: null,
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.black),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0))),
                                        ),
                                        child: Stack(
                                          children: [
                                            Container(
                                                child: TextButton(
                                              onPressed: () => _submitForm(),
                                              child: Text(
                                                "Submit",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ))
                                          ],
                                        )),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: TextButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  '/',
                                                );
                                              },
                                              child: Text(
                                                "Back to login",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ))),
                                      SizedBox(
                                        height: 200,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );

    //   Scaffold(
    //   backgroundColor: Colors.blue,
    //   appBar: AppBar(
    //     title: const Text('This is Screen 1'),
    //   ),
    //   body: const Center(
    //       child: Text('')
    //   ), // This trailing comma makes auto-formatting nicer for build methods.
    // );
  }
}
