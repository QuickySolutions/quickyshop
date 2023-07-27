import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/models/survey/Question.dart';
import 'package:quickyshop/providers/survey/survey_provider.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/utils/survey_utils.dart';
import 'package:quickyshop/widgets/surveys/survey_question_type_item.dart';

class SurveyQuestionItem extends StatelessWidget {
  Question question;
  int indexQuestion;
  SurveyQuestionItem(
      {super.key, required this.question, required this.indexQuestion});

  @override
  Widget build(BuildContext context) {
    final surveyProvider = Provider.of<SurveyProvider>(context);
    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50), bottomRight: Radius.circular(50))),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question.title + '$indexQuestion'),
          SizedBox(height: 10),
          question.type != 'normal'
              ? showTypeQuestion(surveyProvider)
              : Container(),
          SizedBox(height: question.type != 'normal' ? 30 : 0),
          question.type == 'normal' ? selectQuestionType() : Container()
        ],
      ),
    );
  }

  Widget selectQuestionType() {
    return Column(
      children: questionTypes
          .map((questionType) => SurveyQuestionTypeItem(
              titleType: questionType, indexQuestion: indexQuestion))
          .toList(),
    );
  }

  Widget showTypeQuestion(SurveyProvider surveyProvider) {
    return GestureDetector(
      onTap: () {
        surveyProvider.handleChangeSelectionTypeQuestion(
            indexQuestion, 'normal');
      },
      child: Container(
          decoration: BoxDecoration(
              color: QuickyColors.primaryColor,
              borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                question.type!,
              ),
              SizedBox(width: 20),
              Image(
                  height: 18,
                  width: 18,
                  image: AssetImage('assets/icons/usability/edit_white.png'))
            ],
          )),
    );
  }
}
