import 'package:flutter/cupertino.dart';
import 'package:towrevo/web_services/otp_web_service.dart';

import '../utilities.dart';

class OTPViewModel with ChangeNotifier{

  String resendUniqueId = '';
  bool otpExpire = false;

  Future<bool> sendOTP(String uniqueId,String otp,BuildContext context) async {
    otpExpire = false;
    resendUniqueId = '';
   final response = await OTPWebService().sendOTPConfirmationRequest(uniqueId,otp);
    // Utilities().showToast(response.toString());
    print(response);
   if(response['success']){

     Utilities().showToast('success');
     return true;
   }else if(response['data']['code'] == 404 || response['data']['code'] == 413){
     otpExpire =true;
     // Utilities().showToast('Invalid OTP Please Resend It');

     resendUniqueId = response['data']['resendId'];
     return false;
   }else{
     resendUniqueId = response['data']['resendId'];
     return false;
   }

  }



  Future<void> resendOTP(String uniqueId) async {
    if(resendUniqueId.isNotEmpty) {

      await OTPWebService().resendOTPRequest(uniqueId);
    }else{
      print('resend id is empty');
    }
  }
}