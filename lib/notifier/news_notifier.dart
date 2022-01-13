import 'dart:collection';

import 'package:CWCFlutter/model/news.dart';
import 'package:flutter/cupertino.dart';

class FoodNotifier with ChangeNotifier {
  List<News> _foodList = [];
  News _currentFood;

  UnmodifiableListView<News> get foodList => UnmodifiableListView(_foodList);

  News get currentFood => _currentFood;

  set foodList(List<News> foodList) {
    _foodList = foodList;
    notifyListeners();
  }

  set currentFood(News food) {
    _currentFood = food;
    notifyListeners();
  }

  addFood(News food) {
    _foodList.insert(0, food);
    notifyListeners();
  }

  deleteFood(News food) {
    _foodList.removeWhere((_food) => _food.id == food.id);
    notifyListeners();
  }
}
