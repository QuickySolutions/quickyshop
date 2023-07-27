class Coupon {
  String? id;
  String name;
  num monetization;
  String brandId;
  bool active;

  Coupon(
      {this.id,
      required this.name,
      required this.monetization,
      required this.brandId,
      required this.active});

  factory Coupon.fromJSONResponse(Map<String, dynamic> response) {
    return Coupon(
        id: response['_id'],
        name: response['name'],
        monetization: response['monetization'],
        active: response['active'],
        brandId: response['brandId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'active': this.active,
      'name': this.name,
      'monetization': this.monetization,
      'brandId': this.brandId
    };
  }
}
