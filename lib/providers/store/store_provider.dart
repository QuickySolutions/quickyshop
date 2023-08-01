import 'package:flutter/material.dart';
import 'package:quickyshop/models/Store.dart';
import 'package:quickyshop/services/brandService.dart';

class StoreProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<Store> _stores = [];
  List<Store> _selectedStores = [];
  BrandService _brandService = BrandService();

  List<Store> get stores => _stores;
  bool get isLoading => _isLoading;
  List<Store> get selectedStores => _selectedStores;

  void selectStore(Store store) {
    print(store);
    if (_selectedStores.map((e) => e.id).contains(store.id)) {
      _selectedStores.removeWhere((selected) => selected.id == store.id);
    } else {
      print('aqui');
      _selectedStores.add(store);
    }

    print(_selectedStores);
    notifyListeners();
  }

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void getAll() async {
    setIsLoading(true);
    List<Store> stores =
        await _brandService.branchOfficesByBrand("64989445c41230ffd2539f89");

    if (stores.isNotEmpty) {
      _stores = stores;
      setIsLoading(false);
    } else {
      setIsLoading(false);
    }

    notifyListeners();
  }
}
