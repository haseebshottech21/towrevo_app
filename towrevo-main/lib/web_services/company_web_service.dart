import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:towrevo/models/models.dart';
import 'package:towrevo/utilities/utilities.dart';

class CompanyWebService {
  final utilities = Utilities();

  Future<List<ServiceRequestModel>> requestsOfUser(
      String type, BuildContext context,
      {bool history = false}) async {
    try {
      // print(await Utilities().headerWithAuth());
      final response = await http.post(
          Uri.parse(
              Utilities.baseUrl + 'service-requests${history ? '' : '/$type'}'),
          headers: await Utilities().headerWithAuth());
      final loadedData = json.decode(response.body);
      // print(response.body);
      if (response.statusCode == 200) {
        List<ServiceRequestModel> list = (loadedData['data'] as List)
            .map((request) => ServiceRequestModel.fromJson(request))
            .toList();
        return list;
      } else if (response.statusCode == 401) {
        // print('logout');
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

  Future<int?> paymentStatusCheckRequest() async {
    try {
      final response = await http.get(
        Uri.parse(Utilities.baseUrl + 'company-payment'),
        headers: await Utilities().headerWithAuth(),
      );

      return response.statusCode;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  Future<dynamic> payNowRequest(
      String transactionId, String amount, String couponId) async {
    try {
      final response = await http.post(
        Uri.parse(Utilities.baseUrl + 'payment'),
        body: {
          'transaction_id': transactionId,
          'amount': amount,
          'coupon_id': couponId,
        },
        headers: await Utilities().headerWithAuth(),
      );
      // print(response.body);

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

  Future<dynamic> setOnlineStatusRequest(
    String token,
    BuildContext context,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(
          Utilities.baseUrl + 'update-token',
        ),
        headers: await Utilities().headerWithAuth(),
        body: {'token': token},
      );

      // print(response.body);

      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return loadedData;
      } else if (response.statusCode == 401) {
        // utilities.unauthenticatedLogout(context);
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

  Future<dynamic> acceptDeclineOrDone(
    String status,
    String requestId,
    BuildContext context,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(Utilities.baseUrl + 'respond-request'),
        headers: await Utilities().headerWithAuth(),
        body: {
          'request_id': requestId,
          'status': status,
        },
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        return responseData;
      } else if (response.statusCode == 401) {
        // utilities.unauthenticatedLogout(context);
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
