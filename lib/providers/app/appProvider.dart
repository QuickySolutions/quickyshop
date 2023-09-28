import 'package:flutter/material.dart';
import 'package:quickyshop/models/Brand.dart';
import 'package:quickyshop/models/Store.dart';

class AppProvider with ChangeNotifier {
  bool _wantToAddNewStore = false;
  late Store _storeSelected;
  late Brand _brandDefault;
  bool _hasSelectedStore = false;
  bool _hasSelectedBrand = false;
  int _currentPage = 0;

  bool get wantToAddNewStore => _wantToAddNewStore;
  Store get storeSelected => _storeSelected;
  Brand get brandDefault => _brandDefault;
  bool get hasSelectedStore => _hasSelectedStore;
  bool get hasSelectedBrand => _hasSelectedBrand;
  int get currentPage => _currentPage;

  void setWantToAddNewStore(bool value) {
    _wantToAddNewStore = value;
    notifyListeners();
  }

  void selectStore(Store store) {
    _storeSelected = store;
    _hasSelectedStore = true;
    _hasSelectedBrand = false;
    notifyListeners();
  }

  void setDefaultBrand(dynamic brandResponse) {
    _brandDefault = Brand.fromJSONResponse(brandResponse);
    _hasSelectedBrand = true;
    _hasSelectedStore = false;
    notifyListeners();
  }

  void restoreBrandDefault() {
    _hasSelectedStore = false;
    _hasSelectedBrand = true;
    notifyListeners();
  }

  void changePage(int nextPage) {
    _currentPage = nextPage;
    notifyListeners();
  }
}
