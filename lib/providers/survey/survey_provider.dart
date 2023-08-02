import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quickyshop/models/survey/questions/CheckboxQuestion.dart';
import 'package:quickyshop/models/survey/Question.dart';
import 'package:quickyshop/models/survey/Survey.dart';
import 'package:quickyshop/models/survey/questions/CloseQuestion.dart';
import 'package:quickyshop/models/survey/questions/TemplateQuestion.dart';
import 'package:quickyshop/models/survey/questions/options/MultipleSelectionOption.dart';
import 'package:quickyshop/models/survey/questions/options/OptionQuestion.dart';
import 'package:quickyshop/services/brandService.dart';
import 'package:quickyshop/utils/survey_utils.dart';
import 'package:uuid/uuid.dart';

class SurveyProvider extends ChangeNotifier {
  late Survey _survey;
  late String _surveyName = "";
  late String _surveyDescription = "";
  late String _initDate = "";
  late String _finalDate = "";
  TextEditingController initDateController = TextEditingController();
  TextEditingController finalDateController = TextEditingController();
  late List<Survey> _surveys;
  late File _selectedPhoto = File('');
  bool _isLoadingRequest = false;
  SurveyAction _surveyAction = SurveyAction.create;

  BrandService _brandService = BrandService();

  Survey get survey => _survey;
  String get surveyName => _surveyName;
  String get surveyDescription => _surveyDescription;
  String get initDate => _initDate;
  String get finalDate => _finalDate;
  List<Survey> get surveys => _surveys;
  bool get isLoading => _isLoadingRequest;
  File get selectedPhoto => _selectedPhoto;
  SurveyAction get surveyAction => _surveyAction;

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

  void selectPicture(File picked) {
    _selectedPhoto = picked;
    notifyListeners();
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
          options: []) as Question;
    } else if (keyType == 'close') {
      _survey.questions![indexQuestion] = CloseQuestion(
          id: oldQuestion.id,
          title: oldQuestion.title,
          type: keyType,
          options: []) as Question;
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
      ) as Question;
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

  void setIsLoading(bool value) {
    _isLoadingRequest = value;
    notifyListeners();
  }

  void getAll() async {
    setIsLoading(true);
    BrandResponse surveyResponse =
        await _brandService.getSurveysByBrand("64989445c41230ffd2539f89");
    List<Survey> surveysResponseList = surveyResponse.data;

    if (surveysResponseList.isNotEmpty) {
      _surveys = surveysResponseList;
      setIsLoading(false);
    } else {
      setIsLoading(false);
    }

    notifyListeners();
  }

  void setSurvey(Survey survey) {
    _surveyAction = SurveyAction.edit;
    _surveyName = survey.name;
    _surveyDescription = survey.description!;
    _initDate = survey.initDate;
    _finalDate = survey.finalDate;
    initDateController.text = survey.initDate;
    finalDateController.text = survey.finalDate;
    _survey = survey;
    notifyListeners();
  }
}
