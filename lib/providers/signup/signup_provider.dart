import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  String _storeName = "";
  String _emailStore = "";
  String _passwordStore = "";

  int _cellPhoneStore = 0;

  //category selection
  String _principalCategorySelected = "";
  String _subLevelSelected = "";
  String _subSubLevelSelected = "";

  String get storeName => _storeName;
  String get emailStore => _emailStore;
  String get passwordStore => _passwordStore;

  String get principalCategorySelected => _principalCategorySelected;
  String get subLevelSelected => _subLevelSelected;
  String get subSubLevelSelected => _subSubLevelSelected;

  int get cellPhoneStore => _cellPhoneStore;

  void setNameStore(String valueNameStore) {
    _storeName = valueNameStore;
    notifyListeners();
  }

  void setEmailStore(String valueEmailStore) {
    _emailStore = valueEmailStore;
    notifyListeners();
  }

  void setPasswordStore(String valuePasswordStore) {
    _passwordStore = valuePasswordStore;
    notifyListeners();
  }

  void setNumberCellPhone(int numberStore) {
    _cellPhoneStore = numberStore;
    notifyListeners();
  }

  void selectPrincipalCategory(String value) {
    _principalCategorySelected = value;
    notifyListeners();
  }

  void selectedSubLevelCategory(String value) {
    _subLevelSelected = value;
    notifyListeners();
  }

  void selectedSubSubLevelCategory(String value) {
    _subSubLevelSelected = value;
    notifyListeners();
  }

  void clearAll() {
    _principalCategorySelected = "";
    _subLevelSelected = "";
    _subSubLevelSelected = "";
    notifyListeners();
  }
}
