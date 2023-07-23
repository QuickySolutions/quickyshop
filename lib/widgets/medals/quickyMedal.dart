import 'package:flutter/material.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/dialogs/QuickyAlertDialog.dart';

class QuickyMedal extends StatelessWidget {
  final String medalName;
  final bool isUnlocked;
  const QuickyMedal(
      {super.key, required this.medalName, required this.isUnlocked});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return QuickyAlertDialog(
                    size: 'xs-small',
                    childContent: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${medalName}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, color: QuickyColors.secondaryColor),
                        ),
                        SizedBox(height: 20),
                        Image(
                          height: 150,
                          width: 150,
                          image: AssetImage('assets/images/reward.png'),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Container(
            height: 75,
            width: 75,
            padding: EdgeInsets.all(9),
            decoration: BoxDecoration(
                border:
                    Border.all(color: isUnlocked ? Colors.black : Colors.grey),
                color: Colors.white,
                borderRadius: BorderRadius.circular(100)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image(
                opacity: isUnlocked ? null : const AlwaysStoppedAnimation(.5),
                image: AssetImage(
                    'assets/icons/usability/medals/exampleMedal.png'),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          medalName,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: isUnlocked ? Colors.black : Colors.grey),
        )
      ],
    );
  }
}
