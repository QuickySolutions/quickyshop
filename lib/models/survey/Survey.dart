import 'package:quickyshop/models/survey/Question.dart';
import 'package:quickyshop/utils/survey_utils.dart';

class Survey {
  String? id;
  String? photo;
  String name;
  String? description;
  bool active;
  late List<Question>? questions;
  String secretPassword;
  String initDate;
  String finalDate;
  Survey(
      {this.id,
      this.photo,
      required this.name,
      required this.initDate,
      required this.finalDate,
      required this.secretPassword,
      this.description,
      this.active = true,
      this.questions});

  factory Survey.fromJSONResponse(Map<String, dynamic> response) {
    return Survey(
        id: response['_id'],
        name: response['name'],
        description: response['description'],
        active: response['active'],
        photo: response['photo'],
        initDate: response['initDate'],
        finalDate: response['finalDate'],
        secretPassword: response['secretPassword'],
        questions: questionsFromJsonResponse(response['questions']));
  }

  Map<String, dynamic> toJson() {
    var len = id ?? null;
    Map<String, dynamic> map = {
      'id': len,
      'photo': photo,
      'name': name,
      'active': active,
      'secretPassword': secretPassword,
      'initDate': initDate,
      'finalDate': finalDate,
    };
    if (description != null) map['description'] = description;
    if (questions != null)
      map['questions'] = questions!.map((q) => q.toJson()).toList();

    return map;
  }
}
