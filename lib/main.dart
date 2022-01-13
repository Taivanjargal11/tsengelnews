import 'package:CWCFlutter/notifier/news_notifier.dart';
import 'package:CWCFlutter/screens/SignUp.dart';
import 'package:CWCFlutter/screens/feed.dart';
import 'package:CWCFlutter/screens/login.dart';
import 'package:CWCFlutter/screens/login1.dart';
import 'package:CWCFlutter/screens/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'notifier/auth_notifier.dart';

void main() =>
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => FoodNotifier(),
        ),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {

  // @override
  // void initState() {
  //   FirebaseMessaging.instance.getInitialMessage();
  //   FirebaseMessaging.onMessage.listen((message) {
  //     if (message.notification != null){
  //       print(message.notification!.body);
  //       print(message.notification!.title);
  //
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.lightBlue,
      ),
      initialRoute: '',
      routes: {
        '/Signup_Screen': (context) => SignUp(),
        // '/Shopping_cart':(context)=>ShoppingCartWidget(),

      },
      home: Consumer<AuthNotifier>(
        builder: (context, notifier, child) {
          return notifier.user != null ? Feed() : Login1();
        },
      ),
    );
  }
}
