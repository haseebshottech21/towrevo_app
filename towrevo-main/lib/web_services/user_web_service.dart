import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:towrevo/models/models.dart';
import 'package:towrevo/utilities/utilities.dart';
import '../utilities/env_settings.dart';

class UserWebService {
  final utilities = Utilities();

  Future<List<CompanyModel>> getCompaniesList(
    Map<String, String> body,
    BuildContext context,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(Utilities.baseUrl + 'companies'),
        body: body,
        headers: await Utilities().headerWithAuth(),
      );
      List<CompanyModel> companiesList = [];
      if (response.statusCode == 200) {
        // print(response.body);
        final loadedData = json.decode(response.body);
        for (var company in loadedData['data']) {
          companiesList.add(CompanyModel.fromJson(company));
        }

        return companiesList;
      } else if (response.statusCode == 401) {
        utilities.unauthenticatedLogout(context);
        return [];
      } else {
        return [];
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return [];
    }
  }

  Future<dynamic> sendRequestToCompany(
    String longitude,
    String latitude,
    String address,
    String? destLongitude,
    String? destLatitude,
    String destAddress,
    String description,
    String serviceId,
    String companyId,
    String notificationId,
    BuildContext context,
  ) async {
    try {
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
          'dest_longitude': destLongitude,
          'dest_latitude': destLatitude,
          'dest_address': destAddress,
          'description': description,
        },
      );

      if (response.statusCode == 200) {
        await sendNotification(
            'Request', 'Requested For Tow', notificationId, 'request');
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        utilities.unauthenticatedLogout(context);
        return [];
      } else {
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  Future<void> sendNotification(
      String title, String body, String fcmToken, String data,
      {String requestId = ''}) async {
    try {
      const String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'key=${ENVSettings.fcmKey}'
      };
      var request = http.Request('POST', Uri.parse(fcmUrl));
      request.body =
          '''{"to":"$fcmToken","priority":"high","notification":{"title":"$title","body":"$body","sound": "default"},"data":{"screen":"$data","id":"$requestId"}}''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
      } else {
        // print(response.reasonPhrase);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<dynamic> submitRating(
      String serviceRequestId, String rate, String review) async {
    try {
      final response = await http.post(
        Uri.parse(Utilities.baseUrl + 'submit-rating'),
        body: {
          'service_request_id': serviceRequestId,
          'rate': rate,
          // 'review': review,
        },
        headers: await Utilities().headerWithAuth(),
      );

      final loadedData = json.decode(response.body);
      if (response.statusCode == 200) {
        return loadedData;
      } else {
        Fluttertoast.showToast(msg: loadedData['message'].toString());
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  Future<dynamic> payNowRequest(String transactionId, String amount) async {
    try {
      final response = await http.post(
        Uri.parse(Utilities.baseUrl + 'payment'),
        body: {
          'transaction_id': transactionId,
          'amount': amount,
        },
        headers: await Utilities().headerWithAuth(),
      );

      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(msg: loadedData['message'].toString());
        return loadedData;
      } else {
        Fluttertoast.showToast(msg: loadedData['message'].toString());
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<List<UserHistoryModel>> requestsOfUserHistory() async {
    try {
      final response = await http.post(Uri.parse(Utilities.baseUrl + 'history'),
          headers: await Utilities().headerWithAuth());

      final loadedData = json.decode(response.body);
      if (response.statusCode == 200) {
        List<UserHistoryModel> list = (loadedData['data'] as List)
            .map((request) => UserHistoryModel.fromJson(request))
            .toList();
        return list;
      } else {
        Fluttertoast.showToast(msg: loadedData['message'].toString());
        return [];
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return [];
    }
  }

  Future<dynamic> getRequestStatusData(String requestId) async {
    try {
      final response = await http.post(
        Uri.parse(
          Utilities.baseUrl + 'request-status/$requestId',
        ),
        headers: await Utilities().headerWithAuth(),
      );

      final loadedData = json.decode(response.body);
      if (response.statusCode == 200) {
        return loadedData;
      } else {
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }
}
