import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:towrevo/utilities.dart';

class EditProfileWebService {
  Future<dynamic> getEditFields() async {
    final response = await http.get(
      Uri.parse(Utilities.baseUrl + 'user'),
      headers: await Utilities().headerWithAuth(),
    );
    final loadedData = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return loadedData;
    } else {
      print(response.body);
      return null;
    }
  }

  Future<dynamic> changePassword(
      String password, String confirmPassword) async {
    final response = await http.post(Uri.parse(Utilities.baseUrl),
        headers: await Utilities().headerWithAuth(),
        body: {'password': password, 'confirmation_password': confirmPassword});
    final loadedData = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return loadedData;
    } else {
      print(response.body);
      return null;
    }
  }

  Future<dynamic> editProfileFields(Map<String, String> body) async {
    final response = await http.post(Uri.parse(Utilities.baseUrl),
        headers: await Utilities().headerWithAuth(), body: body);
    final loadedData = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return loadedData;
    } else {
      print(response.body);
      return null;
    }
  }
}
