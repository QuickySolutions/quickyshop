import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/models/survey/Question.dart';
import 'package:quickyshop/models/survey/questions/CheckboxQuestion.dart';
import 'package:quickyshop/models/survey/questions/CloseQuestion.dart';
import 'package:quickyshop/models/survey/questions/ComboBoxQuestion.dart';
import 'package:quickyshop/models/survey/questions/RadioQuestion.dart';
import 'package:quickyshop/models/survey/questions/ScaleQuestion.dart';
import 'package:quickyshop/models/survey/questions/options/ComboBoxOption.dart';
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
      margin: EdgeInsets.only(bottom: 10),
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
                GestureDetector(
                  onTap: () {
                    surveyProvider.changeTitleQuestion(indexQuestion);
                  },
                  child:
                      surveyProvider.indexTitleToEditQuestion == indexQuestion
                          ? Icon(Icons.check)
                          : Icon(Icons.edit),
                ),
                SizedBox(width: 5),
                surveyProvider.indexTitleToEditQuestion == indexQuestion
                    ? Expanded(
                        child: TextField(
                        cursorColor: QuickyColors.primaryColor,
                        onChanged: (String value) {
                          surveyProvider.onChangeTitleQuetion(
                              indexQuestion, value);
                        },
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: QuickyColors.primaryColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: QuickyColors.primaryColor),
                          ),
                        ),
                      ))
                    : Expanded(
                        child: Text(
                          '${indexQuestion + 1}. ${question.title}',
                          style: TextStyle(fontSize: 20),
                        ),
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
              ? multipleSelectionContent(
                  surveyProvider, question as CheckBoxQuestion)
              : Container(),
          question.type == 'close'
              ? closeQuestionContent(surveyProvider, question as CloseQuestion)
              : Container(),
          question.type == 'combo-box'
              ? comboBoxQuestionContent(
                  surveyProvider, question as ComboBoxQuestion)
              : Container(),
          question.type == 'mini-review'
              ? miniReviewQuestionContent()
              : Container(),
          question.type == 'large-review'
              ? largeReviewQuestionContent()
              : Container(),
          question.type == 'radio'
              ? radioQuestionContent(surveyProvider, question as RadioQuestion)
              : Container(),
          question.type == 'scale'
              ? scaleQuestionContent(surveyProvider, question as ScaleQuestion)
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
                questionTypes
                    .firstWhere((element) => element.keyType == question.type)
                    .name,
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

  Widget multipleSelectionContent(
      SurveyProvider surveyProvider, CheckBoxQuestion question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            'Esta pregunta debe de tener como minimo ${question.minimumOptions} y como maximo ${question.maximumOptions}'),
        SizedBox(height: 10),
        showListOptions(surveyProvider),
        SizedBox(height: 5),
        addNewOptionButton(surveyProvider, question.type!)
      ],
    );
  }

  Widget closeQuestionContent(
      SurveyProvider surveyProvider, CloseQuestion question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [SizedBox(height: 10), showListOptions(surveyProvider)],
    );
  }

  Widget radioQuestionContent(
      SurveyProvider surveyProvider, RadioQuestion question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        showListOptions(surveyProvider),
        SizedBox(height: 5),
        addNewOptionButton(surveyProvider, question.type!)
      ],
    );
  }

  Widget comboBoxQuestionContent(
      SurveyProvider surveyProvider, ComboBoxQuestion question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        showListOptions(surveyProvider),
        SizedBox(height: 5),
        addNewOptionButton(surveyProvider, question.type!)
      ],
    );
  }

  Widget miniReviewQuestionContent() {
    return QuickyTextField();
  }

  Widget largeReviewQuestionContent() {
    return QuickyTextArea(maxLines: 6);
  }

  Widget scaleQuestionContent(
      SurveyProvider surveyProvider, ScaleQuestion question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        showListOptions(surveyProvider),
        SizedBox(height: 5),
        question.options!.length == 5
            ? Container()
            : addNewOptionButton(surveyProvider, question.type!)
      ],
    );
  }

  Widget addNewOptionButton(SurveyProvider surveyProvider, String type) {
    return QuickyButton(
      type: QuickyButtonTypes.tertiary,
      onTap: () {
        surveyProvider.addNewOptionToQuestion(type, indexQuestion);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '+',
            style: TextStyle(
                fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 10),
          Text(
            'Añadir opción',
            style: TextStyle(
                fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget showListOptions(SurveyProvider surveyProvider) {
    return Column(
      children: question.options!.map((OptionQuestion optionQuestion) {
        int index =
            question.options!.indexWhere((el) => el.id == optionQuestion.id);

        if (question.type == 'scale') {
          return Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      getEmojiByPosition(index),
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: QuickyTextField(
                      onChanged: (String value) {
                        surveyProvider.handleChangeTitleOption(
                            indexQuestion, index, value);
                      },
                      hintText: optionQuestion.titleOptionSurvey,
                    ),
                  )
                ],
              ));
        } else {
          return Container(
              margin: EdgeInsets.only(bottom: 10),
              child: QuickyTextField(
                readOnly: question.type == 'close',
                onChanged: (String value) {
                  surveyProvider.handleChangeTitleOption(
                      indexQuestion, index, value);
                },
                hintText: optionQuestion.titleOptionSurvey,
              ));
        }
      }).toList(),
    );
  }
}
