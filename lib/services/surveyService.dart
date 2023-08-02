import 'package:dio/dio.dart';
import 'package:quickyshop/models/Store.dart';
import 'package:quickyshop/models/survey/Survey.dart';
import 'package:quickyshop/utils/api.dart';

class SurveyResponse {
  String message;
  dynamic data;
  bool status;

  SurveyResponse(
      {required this.message, required this.data, required this.status});

  factory SurveyResponse.fromJSONResponse(Map<String, dynamic> response) {
    return SurveyResponse(
        message: response['message'],
        data: response['data'],
        status: response['status']);
  }
}

class SurveyService {
  Dio _dio = Dio();

  Future<SurveyResponse> createSurvey(
      Survey survey, List<Store> storeList, String brandId) async {
    Response response = await _dio.post(ApiUrl.LOCAL_API + '/surveys', data: {
      'survey': survey.toJson(),
      'stores': storeList.map((e) => e.id).toList(),
      'brandId': brandId
    });

    return SurveyResponse.fromJSONResponse(response.data);
  }

  Future<SurveyResponse> editSurvey(Survey survey) async {
    Response response =
        await _dio.put(ApiUrl.LOCAL_API + '/surveys/${survey.id}', data: {
      'survey': survey.toJson(),
    });

    return SurveyResponse.fromJSONResponse(response.data);
  }
}
