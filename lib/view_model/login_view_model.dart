import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:towrevo/web_services/authentication.dart';

class LoginViewModel with ChangeNotifier{
  bool isRememberChecked = false;

  toggleRemember(){
    isRememberChecked = !isRememberChecked;
    notifyListeners();
  }

  bool obscurePassword = false;

  toggleObscure(){
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<bool> loginRequest(String email,String password)async{
   bool result = await AuthenticationWebService().login(email,password);
   return result;
  }


}