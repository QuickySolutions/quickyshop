import 'package:flutter/material.dart';
import 'package:quickyshop/providers/signup/signup_provider.dart';

Widget getCustomIconToTextFieldInPrefx(String pathAssetImage) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Image.asset(
      pathAssetImage,
      width: 20,
      height: 20,
      fit: BoxFit.contain,
    ),
  );
}

ImageProvider<Object> getProfile(SignUpProvider provider) {
  if (provider.photoProfile == "no_photo") {
    return AssetImage("assets/images/not-available.png");
  } else if (provider.physicalPhoto.path.isNotEmpty) {
    return AssetImage(provider.photoProfile);
  } else {
    return NetworkImage(provider.photoProfile);
  }
}
