import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<bool> preferenceHasKey(String key) async {
    SharedPreferences prefsInstance = await SharedPreferences.getInstance();
    return prefsInstance.containsKey(key);
  }

  static storeDataToShared(String key, String data) async {
    SharedPreferences prefsInstance = await SharedPreferences.getInstance();
    prefsInstance.setString(key, data);
  }

  static removeDataFromShared(String key) async {
    SharedPreferences prefsInstance = await SharedPreferences.getInstance();
    prefsInstance.remove(key);
  }

  static clear() async {
    SharedPreferences prefsInstance = await SharedPreferences.getInstance();
    prefsInstance.clear();
  }

  static Future<String?> getDataFromShared(String key) async {
    SharedPreferences prefInstance = await SharedPreferences.getInstance();
    return prefInstance.getString(key);
  }
}
