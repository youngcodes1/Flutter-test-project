import 'package:flutter/material.dart';
import 'package:flutter_test_project/Core/BoxStorage/boxstorage.dart';
import 'package:get/get.dart';

import '../../Db/user_dbhelper/user_dbhelper.dart';
import '../../Models/user_model.dart';
import '../../Views/Screens/AuthScreens/login.dart';

import '../../Views/Screens/AuthScreens/signup.dart';
import '../../common/widgets/bottom_nav.dart';

class AuthProvider extends ChangeNotifier {
  final UserDatabaseHelper _userDatabaseHelper = UserDatabaseHelper.instance;
  bool _loading = false;
  String? _user;
  bool get loading => _loading;
  String? get user => _user;

  signupUser(String username, String password) async {
    try {
      _loading = true;
      notifyListeners();

      User? existingUser =
          await _userDatabaseHelper.queryUser(username, password);
      if (existingUser != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
              content: Text('An account with this email already exists')),
        );
        _loading = false;
        notifyListeners();
        return;
      }

      User newUser = User(username: username, password: password);
      await _userDatabaseHelper.createUser(newUser);
      await BoxStorage.saveUsername(username);

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Signed up Successfully')),
      );
      Get.to(const LoginScreen());

      _loading = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _loading = false;
      notifyListeners();
    }
  }

  loginUser(String username, String password) async {
    try {
      _loading = true;
      notifyListeners();
      User? user = await _userDatabaseHelper.queryUser(username, password);
      await BoxStorage.saveUsername(username);
      if (user != null) {
        Get.to(const BottomNav());
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Invalid username and password')),
        );
        _loading = false;
      }
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _loading = false;
      notifyListeners();
    }
  }

  isUserLoggedIn() async {
    try {
      String? storedUser = await BoxStorage.getUsername();
      if (storedUser != null) {
        Get.to(const BottomNav());
      } else {
        Get.to(const SignupScreen());
      }
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  logoutUser() async {
    try {
      await BoxStorage.clearUsername();
      Get.offAll(const LoginScreen());
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('logged out successfully')),
      );
      _loading = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
