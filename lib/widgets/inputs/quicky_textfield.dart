import 'package:flutter/material.dart';

class QuickyTextField extends StatelessWidget {
  Widget? prefixIcon;
  Widget? suffixIcon;
  String? defaultValue;
  void Function(String)? onChanged;
  void Function()? onTap;
  String? hintText;
  bool? readOnly;
  TextInputType keyboardType;
  TextEditingController? controller;
  final bool? isDate;
  final bool? hideText;
  QuickyTextField(
      {this.prefixIcon,
      this.onChanged,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.hideText = false,
      this.onTap,
      this.readOnly = false,
      this.suffixIcon,
      this.isDate = false,
      this.hintText,
      this.defaultValue});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      onTap: onTap,
      initialValue: defaultValue,
      readOnly: readOnly!,
      onChanged: onChanged,
      controller: controller,
      obscureText: hideText!,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20.0),
        hintStyle: TextStyle(color: Colors.black),
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}

class QuickyTextArea extends StatelessWidget {
  Widget? prefixIcon;
  Widget? suffixIcon;
  String? defaultValue;
  void Function(String)? onChanged;
  void Function()? onTap;
  String? hintText;
  bool? readOnly;
  TextInputType keyboardType;
  TextEditingController? controller;
  final bool? hideText;
  final int? maxLines;
  QuickyTextArea(
      {this.prefixIcon,
      this.onChanged,
      this.controller,
      this.hideText = false,
      this.onTap,
      this.keyboardType = TextInputType.text,
      this.readOnly = false,
      this.suffixIcon,
      required this.maxLines,
      this.hintText,
      this.defaultValue});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      onTap: onTap,
      initialValue: defaultValue,
      readOnly: readOnly!,
      onChanged: onChanged,
      textInputAction: TextInputAction.done,
      controller: controller,
      maxLines: maxLines!,
      obscureText: hideText!,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20.0),
        hintStyle: TextStyle(color: Colors.black),
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
