import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:quickyshop/utils/api.dart';

class AuthResponse {
  String message;
  dynamic data;
  bool status;
  String from;
  AuthResponse(
      {required this.message,
      required this.from,
      required this.data,
      required this.status});

  factory AuthResponse.fromJSONResponse(Map<String, dynamic> response) {
    return AuthResponse(
        message: response['message'],
        data: response['data'],
        from: response['from'],
        status: response['status']);
  }
}

class AuthService {
  final Dio _dio = Dio();

  Future<AuthResponse> login({
    String? email,
    String? password,
    String? signInMethod,
  }) async {
    late Response response;

    try {
      if (signInMethod == 'password') {
        response = await _dio.post("${ApiUrl.API}/users/store/login", data: {
          'email': email,
          'password': password,
          'signInMethod': 'password',
        });
      } else {
        response = await _dio.post("${ApiUrl.API}/users/store/login", data: {
          'email': email,
          'password': '',
          'signInMethod': 'socialMedia',
        });
      }

      return AuthResponse.fromJSONResponse(response.data);
    } catch (error) {
      throw error;
    }
  }
}
