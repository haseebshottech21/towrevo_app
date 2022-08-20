import 'package:flutter/cupertino.dart';
import 'package:towrevo/screens/authentication/forgot_password/forgot_password_otp_screen.dart';
import 'package:towrevo/screens/authentication/login/login_screen.dart';
import 'package:towrevo/web_services/authentication.dart';
import '../utilities/utilities.dart';

class LoginViewModel with ChangeNotifier {
  bool isRememberChecked = false;
  bool isLoading = false;
  Utilities utilities = Utilities();
  AuthenticationWebService authenticationWebService =
      AuthenticationWebService();
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
    if (!(await utilities.isInternetAvailable())) {
      return false;
    }
    changeLoadingStatus(true);
    bool result = await authenticationWebService.login(
        email, password, isRememberChecked);
    changeLoadingStatus(false);
    return result;
  }

  Future<void> logoutRequest(BuildContext context) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);
    final loadedData = await authenticationWebService.logout();
    changeLoadingStatus(false);
    if (loadedData) {
      // CompanySideNotificationHandler.musicCache.clearAll();
      // CompanySideNotificationHandler.instance.stop();
      // CompanySideNotificationHandler.instance.dispose();
      Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
        LoginScreen.routeName,
        (route) => false,
      );
    }
  }

  String token = '';

  Future<void> forgotPassword(String email, BuildContext context) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);
    final loadedData = await authenticationWebService.forgotPassword(email);
    changeLoadingStatus(false);
    if (loadedData != null) {
      token = loadedData['data']['token'].toString();
      Navigator.of(context)
          .pushNamed(ForgotPasswordOTPScreen.routeName, arguments: email);
    }
  }

  Future<void> sendOTP(String otp, String token, String password,
      String confirmationPassword, BuildContext context) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);
    final loadedData =
        await authenticationWebService.validateOTPAndResetPassword(
            token, password, confirmationPassword, otp);
    changeLoadingStatus(false);
    if (loadedData != null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
    }
  }
}
