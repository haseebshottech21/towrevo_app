import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/main.dart';
import 'package:towrevo/models/models.dart';
import 'package:towrevo/screens/company/company_notification_utility/company_side_notification_handler.dart';
import 'package:towrevo/screens/company/company_payment_screen.dart';
import 'package:towrevo/screens/company/company_unverified_screen.dart';
import 'package:towrevo/screens/screens.dart';
import 'package:towrevo/utilities/utilities.dart';
import 'package:towrevo/web_services/company_web_service.dart';
import 'package:towrevo/web_services/user_web_service.dart';

class CompanyHomeScreenViewModel with ChangeNotifier {
  List<ServiceRequestModel> requestServiceList = [];
  List<ServiceRequestModel> onGoingRequestsList = [];

  final companyWebService = CompanyWebService();
  final userWebService = UserWebService();
  final utilities = Utilities();
  final compnayNotifiction = CompanySideNotificationHandler();
  bool isLoading = false;
  bool isSwitched = true;

  String isOnline = '0';
  changeLoadingStatus(bool loadingStatus) {
    isLoading = loadingStatus;
    notifyListeners();
  }

  checkOnlineStatus() async {
    isOnline = await utilities.getSharedPreferenceValue('is_online') ?? '0';
    if (isOnline == '0') {
      isSwitched = true;
    } else if (isOnline == '1') {
      isSwitched = false;
    }
    notifyListeners();
  }

  changeOnlineStatus(bool status, BuildContext context) async {
    if (!(await utilities.isInternetAvailable())) {
      return null;
    }
    bool oldStatus = status;
    isSwitched = status;
    notifyListeners();
    dynamic success =
        await setOnlineStatus(status ? MyApp.notifyToken : '', context);
    if (success == null) {
      isSwitched = oldStatus;
      notifyListeners();
    }
  }

  Future<void> getRequests(BuildContext context) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);
    requestServiceList = [];
    // print(requestServiceList);
    final loadedResponse = await companyWebService.requestsOfUser('0', context);
    if (loadedResponse.isNotEmpty) {
      requestServiceList = loadedResponse;
    }
    changeLoadingStatus(false);
  }

  Future<bool?> setOnlineStatus(String token, BuildContext context) async {
    final loadedResponse =
        await companyWebService.setOnlineStatusRequest(token, context);
    if (loadedResponse != null) {
      if (token.isEmpty) {
        await utilities.setSharedPrefValue('is_online', '1');
        isSwitched = false;
        isOnline == '1';
      } else {
        await utilities.setSharedPrefValue('is_online', '0');
        isSwitched = true;
        isOnline == '0';
      }
      return true;
    } else {
      return null;
    }
  }

  Future<void> verifiedStatusCheck(BuildContext context) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }

    final loadResponse = await companyWebService.verificationStatus();
    if (loadResponse != null) {
      // print('status: ${loadResponse['status']}');
      if (loadResponse['status'] == '0' || loadResponse['status'] == '3') {
        Navigator.of(context).pushNamed(
          CompanyVerificationRequest.routeName,
          arguments: loadResponse['status'],
        );
      } else if (loadResponse['status'] == '1') {
        Utilities().setSharedPrefValue('verified', loadResponse['status']);
      }
    }
  }

  getVerified(BuildContext context) async {
    final verified = await Utilities().getSharedPreferenceValue('verified');
    print('Company Status: $verified');

    if (verified == null ||
        verified == '' ||
        verified == '0' ||
        verified == '3') {
      verifiedStatusCheck(context);
    } else {
      print('Verified Success!');
    }
    notifyListeners();
  }

  Future<void> paymentStatusCheck(BuildContext context) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }

    int? loadedResponseCode =
        await companyWebService.paymentStatusCheckRequest();

    if (loadedResponseCode != null) {
      if (loadedResponseCode == 403 || loadedResponseCode == 401) {
        Navigator.of(context).pushNamed(
          CompanyPaymentScreen.routeName,
          arguments: loadedResponseCode,
        );
      }
    }
  }

  List<ServiceRequestModel> companyHistoryList = [];

  Future<void> getCompanyHistrory(BuildContext context) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);
    companyHistoryList = [];
    final loadedResponse =
        await companyWebService.requestsOfUser('', context, history: true);
    if (loadedResponse.isNotEmpty) {
      companyHistoryList = loadedResponse.reversed.toList();
    }
    changeLoadingStatus(false);
  }

  Future<void> getOnGoingRequests(BuildContext context) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);
    onGoingRequestsList = [];
    final loadedResponse = await companyWebService.requestsOfUser('1', context);
    if (loadedResponse.isNotEmpty) {
      onGoingRequestsList = loadedResponse;
    }
    changeLoadingStatus(false);
  }

  // bool soundStop = false;

  Future<void> acceptDeclineOrDone(
    String status,
    String requestId,
    BuildContext context, {
    bool getData = true,
    bool notRespond = false,
    required String notificationId,
  }) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    final companyProvider =
        Provider.of<CompanyHomeScreenViewModel>(context, listen: false);

    changeLoadingStatus(true);
    final loadedData =
        await companyWebService.acceptDeclineOrDone(status, requestId, context);
    changeLoadingStatus(false);
    if (loadedData != null) {
      if (status == '3') {
        companyProvider.getOnGoingRequests(context);
        notifyListeners();
        await userWebService.sendNotification(
          'Job Complete',
          'Your Job has been Completed',
          notificationId,
          'complete',
          requestId: requestId,
        );
        Navigator.of(context).pop();
      } else {
        if (getData) {
          companyProvider.getRequests(context);
          notifyListeners();
        } else if (!getData) {
          if (notRespond) {
            userWebService.sendNotification(
              'Time Delayed',
              'Request Time Over',
              notificationId,
              'decline_from_user',
            );
          }
        }
        if (status == '2' && !notRespond) {
          await Future.delayed(const Duration(seconds: 1)).then(
            (value) {
              CompanySideNotificationHandler.player.stop();
            },
          );
          await userWebService.sendNotification(
            'Request Decline',
            'Company Declined Your Request',
            notificationId,
            'decline_from_company',
          );
        } else if (status == '1') {
          await Future.delayed(const Duration(seconds: 1)).then(
            (value) {
              CompanySideNotificationHandler.player.stop();
            },
          );
          await userWebService.sendNotification(
            'Request Accepted',
            'Company Accepted Your Request',
            notificationId,
            'accept',
            requestId: requestId,
          );
        }
      }
    }
  }

  Future<void> payNow({
    required String transactionId,
    required String amount,
    required String couponId,
    required BuildContext context,
  }) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);

    final loadedResponse =
        await companyWebService.payNowRequest(transactionId, amount, couponId);
    if (loadedResponse != null) {
      await getRequests(context);
      Navigator.of(context).pop();
    }
    changeLoadingStatus(false);
  }
}
