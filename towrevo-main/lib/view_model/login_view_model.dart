import 'package:flutter/cupertino.dart';
import 'package:towrevo/screens/authentication/forgot_password/forgot_password_otp.dart';
import 'package:towrevo/screens/authentication/login/login_screen.dart';
import 'package:towrevo/web_services/authentication.dart';

class LoginViewModel with ChangeNotifier {
  bool isRememberChecked = false;

  toggleRemember() {
    isRememberChecked = !isRememberChecked;
    notifyListeners();
  }

  bool obscurePassword = true;

  toggleObscure() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<bool> loginRequest(String email, String password) async {
    bool result = await AuthenticationWebService().login(email, password);
    return result;
  }

  Future<void> logoutRequest(BuildContext context) async {
    final loadedData = await AuthenticationWebService().logout();
    if (loadedData) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
    }
  }

  String token = '';

  Future<void> forgotPassword(String email, BuildContext context) async {
    final loadedData = await AuthenticationWebService().forgotPassword(email);
    if (loadedData != null) {
      token = loadedData['data']['token'].toString();
      Navigator.of(context)
          .pushNamed(ForgotPasswordOTP.routeName, arguments: email);
    }
  }

  Future<void> sendOTP(String otp, String token, String password,
      String confirmationPassword, BuildContext context) async {
    final loadedData = await AuthenticationWebService()
        .validateOTPAndResetPassword(
            token, password, confirmationPassword, otp);
    if (loadedData != null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
    }
  }
}
