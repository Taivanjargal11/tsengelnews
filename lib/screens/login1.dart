import 'package:flutter/material.dart';
import 'package:CWCFlutter/api/food_api.dart';
import 'package:CWCFlutter/model/user.dart';
import 'package:CWCFlutter/notifier/auth_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class Login1 extends StatefulWidget {
  @override
  State<Login1> createState() => _Login1();
}

class _Login1 extends State<Login1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = new TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  User _user = User();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _submitForm() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    if (_authMode == AuthMode.Login) {
      login(_user, authNotifier);
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
          child: Stack(
            children: [
              Image.asset("assets/image/bg.png"),
              Column(
                children: [
                  SizedBox(
                    height: 280,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Log-in',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            )),
                        Container(
                          height: 50,
                          child: TextFormField(
                            onChanged: (String value) {
                              _user.email = value;
                            },
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.justify,
                            decoration:
                                InputDecoration(hintText: 'mail@website.com'),
                          ),
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              'Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            )),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(top: 0),
                          child: TextFormField(
                            onChanged: (String value) {
                              _user.password = value;
                            },
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.justify,
                            decoration: InputDecoration(hintText: 'Password'),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/Forget_Password',
                                );
                              },
                              child: const Text(
                                'Forget password!',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 300,
                          height: 50,
                          margin: EdgeInsets.only(top: 15),
                          child: OutlinedButton(
                              onPressed: null,
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.black),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0))),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    child: TextButton(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      onPressed: () => _submitForm(),
                                    ),
                                  )
                                ],
                              )),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Don't have an account ?",
                              ),
                            ),
                            Expanded(
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/Signup_Screen',
                                      );
                                    },
                                    child: Text(
                                      "Sign-up",
                                      style: TextStyle(color: Colors.grey),
                                    ))),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                                "-----------------Or login with-----------------"),
                          ],
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const <Widget>[
                              IconButton(
                                  icon: const Icon(
                                    Icons.mail_outline,
                                    size: 50,
                                  ),
                                  tooltip: 'E-Mail',
                                  onPressed: null),
                              IconButton(
                                  icon: const Icon(
                                    Icons.facebook,
                                    size: 50,
                                  ),
                                  tooltip: 'Facebook',
                                  onPressed: null),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
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
    //   backgroundColor: Colors.yellow,
    //   appBar: AppBar(
    //     title: const Text('This is Screen 0'),
    //   ),
    //   body: Center(
    //       child: Column(
    //         children: [
    //           ElevatedButton(
    //             child: const Text('Go to Screen 1'),
    //             onPressed: (){
    //               Navigator.pushNamed(context,'First Screen',);
    //             },
    //           ),
    //           ElevatedButton(
    //             child: const Text('Go to Screen 2'),
    //             onPressed: (){
    //               Navigator.pushNamed(context,'Second Screen',);
    //             },
    //           ),
    //         ],
    //       )
    //   ), // This trailing comma makes auto-formatting nicer for build methods.
    // );
  }
}
