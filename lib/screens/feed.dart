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

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  void initState() {
    FoodNotifier foodNotifier =
        Provider.of<FoodNotifier>(context, listen: false);
    getFoods(foodNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);

    Future<void> _refreshList() async {
      getFoods(foodNotifier);
    }

    print("building Feed");
    return Scaffold(
        appBar: AppBar(
          title: Text(
            authNotifier.user != null ? authNotifier.user.displayName : "Feed",
          ),
          actions: <Widget>[
            // action button
            FlatButton(
              onPressed: () => signout(authNotifier),
              child: Text(
                "Logout",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/Signup_Screen',
                  );
                  showBarModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      color: Colors.white,
                    ),
                  );
                })
          ],
        ),
        body: new RefreshIndicator(
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Column(children: [
                ListTile(
                  leading: Image.network(
                    foodNotifier.foodList[index].image != null
                        ? foodNotifier.foodList[index].image
                        : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                    width: 50,
                    height: 50,
                    fit: BoxFit.fitWidth,
                  ),
                  title: Text(foodNotifier.foodList[index].name),
                  subtitle: Text(foodNotifier.foodList[index].category),
                  onTap: () {
                    foodNotifier.currentFood = foodNotifier.foodList[index];
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return FoodDetail();
                    }));
                  },
                ),
                IconButton(
                  onPressed: () =>
                      _chooseProduct(foodNotifier.foodList[index].name),
                  icon: const Icon(Icons.add_shopping_cart),
                )
              ]);
            },
            itemCount: foodNotifier.foodList.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.black,
              );
            },
          ),
          onRefresh: _refreshList,
        ),
        floatingActionButton: new Visibility(
          visible: authNotifier.user.email == "admin@gmail.com",
          child: new FloatingActionButton(
            onPressed: () {
              foodNotifier.currentFood = null;
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return FoodForm(
                    isUpdating: false,
                  );
                }),
              );
            },
            child: Icon(Icons.add),
            foregroundColor: Colors.white,
          ),
        ));
  }

  dynamic _chooseProduct(String name) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString("Cart", name);
  }
}
/// Adding a list or object
/// Use import 'dart:convert'; for jsonEncode
// dynamic putJson(key, val) async {
//   Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//   final SharedPreferences prefs = await _prefs;
//   var valString = jsonEncode(val);
//   var _res = prefs.setString("$key", valString);
//   return _res;
// }