class Coupon {
  String? id;
  String name;
  num monetization;
  String brandId;
  bool active;
  String? photo;

  Coupon(
      {this.id,
      required this.name,
      required this.monetization,
      required this.brandId,
      this.photo,
      required this.active});

  factory Coupon.fromJSONResponse(Map<String, dynamic> response) {
    String photo = "";
    if (response['photo'] != null) {
      photo = response['photo'];
    }

    return Coupon(
        id: response['_id'],
        name: response['name'],
        photo: photo,
        monetization: response['monetization'],
        active: response['active'],
        brandId: response['brandId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'active': this.active,
      'name': this.name,
      'photo': this.photo,
      'monetization': this.monetization,
      'brandId': this.brandId
    };
  }
}
