import 'dart:convert';

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

void printJson(String jsonString) {
  final dynamic parsedJson = jsonDecode(jsonString);
  final prettyJson = JsonEncoder.withIndent('  ').convert(parsedJson);
  print(prettyJson);
}

ImageProvider<Object> getProfile(String photo) {
  if (photo == "no_photo") {
    return AssetImage("assets/images/not-available.png");
  } else {
    return NetworkImage(photo);
  }
}
