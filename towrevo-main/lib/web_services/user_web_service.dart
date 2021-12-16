import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:towrevo/models/company_model.dart';
import 'package:towrevo/utilities.dart';

class UserWebService {
  Future<List<CompanyModel>> getCompaniesList(Map<String, String> body) async {
    print(Utilities.baseUrl + 'companies');
    print(body);
    print(await Utilities().headerWithAuth());
    final response = await http.post(
      Uri.parse(Utilities.baseUrl + 'companies'),
      body: {
        'longitude': '67.059928',
        'latitude': '24.871800',
        'time': '16:08',
        'day': '3',
        'service': '1'
      },
      headers: await Utilities().headerWithAuth(),
    );
    print(response.body);
    print(response.statusCode);
    List<CompanyModel> companiesList = [];
    if (response.statusCode == 200) {
      final loadedData = json.decode(response.body);
      for (var company in loadedData['data']['data']) {
        companiesList.add(CompanyModel.fromJson(company));
      }
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
      await sendNotification('Request', 'Requested For Tow', notificationId,'request');
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<void> sendNotification(
      String title, String body, String fcmToken,String data) async {
    const String fcmUrl = 'https://fcm.googleapis.com/fcm/send';
    const fcmKey =
        "AAAAaZTXvTc:APA91bHoOPCTghnb4tifuy3ZQBCuEKJvapyQGKk3BFpj_Ec5LNutNv-dH3rYXAHTaTKjuRkxcEIuszj3JonwlYE-LF9aPQK4VOvIwlZHxXiWwvYQxcmIcXjoviJwa9PqqcvkQ9fEMRNs";
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$fcmKey'
    };
    var request = http.Request('POST', Uri.parse(fcmUrl));
    request.body =
        '''{"to":"$fcmToken","priority":"high","notification":{"title":"$title","body":"$body","sound": "default"},"data":{"screen":"$data"}}''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }


Future<void> submitRating(String serviceRequestId,String rate,String review) async{
   final response = await http.post(
      Uri.parse(Utilities.baseUrl + 'companies'),
      body: {
        'services_request_id': serviceRequestId,
        'rate': rate,
        'review': review,
      },
      headers: await Utilities().headerWithAuth(),
    );
      print(response.body);

     if (response.statusCode == 200) {
       print('yes in 200');
      print(response.statusCode);
    } else {
      print(response.statusCode);
    }
}

}
