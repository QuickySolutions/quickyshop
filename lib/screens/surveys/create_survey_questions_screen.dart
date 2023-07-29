import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/models/survey/questions/CheckboxQuestion.dart';
import 'package:quickyshop/models/survey/Question.dart';
import 'package:quickyshop/models/survey/questions/TemplateQuestion.dart';
import 'package:quickyshop/providers/survey/survey_provider.dart';
import 'package:quickyshop/screens/app/goBackButton.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/utils/general_methods.dart';
import 'package:quickyshop/widgets/surveys/survey_question_item.dart';
import 'package:uuid/uuid.dart';

class CreateSurveyQuestionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final surveyProvider = Provider.of<SurveyProvider>(context);
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Question newQuestion = TemplateQuestion(
                  id: Uuid().v4(), title: 'hola', type: 'normal');
              surveyProvider.addNewQuestion(newQuestion);
              //printJson(surveyProvider.survey.toJson());
            },
            child: Icon(Icons.add),
          ),
          SizedBox(width: 20),
          FloatingActionButton(
            onPressed: () {
              printJson(surveyProvider.survey.toJson());
            },
            child: Icon(Icons.save),
          ),
        ],
      ),
      backgroundColor: Color(0xffF4F4F4),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: GoBackButton(),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Preguntas', style: TextStyle(fontSize: 20)),
                            SizedBox(height: 20),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismo.',
                              style:
                                  TextStyle(color: QuickyColors.disableColor),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  children:
                      surveyProvider.survey.questions!.map((Question question) {
                    int index = surveyProvider.survey.questions!
                        .indexWhere((el) => el.id == question.id);
                    return SurveyQuestionItem(
                      indexQuestion: index,
                      question: question,
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
