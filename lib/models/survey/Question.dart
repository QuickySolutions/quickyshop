import 'package:quickyshop/models/survey/questions/options/OptionQuestion.dart';

abstract class Question {
  late String id;
  late String title;
  late String? type;
  late bool isNew;
  late List<OptionQuestion>? options;
  Map<String, dynamic>? toJson();
}
