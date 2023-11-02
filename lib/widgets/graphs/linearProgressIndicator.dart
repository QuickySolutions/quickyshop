import 'package:flutter/material.dart';
import 'package:quickyshop/utils/Colors.dart';

class ProgressBar extends StatelessWidget {
  final double current;

  const ProgressBar({
    Key? key,
    required this.current,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, boxConstraints) {
        var x = boxConstraints.maxWidth;
        var currentOnDecimal = current / 100;
        var percent = (currentOnDecimal / 10) * x;

        return Stack(
          children: [
            Container(
              width: x,
              height: 7,
              decoration: BoxDecoration(
                color: Color(0xffd3d3d3),
                borderRadius: BorderRadius.circular(35),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: percent,
              height: 7,
              decoration: BoxDecoration(
                color: QuickyColors.primaryColor,
                borderRadius: BorderRadius.circular(35),
              ),
            ),
          ],
        );
      },
    );
  }
}
