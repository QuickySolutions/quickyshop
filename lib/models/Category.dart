import 'SubLevel.dart';

class Category {
  String? id;
  String name;
  String banner;
  List<SubLevel> sublevels;
  Category(
      {this.id,
      required this.banner,
      required this.name,
      required this.sublevels});

  factory Category.fromResponse(Map<String, dynamic> response) {
    return Category(
        id: response['_id'],
        name: response['name'],
        banner: response['banner'],
        sublevels: response['sublevels']
            .map<SubLevel>((e) => SubLevel.fromJSONResponse(e))
            .toList());
  }
  Category copyWith(
      {String? id, String? name, String? banner, List<SubLevel>? sublevels}) {
    return Category(
        id: id, banner: banner!, name: name!, sublevels: sublevels!);
  }
}
