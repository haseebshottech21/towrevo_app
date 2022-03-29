import 'package:flutter/material.dart';
import 'package:towrevo/models/coupan_model.dart';
import 'package:towrevo/screens/company/company_payment_screen.dart';
import 'package:towrevo/web_services/payment_web_service.dart';

import '../utilities/utilities.dart';
import '../widgets/Company/add_discount_bottom_sheet.dart';

class PaymentViewModel with ChangeNotifier {
  final PaymentWebService paymentWebService = PaymentWebService();

  CouponModel couponModel = CouponModel.emptyObject();

  Future<void> checkCoupon(
      {required String coupon,
      required BuildContext context,
      required Function makePament}) async {
    if (!(await Utilities().isInternetAvailable())) {
      return;
    }
    couponModel = await paymentWebService.checkCouponService(coupon: coupon);
    if (couponModel.id.isNotEmpty) {
      Navigator.of(context).pop();
      showDiscountPayment(
        context,
        couponModel.couponDiscountPercent,
        () async {
          Navigator.of(context).pop();

          await makePament(context,
              '${(CompanyPaymentScreen.payAmmount - (CompanyPaymentScreen.payAmmount / 100 * int.parse(couponModel.couponDiscountPercent))).round()}');
        },
      );
    }
  }
}
