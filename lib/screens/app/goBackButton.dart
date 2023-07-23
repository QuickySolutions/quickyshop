import 'package:flutter/material.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, true);
      },
      child: CircleAvatar(
        backgroundColor: Color(0xffF4F4F4),
        radius: 30,
        child: Image(
          height: 30,
          image: AssetImage('assets/icons/usability/backIcon.png'),
        ),
      ),
    );
  }
}
