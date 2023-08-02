import 'package:flutter/material.dart';

enum BackButton { primary, secondary }

class GoBackButton extends StatelessWidget {
  const GoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, true);
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 30,
        child: Image(
          height: 30,
          image: AssetImage('assets/icons/usability/backIcon.png'),
        ),
      ),
    );
  }
}

class SecondaryGoBackButton extends StatelessWidget {
  const SecondaryGoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Image(height: 60, image: AssetImage('assets/images/go-back.png')),
    );
  }
}
