import 'package:CWCFlutter/api/food_api.dart';
import 'package:CWCFlutter/notifier/auth_notifier.dart';
import 'package:CWCFlutter/notifier/food_notifier.dart';
import 'package:CWCFlutter/screens/detail.dart';
import 'package:CWCFlutter/screens/food_form.dart';
import 'package:CWCFlutter/screens/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCartWidget extends StatefulWidget {
  @override
  _ShoppingCartWidget createState() => _ShoppingCartWidget();
}

class _ShoppingCartWidget extends State<ShoppingCartWidget> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Text(getString())),
    );
  }

  dynamic getString() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String _res = prefs.getString("Cart");
    return _res;
  }
}
