import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:towrevo/models/models.dart';
import 'package:towrevo/utilities/utilities.dart';

class ServicesWebService {
  Future<List<ServicesModel>> getServices() async {
    try {
      List<ServicesModel> serviceList = [];
      final response = await http.get(
        Uri.parse(Utilities.baseUrl + 'services'),
        headers: Utilities.header,
      );
      final loadedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        serviceList = (loadedData['data'] as List)
            .map((service) => ServicesModel.fromJson(service))
            .toList();
        return serviceList;
      } else {
        return serviceList;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return [];
    }
  }
}
