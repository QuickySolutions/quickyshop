class Coupon {
  String name;
  num monetization;
  String brandId;

  Coupon(
      {required this.name, required this.monetization, required this.brandId});

  factory Coupon.fromJSONResponse(Map<String, dynamic> response) {
    return Coupon(
        name: response['name'],
        monetization: response['monetization'],
        brandId: response['brandId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'monetization': this.monetization,
      'brandId': this.brandId
    };
  }
}
