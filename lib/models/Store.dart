class Store {
  String? id;
  String name;
  String photo;
  String category;
  String subcategory;
  String location;
  String email;
  String principal_category;
  String brandId;

  Store(
      {this.id,
      required this.name,
      required this.photo,
      required this.category,
      required this.subcategory,
      required this.email,
      required this.location,
      required this.principal_category,
      required this.brandId});

  factory Store.fromJSONResponse(Map<String, dynamic> response) {
    return Store(
        id: response['_id'],
        name: response['name'],
        email: response['email'],
        photo: response['photo'],
        location: response['location'],
        category: response['category'],
        subcategory: response['subcategory'],
        principal_category: response['principal_category'],
        brandId: response['brandId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'photo': photo,
      'location': location,
      'email': email,
      'category': category,
      'subcategory': subcategory,
      'principal_category': principal_category,
      'brandId': brandId
    };
  }
}
