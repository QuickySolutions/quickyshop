import 'package:dio/dio.dart';
import 'package:quickyshop/utils/api.dart';

class AuthResponse {
  String message;
  dynamic data;
  bool status;

  AuthResponse(
      {required this.message, required this.data, required this.status});

  factory AuthResponse.fromJSONResponse(Map<String, dynamic> response) {
    return AuthResponse(
        message: response['message'],
        data: response['data'],
        status: response['status']);
  }
}

class AuthService {
  final Dio _dio = Dio();
  Future<AuthResponse> login({email, password}) async {
    Response response = await _dio.post("${ApiUrl.API}/users/store/login",
        data: {'email': email, 'password': password});
    return AuthResponse.fromJSONResponse(response.data);
  }
}
