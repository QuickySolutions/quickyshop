import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static final AppPreferences _instance = AppPreferences._internal();
  factory AppPreferences() => _instance;
  AppPreferences._internal();

  late SharedPreferences _pref;
  Future<void> initialize() async {
    _pref = await SharedPreferences.getInstance();
  }

  Future<bool> setIdBrand(String name) => _pref.setString('brand_id', name);
  String get brandId => _pref.getString('brand_id') ?? '';
}
