import 'package:flutter/material.dart';
import 'package:quickyshop/models/survey/questions/CheckboxQuestion.dart';
import 'package:quickyshop/models/survey/Question.dart';
import 'package:quickyshop/models/survey/Survey.dart';
import 'package:quickyshop/models/survey/questions/CloseQuestion.dart';
import 'package:quickyshop/models/survey/questions/TemplateQuestion.dart';

class SurveyProvider extends ChangeNotifier {
  Survey _survey =
      Survey(id: '12345-555', photo: '', nameSurvey: 'prueba', questions: []);

  Survey get survey => _survey;

  void addNewQuestion(Question question) {
    _survey.questions!.add(question);
    notifyListeners();
  }

  void handleChangeSelectionTypeQuestion(int indexQuestion, String keyType) {
    Question oldQuestion = _survey.questions![indexQuestion];
    if (keyType == 'check') {
      _survey.questions![indexQuestion] = CheckBoxQuestion(
          id: oldQuestion.id,
          title: oldQuestion.title,
          type: keyType,
          options: []);
    } else if (keyType == 'close') {
      _survey.questions![indexQuestion] = CloseQuestion(
          id: oldQuestion.id,
          title: oldQuestion.title,
          type: keyType,
          options: []);
    } else if (keyType == 'combo-box') {
    } else if (keyType == 'mini-review') {
    } else if (keyType == 'large-review') {
    } else if (keyType == 'radio') {
    } else if (keyType == 'scale') {
    } else {
      //option will be normal
      _survey.questions![indexQuestion] = TemplateQuestion(
        id: oldQuestion.id,
        title: oldQuestion.title,
        type: 'normal',
      );
    }

    notifyListeners();
  }
}
