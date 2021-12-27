import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/main.dart';
import 'package:towrevo/view_model/otp_view_model.dart';
import 'package:towrevo/web_services/authentication.dart';
import '../utilities.dart';

class RegisterCompanyViewModel with ChangeNotifier {
  bool isCheckedTermsAndCondition = false;

  Map<String, dynamic> body = {
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
    'transaction_id': '',
    'days': [],
    'services': [],
    'notification_id': MyApp.notifyToken,
    'image': '',
    // 'from_day' : '',
    // 'to_day' : '',
  };

  // String uniqueId ='';

  Future<bool> registerCompany(BuildContext context) async {
    // uniqueId = '';
    final responseBody = await AuthenticationWebService().signUpCompany(body);
    final otpProvider = Provider.of<OTPViewModel>(context, listen: false);
    print(responseBody);
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

  bool obscurePassword = false;

  toggleObscure() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  bool obscureConfirmPassword = false;

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

  // filterDays(int index,String key){
  //   daysList[index] = {
  //     key: !daysList[index].values.first
  //   };
  //   notifyListeners();
  // }

  // List<dynamic> filterDays(List<DaysModel> list){
  //   List<dynamic> daysList= list.map((day){
  //     return day.dayAvailable?day.id;
  //   }).toList();
  //
  //   return daysList;
  // }

  String imagePath = '';
  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath = image.path;
      print(image.path);
      body['extension'] = image.path.split('.').last;
      body['image'] = base64Encode(await File(image.path).readAsBytes());
      notifyListeners();
    }
  }
}
