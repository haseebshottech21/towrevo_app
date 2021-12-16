import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/models/company_model.dart';
import 'package:towrevo/models/user_history_model.dart';
import 'package:towrevo/utilities.dart';
import 'package:towrevo/view_model/company_home_screen_view_model.dart';
import 'package:towrevo/web_services/user_web_service.dart';

import '../number_creator.dart';

class UserHomeScreenViewModel with ChangeNotifier {
  Map<String, String> body = {
    'longitude': '',
    'latitude': '',
    'time': '',
    'day': '',
    'service': '',
    'address': '',
  };

  List<CompanyModel> list = [];
  bool isLoading = false;
  List<UserHistoryModel> userHistoryList = [];

  Future<void> getUserHistory() async {
    isLoading = true;
    notifyListeners();
    userHistoryList
     = [];
    final loadedResponse =
        await UserWebService().requestsOfUserHistory();
    if (loadedResponse.isNotEmpty) {
      userHistoryList = loadedResponse;
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getCompanies(Map<String, String> requestedBody) async {
    list = [];
    isLoading = true;
    notifyListeners();

    list = await UserWebService().getCompaniesList(requestedBody);
    isLoading = false;
    notifyListeners();
  }


  Future<void> subimtRating()async{

    // final response = await UserWebService().submitRating(serviceRequestId, rate, review);
  }


  Future<void> requestToCompany(
      BuildContext context,
      String longitude,
      String latitude,
      String address,
      String serviceId,
      String companyId,
      String notificationId) async {
    isLoading = false;
    notifyListeners();
    final response = await UserWebService().sendRequestToCompany(
        longitude, latitude, address, serviceId, companyId, notificationId);
    if (response != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          // Future.delayed(Duration(seconds: 15)).then((value) {
          //   Navigator.of(context).pop();
          // });
          return AlertDialog(
            content: StreamBuilder<String>(
              stream: NumberCreator(ctx).stream.map((event) => 'Count $event'),
              builder: (ctx, snapshot) {
                // print(snapshot.connectionState);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: const CircleAvatar(
                        backgroundColor: Colors.green,
                        child: FaIcon(FontAwesomeIcons.check),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      snapshot.data.toString(),
                      // 'SuccessFully Send!',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ).then((value) async{
        print(value);
        if (value == true) {
          print(response['data']['id'].toString());
          await Provider.of<CompanyHomeScreenViewModel>(context, listen: false)
              .acceptDeclineOrDone(
                  '2', response['data']['id'].toString(), context,
                  getData: false,notificationId: notificationId);
          Utilities().showToast('Company not responad send request again');
        }
      });
    }
  }
}
