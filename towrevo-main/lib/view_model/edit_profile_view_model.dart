import 'package:flutter/cupertino.dart';
import 'package:towrevo/web_services/edit_profile_web_service.dart';

class EditProfileViewModel with ChangeNotifier {
  Map body = {};

  Future<void> getEditData() async {
    final loadedData = await EditProfileWebService().getEditFields();
  }

  Future<void> changePassword(String password, String confirmPassword) async {
    final loadedData = await EditProfileWebService().changePassword(
      password,
      confirmPassword,
    );
  }

  Future<void> editProfileFields(Map<String, String> body) async {
    final loadedData = await EditProfileWebService().editProfileFields(body);
  }
}
