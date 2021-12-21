import 'package:flutter/cupertino.dart';
import 'package:towrevo/web_services/edit_profile_web_service.dart';

class EditProfileViewModel with ChangeNotifier {
  Map body = {};

  Future<void> getEditData() async {
    body = {};
    final loadedData = await EditProfileWebService().getEditFields();

    if (loadedData != null) {
      body = loadedData;
    } else {
      body = {};
    }
    notifyListeners();
  }

  Future<void> changePassword(
      String password, String confirmPassword, BuildContext context) async {
    final loadedData = await EditProfileWebService().changePassword(
      password,
      confirmPassword,
    );
    if (loadedData != null) {
      Navigator.of(context).pop();
    }
  }

  Future<void> editProfileFields(Map<String, String> body) async {
    final loadedData = await EditProfileWebService().editProfileFields(body);
  }
}
