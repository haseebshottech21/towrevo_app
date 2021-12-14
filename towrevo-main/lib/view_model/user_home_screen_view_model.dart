import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:towrevo/models/company_model.dart';
import 'package:towrevo/web_services/home_web_service.dart';

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

  Future<void> getCompanies(Map<String, String> requestedBody) async {
    list = [];
    isLoading = true;
    notifyListeners();

    list = await HomeWebService().getCompaniesList(requestedBody);
    isLoading = false;
    notifyListeners();
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
    final response = await HomeWebService().sendRequestToCompany(
        longitude, latitude, address, serviceId, companyId, notificationId);
    if (response) {
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
                print(snapshot.connectionState);
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
      );
    }
  }
}
