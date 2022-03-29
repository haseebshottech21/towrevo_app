class CouponModel {
  String id;
  String couponName;
  String couponCode;
  String couponDiscountPercent;
  bool isActive;

  CouponModel({
    required this.id,
    required this.couponName,
    required this.couponCode,
    required this.couponDiscountPercent,
    required this.isActive,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'].toString(),
      couponName: json['coupon_name'].toString(),
      couponCode: json['coupon_code'].toString(),
      couponDiscountPercent: json['coupon_percent'].toString(),
      isActive: json['is_active'].toString() == '1' ? true : false,
    );
  }

  factory CouponModel.emptyObject() {
    return CouponModel(
      id: '',
      couponName: '',
      couponCode: '',
      couponDiscountPercent: '',
      isActive: false,
    );
  }
}
