import 'package:flutter/material.dart';
import 'package:flutter_test_project/Views/Screens/AppScreens/Favorite/favorite.dart';
import 'package:flutter_test_project/Views/Screens/AppScreens/History/history.dart';

import '../../Views/Screens/AppScreens/Home/home.dart';

class BottomNavProvider extends ChangeNotifier {
  int currentIndex = 1;

  final screens = const [
    HistoryScreen(),
    HomeScreen(),
    FavoriteScreen(),
  ];

  void updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
