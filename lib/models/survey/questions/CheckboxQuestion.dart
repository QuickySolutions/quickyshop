import 'package:quickyshop/models/survey/questions/options/OptionQuestion.dart';
import 'package:quickyshop/models/survey/Question.dart';

class CheckBoxQuestion implements Question {
  int? minimumOptions;
  int? maximumOptions;

  int? maxSelected;
  int? minimumSelected;
  bool isCompletedQuestion;

  @override
  List<OptionQuestion>? options;

  @override
  String title;

  @override
  String? type;

  CheckBoxQuestion(
      {required this.title,
      required this.type,
      this.options,
      required this.id,
      this.minimumOptions,
      this.maximumOptions,
      this.maxSelected,
      required this.isNew,
      this.minimumSelected,
      this.isCompletedQuestion = false});

  @override
  String id;

  @override
  bool isNew;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'options': options,
      'completedQuestion': isCompletedQuestion,
      'maxSelected': maxSelected,
      'minimumSelected': minimumSelected,
      'isNew': isNew,
    };
  }
}
