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
  late Survey _survey;
  late String _surveyName;
  late String _surveyDescription;
  late String _initDate;
  late String _finalDate;

  Survey get survey => _survey;
  String get surveyName => _surveyName;
  String get surveyDescription => _surveyDescription;
  String get initDate => _initDate;
  String get finalDate => _finalDate;

  bool get isValidForm {
    if (_surveyName.isEmpty ||
        _surveyDescription.isEmpty ||
        _initDate.isEmpty ||
        _finalDate.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void onChangeName(String value) {
    _surveyName = value;
    notifyListeners();
  }

  void onChangeDescription(String value) {
    _surveyDescription = value;
    notifyListeners();
  }

  void onChangeInitDate(String date) {
    _initDate = date;
    notifyListeners();
  }

  void onChangeFinalDate(String date) {
    _finalDate = date;
    notifyListeners();
  }

  void addNewQuestion(Question question) {
    _survey.questions!.add(question);
    notifyListeners();
  }

  void addSurvey(Survey survey) {
    _survey = survey;
    notifyListeners();
  }

  void handleChangeSelectionTypeQuestion(int indexQuestion, String keyType) {
    print(indexQuestion);
    Question oldQuestion = _survey.questions![indexQuestion];
    if (keyType == 'check') {
      _survey.questions![indexQuestion] = CheckBoxQuestion(
          maximumOptions: 6,
          minimumOptions: 3,
          maxSelected: 6,
          minimumSelected: 2,
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
