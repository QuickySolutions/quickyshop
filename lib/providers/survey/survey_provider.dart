import 'package:flutter/material.dart';
import 'package:quickyshop/models/survey/questions/CheckboxQuestion.dart';
import 'package:quickyshop/models/survey/Question.dart';
import 'package:quickyshop/models/survey/Survey.dart';
import 'package:quickyshop/models/survey/questions/CloseQuestion.dart';
import 'package:quickyshop/models/survey/questions/TemplateQuestion.dart';
import 'package:quickyshop/models/survey/questions/options/MultipleSelectionOption.dart';
import 'package:quickyshop/models/survey/questions/options/OptionQuestion.dart';
import 'package:uuid/uuid.dart';

class SurveyProvider extends ChangeNotifier {
  Survey _survey = Survey(
      id: '1234',
      name: 'prueba',
      questions: [],
      photo: '',
      secretPassword: '1334444',
      initDate: "2034-03-32",
      finalDate: "3233-43-43");

  Survey get survey => _survey;

  void addNewQuestion(Question question) {
    _survey.questions!.add(question);
    notifyListeners();
  }

  void handleChangeSelectionTypeQuestion(int indexQuestion, String keyType) {
    print(indexQuestion);
    Question oldQuestion = _survey.questions![indexQuestion];
    if (keyType == 'check') {
      _survey.questions![indexQuestion] = CheckBoxQuestion(
          maximumOptions: 6,
          minimumOptions: 3,
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

  void addNewOptionToQuestion(int indexQuestion) {
    OptionQuestion newOption = MultipleSelectionOption(
        id: Uuid().v4(),
        titleOptionSurvey: 'titulo de la opción...',
        value: false);
    _survey.questions![indexQuestion].options!.add(newOption);
    notifyListeners();
  }

  void handleChangeTitleOption(
      int indexQuestion, int indexOption, String value) {
    _survey.questions![indexQuestion].options![indexOption].titleOptionSurvey =
        value;
    notifyListeners();
  }
}
