import 'package:flutter/cupertino.dart';
import 'package:towrevo/models/days_model.dart';
import 'package:towrevo/models/services_model.dart';
import 'package:towrevo/web_services/services_web_service.dart';

import '../utilities.dart';

class ServicesAndDaysViewModel with ChangeNotifier {
  List<DaysModel> daysListViewModel = [
    DaysModel(id: '1', name: 'Monday'),
    DaysModel(id: '2', name: 'Tuesday'),
    DaysModel(id: '3', name: 'Wednesday'),
    DaysModel(id: '4', name: 'Thursday'),
    DaysModel(id: '5', name: 'Friday'),
    DaysModel(id: '6', name: 'Saturday'),
    DaysModel(id: '7', name: 'Sunday'),
  ];

  initializeValues() {
    for (var element in daysListViewModel) {
      element.dayAvailable = false;
    }
  }

  bool isLoading = false;
  changeLoadingStatus(bool loadingStatus) {
    isLoading = loadingStatus;
    notifyListeners();
  }

  List<ServicesModel> serviceListViewModel = [];
  List<String> daysId = [];
  List<String> servicesId = [];
  String? serviceSelectedValue;

  Future<void> getServices() async {
    if (!(await Utilities().isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);
    serviceListViewModel = [];
    serviceListViewModel = await ServicesWebService().getServices();
    changeLoadingStatus(false);
  }

  Future<void> setServicesAndDaysSelectedWhileCompamyEditOperationPerform(
    List<dynamic> serviceList,
    List<dynamic> daysList,
  ) async {
    daysId.clear();
    servicesId.clear();
    for (var item in serviceList) {
      serviceListViewModel.firstWhere((element) {
        if (element.id == item['id'].toString()) {
          servicesId.add(element.id);
        }
        return element.id == item['id'].toString();
      }).serviceAvailable = true;
    }

    for (var item in daysList) {
      daysListViewModel.firstWhere((element) {
        if (element.id == item['id'].toString()) {
          daysId.add(element.id);
        }
        return element.id == item['id'].toString();
      }).dayAvailable = true;
    }
  }

  void changeServiceSelectedValue(String value) {
    serviceSelectedValue = value;
    notifyListeners();
  }

  void clearDaysList() {
    daysId.clear();
    for (var days in daysListViewModel) {
      days.dayAvailable = false;
    }
    notifyListeners();
  }

  void clearServicesList() {
    servicesId.clear();
    for (var days in serviceListViewModel) {
      days.serviceAvailable = false;
    }
    notifyListeners();
  }

  String getDays() {
    String days = '';
    for (var item in daysListViewModel) {
      if (item.dayAvailable) {
        days += ' ' + item.name;
      }
    }
    return days.isEmpty ? 'Select Days' : days;
  }

  String getService() {
    String services = '';
    for (var item in serviceListViewModel) {
      if (item.serviceAvailable) {
        services += ' ' + item.name;
      }
    }
    return services.isEmpty ? 'Select Categories' : services;
  }

  notify() {
    notifyListeners();
  }
}
