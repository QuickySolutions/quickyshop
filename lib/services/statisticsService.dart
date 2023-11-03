import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:quickyshop/models/survey/Survey.dart';
import 'package:quickyshop/utils/api.dart';

class StatisticResponse {
  Map<String, dynamic> survey;
  List<Map<String, dynamic>> questions;

  StatisticResponse({required this.survey, required this.questions});

  factory StatisticResponse.fromJSONResponse(Map<String, dynamic> response) {
    return StatisticResponse(
        survey: response['survey'], questions: response['questions']);
  }
}

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

  Future<List<Survey>> getStoreStatistics(String storeId) async {
    List<Survey> responseData = [];
    List<dynamic> responseMap;
    Response response =
        await _dio.get(ApiUrl.API + '/stadistics/store/${storeId}');
    responseMap = response.data['surveys'];
    responseMap.forEach((e) {
      responseData.add(Survey.fromJSONResponseWithOutQuestions(e));
    });

    return responseData;
  }

  Future<Map<String, dynamic>> getSurveyQuestionsStatistics(
      String surveyId) async {
    Response response =
        await _dio.get(ApiUrl.API + '/surveys/$surveyId/question/stadistics');
    return response.data;
  }
}
