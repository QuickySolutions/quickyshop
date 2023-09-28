import 'package:dio/dio.dart';

import '../utils/api.dart';

class StoreService {
  Dio _dio = Dio();

  Future<Map<String, dynamic>> createBranch(
      Map<String, dynamic> storeData) async {
    Response response =
        await _dio.post(ApiUrl.API + '/stores/brand', data: storeData);

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
}
