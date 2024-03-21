import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  late String _name;
  late String _location;
  late String _photo;
  late String _email;
  late String _cellphone;
  bool _isLoading = false;
  bool _showForm = false;
  bool _showChangePasswordForm = false;

  String get name => _name;
  String get location => _location;
  String get photo => _photo;
  String get email => _email;
  String get cellPhone => _cellphone;
  bool get isLoading => _isLoading;
  bool get showForm => _showForm;
  bool get showChangePasswordForm => _showChangePasswordForm;

  void onChangeName(String value) {
    _name = value;
    notifyListeners();
  }

  void onChangeEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void onChangePhoto(String picture) {
    _photo = picture;
    notifyListeners();
  }

  void onChangeLocation(String value) {
    _location = value;
    notifyListeners();
  }

  void onChangeCellPhone(String phone) {
    _cellphone = phone;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void showFormProfile(bool value) {
    _showForm = value;
    notifyListeners();
  }

  void showChangePassword(bool value) {
    _showChangePasswordForm = value;
    notifyListeners();
  }

  Map<String, dynamic> toBrand() {
    return {
      "name": _name,
      "email": _email,
      "cellphone": _cellphone,
      "photo": _photo
    };
  }

  Map<String, dynamic> toStore() {
    return {
      "name": _name,
      "email": _email,
      "location": _location,
      "photo": _photo
    };
  }
}
