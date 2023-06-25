import 'dart:io';

import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  bool _isSignedWithSocialMedia = false;
  late File _phisicalPhoto = File('');

  String _storeName = "";
  String _emailStore = "";
  String _passwordStore = "";
  String _photoProfile = "no_photo";

  String _cellPhoneStore = "";

  //category selection
  String _principalCategorySelected = "";
  String _subLevelSelected = "";
  String _subSubLevelSelected = "";

  bool get isSignedWithSocialMedia => _isSignedWithSocialMedia;

  String get storeName => _storeName;
  String get photoProfile => _photoProfile;
  String get emailStore => _emailStore;
  String get passwordStore => _passwordStore;
  File get physicalPhoto => _phisicalPhoto;

  String get principalCategorySelected => _principalCategorySelected;
  String get subLevelSelected => _subLevelSelected;
  String get subSubLevelSelected => _subSubLevelSelected;

  String get cellPhoneStore => _cellPhoneStore;

  void setSignedWithSocialMedia(bool value) {
    _isSignedWithSocialMedia = value;
    notifyListeners();
  }

  void setNameStore(String valueNameStore) {
    _storeName = valueNameStore;
    notifyListeners();
  }

  void setEmailStore(String valueEmailStore) {
    _emailStore = valueEmailStore;
    notifyListeners();
  }

  void setPhisicalPhoto(File file) {
    _phisicalPhoto = file;
    notifyListeners();
  }

  void setPhotoProfile(String photoProfileValue) {
    _photoProfile = photoProfileValue;
    notifyListeners();
  }

  void setPasswordStore(String valuePasswordStore) {
    _passwordStore = valuePasswordStore;
    notifyListeners();
  }

  void setNumberCellPhone(String numberStore) {
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
