import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:towrevo/models/company_model.dart';
import 'package:towrevo/models/user_history_model.dart';
import 'package:towrevo/utilities.dart';

class UserWebService {
  Future<List<CompanyModel>> getCompaniesList(Map<String, String> body) async {
    // print(Utilities.baseUrl + 'companies');
    print(body);
    // print(await Utilities().headerWithAuth());
    final response = await http.post(
      Uri.parse(Utilities.baseUrl + 'companies'),
      // body: body,
      body: {
        'longitude': '-119.417931',
        'latitude': '36.778259',
        'time': '10:50',
        'day': '1',
        'service': '1'
      },
      headers: await Utilities().headerWithAuth(),
    );
    // print(response.body);
    // print(response.statusCode);
    List<CompanyModel> companiesList = [];
    if (response.statusCode == 200) {
      final loadedData = json.decode(response.body);
      for (var company in loadedData['data']) {
        companiesList.add(CompanyModel.fromJson(company));
      }
      print(companiesList.length);
      return companiesList;
    } else {
      return [];
    }
  }

  Future<dynamic> sendRequestToCompany(
      String longitude,
      String latitude,
      String address,
      String serviceId,
      String companyId,
      String notificationId) async {
    print({
      'service_id': serviceId,
      'company_id': companyId,
      'longitude': longitude,
      'latitude': latitude,
      'address': address,
    });
    final response = await http.post(
        Uri.parse(
          Utilities.baseUrl + 'request-service',
        ),
        headers: await Utilities().headerWithAuth(),
        body: {
          'service_id': serviceId,
          'company_id': companyId,
          'longitude': longitude,
          'latitude': latitude,
          'address': address,
        });
    print(response.body);
    if (response.statusCode == 200) {
      await sendNotification(
          'Request', 'Requested For Tow', notificationId, 'request');
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<void> sendNotification(
      String title, String body, String fcmToken, String data,
      {String requestId = ''}) async {
    const String fcmUrl = 'https://fcm.googleapis.com/fcm/send';
    const fcmKey =
        "AAAAaZTXvTc:APA91bHoOPCTghnb4tifuy3ZQBCuEKJvapyQGKk3BFpj_Ec5LNutNv-dH3rYXAHTaTKjuRkxcEIuszj3JonwlYE-LF9aPQK4VOvIwlZHxXiWwvYQxcmIcXjoviJwa9PqqcvkQ9fEMRNs";
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$fcmKey'
    };
    var request = http.Request('POST', Uri.parse(fcmUrl));
    request.body =
        '''{"to":"$fcmToken","priority":"high","notification":{"title":"$title","body":"$body","sound": "default"},"data":{"screen":"$data","id":"$requestId"}}''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<dynamic> submitRating(
      String serviceRequestId, String rate, String review) async {
    final response = await http.post(
      Uri.parse(Utilities.baseUrl + 'submit-rating'),
      body: {
        'service_request_id': serviceRequestId,
        'rate': rate,
        // 'review': review,
      },
      headers: await Utilities().headerWithAuth(),
    );
    print(response.body);
    final loadedData = json.decode(response.body);
    if (response.statusCode == 200) {
      print('yes in 200');
      return loadedData;
    } else {
      Fluttertoast.showToast(msg: loadedData['message'].toString());
      print(response.statusCode);
      return null;
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

  Future<List<UserHistoryModel>> requestsOfUserHistory() async {
    final response = await http.post(Uri.parse(Utilities.baseUrl + 'history'),
        headers: await Utilities().headerWithAuth());
    print(response.body);
    final loadedData = json.decode(response.body);
    if (response.statusCode == 200) {
      List<UserHistoryModel> list = (loadedData['data'] as List)
          .map((request) => UserHistoryModel.fromJson(request))
          .toList();
      return list;
    } else {
      Utilities().showToast('error');
      return [];
    }
  }

  Future<dynamic> getRequestStatusData(String requestId) async {
    final response = await http.post(
        Uri.parse(
          Utilities.baseUrl + 'request-status/$requestId',
        ),
        headers: await Utilities().headerWithAuth());
    print(response.body);
    final loadedData = json.decode(response.body);
    if (response.statusCode == 200) {
      return loadedData;
    } else {
      return null;
    }
  }
}
