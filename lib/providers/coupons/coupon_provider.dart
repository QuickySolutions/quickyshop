import 'package:flutter/material.dart';
import 'package:quickyshop/models/Coupon.dart';
import 'package:quickyshop/services/couponsService.dart';

class CouponProvider extends ChangeNotifier {
  CouponsService _couponsService = CouponsService();
  bool _isLoadingRequest = false;
  List<Coupon> _coupons = [];
  late String _couponName = "";
  num _couponMonetization = 0.0;
  late Coupon _selectedCoupon =
      Coupon(id: '', name: '', monetization: 0, brandId: '', active: false);
  late Coupon _couponForSurvey =
      Coupon(id: '', name: '', monetization: 0, brandId: '', active: false);
  int _addToStores = 0;

  bool get isLoading => _isLoadingRequest;
  List<Coupon> get couponsList => _coupons;
  Coupon get selectedCoupon => _selectedCoupon;
  String get couponName => _couponName;
  int get addToStores => _addToStores;
  num get couponMonetization => _couponMonetization;
  Coupon get couponForSurvey => _couponForSurvey;

  bool get couponsAreDifferent {
    if ((_couponForSurvey.id!.isNotEmpty && _selectedCoupon.id!.isNotEmpty) &&
        (_couponForSurvey.id != _selectedCoupon.id)) {
      return true;
    } else {
      return false;
    }
  }

  bool get areCouponSelectedOrCreated {
    if (_couponForSurvey.id!.isEmpty && _selectedCoupon.id!.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Coupon get getCoupon {
    if (_couponForSurvey.id!.isEmpty) {
      return _selectedCoupon;
    } else {
      return _couponForSurvey;
    }
  }

  bool get isValidForm {
    if (_couponName.isEmpty ||
        (_couponMonetization.isNegative || _couponMonetization == 0)) {
      return false;
    } else {
      return true;
    }
  }

  void onChangeName(String value) {
    _couponName = value;
    notifyListeners();
  }

  void onChangeMonetization(num monetization) {
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
    } else {
      setIsLoading(false);
    }

    notifyListeners();
  }

  void create(Coupon coupon) async {
    setIsLoading(true);
    CouponResponse response = await _couponsService.createCoupon(coupon);
    _coupons.add(Coupon.fromJSONResponse(response.data));
    setIsLoading(false);
    notifyListeners();
  }

  void update(Coupon updatedCoupon) {
    int indexOfItem =
        _coupons.indexWhere((coupon) => coupon.id == updatedCoupon.id);

    _coupons[indexOfItem] = updatedCoupon;
    notifyListeners();
  }

  void delete(String id) {
    _coupons.removeWhere((coupon) => coupon.id == id);
    _couponsService.desactiveCoupon(id);
    notifyListeners();
  }

  void setIsLoading(bool value) {
    _isLoadingRequest = value;
    notifyListeners();
  }

  void selectCouponToEdit(Coupon couponItem) {
    _couponName = couponItem.name;
    _couponMonetization = couponItem.monetization;
    _selectedCoupon = couponItem;
    notifyListeners();
  }

  void selectCoupon(Coupon coupon) {
    _selectedCoupon = coupon;
    notifyListeners();
  }

  void addCoupon(Coupon coupon) {
    _couponForSurvey = coupon;
    notifyListeners();
  }
}
