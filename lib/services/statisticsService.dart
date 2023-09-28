import 'package:dio/dio.dart';
import 'package:quickyshop/models/survey/Survey.dart';
import 'package:quickyshop/utils/api.dart';

class StatisticService {
  final Dio _dio = Dio();
  Future<List<Survey>> getBrandStatistics(String brandId) async {
    List<Survey> responseData = [];
    List<dynamic> responseMap;
    Response response =
        await _dio.get(ApiUrl.API + '/stadistics/brand/${brandId}');

    responseMap = response.data['surveys'];
    responseMap.forEach((e) {
      responseData.add(Survey.fromJSONResponseWithOutQuestions(e));
    });

    return responseData;
  }
}
