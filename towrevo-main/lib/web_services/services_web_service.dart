import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:towrevo/models/services_model.dart';
import 'package:towrevo/utilities.dart';
class ServicesWebService{
  Future<List<ServicesModel>> getServices() async{

    List<ServicesModel> serviceList =[];
    final response = await http.get(Uri.parse(Utilities.baseUrl+'services'),headers: Utilities.header,);
    final loadedData = jsonDecode(response.body);

    if(response.statusCode == 200){
      serviceList = (loadedData['data'] as List).map((service) => ServicesModel.fromJson(service)).toList();
      return serviceList;
    }else{
      return serviceList;
    }
  }

}