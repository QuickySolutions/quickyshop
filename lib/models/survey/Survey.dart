import 'package:quickyshop/models/survey/Question.dart';

class Survey {
  String id;
  String photo;
  String nameSurvey;
  String? description;
  bool active;
  late List<Question>? questions;
  Survey(
      {required this.id,
      required this.photo,
      required this.nameSurvey,
      this.description,
      this.active = true,
      this.questions});
}
