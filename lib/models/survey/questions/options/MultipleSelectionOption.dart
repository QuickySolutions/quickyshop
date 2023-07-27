import 'package:quickyshop/models/survey/questions/options/OptionQuestion.dart';

class MultipleSelectionOption implements OptionQuestion {
  @override
  String titleOptionSurvey;

  bool value;

  MultipleSelectionOption(
      {required this.titleOptionSurvey, required this.value});
}
