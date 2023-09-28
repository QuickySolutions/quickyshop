import 'package:dio/dio.dart';
import 'package:quickyshop/utils/api.dart';

import '../models/Category.dart';
import '../models/SubLevel.dart';

class CategoriesService {
  final Dio _dio = Dio();
  Future<Map<String, dynamic>> getInformationFromCategory(
      String categoryName) async {
    late Map<String, dynamic> responseMap;

    try {
      Response response =
          await _dio.get("${ApiUrl.API}/categories?name=${categoryName}");

      if (response.data['data'] == null) {
        responseMap = {"status": false, "category": null};
      } else {
        responseMap = {
          "status": true,
          "category": Category.fromResponse(response.data['data'])
        };
      }
    } catch (e) {
      print(e);
    }

    return responseMap;
  }

  Future<List<Category>> getCategories() async {
    List<Category> categories = [];

    try {
      String route = "${ApiUrl.API}/categories";

      print(route);
      Response response = await _dio.get("${ApiUrl.API}/categories");
      print(response);
      List<dynamic> res = response.data['data'];
      print(res);
      res.forEach((element) {
        categories.add(Category.fromResponse(element));
      });
    } catch (e) {
      print(e);
    }

    return categories;
  }

  Future<Map<String, dynamic>> getSubLevelInformation(
      String principalCategory, String subLevelName) async {
    late Map<String, dynamic> responseMap;

    try {
      Response response = await _dio.get(
          "${ApiUrl.API}/categories/category?name=${principalCategory}&subLevel=${subLevelName}");

      if (response.data['status']) {
        responseMap = {
          'subLevel': SubLevel.fromJSONResponse(response.data['data']),
          'status': true
        };
      } else {
        responseMap = {'subLevel': null, 'status': false};
      }
    } catch (e) {
      print(e);
    }

    return responseMap;
  }
}
