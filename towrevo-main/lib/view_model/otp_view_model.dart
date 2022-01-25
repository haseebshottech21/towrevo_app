import 'package:flutter/cupertino.dart';
import 'package:towrevo/web_services/otp_web_service.dart';

import '../utilities.dart';

class OTPViewModel with ChangeNotifier {
  String resendUniqueId = '';
  bool otpExpire = false;

  Future<bool> sendOTP(
      String uniqueId, String otp, BuildContext context) async {
    if (!(await Utilities().isInternetAvailable())) {
      return false;
    }
    int validate = await getResendOTPOrValidateValue('validate');
    int resendOTP = await getResendOTPOrValidateValue('resendOTP');
    print('validate $validate ');
    print('resend otp $resendOTP ');
    if (resendOTP > 2) {
      Utilities().showToast('You can\'t atempt more, please contact to admin');
      return false;
    } else if (validate >= 5) {
      Utilities()
          .showToast('Your attempt many time please click on resend otp');
      return false;
    }
    otpExpire = false;
    resendUniqueId = '';
    final response =
        await OTPWebService().sendOTPConfirmationRequest(uniqueId, otp);

    print(response);
    if (response['success']) {
      Utilities().showToast('success');
      return true;
    } else if (response['data']['code'] == 404 ||
        response['data']['code'] == 413) {
      print('in 400 error');
      otpExpire = false;
      // Utilities().showToast('Invalid OTP Please Resend It');

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
    int resendOTP = await getResendOTPOrValidateValue('resendOTP');
    print('resend otp $resendOTP ');
    if (resendOTP >= 3) {
      Utilities()
          .showToast('Your OTP Reset Limit is Over Please contact to admin');
      return false;
    }
    if (resendUniqueId.isNotEmpty) {
      final response = await OTPWebService().resendOTPRequest(uniqueId);
      print(response);
      if (response['status']) {
        resendUniqueId = response['uniqueId'];
        Utilities().showToast('OTP Resend Success');

        return true;
      } else {
        // resendUniqueId = response['data']['resendId'];
        return false;
      }
    } else {
      Utilities().showToast('resend id is empty');
      print('resend id is empty');
      return false;
    }
  }

  getResendOTPOrValidateValue(String key) async {
    int value = (int.parse(await Utilities().getSharedPreferenceValue(key)));
    print('$key : $value');
    return value;
  }
}
