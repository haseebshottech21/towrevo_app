import 'package:flutter/cupertino.dart';
import 'package:towrevo/models/days_model.dart';
import 'package:towrevo/models/services_model.dart';
import 'package:towrevo/web_services/services_web_service.dart';


class ServicesAndDaysViewModel with ChangeNotifier{

  List<DaysModel> daysListViewModel=[
    DaysModel(id: '1', name: 'Monday'),
    DaysModel(id: '2', name: 'Tuesday'),
    DaysModel(id: '3', name: 'Wednesday'),
    DaysModel(id: '4', name: 'Thursday'),
    DaysModel(id: '5', name: 'Friday'),
    DaysModel(id: '6', name: 'Saturday'),
    DaysModel(id: '7', name: 'Sunday'),
  ];

  List<ServicesModel> serviceListViewModel=[];
  List<String> daysId=[];
  List<String> servicesId=[];
  String? serviceSelectedValue;


 Future<void> getServices() async {
   serviceListViewModel=[];
   serviceListViewModel = await ServicesWebService().getServices();
   print(serviceListViewModel);
   notifyListeners();
 }

 void changeServiceSelectedValue(String value){
    serviceSelectedValue = value;
    notifyListeners();
 }


  String getDays(){
    String days='';
    for (var item in daysListViewModel) {
      if(item.dayAvailable) {
        days += ' '+ item.name;
      }
    }
    return days.isEmpty?'Select Days':days;
  }

  String getService(){
    String services='';
    for (var item in serviceListViewModel) {
      if(item.serviceAvailable) {
        services += ' '+item.name;
      }
    }
    return services.isEmpty?'Select Categories':services;
  }

  notify(){
   notifyListeners();
  }

}