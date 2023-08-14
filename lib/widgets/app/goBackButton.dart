import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/providers/survey/survey_provider.dart';

enum BackButton { primary, secondary }

class GoBackButton extends StatelessWidget {
  final void Function()? onTap;
  GoBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final surveyProvider = Provider.of<SurveyProvider>(context);
    return GestureDetector(
      onTap: onTap,
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
