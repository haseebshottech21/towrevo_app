
import 'package:flutter/cupertino.dart';
import 'package:towrevo/models/company_model.dart';
import 'package:towrevo/web_services/home_web_service.dart';

class UserHomeScreenViewModel with ChangeNotifier{

  Map<String,String> body ={
    'longitude' : '',
    'latitude' : '',
    'time' : '',
    'day' : '',
    'service' : ''
  };

  List<CompanyModel> list =[];
  bool isLoading =false;

  Future<void> getCompanies(Map<String,String> requestedBody)async{

    list =[];
    isLoading = true;
    notifyListeners();

    list = await HomeWebService().getCompaniesList(requestedBody);
    isLoading = false;
    notifyListeners();

  }

  Future<void> requestToCompany(String serviceId,String companyId,String notificationId)async{
    isLoading = false;
    notifyListeners();
    await HomeWebService().sendRequestToCompany(serviceId, companyId, notificationId);
  }

}