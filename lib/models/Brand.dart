class Brand {
  String id;
  String name;
  String email;
  String cellphone;
  String principalCategory;
  String category;
  String subCategory;
  String photo;

  Brand({
    required this.id,
    required this.name,
    required this.email,
    required this.cellphone,
    required this.principalCategory,
    required this.category,
    required this.subCategory,
    required this.photo,
  });

  factory Brand.fromJSONResponse(Map<String, dynamic> response) {
    return Brand(
        id: response['_id'],
        name: response['name'],
        email: response['email'],
        cellphone: response['cellphone'],
        principalCategory: response['principal_category'],
        category: response['category'],
        subCategory: response['subcategory'],
        photo: response['photo']);
  }

  factory Brand.init() {
    return Brand(
        id: '',
        name: '',
        email: '',
        cellphone: '',
        principalCategory: '',
        category: '',
        subCategory: '',
        photo: 'photo');
  }
}
