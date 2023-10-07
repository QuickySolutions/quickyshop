import 'package:dio/dio.dart';
import 'package:quickyshop/models/Coupon.dart';
import 'package:quickyshop/utils/api.dart';

class CouponResponse {
  String message;
  dynamic data;
  bool status;

  CouponResponse(
      {required this.message, required this.data, required this.status});

  factory CouponResponse.fromJSONResponse(Map<String, dynamic> response) {
    return CouponResponse(
        message: response['message'],
        data: response['data'],
        status: response['status']);
  }
}

class CouponsService {
  Dio _dio = Dio();

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

  Future<CouponResponse> createCoupon(
      Coupon coupon, List<String> storesId) async {
    Response response = await _dio.post(ApiUrl.API + '/coupons',
        data: {...coupon.toJson(), 'stores': storesId});
    return CouponResponse.fromJSONResponse(response.data);
  }

  Future<CouponResponse> desactiveCoupon(String id) async {
    Response response = await _dio.put(ApiUrl.API + '/coupons/$id/desactive');

    return CouponResponse.fromJSONResponse(response.data);
  }

  Future<CouponResponse> editCoupon(Coupon updatedCoupon) async {
    Response response = await _dio.put(
        ApiUrl.API + '/coupons/${updatedCoupon.id}',
        data: updatedCoupon.toJson());
    print(response.data);
    return CouponResponse.fromJSONResponse(response.data);
  }

  // Future<CouponResponse> deleteCoupon() async {
  //   try {
  //     Response response = await _dio.post(ApiUrl.API + '/stores');
  //     return
  //   } catch (e) {

  //   }
  // }
}
