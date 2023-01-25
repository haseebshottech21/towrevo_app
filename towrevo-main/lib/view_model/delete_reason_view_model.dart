import 'package:flutter/material.dart';

// import '../screens/authentication/login/login_screen.dart';
import '../screens/authentication/login/login_screen.dart';
import '../screens/delete_my_account.dart';
import '../utilities/utilities.dart';
import '../web_services/authentication.dart';

class DeleteViewModel extends ChangeNotifier {
  AuthenticationWebService authRepo = AuthenticationWebService();
  Utilities utilities = Utilities();

  int? selectRadio;
  String? reason;
  bool isLoading = false;

  changeLoadingStatus(bool loadingStatus) {
    isLoading = loadingStatus;
    notifyListeners();
  }

  List<CancelReasonModel> selectReasons = [
    CancelReasonModel(title: 'I get too many emails', isActive: false),
    CancelReasonModel(title: 'I have another TowRevo Account', isActive: false),
    CancelReasonModel(
        title: 'I don\'t understand how to use TowRevo', isActive: false),
    CancelReasonModel(
        title: 'Others - please tell us a bit more', isActive: false),
  ];

  selectRason({required int value, required int index}) {
    selectRadio = value;
    reason = selectReasons[index].title;
    notifyListeners();
  }

  submitReason({required TextEditingController controller}) {
    if (reason!.contains('Others - please tell us a bit more')) {
      reason = controller.text;
    }
    notifyListeners();
    // print(reason);
  }

  Future<void> deleteMyAccount({
    required BuildContext context,
  }) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    // Navigator.of(context).pop();
    changeLoadingStatus(true);
    if (reason != null) {
      final loadedData = await authRepo.deleteMyAccount(reason!);
      if (loadedData != null) {
        Future.delayed(Duration.zero).then((value) {
          changeLoadingStatus(false);
          Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
            LoginScreen.routeName,
            (route) => false,
          );
        });
      }
    } else {}
  }
}
