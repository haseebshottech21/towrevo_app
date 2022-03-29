class CouponModel {
  String id;
  String couponName;
  String couponCode;
  String couponPercent;
  String isActive;

  CouponModel({
    required this.id,
    required this.couponName,
    required this.couponCode,
    required this.couponPercent,
    required this.isActive,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'].toString(),
      couponName: json['coupon_name'].toString(),
      couponCode: json['coupon_code'].toString(),
      couponPercent: json['coupon_percent'].toString(),
      isActive: json['is_active'].toString(),
    );
  }
}
