import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:towrevo/web_services/otp_web_service.dart';
import '../utilities/utilities.dart';

class OTPViewModel with ChangeNotifier {
  Utilities utilities = Utilities();
  OTPWebService otpWebService = OTPWebService();
  String resendUniqueId = '';
  bool otpExpire = false;

  bool isLoading = false;
  changeLoadingStatus(bool loadingStatus) {
    isLoading = loadingStatus;
    notifyListeners();
  }

  Future<bool> sendOTP(
      String uniqueId, String otp, BuildContext context) async {
    if (!(await utilities.isInternetAvailable())) {
      return false;
    }
    int validate = await getResendOTPOrValidateValue('validate');
    int resendOTP = await getResendOTPOrValidateValue('resendOTP');

    if (resendOTP > 2) {
      Fluttertoast.showToast(
          msg: 'You can\'t atempt more, please contact to admin');
      return false;
    } else if (validate >= 5) {
      Fluttertoast.showToast(
          msg: 'Your attempt many time please click on resend otp');
      return false;
    }
    otpExpire = false;
    resendUniqueId = '';
    changeLoadingStatus(true);
    final response =
        await otpWebService.sendOTPConfirmationRequest(uniqueId, otp);
    changeLoadingStatus(true);

    if (response['success']) {
      Fluttertoast.showToast(msg: 'success');
      return true;
    } else if (response['data']['code'] == 404 ||
        response['data']['code'] == 413) {
      otpExpire = false;

      resendUniqueId = response['data']['resendId'];
      return false;
    } else {
      resendUniqueId = response['data']['resendId'];
      return false;
    }
  }

  Future<bool> resendOTP(String uniqueId) async {
    if (!(await Utilities().isInternetAvailable())) {
      return false;
    }
    changeLoadingStatus(true);
    int resendOTP = await getResendOTPOrValidateValue('resendOTP');
    changeLoadingStatus(false);

    if (resendOTP >= 3) {
      Fluttertoast.showToast(
          msg: 'Your OTP Reset Limit is Over Please contact to admin');
      return false;
    }
    if (resendUniqueId.isNotEmpty) {
      final response = await otpWebService.resendOTPRequest(uniqueId);
      // print(response);
      if (response['status']) {
        resendUniqueId = response['uniqueId'];
        Fluttertoast.showToast(msg: 'OTP Resend Success');

        return true;
      } else {
        return false;
      }
    } else {
      Fluttertoast.showToast(msg: 'resend id is empty');
      return false;
    }
  }

  getResendOTPOrValidateValue(String key) async {
    int value = (int.parse(await utilities.getSharedPreferenceValue(key)));

    return value;
  }
}
