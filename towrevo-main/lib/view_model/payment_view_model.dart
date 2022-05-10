import 'package:flutter/material.dart';
import 'package:towrevo/models/coupan_model.dart';
import 'package:towrevo/models/payment.dart';
import 'package:towrevo/screens/company/company_payment_screen.dart';
import 'package:towrevo/web_services/payment_web_service.dart';

import '../utilities/utilities.dart';
import '../widgets/Company/add_discount_bottom_sheet.dart';

class PaymentViewModel with ChangeNotifier {
  final PaymentWebService paymentWebService = PaymentWebService();

  CouponModel couponModel = CouponModel.emptyObject();
  bool isLoading = false;
  final Utilities utilities = Utilities();

  Future<void> checkCoupon(
      {required String coupon,
      required BuildContext context,
      required Function makePament}) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    isLoading = true;
    notifyListeners();
    couponModel = await paymentWebService.checkCouponService(coupon: coupon);
    isLoading = false;
    notifyListeners();
    if (couponModel.id.isNotEmpty) {
      Navigator.of(context).pop();
      Future.delayed(const Duration(seconds: 1), () {
        showDiscountPayment(
          context,
          couponModel.couponCode,
          couponModel.couponDiscountPercent,
          () async {
            Navigator.of(context).pop();

            await makePament(
              context,
              '${(CompanyPaymentScreen.payAmmount - (CompanyPaymentScreen.payAmmount / 100 * int.parse(couponModel.couponDiscountPercent))).round()}',
              couponModel.id,
            );
          },
        );
      });
    }
  }

  List<Payment> paymentHistoryList = [];
  Map<String, String> dates = {
    'difference': '',
    'last_payment_date': '',
    'expire_date': '',
  };

  Future<void> paymentHistory() async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    isLoading = true;
    // notifyListeners();
    final Map<String, dynamic> loadedData =
        await paymentWebService.paymentHistoryWebService();
    if (loadedData.isNotEmpty) {
      dates = {
        'difference': loadedData['difference'].toString(),
        'last_payment_date': loadedData['last_payment_date'].toString(),
        'expire_date': loadedData['expire_date'].toString(),
      };
      paymentHistoryList = loadedData['payment'] as List<Payment>;
      isLoading = false;
      notifyListeners();
    }
  }
}
