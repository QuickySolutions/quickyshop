import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/models/survey/Question.dart';
import 'package:quickyshop/models/survey/questions/TemplateQuestion.dart';
import 'package:quickyshop/providers/app/appProvider.dart';
import 'package:quickyshop/providers/store/store_provider.dart';
import 'package:quickyshop/providers/survey/survey_provider.dart';
import 'package:quickyshop/screens/app/goBackButton.dart';
import 'package:quickyshop/services/surveyService.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/dialogs/QuickyAlertDialog.dart';
import 'package:quickyshop/widgets/dialogs/stores/store_list.dart';
import 'package:quickyshop/widgets/surveys/survey_question_item.dart';
import 'package:uuid/uuid.dart';

class CreateSurveyQuestionsScreen extends StatelessWidget {
  final SurveyService surveyService = SurveyService();

  @override
  Widget build(BuildContext context) {
    final surveyProvider = Provider.of<SurveyProvider>(context);
    final storeProvider = Provider.of<StoreProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Question newQuestion = TemplateQuestion(
                  id: Uuid().v4(), title: 'hola', type: 'normal');
              surveyProvider.addNewQuestion(newQuestion);
            },
            child: Icon(Icons.add),
          ),
          SizedBox(width: 20),
          FloatingActionButton(
            onPressed: () async {
              if (surveyProvider.survey.questions!.length < 3) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return QuickyAlertDialog(
                          size: 'xs-small',
                          childContent: Center(
                            child: Text(
                                'La encuesta debe de tener al menos 3 preguntas'),
                          ));
                    });
              } else if (surveyProvider.survey.questions!
                  .any((element) => element.type == 'normal')) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return QuickyAlertDialog(
                          size: 'xs-small',
                          childContent: Center(
                            child: Text(
                                'Alguna de tus preguntas no tiene un tipo valido de pregunta'),
                          ));
                    });
              } else if (surveyProvider.survey.questions!
                  .any((element) => element.options!.isEmpty)) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return QuickyAlertDialog(
                          size: 'xs-small',
                          childContent: Center(
                            child: Text(
                                'Todas las preguntas deben de tener al menos una opción'),
                          ));
                    });
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return QuickyAlertDialog(
                          showNextButton: true,
                          onNextClick: () async {
                            await surveyService.createSurvey(
                                surveyProvider.survey,
                                storeProvider.selectedStores,
                                appProvider.brandDefault.id);
                            Navigator.pushNamed(context, '/home');
                          },
                          childContent: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 20, left: 20, right: 20),
                                child: Text(
                                    'Para que tiendas quieres esta encuesta?'),
                              ),
                              Expanded(child: StoreList())
                            ],
                          ));
                    });
              }
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
