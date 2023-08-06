import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper {
  static SharedPreferences? _sharedPreferences;
  static void createSharedPrefrence() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData(@required String key, @required String value) {
    return _sharedPreferences!.setString(key, value!);
  }

  static dynamic getData(@required String key) {
    return _sharedPreferences!.getString(key);
  }

  static dynamic removeData(@required String key) {
    return _sharedPreferences!.remove(key);
  }

  static bool checkIfLoggedIn(String uId) {
    if (CasheHelper.getData(uId) == null) {
      return false;
    } else {
      return true;
    }
  }
}
