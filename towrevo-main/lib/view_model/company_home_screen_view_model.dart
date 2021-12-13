import 'package:flutter/cupertino.dart';
import 'package:towrevo/models/service_request_model.dart';
import 'package:towrevo/web_services/company_web_service.dart';

class CompanyHomeScreenViewModel with ChangeNotifier{

  List<ServiceRequestModel> requestServiceList = [];
  bool isLoading = true;

  Future<void> getRequests()async{
    isLoading = true;
    notifyListeners();
    requestServiceList = [];
   final loadedResponse =  await CompanyWebService().requestForRequestOfUser();
   if(loadedResponse.isNotEmpty){
    requestServiceList = loadedResponse;
   }
   isLoading = false;
   notifyListeners();
  }

}