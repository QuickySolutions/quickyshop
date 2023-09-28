import 'package:flutter/material.dart';

class ChipItem extends StatelessWidget {
  final String text;
  ChipItem({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 200, 200, 200).withOpacity(0.2),
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          text,
          style: TextStyle(fontSize: 12),
        ));
  }
}
