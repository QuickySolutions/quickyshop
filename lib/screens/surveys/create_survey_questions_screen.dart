import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/firebase/uploadFilesToFirebase.dart';
import 'package:quickyshop/models/survey/Question.dart';
import 'package:quickyshop/models/survey/questions/TemplateQuestion.dart';
import 'package:quickyshop/providers/app/appProvider.dart';
import 'package:quickyshop/providers/store/store_provider.dart';
import 'package:quickyshop/providers/survey/survey_provider.dart';
import 'package:quickyshop/utils/survey_utils.dart';
import 'package:quickyshop/widgets/app/goBackButton.dart';
import 'package:quickyshop/services/surveyService.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/buttons/quickyButton.dart';
import 'package:quickyshop/widgets/surveys/survey_question_item.dart';
import 'package:uuid/uuid.dart';

class CreateSurveyQuestionsScreen extends StatelessWidget {
  final SurveyService surveyService = SurveyService();
  UploadFilesToFirebase _uploadFilesToFirebase = UploadFilesToFirebase();

  CreateSurveyQuestionsScreen({super.key});
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
                  isNew: true,
                  id: Uuid().v4(),
                  title: 'Pregunta...',
                  type: 'normal') as Question;
              surveyProvider.addNewQuestion(newQuestion);
            },
            child: Icon(Icons.add),
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
                        child: GoBackButton(
                          onTap: () {
                            surveyProvider.goBackPage();
                          },
                        ),
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
                ),
                SizedBox(height: 20),
                QuickyButton(
                    disabled: surveyProvider.survey.questions!.isEmpty,
                    type: QuickyButtonTypes.primary,
                    child: Text('Finalizar'),
                    onTap: () async {
                      if (surveyProvider.surveyAction == SurveyAction.create) {
                        if (surveyProvider.selectedPhoto.path.isEmpty) {
                          createSurvey(surveyProvider, storeProvider,
                              appProvider, context);
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/home', (_) => false);
                        } else {
                          String url =
                              await _uploadFilesToFirebase.uploadSurveyPhoto(
                                  surveyProvider.selectedPhoto,
                                  'SURVEY_PHOTO_${Uuid().v4()}');
                          surveyProvider.setPhoto(url);
                          createSurvey(surveyProvider, storeProvider,
                              appProvider, context);

                          Navigator.pushNamed(context, '/home');
                        }
                      } else {
                        if (surveyProvider.selectedPhoto.path.isNotEmpty) {
                          String url =
                              await _uploadFilesToFirebase.uploadSurveyPhoto(
                                  surveyProvider.selectedPhoto,
                                  'SURVEY_PHOTO_${surveyProvider.survey.id}');
                          surveyProvider.setPhoto(url);
                          await surveyService.editSurvey(
                              surveyProvider.survey, storeProvider);
                          surveyProvider.reset();
                          storeProvider.reset();

                          Navigator.pushNamedAndRemoveUntil(
                              context, '/home', (_) => false);
                        } else {
                          await surveyService.editSurvey(
                              surveyProvider.survey, storeProvider);
                          surveyProvider.reset();
                          storeProvider.reset();
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/home', (_) => false);
                        }
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createSurvey(SurveyProvider surveyProvider, StoreProvider storeProvider,
      AppProvider appProvider, BuildContext context) async {
    await surveyService.createSurvey(surveyProvider.survey,
        storeProvider.selectedStores, appProvider.brandDefault.id);
    surveyProvider.reset();
    storeProvider.reset();
    Navigator.pushNamed(context, '/home');
  }
}
