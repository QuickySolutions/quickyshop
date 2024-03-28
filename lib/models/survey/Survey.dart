import 'package:quickyshop/models/Coupon.dart';
import 'package:quickyshop/models/survey/Gift.dart';
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
  Coupon? gift;
  List<String>? stores;
  int points;
  Survey(
      {this.id,
      this.photo,
      required this.name,
      required this.initDate,
      required this.finalDate,
      required this.secretPassword,
      this.gift,
      this.description,
      this.stores,
      this.points = 30,
      this.active = true,
      this.questions});

  factory Survey.fromJSONResponse(Map<String, dynamic> response) {
    var storesResponse = response['stores']; // array is now List<dynamic>
    List<String> stores = List<String>.from(storesResponse);
    return Survey(
        id: response['_id'],
        name: response['name'],
        stores: stores,
        description: response['description'],
        active: response['active'],
        photo: response['photo'],
        points: response['points'],
        gift: response['gift'] != null
            ? Coupon.fromJSONResponse(response['gift'])
            : Coupon(
                id: '',
                name: '',
                monetization: 0,
                active: false,
                brandId: '',
                photo: '',
              ),
        initDate: response['initDate'],
        finalDate: response['finalDate'],
        secretPassword: response['secretPassword'],
        questions: questionsFromJsonResponse(response['questions']));
  }
  factory Survey.fromJSONResponseWithOutQuestions(
      Map<String, dynamic> response) {
    var storesResponse = response['stores']; // array is now List<dynamic>
    List<String> stores = List<String>.from(storesResponse);
    return Survey(
        id: response['_id'],
        name: response['name'],
        stores: stores,
        points: response['points'],
        description: response['description'],
        active: response['active'],
        photo: response['photo'],
        initDate: response['initDate'],
        finalDate: response['finalDate'],
        secretPassword: response['secretPassword']);
  }

  Map<String, dynamic> toJson() {
    var len = id ?? null;
    Map<String, dynamic> map = {
      'id': len,
      'photo': photo,
      'name': name,
      'active': active,
      'points': points,
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
