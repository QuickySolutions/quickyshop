import 'package:quickyshop/models/survey/Question.dart';
import 'package:quickyshop/models/survey/questions/CheckboxQuestion.dart';
import 'package:quickyshop/models/survey/questions/CloseQuestion.dart';
import 'package:quickyshop/models/survey/questions/ComboBoxQuestion.dart';
import 'package:quickyshop/models/survey/questions/RadioQuestion.dart';
import 'package:quickyshop/models/survey/questions/ReviewQuestion.dart';
import 'package:quickyshop/models/survey/questions/ScaleQuestion.dart';
import 'package:quickyshop/models/survey/questions/options/CloseOption.dart';
import 'package:quickyshop/models/survey/questions/options/ComboBoxOption.dart';
import 'package:quickyshop/models/survey/questions/options/MultipleSelectionOption.dart';
import 'package:quickyshop/models/survey/questions/options/OptionQuestion.dart';
import 'package:quickyshop/models/survey/questions/options/RadioOption.dart';
import 'package:quickyshop/models/survey/questions/options/ScaleOption.dart';

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
          isNew: false,
          type: element['type'],
          maxSelected: element['maxSelected'],
          minimumSelected: element['minimumSelected'],
          options:
              optionsFromJsonResponse(element['options'], element['type'])));
    } else if (element['type'] == 'close') {
      questions.add(CloseQuestion(
          id: element['_id'],
          title: element['title'],
          isNew: false,
          type: element['type'],
          options:
              optionsFromJsonResponse(element['options'], element['type'])));
    } else if (element['type'] == 'combo-box') {
      questions.add(ComboBoxQuestion(
          id: element['_id'],
          title: element['title'],
          type: element['type'],
          options: optionsFromJsonResponse(element['options'], element['type']),
          isNew: false));
    } else if (element['type'] == 'mini-review') {
      questions.add(ReviewQuestion(
          id: element['_id'],
          title: element['title'],
          type: element['type'],
          options: optionsFromJsonResponse(element['options'], element['type']),
          isNew: false,
          review: "",
          maxCharacters: 100));
    } else if (element['type'] == 'large-review') {
      questions.add(ReviewQuestion(
          id: element['_id'],
          title: element['title'],
          type: element['type'],
          options: [],
          isNew: false,
          review: "",
          maxCharacters: 250));
    } else if (element['type'] == 'radio') {
      questions.add(RadioQuestion(
          id: element['_id'],
          title: element['title'],
          type: element['type'],
          options: optionsFromJsonResponse(element['options'], element['type']),
          isNew: false,
          selected: ""));
    } else if (element['type'] == 'scale') {
      questions.add(ScaleQuestion(
        id: element['_id'],
        title: element['title'],
        type: element['type'],
        maxOptions: 5,
        options: optionsFromJsonResponse(element['options'], element['type']),
        isNew: false,
      ));
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
    } else if (typeQuestion == 'close') {
      options.add(CloseOption(
          id: element['id'], titleOptionSurvey: element['titleOptionSurvey']));
    } else if (typeQuestion == 'combo-box') {
      options.add(ComboBoxOption(
          id: element['id'], titleOptionSurvey: element['titleOptionSurvey']));
    } else if (typeQuestion == 'radio') {
      options.add(RadioOption(
          id: element['id'], titleOptionSurvey: element['titleOptionSurvey']));
    } else if (typeQuestion == 'scale') {
      options.add(ScaleOption(
          id: element['id'], titleOptionSurvey: element['titleOptionSurvey']));
    }
  });

  return options;
}

String getEmojiByPosition(int position) {
  List<dynamic> emojis = ['🤢', '😡', '🤷🏽‍♂️', '🤩', '🥳'];
  return emojis.elementAt(position);
}
