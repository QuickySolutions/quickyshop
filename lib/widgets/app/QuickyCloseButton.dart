import 'package:flutter/material.dart';
import 'package:quickyshop/utils/Colors.dart';

class QuickyCloseButton extends StatelessWidget {
  const QuickyCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, true);
      },
      child: CircleAvatar(
        backgroundColor: QuickyColors.primaryColor,
        radius: 30,
        child: Image(
          height: 90,
          image: AssetImage('assets/icons/usability/close.png'),
        ),
      ),
    );
  }
}
