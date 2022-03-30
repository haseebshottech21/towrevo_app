import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:towrevo/models/coupan_model.dart';
import '../utilities/utilities.dart';

class PaymentWebService {
  Future<CouponModel> checkCouponService({required String coupon}) async {
    try {
      final response = await http.post(Uri.parse(Utilities.baseUrl + 'coupon'),
          headers: await Utilities().headerWithAuth(),
          body: {
            'coupon_code': coupon,
          });
      print(response.body);
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(msg: 'Voucher Applied');

        return CouponModel.fromJson(loadedData['data']);
      } else if (response.statusCode >= 404 && response.statusCode <= 499) {
        Fluttertoast.showToast(msg: loadedData['data'].toString());
        return CouponModel.emptyObject();
      }
      return CouponModel.emptyObject();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return CouponModel.emptyObject();
    }
  }
}
