import 'package:quickyshop/models/survey/questions/options/OptionQuestion.dart';

class MultipleSelectionOption implements OptionQuestion {
  bool value;

  @override
  String titleOptionSurvey;

  @override
  String id;

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    return {'id': id, 'titleOptionSurvey': titleOptionSurvey, 'value': value};
  }

  MultipleSelectionOption(
      {required this.id, required this.titleOptionSurvey, this.value = false});
}
