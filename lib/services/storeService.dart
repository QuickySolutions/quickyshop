import 'package:dio/dio.dart';
import 'package:quickyshop/models/Coupon.dart';
import 'package:quickyshop/models/survey/Survey.dart';
import 'package:quickyshop/services/couponsService.dart';

import '../utils/api.dart';

class StoreResponse {
  String message;
  dynamic data;
  bool status;

  StoreResponse(
      {required this.message, required this.data, required this.status});

  factory StoreResponse.fromJSONResponse(Map<String, dynamic> response) {
    return StoreResponse(
        message: response['message'],
        data: response['data'],
        status: response['status']);
  }
}

class StoreService {
  Dio _dio = Dio();

  Future<Map<String, dynamic>> createBranch(
      Map<String, dynamic> storeData) async {
    Response response =
        await _dio.post(ApiUrl.API + '/stores/brand', data: storeData);

    return response.data;
  }

  Future<StoreResponse> getStoreInformation(String id) async {
    Response response = await _dio.get(ApiUrl.API + '/stores/${id}');
    print(response.data);
    return StoreResponse.fromJSONResponse(response.data);
  }

  Future<Map<String, dynamic>> updateStore(
      String id, Map<String, dynamic> data) async {
    Response response =
        await _dio.put(ApiUrl.API + '/stores/${id}', data: data);
    print(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> verifyNumberStoreToSendSMS(
      Map<String, dynamic> storeData) async {
    late Map<String, dynamic> responseMap = {};

    Response response =
        await _dio.post(ApiUrl.API + '/stores/exist/cellhone', data: storeData);

    if (!response.data['exist']) {
      responseMap = {'exist': false, 'message': 'Telefono no existente.'};
    } else {
      responseMap = {'exist': true, 'message': 'Telefono existente.'};
    }

    return responseMap;
  }

  Future<void> changeStatusStore(String id, bool status) async {
    try {
      await _dio.put(ApiUrl.API + '/stores/${id}/change/status',
          data: {'status': status});
    } catch (e) {
      print(e);
    }
  }

  Future<StoreResponse> getSurveysFromStore(String id) async {
    try {
      List<Survey> surveys = [];

      Response response = await _dio.get(ApiUrl.API + '/stores/${id}/surveys');

      response.data['data'].forEach((element) {
        surveys.add(Survey.fromJSONResponse(element));
      });

      return StoreResponse(message: 'Exito', data: surveys, status: true);
    } catch (e) {
      return StoreResponse(message: 'Fallo', data: [], status: false);
    }
  }

  Future<CouponResponse> getAllCoupons(String brandId) async {
    try {
      List<Coupon> couponsResponse = [];
      print(ApiUrl.API);
      String route = ApiUrl.API + '/brands/$brandId/coupons';
      Response response = await _dio.get(route);

      print(response);

      response.data['data'].forEach((element) {
        couponsResponse.add(Coupon.fromJSONResponse(element));
      });

      return CouponResponse(
          message: 'Exito', data: couponsResponse, status: true);
    } catch (e) {
      print(e);
      return CouponResponse(message: 'Fallo', data: [], status: false);
    }
  }

  Future<CouponResponse> getAllCouponsFromStore(String storeId) async {
    try {
      List<Coupon> couponsResponse = [];
      print(ApiUrl.API);
      String route = ApiUrl.API + '/stores/$storeId/coupons';
      Response response = await _dio.get(route);

      response.data['data'].forEach((element) {
        couponsResponse.add(Coupon.fromJSONResponse(element));
      });

      return CouponResponse(
          message: 'Exito', data: couponsResponse, status: true);
    } catch (e) {
      return CouponResponse(message: 'Fallo', data: [], status: false);
    }
  }
}
