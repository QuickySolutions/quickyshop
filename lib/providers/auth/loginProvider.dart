import 'package:flutter/material.dart';
import 'package:quickyshop/models/Brand.dart';
import 'package:quickyshop/services/authService.dart';

class LoginProvider with ChangeNotifier {
  late String _email = "";
  late String _password = "";
  AuthService _authService = AuthService();

  String get email => _email;
  String get password => _password;

  bool get isValidForm {
    if (_email.isEmpty || _password.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<AuthResponse> login() async {
    try {
      var response =
          await _authService.login(email: _email, password: _password);

      return AuthResponse(
          message: response.message,
          data: response.data,
          from: response.from,
          status: response.status);
    } catch (e) {
      return AuthResponse(
          message: 'Email o usuario incorrectos',
          from: 'nothing',
          data: null,
          status: false);
    }
  }

  void onChangeEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void onChangePassword(String value) {
    _password = value;
    notifyListeners();
  }
}
