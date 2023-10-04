import 'package:dio/dio.dart';
import 'package:quickyshop/models/survey/Survey.dart';
import 'package:quickyshop/providers/coupons/coupon_provider.dart';
import 'package:quickyshop/providers/store/store_provider.dart';
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

  Future<SurveyResponse> createSurvey(Survey survey, List<String> storeList,
      String brandId, CouponProvider couponProvider) async {
    Response response = await _dio.post(ApiUrl.API + '/surveys', data: {
      'survey': survey.toJson(),
      'stores': storeList,
      'brandId': brandId,
      'coupon': {
        'isCreated': couponProvider.getCreatedCoupon().id!.isNotEmpty,
        ...couponProvider.getCreatedCoupon().id!.isNotEmpty
            ? couponProvider.getCreatedCoupon().toJson()
            : couponProvider.getSelectedCoupon().toJson(),
      }
    });

    return SurveyResponse.fromJSONResponse(response.data);
  }

  Future<SurveyResponse> editSurvey(
      Survey survey, StoreProvider storeProvider) async {
    Response response = await _dio.put(ApiUrl.API + '/surveys/${survey.id}',
        data: {
          'survey': survey.toJson(),
          'stores': storeProvider.selectedStores
        });
    return SurveyResponse.fromJSONResponse(response.data);
  }

  Future<Map<String, dynamic>> uploadResponse(payload) async {
    late Map<String, dynamic> responseMap;
    try {
      Response response =
          await _dio.post("${ApiUrl.API}/question/saveResponse", data: payload);

      responseMap = response.data;
    } catch (e) {
      print(e);
    }

    return responseMap;
  }
}
