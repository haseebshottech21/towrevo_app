import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:towrevo/utilities.dart';

class OTPWebService {
  Utilities utilities = Utilities();
  Future<dynamic> sendOTPConfirmationRequest(
      String uniqueId, String otp) async {
    print({'uniqueId': uniqueId, 'otp': otp});
    final response = await http.post(
        Uri.parse(
          Utilities.baseUrl + 'validate',
        ),
        headers: Utilities.header,
        body: {'uniqueId': uniqueId, 'otp': otp});
    final loadedData = json.decode(response.body);
    // Utilities().showToast(loadedData.toString());
    print(loadedData);
    if (response.statusCode == 200) {
      print('200');
      print(response.body);
      // print(loadedData['data']['type']);
      // print(loadedData['data']['user']['token']);
      await utilities.setSharedPrefValue('token', loadedData['data']['token']);
      await utilities.setSharedPrefValue(
          'type', loadedData['data']['user']['type']);

      await utilities.setSharedPrefValue(
        'email',
        loadedData['data']['user']['email'],
      );
      await utilities.setSharedPrefValue(
        'image',
        loadedData['data']['user']['image'] ?? '',
      );
      await utilities.setSharedPrefValue(
        'name',
        loadedData['data']['user']['first_name'].toString() +
            ' ' +
            (loadedData['data']['user']['last_name'] ?? '').toString(),
      );

      utilities.showToast('success');
      return loadedData;
    } else if (loadedData['success'] == false) {
      print('error vialidate ${loadedData['data']['resendId']}');
      await utilities.setSharedPrefValue(
          'validate', await getResendOTPOrOTPValue('validate'));
      await utilities.setSharedPrefValue(
          'uniqueId', loadedData['data']['resendId']);
      utilities.showToast(loadedData['message'].toString());
      return loadedData;
    }
  }

  Future<dynamic> resendOTPRequest(String uniqueId) async {
    print('in req');
    final response = await http.post(
        Uri.parse(
          Utilities.baseUrl + 'resend-otp',
        ),
        headers: Utilities.header,
        body: {
          'uniqueId': uniqueId,
        });
    print(uniqueId);

    print(response.statusCode);
    if (response.statusCode == 200) {
      final loadedResponse = json.decode(response.body);
      print('200');
      print(loadedResponse);
      await Utilities().setSharedPrefValue(
          'resendOTP', await getResendOTPOrOTPValue('resendOTP'));
      await utilities.setSharedPrefValue('validate', '0');
      print(await utilities.getSharedPreferenceValue('validate'));
      await utilities.setSharedPrefValue(
          'uniqueId', loadedResponse['uniqueId']);
      return loadedResponse;
      //return loadedResponse['id'].toString();
    } else {
      return null;
    }
  }

  getResendOTPOrOTPValue(String key) async {
    String value =
        (int.parse(await utilities.getSharedPreferenceValue(key)) + 1)
            .toString();
    print('$key : $value');
    return value;
  }
}
