import 'SubSubLevel.dart';

class SubLevel {
  String name;
  String banner;
  List<SubSubLevel> subSublevels;
  SubLevel(
      {required this.name, required this.banner, required this.subSublevels});

  factory SubLevel.fromJSONResponse(Map<String, dynamic> response) {
    return SubLevel(
        banner: response['banner'],
        name: response['name'],
        subSublevels: response['subSublevels']
            .map<SubSubLevel>((e) => SubSubLevel.fromJSONResponse(e))
            .toList());
  }
}
