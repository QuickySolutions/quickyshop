import 'package:quickyshop/models/survey/Question.dart';
import 'package:quickyshop/models/survey/questions/options/OptionQuestion.dart';

class RadioQuestion implements Question {
  @override
  String id;

  @override
  List<OptionQuestion>? options;

  @override
  String title;

  @override
  String? type;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'options': options,
      'isNew': isNew,
      'selected': selected
    };
  }

  RadioQuestion(
      {required this.id,
      required this.title,
      required this.type,
      required this.options,
      required this.isNew,
      required this.selected});

  @override
  bool isNew;

  String selected;
}
