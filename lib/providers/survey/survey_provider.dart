import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quickyshop/models/Coupon.dart';
import 'package:quickyshop/models/Store.dart';
import 'package:quickyshop/models/survey/questions/CheckboxQuestion.dart';
import 'package:quickyshop/models/survey/Question.dart';
import 'package:quickyshop/models/survey/Survey.dart';
import 'package:quickyshop/models/survey/questions/CloseQuestion.dart';
import 'package:quickyshop/models/survey/questions/ComboBoxQuestion.dart';
import 'package:quickyshop/models/survey/questions/RadioQuestion.dart';
import 'package:quickyshop/models/survey/questions/ReviewQuestion.dart';
import 'package:quickyshop/models/survey/questions/ScaleQuestion.dart';
import 'package:quickyshop/models/survey/questions/TemplateQuestion.dart';
import 'package:quickyshop/models/survey/questions/options/CloseOption.dart';
import 'package:quickyshop/models/survey/questions/options/ComboBoxOption.dart';
import 'package:quickyshop/models/survey/questions/options/MultipleSelectionOption.dart';
import 'package:quickyshop/models/survey/questions/options/OptionQuestion.dart';
import 'package:quickyshop/models/survey/questions/options/RadioOption.dart';
import 'package:quickyshop/models/survey/questions/options/ScaleOption.dart';
import 'package:quickyshop/preferences/appPreferences.dart';
import 'package:quickyshop/services/brandService.dart';
import 'package:quickyshop/services/storeService.dart';
import 'package:quickyshop/utils/survey_utils.dart';
import 'package:uuid/uuid.dart';

class SurveyProvider extends ChangeNotifier {
  late Survey _survey = Survey(
      name: '', initDate: '', finalDate: '', secretPassword: '', questions: []);
  late String _surveyName = "";
  late String _surveyDescription = "";
  late String _initDate = "";
  late String _finalDate = "";
  TextEditingController initDateController = TextEditingController();
  TextEditingController finalDateController = TextEditingController();
  late List<Survey> _surveys = [];
  late File _selectedPhoto = File('');
  bool _isLoadingRequest = false;
  bool _isLoadingCreateOrEditSurvey = false;
  SurveyAction _surveyAction = SurveyAction.create;
  int _activePage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final BrandService _brandService = BrandService();
  late int _indexTitleToEditQuestion = -1;
  late Coupon _selectedCoupon =
      Coupon(id: "", name: '', monetization: 0, brandId: "", active: false);
  late Coupon _createdCoupon =
      Coupon(name: '', monetization: 0, brandId: "", active: false);
  List<Store> _selectedStores = [];

  Survey get survey => _survey;
  String get surveyName => _surveyName;
  String get surveyDescription => _surveyDescription;
  String get initDate => _initDate;
  int get activePage => _activePage;
  PageController get pageController => _pageController;
  String get finalDate => _finalDate;
  List<Survey> get surveys => _surveys;
  bool get isLoading => _isLoadingRequest;
  Coupon get couponSelected => _selectedCoupon;
  bool get isLoadingCreateOrEditSurvey => _isLoadingCreateOrEditSurvey;
  File get selectedPhoto => _selectedPhoto;
  SurveyAction get surveyAction => _surveyAction;
  int get indexTitleToEditQuestion => _indexTitleToEditQuestion;

  StoreService _storeService = StoreService();

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

  void setLoadCreateOrEditSurvey(bool value) {
    _isLoadingCreateOrEditSurvey = value;
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

  void setPhoto(String photoValue) {
    _survey.photo = photoValue;
    notifyListeners();
  }

  void addSurvey(Survey survey) {
    _survey = survey;
    notifyListeners();
  }

  void setPage(int page) {
    _activePage = page;
    notifyListeners();
  }

  void changePage() {
    _pageController.animateToPage(_activePage + 1,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
    notifyListeners();
  }

  void goBackPage() {
    _pageController.animateToPage(_activePage - 1,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
    notifyListeners();
  }

  void handleChangeSelectionTypeQuestion(int indexQuestion, String keyType) {
    Question oldQuestion = _survey.questions![indexQuestion];
    if (keyType == 'check') {
      _survey.questions![indexQuestion] = CheckBoxQuestion(
          maximumOptions: 6,
          minimumOptions: 3,
          maxSelected: 6,
          isNew: true,
          minimumSelected: 2,
          id: oldQuestion.id,
          title: oldQuestion.title,
          type: keyType,
          options: []) as Question;
    } else if (keyType == 'close') {
      _survey.questions![indexQuestion] = CloseQuestion(
          id: oldQuestion.id,
          isNew: true,
          title: oldQuestion.title,
          type: keyType,
          options: [
            CloseOption(id: Uuid().v4(), titleOptionSurvey: 'Si'),
            CloseOption(id: Uuid().v4(), titleOptionSurvey: 'No')
          ]) as Question;
    } else if (keyType == 'combo-box') {
      _survey.questions![indexQuestion] = ComboBoxQuestion(
          id: oldQuestion.id,
          title: oldQuestion.title,
          type: keyType,
          options: [],
          isNew: true) as Question;
    } else if (keyType == 'mini-review') {
      _survey.questions![indexQuestion] = ReviewQuestion(
          id: oldQuestion.id,
          title: oldQuestion.title,
          review: "",
          type: keyType,
          maxCharacters: 100,
          options: [],
          isNew: true) as Question;
    } else if (keyType == 'large-review') {
      _survey.questions![indexQuestion] = ReviewQuestion(
          id: oldQuestion.id,
          title: oldQuestion.title,
          review: "",
          type: keyType,
          maxCharacters: -1,
          options: [],
          isNew: true) as Question;
    } else if (keyType == 'radio') {
      _survey.questions![indexQuestion] = RadioQuestion(
          id: oldQuestion.id,
          title: oldQuestion.title,
          type: keyType,
          options: [],
          selected: "",
          isNew: true) as Question;
    } else if (keyType == 'scale') {
      _survey.questions![indexQuestion] = ScaleQuestion(
          id: oldQuestion.id,
          title: oldQuestion.title,
          type: keyType,
          options: [],
          maxOptions: 5,
          isNew: true) as Question;
    } else {
      //option will be normal
      _survey.questions![indexQuestion] = TemplateQuestion(
        id: oldQuestion.id,
        isNew: true,
        title: oldQuestion.title,
        type: 'normal',
      ) as Question;
    }

    notifyListeners();
  }

  void addNewOptionToQuestion(String type, int indexQuestion) {
    late OptionQuestion newOption;

    if (type == 'check') {
      newOption = MultipleSelectionOption(
          id: Uuid().v4(),
          titleOptionSurvey: 'titulo de la opción...',
          value: false);
    } else if (type == 'close') {
      newOption = CloseOption(
          id: Uuid().v4(), titleOptionSurvey: 'titulo de la opción...');
    } else if (type == 'combo-box') {
      newOption = ComboBoxOption(
          id: Uuid().v4(), titleOptionSurvey: 'titulo de la opción...');
    } else if (type == 'radio') {
      newOption = RadioOption(
          id: Uuid().v4(), titleOptionSurvey: 'titulo de la opción...');
    } else if (type == 'scale') {
      newOption = ScaleOption(
          id: Uuid().v4(), titleOptionSurvey: 'titulo de la opción...');
    }

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
        await _brandService.getSurveysByBrand(AppPreferences().brandId);
    List<Survey> surveysResponseList = surveyResponse.data;

    if (surveysResponseList.isNotEmpty) {
      _surveys = surveysResponseList;
      setIsLoading(false);
    } else {
      setIsLoading(false);
    }

    notifyListeners();
  }

  void getSurveysFromStore(String storeId) async {
    setIsLoading(true);
    StoreResponse surveyResponse =
        await _storeService.getSurveysFromStore(storeId);
    List<Survey> surveysResponseList = surveyResponse.data;
    if (surveysResponseList.isEmpty) {
      _surveys = [];
      setIsLoading(false);
    } else {
      _surveys = surveysResponseList;
      setIsLoading(false);
    }

    notifyListeners();
  }

  void changeTitleQuestion(int indexQuestion) {
    if (_indexTitleToEditQuestion < 0) {
      _indexTitleToEditQuestion = indexQuestion;
    } else {
      _indexTitleToEditQuestion = -1;
    }

    notifyListeners();
  }

  void onChangeTitleQuetion(int indexQuestion, String value) {
    _survey.questions![indexQuestion].title = value;
    notifyListeners();
  }

  void setSurvey(Survey survey) {
    _surveyAction = SurveyAction.edit;
    _surveyName = survey.name;
    _surveyDescription = survey.description!;
    _initDate = survey.initDate;
    _finalDate = survey.finalDate;
    _survey.photo = survey.photo;
    initDateController.text = survey.initDate;
    finalDateController.text = survey.finalDate;
    _survey = survey;
    notifyListeners();
  }

  void reset() {
    _surveyAction = SurveyAction.create;
    _surveyName = "";
    _surveyDescription = "";
    _initDate = "";
    _finalDate = "";
    initDateController.text = "";
    finalDateController.text = "";
    _survey = Survey(
        name: '',
        initDate: '',
        finalDate: '',
        secretPassword: '',
        questions: []);
    _selectedPhoto = File('');
    notifyListeners();
  }

  void deleteQuestion(int indexQuestion, SurveyAction action) {
    switch (action) {
      case SurveyAction.create:
        _survey.questions!.removeAt(indexQuestion);
        break;
      case SurveyAction.edit:
        break;
      default:
    }
  }

  void selectCoupon(Coupon coupon) {
    _selectedCoupon = coupon;
    notifyListeners();
  }

  void chooseStore(Store store) {
    if (_selectedStores.contains(store)) {
      _selectedStores.remove(store);
    } else {
      _selectedStores.add(store);
    }
    notifyListeners();
  }

  void resetCurrentPage() {
    _activePage = 0;
    notifyListeners();
  }
}
