import 'package:hive_flutter/hive_flutter.dart';

class BoxStorage {
  static const String _usernameBoxName = 'usernameBox';

  static Future<void> saveUsername(String username) async {
    final box = await Hive.openBox(_usernameBoxName);
    await box.put('username', username);
  }

  static Future<String?> getUsername() async {
    final box = await Hive.openBox(_usernameBoxName);
    return box.get('username');
  }

  static Future<void> clearUsername() async {
    final box = await Hive.openBox(_usernameBoxName);
    await box.delete('username');
  }
}
