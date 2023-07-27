import 'package:flutter/material.dart';
import 'package:quickyshop/utils/Colors.dart';

enum QuickyButtonTypes { primary, secondary, tertiary }

class QuickyButton extends StatelessWidget {
  final List<Color> colors = [
    QuickyColors.primaryColor,
    QuickyColors.secondaryColor,
    Colors.white
  ];
  QuickyButtonTypes type;
  Widget child;
  final void Function()? onTap;
  QuickyButton(
      {super.key,
      required this.type,
      required this.child,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: MediaQuery.of(context).size.width * 0.85,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            side: type == QuickyButtonTypes.tertiary ? BorderSide() : null,
            elevation: 0,
            backgroundColor: type == QuickyButtonTypes.primary
                ? QuickyColors.primaryColor
                : type == QuickyButtonTypes.secondary
                    ? QuickyColors.secondaryColor
                    : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          onPressed: () => onTap!(),
          child: child),
    );
  }
}
