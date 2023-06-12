import 'package:dio/dio.dart';

import '../utils/api.dart';

class StoreService {
  Dio _dio = Dio();

  Future<Map<String, dynamic>> registerStore(
      Map<String, dynamic> storeData) async {
    late Map<String, dynamic> responseMap = {};

    Response response = await _dio
        .post(ApiUrl.LOCAL_API + '/stores/addBrandStore', data: storeData);

    print(response.data);

    return responseMap;
  }

  Future<Map<String, dynamic>> verifyNumberStoreToSendSMS(
      Map<String, dynamic> storeData) async {
    late Map<String, dynamic> responseMap = {};

    Response response = await _dio
        .post(ApiUrl.LOCAL_API + '/stores/exist/cellhone', data: storeData);

    if (!response.data['exist']) {
      responseMap = {'exist': false, 'message': 'Telefono no existente.'};
    } else {
      responseMap = {'exist': true, 'message': 'Telefono existente.'};
    }

    return responseMap;
  }
}
