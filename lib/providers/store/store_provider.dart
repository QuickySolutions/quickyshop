import 'package:flutter/material.dart';
import 'package:quickyshop/models/Store.dart';
import 'package:quickyshop/preferences/appPreferences.dart';
import 'package:quickyshop/services/brandService.dart';

class StoreProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<Store> _stores = [];
  List<String> _selectedStores = [];
  BrandService _brandService = BrandService();
  bool _wantToSaveInAllStores = false;

  List<Store> get stores => _stores;
  bool get isLoading => _isLoading;
  List<String> get selectedStores => _selectedStores;
  bool get wantToSaveInAllStores => _wantToSaveInAllStores;

  void selectStore(Store store) {
    if (_selectedStores.map((e) => e).contains(store.id)) {
      _selectedStores.removeWhere((selected) => selected == store.id);
    } else {
      _selectedStores.add(store.id!);
    }
    notifyListeners();
  }

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void onSaveInAllStores(bool value) {
    _wantToSaveInAllStores = !wantToSaveInAllStores;

    if (_wantToSaveInAllStores) {
      if (selectedStores.isNotEmpty) {
        _selectedStores.clear();
        List<String> storesId = stores.map((e) => e.id!).toList();
        _selectedStores.addAll([...storesId]);
      } else {
        List<String> storesId = stores.map((e) => e.id!).toList();
        _selectedStores.addAll([...storesId]);
      }
    } else {
      _selectedStores.clear();
    }

    notifyListeners();
  }

  void setSelectedStores(List<String> storesFromSurvey) {
    _selectedStores = storesFromSurvey;
    notifyListeners();
  }

  void getAll() async {
    setIsLoading(true);
    List<Store> stores =
        await _brandService.branchOfficesByBrand(AppPreferences().brandId);

    if (stores.isNotEmpty) {
      _stores = stores;
      setIsLoading(false);
    } else {
      setIsLoading(false);
    }

    notifyListeners();
  }

  void reset() {
    _wantToSaveInAllStores = false;
    _selectedStores = [];
    notifyListeners();
  }
}
