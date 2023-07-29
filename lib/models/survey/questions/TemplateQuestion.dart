import 'package:quickyshop/models/survey/questions/options/OptionQuestion.dart';
import 'package:quickyshop/models/survey/Question.dart';

class TemplateQuestion implements Question {
  @override
  String title;

  @override
  List<OptionQuestion>? options;

  @override
  String? type;

  @override
  String id;

  TemplateQuestion({required this.title, required this.type, required this.id});

  @override
  Map<String, dynamic>? toJson() {
    // TODO: implement toJson
    return {};
  }
}
