import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/models/survey/Question.dart';
import 'package:quickyshop/models/survey/questions/CheckboxQuestion.dart';
import 'package:quickyshop/models/survey/questions/options/MultipleSelectionOption.dart';
import 'package:quickyshop/models/survey/questions/options/OptionQuestion.dart';
import 'package:quickyshop/providers/survey/survey_provider.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/utils/survey_utils.dart';
import 'package:quickyshop/widgets/buttons/quickyButton.dart';
import 'package:quickyshop/widgets/inputs/quicky_textfield.dart';
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
          Container(
            child: Row(
              children: [
                Icon(Icons.edit),
                SizedBox(width: 5),
                Text(
                  question.title + ' - $indexQuestion',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          question.type != 'normal'
              ? showTypeQuestion(surveyProvider)
              : Container(),
          SizedBox(height: question.type != 'normal' ? 20 : 0),
          question.type == 'normal' ? selectQuestionType() : Container(),
          question.type == 'check'
              ? MultipleSelectionContent(
                  surveyProvider, question as CheckBoxQuestion)
              : Container()
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

  Widget MultipleSelectionContent(
      SurveyProvider surveyProvider, CheckBoxQuestion question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            'Esta pregunta debe de tener como minimo ${question.minimumOptions} y como maximo ${question.maximumOptions}'),
        SizedBox(height: 10),
        Column(
          children: question.options!.map((OptionQuestion optionQuestion) {
            int index = question.options!
                .indexWhere((el) => el.id == optionQuestion.id);
            return Container(
                margin: EdgeInsets.only(bottom: 5),
                child: QuickyTextField(
                  onChanged: (String value) {
                    surveyProvider.handleChangeTitleOption(
                        indexQuestion, index, value);
                  },
                  hintText: optionQuestion.titleOptionSurvey,
                ));
          }).toList(),
        ),
        SizedBox(height: 5),
        QuickyButton(
          type: QuickyButtonTypes.tertiary,
          onTap: () {
            if (question.options!.length < question.minimumOptions ||
                question.options!.length < question.maximumOptions) {
              surveyProvider.addNewOptionToQuestion(indexQuestion);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '+',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 10),
              Text(
                'Añadir opción',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ],
    );
  }
}
