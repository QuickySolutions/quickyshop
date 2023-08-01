import 'package:quickyshop/models/survey/questions/options/OptionQuestion.dart';
import 'package:quickyshop/models/survey/Question.dart';

class CheckBoxQuestion implements Question {
  int minimumOptions;
  int maximumOptions;

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
      required this.options,
      required this.id,
      required this.minimumOptions,
      required this.maximumOptions,
      required this.maxSelected,
      required this.minimumSelected,
      this.isCompletedQuestion = false});

  @override
  String id;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'options': options,
      'completedQuestion': isCompletedQuestion,
      'maxSelected': maxSelected,
      'minimumSelected': minimumSelected
    };
  }
}
