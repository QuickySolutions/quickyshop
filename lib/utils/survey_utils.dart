import 'package:quickyshop/models/survey/Question.dart';
import 'package:quickyshop/models/survey/questions/CheckboxQuestion.dart';
import 'package:quickyshop/models/survey/questions/options/MultipleSelectionOption.dart';
import 'package:quickyshop/models/survey/questions/options/OptionQuestion.dart';

class QuestionTypeItem {
  String name;
  String keyType;

  QuestionTypeItem({required this.name, required this.keyType});
}

List<QuestionTypeItem> questionTypes = [
  QuestionTypeItem(name: 'Multiple selección', keyType: 'check'),
  QuestionTypeItem(name: 'Cerrado', keyType: 'close'),
  QuestionTypeItem(name: 'Seleccionar un Item', keyType: 'combo-box'),
  QuestionTypeItem(name: 'Opinión corta', keyType: 'mini-review'),
  QuestionTypeItem(name: 'Opinión larga', keyType: 'large-review'),
  QuestionTypeItem(name: 'Unica selección', keyType: 'radio'),
  QuestionTypeItem(name: 'Escalar', keyType: 'scale')
];

enum SurveyAction { create, edit }

List<Question> questionsFromJsonResponse(List<dynamic> questionsResponse) {
  List<Question> questions = [];
  questionsResponse.forEach((element) {
    if (element['type'] == 'check') {
      questions.add(CheckBoxQuestion(
          id: element['_id'],
          title: element['title'],
          type: element['type'],
          maxSelected: element['maxSelected'],
          minimumSelected: element['minimumSelected'],
          options:
              optionsFromJsonResponse(element['options'], element['type'])));
    }
  });
  return questions;
}

List<OptionQuestion> optionsFromJsonResponse(
    List<dynamic> optionsResponse, String typeQuestion) {
  List<OptionQuestion> options = [];

  optionsResponse.forEach((element) {
    if (typeQuestion == 'check') {
      options.add(MultipleSelectionOption(
          id: element['id'],
          titleOptionSurvey: element['titleOptionSurvey'],
          value: element['value']));
    }
  });

  return options;
}
