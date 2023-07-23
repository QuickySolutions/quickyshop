import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class PictureSelectionService {
  Future<XFile> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      return image!;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      return XFile('');
    }
  }
}
