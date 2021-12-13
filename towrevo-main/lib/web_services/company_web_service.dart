import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:towrevo/models/service_request_model.dart';
import 'package:towrevo/utilities.dart';
class CompanyWebService{

  Future<List<ServiceRequestModel>> requestForRequestOfUser ()async{
    print(Utilities.baseUrl+'service-requests');
    print(await Utilities().headerWithAuth());
   final response = await http.post(Uri.parse(Utilities.baseUrl+'service-requests'),headers: await Utilities().headerWithAuth());
   print(response.body);
    final loadedData = json.decode(response.body);
   if(response.statusCode == 200){
      List<ServiceRequestModel> list = (loadedData['data'] as List).map((request) => ServiceRequestModel.fromJson(request)).toList();
      return list;
   }else{
     Utilities().showToast('error');
     return [];
   }
  }
}