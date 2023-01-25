import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:towrevo/models/models.dart';
import 'package:towrevo/utilities/utilities.dart';
import '../utilities/env_settings.dart';

class UserWebService {
  final utilities = Utilities();

  Future<Map<String, dynamic>> getCompaniesList(
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

      // if (response.statusCode == 200) {
      //   // print(response.body);
      //   for (var company in loadedData['data']) {
      //     companiesList.add(CompanyModel.fromJson(company));
      //   }
      //   return companiesList;
      // }
      if (response.statusCode == 200 || response.statusCode == 201) {
        // List<Comment> list = (loadedData['data']['comments'] as List)
        //     .map((e) => Comment.fromJson(e))
        //     .toList();
        final loadedData = json.decode(response.body);
        for (var company in loadedData['data']['companies']) {
          companiesList.add(CompanyModel.fromJson(company));
        }
        // print(companiesList);
        // print(loadedData['data']['pay_status']['is_paid'].toString());
        return {
          'compaines': companiesList,
          'paidStatus': loadedData['data']['pay_status']['is_paid'].toString(),
          'payFirst': loadedData['data']['pay_status']['pay'],
          'counts': loadedData['data']['pay_status']['counts'],
        };
      } else if (response.statusCode == 401) {
        utilities.unauthenticatedLogout(context);
        return {};
      } else {
        return {};
      }
    } catch (e) {
      // print('object');
      Fluttertoast.showToast(msg: e.toString());
      return {};
    }
  }

  Future<dynamic> getCount({
    required BuildContext context,
    required int type,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(Utilities.baseUrl + 'get-count?type=$type'),
        headers: await Utilities().headerWithAuth(),
      );
      if (response.statusCode == 200) {
        // print(response.body);
        final loadedData = json.decode(response.body);
        // print(loadedData);
        return loadedData;
      } else if (response.statusCode == 401) {
        utilities.unauthenticatedLogout(context);
        return null;
      } else {
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
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
          'Request',
          'Customer Send Request !!',
          notificationId,
          'request',
        );
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
    String title,
    String body,
    String fcmToken,
    String data, {
    String requestId = '',
  }) async {
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
    String serviceRequestId,
    String rate,
    String review,
    BuildContext context,
  ) async {
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
      } else if (response.statusCode == 401) {
        utilities.unauthenticatedLogout(context);
        return [];
      } else {
        Fluttertoast.showToast(msg: loadedData['message'].toString());
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  Future<dynamic> payNowRequest(
    String transactionId,
    String amount,
    BuildContext context,
  ) async {
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
      } else if (response.statusCode == 401) {
        utilities.unauthenticatedLogout(context);
        return [];
      } else {
        // print(loadedData['message']);
        Fluttertoast.showToast(msg: loadedData['message'].toString());
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<List<UserHistoryModel>> requestsOfUserHistory(
      BuildContext context) async {
    try {
      final response = await http.post(Uri.parse(Utilities.baseUrl + 'history'),
          headers: await Utilities().headerWithAuth());

      final loadedData = json.decode(response.body);
      if (response.statusCode == 200) {
        List<UserHistoryModel> list = (loadedData['data'] as List)
            .map((request) => UserHistoryModel.fromJson(request))
            .toList();
        return list;
      } else if (response.statusCode == 401) {
        utilities.unauthenticatedLogout(context);
        return [];
      } else {
        Fluttertoast.showToast(msg: loadedData['message'].toString());
        return [];
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return [];
    }
  }

  Future<dynamic> getRequestStatusData(
    String requestId,
    BuildContext context,
  ) async {
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
}
