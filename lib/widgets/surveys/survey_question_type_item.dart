import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/providers/survey/survey_provider.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/utils/survey_utils.dart';

class SurveyQuestionTypeItem extends StatelessWidget {
  QuestionTypeItem titleType;
  int indexQuestion;
  SurveyQuestionTypeItem(
      {required this.titleType, required this.indexQuestion});
  @override
  Widget build(BuildContext context) {
    final surveyProvider = Provider.of<SurveyProvider>(context);
    return GestureDetector(
      onTap: () {
        surveyProvider.handleChangeSelectionTypeQuestion(
            indexQuestion, titleType.keyType);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
            color: QuickyColors.greyColor,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Text(titleType.name),
      ),
    );
  }
}
