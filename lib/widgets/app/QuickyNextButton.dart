import 'package:flutter/material.dart';
import 'package:quickyshop/utils/Colors.dart';

class QuickyNextButton extends StatelessWidget {
  final void Function()? onTap;
  const QuickyNextButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: QuickyColors.primaryColor,
        radius: 30,
        child: Image(
          height: 30,
          image: AssetImage('assets/icons/usability/arrow_next.png'),
        ),
      ),
    );
  }
}
