import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/web_services/authentication.dart';

import 'otp_view_model.dart';

class RegisterUserViewModel with ChangeNotifier {
  bool isCheckedTermsAndCondition = false;

  Future<bool> userSignUp(
      Map<String, String> body, BuildContext context) async {
    final responseBody = await AuthenticationWebService().signUpCompany(body);
    final otpProvider = Provider.of<OTPViewModel>(context, listen: false);

    print(responseBody);
    if (responseBody != null) {
      // print(responseBody['data']['uniqueId']);
      otpProvider.resendUniqueId = responseBody['data']['uniqueId'];
      return true;
    } else {
      otpProvider.resendUniqueId = '';
      return false;
    }
  }

  toggleTermsAndCondition() {
    isCheckedTermsAndCondition = !isCheckedTermsAndCondition;
    notifyListeners();
  }

  bool obscurePassword = true;

  toggleObscure() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  initializeValues() {
    obscureConfirmPassword = true;
    isCheckedTermsAndCondition = false;
    obscurePassword = true;
    imagePath = '';
    extension = '';
    image = '';
  }

  bool obscureConfirmPassword = true;

  toggleObscureConfirm() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  String imagePath = '';
  String extension = '';
  String image = '';

  Future<void> pickImage() async {
    final imageObject =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath = imageObject!.path;
      extension = imageObject.path.split('.').last;
      image = base64Encode(await File(imageObject.path).readAsBytes());
      notifyListeners();
    }
  }
}
