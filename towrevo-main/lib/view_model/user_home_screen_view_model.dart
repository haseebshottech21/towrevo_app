import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/models/company_model.dart';
import 'package:towrevo/models/user_history_model.dart';
// import 'package:towrevo/screens/colors/towrevo_appcolor.dart';
import 'package:towrevo/utilities.dart';
import 'package:towrevo/view_model/company_home_screen_view_model.dart';
import 'package:towrevo/web_services/user_web_service.dart';
import '../number_creator.dart';

class UserHomeScreenViewModel with ChangeNotifier {
  Map<String, dynamic> ratingData = {
    'requestedId': '',
    'requested': false,
  };
  Map<String, dynamic> bottomSheetData = {
    'requestedId': '',
    'requested': false,
  };

  bool isLoading = false;
  changeLoadingStatus(bool loadingStatus) {
    isLoading = loadingStatus;
    notifyListeners();
  }

  int rating = 0;

  updateRating(int curretRating) {
    rating = curretRating;
    notifyListeners();
  }

  Utilities utilities = Utilities();
  Map<String, String> drawerInfo = {'image': '', 'name': '', 'email': ''};
  updateDrawerInfo() async {
    drawerInfo['image'] =
        await utilities.getSharedPreferenceValue('image') ?? '';
    drawerInfo['name'] = await utilities.getSharedPreferenceValue('name') ?? '';
    drawerInfo['email'] =
        await utilities.getSharedPreferenceValue('email') ?? '';

    notifyListeners();
  }

  getType() async {
    String type = (await Utilities().getSharedPreferenceValue('type'));
    notifyListeners();
    return type;
  }

  setDrawerInfo({
    required String name,
    required String image,
  }) {
    utilities.setSharedPrefValue('name', name);
    utilities.setSharedPrefValue('image', image);
    updateDrawerInfo();
  }

  Map<String, String> body = {
    'longitude': '',
    'latitude': '',
    'time': '',
    'day': '',
    'service': '',
    'address': '',
  };

  List<CompanyModel> list = [];

  List<UserHistoryModel> userHistoryList = [];

  Future<void> getUserHistory() async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);
    ;
    userHistoryList = [];
    final loadedResponse = await UserWebService().requestsOfUserHistory();
    if (loadedResponse.isNotEmpty) {
      userHistoryList = loadedResponse.reversed.toList();
    }
    changeLoadingStatus(false);
  }

  Future<void> payNow(
      String transactionId, String amount, BuildContext context) async {
    if (!(await Utilities().isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);
    userHistoryList = [];
    final loadedResponse =
        await UserWebService().payNowRequest(transactionId, amount);
    if (loadedResponse != null) {
      await getCompanies(body);
      Navigator.of(context).pop();
    }
    changeLoadingStatus(false);
  }

  Future<void> getCompanies(Map<String, String> requestedBody) async {
    if (!(await Utilities().isInternetAvailable())) {
      return;
    }
    list = [];
    changeLoadingStatus(true);

    list = await UserWebService().getCompaniesList(requestedBody);
    changeLoadingStatus(false);
  }

  Future<void> subimtRating(
    String reqId,
    String rate,
    BuildContext context,
  ) async {
    if (!(await Utilities().isInternetAvailable())) {
      return;
    }
    // changeLoadingStatus(true);
    final loadedData = await UserWebService().submitRating(
      reqId,
      rate,
      '',
    );
    // changeLoadingStatus(false);
    if (loadedData != null) {
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: 'Success');
    }
  }

  Future<Map<String, String>> getRequestStatusData(String reqId) async {
    changeLoadingStatus(true);
    final loadedData = await UserWebService().getRequestStatusData(reqId);
    changeLoadingStatus(false);
    if (loadedData != null) {
      print(loadedData['data']);
      return {
        'companyName': loadedData['data']['company']['first_name'],
        'serviceName': loadedData['data']['service']['name'],
      };
    } else {
      return {};
    }
  }

  Future<void> requestToCompany(
      BuildContext context,
      String longitude,
      String latitude,
      String address,
      String serviceId,
      String companyId,
      String notificationId) async {
    // changeLoadingStatus(true);
    final response = await UserWebService().sendRequestToCompany(
        longitude, latitude, address, serviceId, companyId, notificationId);
    // changeLoadingStatus(false);
    if (response != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          // Future.delayed(Duration(seconds: 15)).then((value) {
          //   Navigator.of(context).pop();
          // });
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: StreamBuilder<String>(
              stream: NumberCreator(ctx).stream.map((event) => '$event'),
              builder: (ctx, snapshot) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Request Send Please Wait..',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Image.asset(
                    //   'assets/images/checked.gif',
                    //   height: MediaQuery.of(context).size.height * 0.20,
                    //   width: MediaQuery.of(context).size.width * 0.20,
                    // ),
                    SizedBox(
                      width: 130,
                      height: 130,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            value: 1 -
                                double.parse(snapshot.data == null
                                        ? '30'
                                        : snapshot.data.toString()) /
                                    30,
                            valueColor:
                                AlwaysStoppedAnimation(Colors.green[800]),
                            strokeWidth: 6,
                            backgroundColor: Colors.black38,
                          ),
                          Center(
                            child: Text(
                              snapshot.data == null
                                  ? ''
                                  : snapshot.data.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 50,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Text(
                    //   snapshot.data.toString(),
                    //   // 'SuccessFully Send!',
                    //   style: const TextStyle(
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ],
                );
              },
            ),
          );
        },
      ).then((value) async {
        print(value);
        if (value == true) {
          print(response['data']['id'].toString());
          await Provider.of<CompanyHomeScreenViewModel>(context, listen: false)
              .acceptDeclineOrDone(
                  '2', response['data']['id'].toString(), context,
                  getData: false, notificationId: notificationId);
          Utilities().showToast('Company not responad send request again');
        }
      });
    }
  }
}
