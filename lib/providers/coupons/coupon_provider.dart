import 'package:flutter/material.dart';
import 'package:quickyshop/models/Coupon.dart';
import 'package:quickyshop/services/couponsService.dart';

class CouponProvider extends ChangeNotifier {
  CouponsService _couponsService = CouponsService();
  bool _isLoadingRequest = false;
  List<Coupon> _coupons = [];
  late String _couponName;
  double _couponMonetization = 0.0;
  int _addToStores = 0;

  bool get isLoading => _isLoadingRequest;
  List<Coupon> get couponsList => _coupons;
  String get couponName => _couponName;
  int get addToStores => _addToStores;
  double get couponMonetization => _couponMonetization;

  bool get isValidForm {
    if (_couponName.isEmpty && _couponMonetization.isNegative ||
        _couponMonetization == 0) {
      return false;
    } else {
      return true;
    }
  }

  void onChangeName(String value) {
    _couponName = value;
    notifyListeners();
  }

  void onChangeMonetization(double monetization) {
    _couponMonetization = monetization;
    notifyListeners();
  }

  void addToStoresSelection(int value) {
    _addToStores = value;
    notifyListeners();
  }

  void getAll() async {
    setIsLoading(true);
    CouponResponse couponResponse =
        await _couponsService.getAllCoupons("64989445c41230ffd2539f89");
    List<Coupon> listCoupons = couponResponse.data;

    if (listCoupons.isNotEmpty) {
      _coupons = listCoupons;
      setIsLoading(false);
    }

    notifyListeners();
  }

  void create(Coupon coupon) async {
    setIsLoading(true);
    await _couponsService.createCoupon(coupon);
  }

  void update(Coupon coupon) {}

  void delete(String id) {}

  void setIsLoading(bool value) {
    _isLoadingRequest = value;
    notifyListeners();
  }
}
