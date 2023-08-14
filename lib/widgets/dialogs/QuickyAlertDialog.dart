import 'package:flutter/material.dart';
import 'package:quickyshop/widgets/app/QuickyCloseButton.dart';
import 'package:quickyshop/widgets/app/QuickyNextButton.dart';

class QuickyAlertDialog extends StatefulWidget {
  final bool showNextButton;
  final Widget childContent;
  final void Function()? onNextClick;
  final String? size;
  const QuickyAlertDialog(
      {super.key,
      required this.childContent,
      this.showNextButton = false,
      this.size,
      this.onNextClick});

  @override
  State<QuickyAlertDialog> createState() => _QuickyAlertDialogState();
}

class _QuickyAlertDialogState extends State<QuickyAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Center(
        child: Material(
          type: MaterialType.transparency,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                  margin: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.only(
                      top: 50, left: 20, right: 20, bottom: 20),
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: widget.size == 'xs-small'
                      ? 120
                      : widget.size == 'small'
                          ? 380
                          : 500,
                  child: widget.childContent),
              QuickyCloseButton(),
              widget.showNextButton
                  ? Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: QuickyNextButton(
                        onTap: widget.onNextClick,
                      ),
                    )
                  : Positioned(bottom: 0, left: 0, right: 0, child: Container())
            ],
          ),
        ),
      ),
    );
  }
}
