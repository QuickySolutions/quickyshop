import 'dart:io';

import 'package:flutter/material.dart';

class PhotoProvider with ChangeNotifier {
  File? _photo = File('');
  late bool _pickedPicture = false;
  late bool _uploadedPhoto = false;

  File? get photo => _photo;
  bool get pickedPicture => _pickedPicture;
  bool get uploadedPhoto => _uploadedPhoto;

  void setImage(File photoSent) {
    _photo = photoSent;
    notifyListeners();
  }

  void setPicketPicture(bool settedPicture) {
    _pickedPicture = settedPicture;
    notifyListeners();
  }

  void uploadPicToFirebase(bool value) {
    _uploadedPhoto = value;
    notifyListeners();
  }
}
