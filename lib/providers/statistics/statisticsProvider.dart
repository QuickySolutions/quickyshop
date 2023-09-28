import 'package:flutter/material.dart';
import 'package:quickyshop/models/survey/Survey.dart';
import 'package:quickyshop/services/statisticsService.dart';

class StatisticProvider extends ChangeNotifier {
  late String _brandId;
  late String _storeId;
  List<Survey> _surveys = [];
  bool _isLoading = false;
  StatisticService _statisticService = StatisticService();

  String get brandId => _brandId;
  String get storeId => _storeId;
  List<Survey> get surveys => _surveys;
  bool get isLoading => _isLoading;

  void setBrandId(String value) {
    _brandId = value;
    notifyListeners();
  }

  void setStoreId(String value) {
    _storeId = value;
    notifyListeners();
  }

  void getAll(String brandIdValue) async {
    List<Survey> response =
        await _statisticService.getBrandStatistics(brandIdValue);

    _surveys = response;

    notifyListeners();
  }

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
