class Gift {
  late final String id;
  late final String name;
  late final int monetization;
  late final int usesCount;
  late final bool active;
  late final List<String> stores;
  late final String brandId;
  late final String photo;

  Gift({
    required this.id,
    required this.name,
    required this.monetization,
    required this.usesCount,
    required this.active,
    required this.stores,
    required this.brandId,
    this.photo = "",
  });

  factory Gift.fromJson(Map<String, dynamic> json) {
    var storesResponse = json['stores']; // array is now List<dynamic>
    List<String> stores = List<String>.from(storesResponse);

    return Gift(
      id: json['_id'] ?? "", // Provide default value for id
      name: json['name'] ?? "", // Provide default value for name
      monetization:
          json['monetization'] ?? 0, // Provide default value for monetization
      usesCount: json['usesCount'] ?? 0, // Provide default value for usesCount
      active: json['active'] ?? false, // Provide default value for active
      stores: stores,
      brandId: json['brandId'] ?? "", // Provide default value for brandId
      photo: json['photo'] ?? "", // Provide default value for photo
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['monetization'] = monetization;
    data['usesCount'] = usesCount;
    data['active'] = active;
    data['stores'] = stores;
    data['brandId'] = brandId;
    data['photo'] = photo;
    return data;
  }
}
