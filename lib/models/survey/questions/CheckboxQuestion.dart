import 'package:quickyshop/models/survey/questions/options/OptionQuestion.dart';
import 'package:quickyshop/models/survey/Question.dart';

class CheckBoxQuestion implements Question {
  @override
  List<OptionQuestion>? options;

  @override
  String title;

  @override
  String? type;

  CheckBoxQuestion(
      {required this.title,
      required this.type,
      required this.options,
      required this.id});

  @override
  String id;

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'type': type, 'options': options};
  }
}
