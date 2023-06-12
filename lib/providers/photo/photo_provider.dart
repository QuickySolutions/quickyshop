import 'dart:io';

import 'package:flutter/material.dart';

class PhotoProvider with ChangeNotifier {
  File? _photo;
  late bool _pickedPicture = false;

  File? get photo => _photo;
  bool get pickedPicture => _pickedPicture;

  void setImage(File photoSent) {
    _photo = photoSent;
    notifyListeners();
  }

  void setPicketPicture(bool settedPicture) {
    _pickedPicture = settedPicture;
    notifyListeners();
  }
}
