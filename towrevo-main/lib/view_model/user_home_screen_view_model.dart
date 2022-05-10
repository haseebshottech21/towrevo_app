import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:towrevo/models/models.dart';
import 'package:towrevo/utilities/utilities.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/web_services/user_web_service.dart';
import 'package:towrevo/widgets/widgets.dart';
import '../request_timer.dart';

class UserHomeScreenViewModel with ChangeNotifier {
  Utilities utilities = Utilities();
  UserWebService userWebService = UserWebService();
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

  Map<String, String> drawerInfo = {'image': '', 'name': '', 'email': ''};
  updateDrawerInfo() async {
    drawerInfo['image'] =
        await utilities.getSharedPreferenceValue('image') ?? '';
    drawerInfo['name'] = await utilities.getSharedPreferenceValue('name') ?? '';
    drawerInfo['email'] =
        await utilities.getSharedPreferenceValue('email') ?? '';

    // print(drawerInfo['name']);

    notifyListeners();
  }

  getType() async {
    String type = (await utilities.getSharedPreferenceValue('type'));
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
    userHistoryList = [];
    final loadedResponse = await userWebService.requestsOfUserHistory();
    if (loadedResponse.isNotEmpty) {
      userHistoryList = loadedResponse.reversed.toList();
    }
    changeLoadingStatus(false);
  }

  Future<void> payNow(
      String transactionId, String amount, BuildContext context) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);
    userHistoryList = [];
    final loadedResponse =
        await userWebService.payNowRequest(transactionId, amount);
    if (loadedResponse != null) {
      await getCompanies(body);
      Navigator.of(context).pop();
    }
    changeLoadingStatus(false);
  }

  Future<void> getCompanies(Map<String, String> requestedBody) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    list = [];
    changeLoadingStatus(true);

    list = await userWebService.getCompaniesList(requestedBody);
    changeLoadingStatus(false);
  }

  Future<void> subimtRating(
    String reqId,
    String rate,
    BuildContext context,
  ) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }

    final loadedData = await userWebService.submitRating(
      reqId,
      rate,
      '',
    );

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
      return {
        'companyName': loadedData['data']['company']['first_name'],
        'serviceName': loadedData['data']['service']['name'],
      };
    } else {
      return {};
    }
  }

  bool isAlive = false;

  Future<bool> willPopCallback() async {
    // print('there');
    if (isAlive) {
      return false;
    }
    return true;
  }

  Future<void> requestToCompany(
    BuildContext context,
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
  ) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    final response = await userWebService.sendRequestToCompany(
      longitude,
      latitude,
      address,
      destLongitude!,
      destLatitude!,
      destAddress,
      description,
      serviceId,
      companyId,
      notificationId,
    );

    if (response != null) {
      isAlive = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return WillPopScope(
            onWillPop: () => willPopCallback(),
            child: AlertDialog(
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
                    ],
                  );
                },
              ),
            ),
          );
        },
      ).then((value) async {
        if (value == true) {
          await CompanyHomeScreenViewModel().acceptDeclineOrDone(
              '2', response['data']['id'].toString(), context,
              getData: false, notificationId: notificationId);

          showSnackBar(
            context: context,
            title: 'Company not responded send request again',
            labelText: '',
            onPress: () {},
          );
        }
        isAlive = false;
      });
    }
  }
}
