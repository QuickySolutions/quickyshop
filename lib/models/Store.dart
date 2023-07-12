class Store {
  String id;
  String name;
  String photo;
  String category;
  String subcategory;
  List<dynamic> coupons;
  List<dynamic> surveys;
  String principal_category;
  String brandId;

  Store(
      {required this.id,
      required this.name,
      required this.photo,
      required this.category,
      required this.subcategory,
      required this.coupons,
      required this.surveys,
      required this.principal_category,
      required this.brandId});

  factory Store.fromJSONResponse(Map<String, dynamic> response) {
    return Store(
        id: response['_id'],
        name: response['name'],
        photo: response['photo'],
        category: response['category'],
        subcategory: response['subcategory'],
        coupons: response['coupons'],
        surveys: response['surveys'],
        principal_category: response['principal_category'],
        brandId: response['brandId']);
  }
}
