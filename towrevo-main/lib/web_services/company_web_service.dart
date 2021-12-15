import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:towrevo/models/service_request_model.dart';
import 'package:towrevo/utilities.dart';

class CompanyWebService {
  Future<List<ServiceRequestModel>> requestsOfUser(String type) async {
    print(Utilities.baseUrl + 'service-requests');
    print(type);
    final response = await http.post(
        Uri.parse(Utilities.baseUrl + 'service-requests/$type'),
        headers: await Utilities().headerWithAuth());
    print(response.body);
    final loadedData = json.decode(response.body);
    if (response.statusCode == 200) {
      List<ServiceRequestModel> list = (loadedData['data'] as List)
          .map((request) => ServiceRequestModel.fromJson(request))
          .toList();
      return list;
    } else {
      Utilities().showToast('error');
      return [];
    }
  }

  Future<dynamic> acceptDeclineOrDone(String status, String requestId) async {
    print(status);
    print('req id $requestId');
    final response = await http.post(
        Uri.parse(Utilities.baseUrl + 'respond-request'),
        headers: await Utilities().headerWithAuth(),
        body: {
          'request_id': requestId,
          'status': status,
        });
    print(response.statusCode == 200);
    print(response.body);
    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      return responseData;
    } else {
      return null;
    }
  }
}
