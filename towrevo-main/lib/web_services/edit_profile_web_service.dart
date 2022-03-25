import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:towrevo/utilities/utilities.dart';

class EditProfileWebService {
  Future<dynamic> getEditFields() async {
    try {
      final response = await http.get(
        Uri.parse(Utilities.baseUrl + 'user'),
        headers: await Utilities().headerWithAuth(),
      );
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200) {
        return loadedData;
      } else {
        return null;
      }
    } catch (e) {
     Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  Future<dynamic> changePassword(
      String password, String confirmPassword) async {
    try {
      final response = await http.post(
          Uri.parse(Utilities.baseUrl + 'password'),
          headers: await Utilities().headerWithAuth(),
          body: {
            'password': password,
            'password_confirmation': confirmPassword
          });
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Successfully Updated');

        return loadedData;
      } else {
        Fluttertoast.showToast(msg: loadedData['errors'].toString());
        return null;
      }
    } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<dynamic> editProfileFields(Map<String, String> body) async {
    try {
      final response = await http.post(Uri.parse(Utilities.baseUrl + 'update'),
          headers: await Utilities().headerWithAuth(), body: body);
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Successfully Updated');

        return loadedData;
      } else {
        Fluttertoast.showToast(msg: 'Failed');
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
