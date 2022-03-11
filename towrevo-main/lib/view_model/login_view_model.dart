import 'package:flutter/cupertino.dart';
import 'package:towrevo/screens/authentication/forgot_password/forgot_password_otp_screen.dart';
import 'package:towrevo/screens/authentication/login/login_screen.dart';
import 'package:towrevo/web_services/authentication.dart';
import '../utitlites/utilities.dart';

class LoginViewModel with ChangeNotifier {
  bool isRememberChecked = false;
  bool isLoading = false;
  changeLoadingStatus(bool loadingStatus) {
    isLoading = loadingStatus;
    notifyListeners();
  }

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
    if (!(await Utilities().isInternetAvailable())) {
      return false;
    }
    changeLoadingStatus(true);
    bool result = await AuthenticationWebService()
        .login(email, password, isRememberChecked);
    changeLoadingStatus(false);
    return result;
  }

  Future<void> logoutRequest(BuildContext context) async {
    if (!(await Utilities().isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);
    final loadedData = await AuthenticationWebService().logout();
    changeLoadingStatus(false);
    if (loadedData) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
    }
  }

  String token = '';

  Future<void> forgotPassword(String email, BuildContext context) async {
    if (!(await Utilities().isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);
    final loadedData = await AuthenticationWebService().forgotPassword(email);
    changeLoadingStatus(false);
    if (loadedData != null) {
      token = loadedData['data']['token'].toString();
      Navigator.of(context)
          .pushNamed(ForgotPasswordOTPScreen.routeName, arguments: email);
    }
  }

  Future<void> sendOTP(String otp, String token, String password,
      String confirmationPassword, BuildContext context) async {
    if (!(await Utilities().isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);
    final loadedData = await AuthenticationWebService()
        .validateOTPAndResetPassword(
            token, password, confirmationPassword, otp);
    changeLoadingStatus(false);
    if (loadedData != null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
    }
  }
}
