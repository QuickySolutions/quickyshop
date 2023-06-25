import 'package:dio/dio.dart';
import 'package:quickyshop/models/Brand.dart';
import 'package:quickyshop/utils/api.dart';

class BrandService {
  Dio _dio = Dio();
  Future<Map<String, dynamic>> getBrandInformation(String brandId) async {
    Map<String, dynamic> responseMap = {};
    Response response =
        await _dio.get(ApiUrl.LOCAL_API + '/stores/brand/${brandId}');
    print(response.data);

    return responseMap;
  }
}
