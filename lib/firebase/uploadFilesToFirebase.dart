import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quickyshop/providers/photo/photo_provider.dart';
import 'package:quickyshop/providers/signup/signup_provider.dart';

class UploadFilesToFirebase {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadFile(
      File file,
      String storeName,
      SignUpProvider provider,
      PhotoProvider photoProvider,
      bool isBranchOffice) async {
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );

    late UploadTask uploadTask;

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance
        .ref()
        .child(isBranchOffice ? 'branch_office_profiles' : 'store_profiles')
        .child(storeName);

    uploadTask = ref.putFile(File(file.path), metadata);

    // Wait for the upload task to complete
    final TaskSnapshot completedTask = await uploadTask.whenComplete(() => {});

    // Get the download URL of the uploaded file
    final String downloadUrl = await completedTask.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> uploadPhoto(
      File file, String fileName, bool isBranchOffice) async {
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );

    late UploadTask uploadTask;

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance
        .ref()
        .child(isBranchOffice ? 'branch_office_profiles' : 'store_profiles')
        .child(fileName);

    uploadTask = ref.putFile(File(file.path), metadata);

    // Wait for the upload task to complete
    final TaskSnapshot completedTask = await uploadTask.whenComplete(() => {});

    // Get the download URL of the uploaded file
    final String downloadUrl = await completedTask.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> uploadSurveyPhoto(File file, String storeName) async {
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );

    late UploadTask uploadTask;

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('surveys_background')
        .child(storeName);

    uploadTask = ref.putFile(File(file.path), metadata);

    // Wait for the upload task to complete
    final TaskSnapshot completedTask = await uploadTask.whenComplete(() => {});

    // Get the download URL of the uploaded file
    final String downloadUrl = await completedTask.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> uploadCouponCover(File file, String couponId) async {
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );

    late UploadTask uploadTask;

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('coupons_backgrounds')
        .child(couponId);

    uploadTask = ref.putFile(File(file.path), metadata);

    // Wait for the upload task to complete
    final TaskSnapshot completedTask = await uploadTask.whenComplete(() => {});

    // Get the download URL of the uploaded file
    final String downloadUrl = await completedTask.ref.getDownloadURL();

    return downloadUrl;
  }
}
