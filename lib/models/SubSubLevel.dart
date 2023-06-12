class SubSubLevel {
  String banner;
  String name;

  SubSubLevel({required this.banner, required this.name});

  factory SubSubLevel.fromJSONResponse(Map<String, dynamic> response) {
    return SubSubLevel(banner: response['banner'], name: response['name']);
  }
}
