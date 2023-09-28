import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quickyshop/firebase/uploadFilesToFirebase.dart';
import 'package:quickyshop/models/Coupon.dart';
import 'package:quickyshop/preferences/appPreferences.dart';
import 'package:quickyshop/services/couponsService.dart';

class CouponProvider extends ChangeNotifier {
  File _selectedFile = File('');
  CouponsService _couponsService = CouponsService();
  int _activePage = 0;
  final PageController _pageController = PageController(initialPage: 0);
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
  File get selectedFile => _selectedFile;
  PageController get pageController => _pageController;
  int get activePage => _activePage;

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
        await _couponsService.getAllCoupons(AppPreferences().brandId);
    List<Coupon> listCoupons = couponResponse.data;

    if (listCoupons.isNotEmpty) {
      _coupons = listCoupons;
      setIsLoading(false);
    } else {
      setIsLoading(false);
    }

    notifyListeners();
  }

  Future<String> uploadCouponCover(
      File selectedPicture, String couponId) async {
    UploadFilesToFirebase service = UploadFilesToFirebase();
    if (selectedPicture.path.isEmpty) {
      return "";
    } else {
      String url = await service.uploadCouponCover(selectedPicture, couponId);
      return url;
    }
  }

  void create(Coupon coupon) async {
    setIsLoading(true);

    if (selectedFile.path.isEmpty) {
      CouponResponse response = await _couponsService.createCoupon(coupon);
      Coupon newCoupon = Coupon.fromJSONResponse(response.data);
      _coupons.add(newCoupon);
      clear();
    } else {
      String urlPicture = await uploadCouponCover(selectedFile, coupon.id!);
      coupon.photo = urlPicture;
      CouponResponse response = await _couponsService.createCoupon(coupon);
      Coupon newCoupon = Coupon.fromJSONResponse(response.data);
      _coupons.add(newCoupon);
      clear();
    }
    setIsLoading(false);
    notifyListeners();
  }

  void update(Coupon updatedCoupon) async {
    late Coupon coupon;
    setIsLoading(true);

    if (selectedFile.path.isEmpty) {
      CouponResponse response = await _couponsService.editCoupon(updatedCoupon);
      print(response);
      coupon = Coupon.fromJSONResponse(response.data);
      clear();
    } else {
      String urlPicture =
          await uploadCouponCover(selectedFile, updatedCoupon.id!);
      updatedCoupon.photo = urlPicture;
      CouponResponse response = await _couponsService.editCoupon(updatedCoupon);
      coupon = Coupon.fromJSONResponse(response.data);
    }

    int indexOfItem =
        _coupons.indexWhere((couponElement) => coupon.id == couponElement.id);
    _coupons[indexOfItem] = updatedCoupon;

    setIsLoading(false);
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

  void selectImage(File fileSelected) {
    _selectedFile = fileSelected;
    notifyListeners();
  }

  void changePageContent() {
    _pageController.animateToPage(_activePage + 1,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
    notifyListeners();
  }

  void setPage(int page) {
    _activePage = page;
    _pageController.animateToPage(_activePage,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
    notifyListeners();
  }

  void clear() {
    _selectedFile = File('');
    notifyListeners();
  }
}
