import 'package:quickyshop/models/survey/questions/options/OptionQuestion.dart';

class ScaleOption implements OptionQuestion {
  @override
  String titleOptionSurvey;

  @override
  String id;

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    return {
      'id': id,
      'titleOptionSurvey': titleOptionSurvey,
    };
  }

  ScaleOption({required this.id, required this.titleOptionSurvey});
}
