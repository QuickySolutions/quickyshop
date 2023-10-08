import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:quickyshop/utils/api.dart';

class RetentionResponse {
  String message;
  dynamic data;
  bool status;

  RetentionResponse(
      {required this.message, required this.data, required this.status});

  factory RetentionResponse.fromJSONResponse(Map<String, dynamic> response) {
    return RetentionResponse(
        message: response['message'],
        data: response['data'],
        status: response['status']);
  }
}

class RetentionService {
  final Dio _dio = Dio();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<RetentionResponse> searchRetention(String scannedQR) async {
    try {
      Response response = await _dio.get("${ApiUrl.API}/retentions/$scannedQR");
      RetentionResponse retentionResponse =
          RetentionResponse.fromJSONResponse(response.data);

      return retentionResponse;
    } catch (e) {
      return RetentionResponse(
          message: 'Algo ha fallado con la busqueda',
          data: null,
          status: false);
    }
  }

  Future<RetentionResponse> deleteRetention(String scannedQR) async {
    print(scannedQR);
    try {
      _firebaseFirestore
          .collection('retentions')
          .doc(scannedQR)
          .update({'validated': true});

      Response response =
          await _dio.delete("${ApiUrl.API}/retentions/$scannedQR");
      RetentionResponse retentionResponse =
          RetentionResponse.fromJSONResponse(response.data);

      return retentionResponse;
    } catch (e) {
      print(e);
      return RetentionResponse(
          message: 'Algo ha fallado con la busqueda',
          data: null,
          status: false);
    }
  }
}
