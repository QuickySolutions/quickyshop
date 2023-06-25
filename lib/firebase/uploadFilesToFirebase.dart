import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quickyshop/providers/signup/signup_provider.dart';

class UploadFilesToFirebase {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future uploadFile(
      File file, String storeName, SignUpProvider provider) async {
    try {
      late String imageUrl = "";
      if (file.path.isNotEmpty) {
        final metadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': file.path},
        );

        late UploadTask uploadTask;

        // Create a Reference to the file
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('store_profiles')
            .child(storeName);

        uploadTask = ref.putFile(File(file.path), metadata);

        uploadTask.whenComplete(() async {
          try {
            imageUrl = await ref.getDownloadURL();
            print(imageUrl);
            provider.setPhotoProfile(imageUrl);
          } catch (onError) {
            print(onError);
            imageUrl = 'ERROR';
            print("Error");
          }
        });
      }
    } catch (e) {
      print(e);
      print('error occured');
    }
  }
}
