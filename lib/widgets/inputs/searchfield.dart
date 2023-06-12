import 'package:flutter/material.dart';

class QuickyTextField extends StatelessWidget {
  Widget? prefixIcon;
  Widget? suffixIcon;
  String? defaultValue;
  void Function(String)? onChanged;
  void Function()? onTap;
  String hintText;
  bool? readOnly;
  bool? isNumeric;
  TextEditingController? controller;
  final bool isDate;
  QuickyTextField(
      {this.prefixIcon,
      this.onChanged,
      this.controller,
      this.isNumeric = false,
      this.onTap,
      this.readOnly = false,
      this.suffixIcon,
      this.isDate = false,
      required this.hintText,
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
      keyboardType: isNumeric! ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
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
