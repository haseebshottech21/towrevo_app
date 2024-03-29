import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:towrevo/main.dart';
import 'package:towrevo/utilities/utilities.dart';

class AuthenticationWebService {
  final utilities = Utilities();
  Future<dynamic> signUpCompany(Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse(Utilities.baseUrl + 'register'),
        body: body,
        headers: Utilities.header,
      );

      final loadedData = json.decode(response.body);

      print(response);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: loadedData['message'].toString(),
        );

        print(loadedData);
        await utilities.setSharedPrefValue(
            'uniqueId', loadedData['data']['uniqueId']);
        await utilities.setSharedPrefValue('validate', '0');
        await utilities.setSharedPrefValue('resendOTP', '0');

        return loadedData;
      } else {
        Fluttertoast.showToast(msg: signUpErrorHandle(loadedData));
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> updateVerificationCompany(Map<String, dynamic> body) async {
    // try {
    final response = await http.post(
      Uri.parse(Utilities.baseUrl + 'update-complete-info'),
      body: body,
      headers: await Utilities().headerWithAuth(),
    );
    // print(response.body);
    final loadedData = json.decode(response.body);

    // print(response.statusCode);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: loadedData['message'].toString());

      return loadedData;
    } else {
      Fluttertoast.showToast(msg: loadedData['message'].toString());
      return null;
    }
  }

  Future<bool> login(String email, String password, bool remember) async {
    try {
      final response = await http.post(
        Uri.parse(Utilities.baseUrl + 'login'),
        body: {
          'email': email,
          'password': password,
          'notification_id': MyApp.notifyToken,
        },
        headers: Utilities.header,
      );

      // print(response.statusCode);

      final responseLoaded = json.decode(response.body);

      if (response.statusCode == 200) {
        await utilities.setUserDataToLocalStorage(responseLoaded['data']);

        if (remember) {
          await utilities.setSharedPrefValue('remember_email', email);
          await utilities.setSharedPrefValue('remember_password', password);
        } else {
          await utilities.removeSharedPreferenceValue('remember_email');
          await utilities.removeSharedPreferenceValue('remember_password');
        }
        Fluttertoast.showToast(msg: 'Successfully Logged In');
        return true;
      } else {
        Fluttertoast.showToast(msg: responseLoaded['message'].toString());
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      // print(e.toString());
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      final response = await http.post(Uri.parse(Utilities.baseUrl + 'logout'),
          headers: await Utilities().headerWithAuth());
      final loadedResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Successfully Logout');
        await utilities.removeAll();
        return true;
      } else {
        Fluttertoast.showToast(msg: loadedResponse['message'].toString());
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }
  }

  Future<dynamic> validateOTPAndResetPassword(
    String token,
    String password,
    String confirmPassword,
    String otp,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(Utilities.baseUrl + 'reset-password'),
        body: {
          'token': token,
          'otp': otp,
          'password': password,
          'password_confirmation': confirmPassword,
        },
        headers: Utilities.header,
      );

      final loadedData = json.decode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: loadedData['message'].toString());
        return loadedData;
      } else {
        Fluttertoast.showToast(msg: loadedData['errors'].toString());
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<dynamic> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse(Utilities.baseUrl + 'forgot-password'),
        body: {
          'email': email,
        },
        headers: Utilities.header,
      );

      final loadedData = json.decode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: loadedData['message'].toString());

        return loadedData;
      } else {
        if (response.statusCode == 422) {
          Fluttertoast.showToast(msg: loadedData['errors']['email'].toString());
        }

        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<dynamic> contactUsRequest(String description) async {
    try {
      final response = await http.post(
        Uri.parse(Utilities.baseUrl + 'contact'),
        body: {
          'text': description,
        },
        headers: await Utilities().headerWithAuth(),
      );

      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(msg: loadedData['message'].toString());

        return loadedData;
      } else {
        Fluttertoast.showToast(msg: loadedData['message'].toString());
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<dynamic> deleteMyAccount(String reason) async {
    try {
      final response = await http.post(
        Uri.parse(Utilities.baseUrl + 'delete-user'),
        body: {'reason': reason},
        headers: await Utilities().headerWithAuth(),
      );

      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(msg: loadedData['message'].toString());

        return loadedData;
      } else {
        Fluttertoast.showToast(msg: loadedData['message'].toString());
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  String signUpErrorHandle(Map<String, dynamic> body) {
    var errorMessage = '';
    if (body['errors']['email'] != null) {
      for (var error in body['errors']['email']) {
        errorMessage += error + '\n';
      }
    }
    if (body['errors']['phone'] != null) {
      for (var error in body['errors']['phone']) {
        errorMessage += error + '\n';
      }
    }
    if (body['errors']['notification_id'] != null) {
      for (var error in body['errors']['notification_id']) {
        errorMessage += error + '\n';
      }
    }
    if (body['errors']['from'] != null) {
      for (var error in body['errors']['from']) {
        errorMessage += error + '\n';
      }
    }
    if (body['errors']['to'] != null) {
      for (var error in body['errors']['from']) {
        errorMessage += error + '\n';
      }
    }
    if (body['errors']['ein_number'] != null) {
      for (var error in body['errors']['ein_number']) {
        errorMessage += error + '\n';
      }
    }
    return errorMessage.trim();
  }
}
