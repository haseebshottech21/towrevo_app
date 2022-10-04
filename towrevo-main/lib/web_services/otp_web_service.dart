import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:towrevo/utilities/utilities.dart';

class OTPWebService {
  Utilities utilities = Utilities();
  Future<dynamic> sendOTPConfirmationRequest(
      String uniqueId, String otp) async {
    try {
      final response = await http.post(
        Uri.parse(
          Utilities.baseUrl + 'validate',
        ),
        headers: Utilities.header,
        body: {
          'uniqueId': uniqueId,
          'otp': otp,
        },
      );
      final loadedData = json.decode(response.body);

      if (response.statusCode == 200) {
        // if (loadedData['data']['user']['type'] != '2') {
        await utilities.setUserDataToLocalStorage(loadedData['data']);
        // }
        Fluttertoast.showToast(msg: 'success');
        return loadedData;
      } else if (loadedData['success'] == false) {
        await utilities.setSharedPrefValue(
            'validate', await getResendOTPOrOTPValue('validate'));
        await utilities.setSharedPrefValue(
            'uniqueId', loadedData['data']['resendId']);
        Fluttertoast.showToast(msg: loadedData['message'].toString());
        return loadedData;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<dynamic> resendOTPRequest(String uniqueId) async {
    try {
      final response = await http.post(
        Uri.parse(
          Utilities.baseUrl + 'resend-otp',
        ),
        headers: Utilities.header,
        body: {
          'uniqueId': uniqueId,
        },
      );

      if (response.statusCode == 200) {
        final loadedResponse = json.decode(response.body);

        await utilities.setSharedPrefValue(
            'resendOTP', await getResendOTPOrOTPValue('resendOTP'));
        await utilities.setSharedPrefValue('validate', '0');

        await utilities.setSharedPrefValue(
            'uniqueId', loadedResponse['uniqueId']);
        return loadedResponse;
      } else {
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  getResendOTPOrOTPValue(String key) async {
    String value =
        (int.parse(await utilities.getSharedPreferenceValue(key)) + 1)
            .toString();

    return value;
  }
}
