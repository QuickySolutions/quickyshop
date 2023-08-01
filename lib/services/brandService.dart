import 'package:dio/dio.dart';
import 'package:quickyshop/models/Brand.dart';
import 'package:quickyshop/models/Store.dart';
import 'package:quickyshop/utils/api.dart';

class BrandResponse {
  String message;
  dynamic data;
  bool status;

  BrandResponse(
      {required this.message, required this.data, required this.status});

  factory BrandResponse.fromJSONResponse(Map<String, dynamic> response) {
    return BrandResponse(
        message: response['message'],
        data: response['data'],
        status: response['status']);
  }
}

class BrandService {
  final Dio _dio = Dio();
  Future<Map<String, dynamic>> getBrandInformation(String brandId) async {
    Response response =
        await _dio.get(ApiUrl.LOCAL_API + '/stores/brand/${brandId}');
    return response.data;
  }

  Future<Map<String, dynamic>> createBranchOffice(
      String brandId, Map<String, dynamic> body) async {
    Response response =
        await _dio.post(ApiUrl.LOCAL_API + '/stores', data: body);
    return response.data;
  }

  Future<List<Store>> branchOfficesByBrand(String brandId) async {
    List<Store> stores = [];

    Response response = await _dio
        .get(ApiUrl.LOCAL_API + '/stores/brand/${brandId}/branchoffices');

    List<dynamic> storesResponse = response.data['data'];

    storesResponse.map((e) => {stores.add(Store.fromJSONResponse(e))}).toList();
    return stores;
  }
}
