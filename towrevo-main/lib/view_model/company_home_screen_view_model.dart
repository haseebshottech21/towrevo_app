import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/main.dart';
import 'package:towrevo/models/models.dart';
// import 'package:towrevo/models/payment_model.dart';
import 'package:towrevo/screens/company/company_payment_screen.dart';
import 'package:towrevo/utilities/utilities.dart';
import 'package:towrevo/web_services/company_web_service.dart';
import 'package:towrevo/web_services/user_web_service.dart';

class CompanyHomeScreenViewModel with ChangeNotifier {
  List<ServiceRequestModel> requestServiceList = [];
  List<ServiceRequestModel> onGoingRequestsList = [];
  Map<String, dynamic> couponModel = {};
  final companyWebService = CompanyWebService();
  final userWebService = UserWebService();
  final utilities = Utilities();
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

  changeOnlineStatus(bool status) async {
    if (!(await utilities.isInternetAvailable())) {
      return null;
    }
    bool oldStatus = status;
    isSwitched = status;
    notifyListeners();
    dynamic success = await setOnlineStatus(status ? MyApp.notifyToken : '');
    if (success == null) {
      isSwitched = oldStatus;
      notifyListeners();
    }
  }

  Future<void> getRequests() async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);
    requestServiceList = [];
    final loadedResponse = await companyWebService.requestsOfUser('0');
    if (loadedResponse.isNotEmpty) {
      requestServiceList = loadedResponse;
    }
    changeLoadingStatus(false);
  }

  Future<bool?> setOnlineStatus(String token) async {
    final loadedResponse =
        await companyWebService.setOnlineStatusRequest(token);
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

  Future<void> paymentStatusCheck(BuildContext context) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }

    bool? loadedResponse = await companyWebService.paymentStatusCheckRequest();
    if (loadedResponse != null) {
      if (!loadedResponse) {
        Navigator.of(context).pushNamed(CompanyPaymentScreen.routeName);
      }
    }
  }

  List<ServiceRequestModel> companyHistoryList = [];

  Future<void> getCompanyHistrory() async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);
    companyHistoryList = [];
    final loadedResponse =
        await companyWebService.requestsOfUser('', history: true);
    if (loadedResponse.isNotEmpty) {
      companyHistoryList = loadedResponse.reversed.toList();
    }
    changeLoadingStatus(false);
  }

  Future<void> getOnGoingRequests() async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);
    onGoingRequestsList = [];
    final loadedResponse = await companyWebService.requestsOfUser('1');
    if (loadedResponse.isNotEmpty) {
      onGoingRequestsList = loadedResponse;
    }
    changeLoadingStatus(false);
  }

  Future<void> acceptDeclineOrDone(
    String type,
    String requestId,
    BuildContext context, {
    bool getData = true,
    required String notificationId,
  }) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    final companyProvider =
        Provider.of<CompanyHomeScreenViewModel>(context, listen: false);

    changeLoadingStatus(true);
    final loadedData =
        await companyWebService.acceptDeclineOrDone(type, requestId);
    changeLoadingStatus(false);
    if (loadedData != null) {
      if (type == '3') {
        companyProvider.getOnGoingRequests();
        notifyListeners();
        await userWebService.sendNotification('Job Complete',
            'Your Job Has Been Compataed', notificationId, 'complete',
            requestId: requestId);
        Navigator.of(context).pop();
      } else {
        if (getData) {
          companyProvider.getRequests();
          notifyListeners();
        } else if (!getData) {
          userWebService.sendNotification('Decline', 'Request Time Over',
              notificationId, 'decline_from_user');
        }
        if (type == '2') {
          userWebService.sendNotification(
              'Decline',
              'Company Declined Your Request',
              notificationId,
              'decline_from_company');
        } else if (type == '1') {
          userWebService.sendNotification(
            'Accepted',
            'Your Request has been accepted',
            notificationId,
            'accept',
            requestId: requestId,
          );
        }
      }
    }
  }

  Future<void> payNow(
      String transactionId, String amount, BuildContext context) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);

    final loadedResponse =
        await companyWebService.payNowRequest(transactionId, amount);
    if (loadedResponse != null) {
      await getRequests();
      Navigator.of(context).pop();
    }
    changeLoadingStatus(false);
  }
}
