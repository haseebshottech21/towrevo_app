import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/models/service_request_model.dart';
import 'package:towrevo/utilities.dart';
import 'package:towrevo/web_services/company_web_service.dart';

class CompanyHomeScreenViewModel with ChangeNotifier {
  List<ServiceRequestModel> requestServiceList = [];
  List<ServiceRequestModel> onGoingRequestsList = [];
  bool isLoading = true;

  Future<void> getRequests() async {
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

  Future<void> getOnGoingRequests() async {
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
      String type, String requestId, BuildContext context) async {
    final loadedData =
        await CompanyWebService().acceptDeclineOrDone(type, requestId);
    if (loadedData != null) {
      print(loadedData);
      if (type == '3') {
        Provider.of<CompanyHomeScreenViewModel>(context, listen: false)
            .getOnGoingRequests();
        notifyListeners();
        Navigator.of(context).pop();
      } else {
        Provider.of<CompanyHomeScreenViewModel>(context, listen: false)
            .getRequests();
        notifyListeners();
      }
    } else {
      Utilities().showToast('Something Went Wrong');
    }
  }
}
