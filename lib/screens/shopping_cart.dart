import 'package:CWCFlutter/api/food_api.dart';
import 'package:CWCFlutter/notifier/auth_notifier.dart';
import 'package:CWCFlutter/notifier/food_notifier.dart';
import 'package:CWCFlutter/screens/detail.dart';
import 'package:CWCFlutter/screens/food_form.dart';
import 'package:CWCFlutter/screens/shopping_cart.dart';
import 'package:CWCFlutter/sharedPref/PreferencesService.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCartWidget extends StatefulWidget {
  @override
  _ShoppingCartWidget createState() => _ShoppingCartWidget();
}

class _ShoppingCartWidget extends State<ShoppingCartWidget> {
  final _preferencesService = PreferencesService();
  final _usernameController = TextEditingController();
  final _imgUrl = TextEditingController();

  @override
  initState() {

    _populateFields();
    super.initState();
  }

  void _populateFields() async {
    final settings = await _preferencesService.getSettings();

    setState(() {
      _usernameController.text = settings.username;
      _imgUrl.text = settings.img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 100,
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(_usernameController.text)),
        Image.network(
          _imgUrl.text != null
              ? (_imgUrl.text.toString())
              : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
          fit: BoxFit.fitWidth,
        ),
        Container(
          width: double.infinity,
          height: 48,
          margin: EdgeInsets.only(top: 550),
          child: OutlinedButton(
            child: Text(
              "Submit",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => print("Tapped"),
            //onPressed: null, //Uncomment this statement to check disabled state.
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey[100];
                }
                return Colors.blue;
              }),
              overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.indigo;
                }
                return Colors.transparent;
              }),
              side: MaterialStateProperty.resolveWith((states) {
                Color _borderColor;

                if (states.contains(MaterialState.disabled)) {
                  _borderColor = Colors.greenAccent;
                } else if (states.contains(MaterialState.pressed)) {
                  _borderColor = Colors.blue;
                } else {
                  _borderColor = Colors.blue;
                }

                return BorderSide(color: _borderColor, width: 5);
              }),
              shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
                return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16));
              }),
            ),
          ),
        )
      ],
    ));
  }

// getString() async {
//   Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//   final SharedPreferences prefs = await _prefs;
//   String _res = prefs.getString("Cart");
//   if (_res != null) {
//     print(_res);
//     return Future.delayed(const Duration(seconds: 1), () => _res);
//   }
// }
}
