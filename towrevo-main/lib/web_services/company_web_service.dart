import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:towrevo/models/models.dart';
import 'package:towrevo/utitlites/utilities.dart';

class CompanyWebService {
  Future<List<ServiceRequestModel>> requestsOfUser(String type,
      {bool history = false}) async {
    print(Utilities.baseUrl + 'service-requests');
    print(type);
    final response = await http.post(
        Uri.parse(
            Utilities.baseUrl + 'service-requests${history ? '' : '/$type'}'),
        headers: await Utilities().headerWithAuth());
    print(response.body);
    final loadedData = json.decode(response.body);
    if (response.statusCode == 200) {
      List<ServiceRequestModel> list = (loadedData['data'] as List)
          .map((request) => ServiceRequestModel.fromJson(request))
          .toList();
      return list;
    } else {
      Utilities().showToast('Something Went Wrong');
      return [];
    }
  }

  Future<bool> paymentStatusCheckRequest() async {
    final response = await http.get(
        Uri.parse(Utilities.baseUrl + 'company-payment'),
        headers: await Utilities().headerWithAuth());
    print(response.body);
    final loadedData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      // Utilities().showToast('Something Went Wrong');
      return false;
    }
  }

  Future<dynamic> payNowRequest(String transactionId, String amount) async {
    final response = await http.post(
      Uri.parse(Utilities.baseUrl + 'payment'),
      body: {
        'transaction_id': transactionId,
        'amount': amount,
      },
      headers: await Utilities().headerWithAuth(),
    );
    print(response.body);
    final loadedData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Fluttertoast.showToast(msg: loadedData['message'].toString());
      return loadedData;
    } else {
      Fluttertoast.showToast(msg: loadedData['message'].toString());
      print(response.statusCode);
    }
  }

  Future<dynamic> setOnlineStatusRequest(String token) async {
    final response = await http.post(
      Uri.parse(
        Utilities.baseUrl + 'update-token',
      ),
      headers: await Utilities().headerWithAuth(),
      body: {'token': token},
    );
    print(response.body);
    final loadedData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return loadedData;
    } else {
      Utilities().showToast('Something Went Wrong');
      return null;
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
      },
    );

    print(response.body);
    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      return responseData;
    } else {
      return null;
    }
  }
}
