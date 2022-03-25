import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/main.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/web_services/authentication.dart';
import '../utilities/utilities.dart';

class RegisterCompanyViewModel with ChangeNotifier {
  bool isCheckedTermsAndCondition = false;
  bool isLoading = false;
  String? selectedState;
  String? selectedCity;

  changeState(String newValue) {
    selectedState = newValue.toString();
    body['state'] = newValue.toString();
    selectedCity = null;

    notifyListeners();
  }

  changeCity(String newValue) {
    selectedCity = newValue.toString();
    body['city'] = newValue.toString();
    notifyListeners();
  }

  changeLoadingStatus(bool loadingStatus) {
    isLoading = loadingStatus;
    notifyListeners();
  }

  Map<String, dynamic> body = {
    'state': '',
    'city': '',
    'first_name': '',
    'description': '',
    'type': '2',
    'email': '',
    'phone': '',
    'password': '',
    'password_confirmation': '',
    'latitude': '',
    'longitude': '',
    'from': '',
    'to': '',
    'extension': '',
    'days': [],
    'services': [],
    'notification_id': MyApp.notifyToken,
    'image': '',
  };

  Future<bool> registerCompany(BuildContext context) async {
    if (!(await Utilities().isInternetAvailable())) {
      return false;
    }

    changeLoadingStatus(true);
    final responseBody = await AuthenticationWebService().signUpCompany(body);
    final otpProvider = Provider.of<OTPViewModel>(context, listen: false);
    changeLoadingStatus(false);

    if (responseBody != null) {
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

  initializeValues() {
    obscurePassword = true;
    obscureConfirmPassword = true;
    isCheckedTermsAndCondition = false;

    timerValues = {
      'from': '',
      'to': '',
    };
    selectedCity = null;
    selectedState = null;
  }

  initalizeImageValues() {
    imagePath = '';
    body['image'] = '';
    body['extension'] = '';
  }

  bool obscurePassword = true;

  toggleObscure() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  bool obscureConfirmPassword = true;

  toggleObscureConfirm() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  Map<String, String> timerValues = {
    'from': '',
    'to': '',
  };

  Future<void> setTimer(BuildContext context) async {
    final provider =
        Provider.of<RegisterCompanyViewModel>(context, listen: false);
    final time = await Utilities().setTimer(context);
    provider.body['from'] = time!['from']!;
    provider.body['to'] = time['to']!;
    timerValues = {
      'from': time['fromUtilize']!,
      'to': time['toUtilize']!,
    };
    notifyListeners();
  }

  String imagePath = '';
  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath = image.path;

      body['extension'] = image.path.split('.').last;
      body['image'] = base64Encode(await File(image.path).readAsBytes());
      notifyListeners();
    }
  }
}
