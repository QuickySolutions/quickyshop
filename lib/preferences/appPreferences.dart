import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  // More abstraction

  static late final SharedPreferences _instance;

  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();
  //Getters
  static bool? getIsLogin(String key) => _instance.getBool(key);
  // Setter
  static Future<bool> setIsLogin(String key, bool value) =>
      _instance.setBool(key, value);

  //Getters
  static String? getIdBrand(String key) => _instance.getString(key);
  // Setter
  static Future<bool> setIdBrand(String key, String value) =>
      _instance.setString(key, value);
}
