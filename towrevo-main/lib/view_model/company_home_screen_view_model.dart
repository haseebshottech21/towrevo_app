import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/models/service_request_model.dart';
import 'package:towrevo/utilities.dart';
import 'package:towrevo/web_services/company_web_service.dart';
import 'package:towrevo/web_services/user_web_service.dart';

class CompanyHomeScreenViewModel with ChangeNotifier {
  List<ServiceRequestModel> requestServiceList = [];
  List<ServiceRequestModel> onGoingRequestsList = [];
  bool isLoading = false;

  Future<void> getRequests() async {
    if (!(await Utilities().isInternetAvailable())) {
      return;
    }
    isLoading = true;
    notifyListeners();
    requestServiceList = [];
    final loadedResponse = await CompanyWebService().requestsOfUser('0');
    if (loadedResponse.isNotEmpty) {
      requestServiceList = loadedResponse;
    }
    isLoading = false;

    notifyListeners();
  }

  List<ServiceRequestModel> companyHistoryList = [];

  Future<void> getCompanyHistrory() async {
    if (!(await Utilities().isInternetAvailable())) {
      return;
    }
    isLoading = true;
    notifyListeners();
    companyHistoryList = [];
    final loadedResponse =
        await CompanyWebService().requestsOfUser('', history: true);
    if (loadedResponse.isNotEmpty) {
      companyHistoryList = loadedResponse.reversed.toList();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getOnGoingRequests() async {
    if (!(await Utilities().isInternetAvailable())) {
      return;
    }
    isLoading = true;
    notifyListeners();
    onGoingRequestsList = [];
    final loadedResponse = await CompanyWebService().requestsOfUser('1');
    if (loadedResponse.isNotEmpty) {
      onGoingRequestsList = loadedResponse;
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> acceptDeclineOrDone(
    String type,
    String requestId,
    BuildContext context, {
    bool getData = true,
    required String notificationId,
  }) async {
    if (!(await Utilities().isInternetAvailable())) {
      return;
    }
    final companyProvider =
        Provider.of<CompanyHomeScreenViewModel>(context, listen: false);

    final loadedData =
        await CompanyWebService().acceptDeclineOrDone(type, requestId);
    if (loadedData != null) {
      print(loadedData);
      if (type == '3') {
        companyProvider.getOnGoingRequests();
        notifyListeners();
        await UserWebService().sendNotification('Job Complete',
            'Your Job Has Been Compataed', notificationId, 'complete',
            requestId: requestId);
        Navigator.of(context).pop();
      } else {
        if (getData) {
          companyProvider.getRequests();
          notifyListeners();
        } else if (!getData) {
          UserWebService().sendNotification('Decline', 'Request Time Over',
              notificationId, 'decline_from_user');
        }
        if (type == '2') {
          UserWebService().sendNotification(
              'Decline',
              'Company Declined Your Request',
              notificationId,
              'decline_from_company');
        } else if (type == '1') {
          UserWebService().sendNotification(
            'Accepted',
            'Your Request has been accepted',
            notificationId,
            'accept',
            requestId: requestId,
          );
        }
      }
    } else {
      Utilities().showToast('Something Went Wrong');
    }
  }
}
