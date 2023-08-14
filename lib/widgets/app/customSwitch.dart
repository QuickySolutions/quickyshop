import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickyshop/utils/Colors.dart';

class SwitchControl extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  SwitchControl({
    this.value = false,
    required this.onChanged,
  });

  bool value;

  @override
  _SwitchControlState createState() => _SwitchControlState();
}

class _SwitchControlState extends State<SwitchControl> {
  Alignment switchControlAlignment = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
        width: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: QuickyColors.greyColor,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          alignment:
              widget.value ? Alignment.centerRight : Alignment.centerLeft,
          curve: Curves.decelerate,
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Container(
              width: 30,
              height: 20,
              decoration: BoxDecoration(
                color: widget.value
                    ? QuickyColors.primaryColor
                    : QuickyColors.borderColor,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          widget.value = !widget.value;
          widget.onChanged(widget.value);
        });
      },
    );
  }
}
