import 'package:flutter/material.dart';
import 'package:quickyshop/utils/Colors.dart';

enum QuickyButtonTypes { primary, secondary, tertiary, finishSurvey }

class QuickyButton extends StatelessWidget {
  final List<Color> colors = [
    QuickyColors.primaryColor,
    QuickyColors.secondaryColor,
    Colors.white
  ];
  QuickyButtonTypes type;
  bool hasBorder;
  Widget child;
  final void Function()? onTap;
  bool disabled;
  QuickyButton(
      {super.key,
      this.hasBorder = false,
      required this.type,
      required this.child,
      required this.onTap,
      this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: MediaQuery.of(context).size.width * 0.85,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            side: type == QuickyButtonTypes.tertiary ||
                    type == QuickyButtonTypes.finishSurvey
                ? BorderSide()
                : null,
            elevation: 0,
            backgroundColor: type == QuickyButtonTypes.primary ||
                    type == QuickyButtonTypes.finishSurvey
                ? QuickyColors.primaryColor
                : type == QuickyButtonTypes.secondary
                    ? QuickyColors.secondaryColor
                    : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          onPressed: disabled ? null : () => onTap!(),
          child: child),
    );
  }
}
