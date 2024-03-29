import 'package:flutter/material.dart';
import 'package:quickyshop/models/Brand.dart';
import 'package:quickyshop/models/Store.dart';

class AppProvider with ChangeNotifier {
  bool _wantToAddNewStore = false;
  late Store _storeSelected = Store(
      name: '',
      photo: '',
      category: '',
      subcategory: '',
      email: '',
      location: '',
      principal_category: '',
      brandId: '');
  late Brand _brandDefault = Brand(
      id: "",
      name: "",
      email: "",
      cellphone: "",
      principalCategory: "",
      category: "",
      subCategory: "",
      photo: "");
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

  void setDefaultStore(dynamic store) {
    _storeSelected = Store.fromJSONResponse(store);
    _hasSelectedStore = true;
    _hasSelectedBrand = false;
    notifyListeners();
  }

  void restoreBrandDefault() {
    _hasSelectedStore = false;
    _hasSelectedBrand = true;
    notifyListeners();
  }

  void selectBrand() {
    _hasSelectedBrand = true;
    notifyListeners();
  }

  void changePage(int nextPage) {
    _currentPage = nextPage;
    notifyListeners();
  }

  void removePhoto() {
    _brandDefault.photo = "";
    notifyListeners();
  }

  void reset() {
    _brandDefault = Brand(
        id: '',
        name: '',
        email: '',
        cellphone: '',
        principalCategory: '',
        category: '',
        subCategory: '',
        photo: '');
    _storeSelected = Store(
        name: '',
        photo: '',
        category: '',
        subcategory: '',
        email: '',
        location: '',
        principal_category: '',
        brandId: '');

    _hasSelectedBrand = false;
    _hasSelectedStore = false;

    notifyListeners();
  }
}
