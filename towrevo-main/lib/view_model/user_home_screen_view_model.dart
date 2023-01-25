import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:towrevo/main.dart';
import 'package:towrevo/models/models.dart';
import 'package:towrevo/screens/screens.dart';
import 'package:towrevo/utilities/utilities.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/web_services/user_web_service.dart';
import 'package:towrevo/widgets/widgets.dart';
import '../request_timer.dart';
import '../screens/user/user_home_screen.dart';

class UserHomeScreenViewModel with ChangeNotifier {
  Utilities utilities = Utilities();
  UserWebService userWebService = UserWebService();

  dynamic totalCount;

  bool isPaid = false;
  bool? isPayFirst;

  // bool isLoading = false;
  dynamic trialLeft = 2;
  chnageFreeTrial(dynamic freeTrial) {
    trialLeft = freeTrial;
    notifyListeners();
  }

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

  List<CompanyModel> companyList = [];
  List<CompanyModel> sortedCompanies = [];
  List<CompanyModel> companyListFree = [];

  List<UserHistoryModel> userHistoryList = [];

  // dynamic requestTrial;

  Future<void> getRequestCount(BuildContext context, int type) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    // changeLoadingStatus(true);
    // final counData =
    await userWebService.getCount(context: context, type: type);
    // await utilities.setSharedPrefIntValue('count', counData['data']['counts']);
    // await utilities.setSharedPrefValue('isPaid', counData['data']['is_paid']);
    // changeLoadingStatus(false);
  }

  Future<void> getUserHistory(BuildContext context) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);
    userHistoryList = [];
    final loadedResponse = await userWebService.requestsOfUserHistory(context);
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
        await userWebService.payNowRequest(transactionId, amount, context);
    if (loadedResponse != null) {
      // await getRequestCount(context);
      await getCompanies(body, context);
      Navigator.of(context).pop();
    }
    changeLoadingStatus(false);
  }

  Future<void> getCompanies(
    Map<String, String> requestedBody,
    BuildContext context,
  ) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    companyList = [];
    changeLoadingStatus(true);
    // serviceModel = ServiceModel.emptyServiceModel();
    Map<String, dynamic> response = await userWebService.getCompaniesList(
      requestedBody,
      context,
    );
    if (response.isNotEmpty) {
      companyList = response['compaines'] as List<CompanyModel>;
      companyList.sort((a, b) => a.distance.compareTo(b.distance));
      isPaid = response['paidStatus'] == '1' ? true : false;
      isPayFirst = response['payFirst'] == 1 ? true : false;
      totalCount = response['counts'];
      // print("Paid: $isPaid, Count: $totalCount, PayFirst $isPayFirst");

      if (isPaid == false) {
        if (totalCount == 0) {
          chnageFreeTrial(2);
        } else if (totalCount == 1) {
          chnageFreeTrial(1);
        } else if (totalCount == 2) {
          chnageFreeTrial(0);
        } else {
          trialLeft == '';
          notifyListeners();
        }
        // print('free trial $trialLeft');
      }
    }
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
      context,
    );

    if (loadedData != null) {
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: 'Success');
    }
  }

  Future<Map<String, String>> getRequestStatusData(
    String reqId,
    BuildContext context,
  ) async {
    changeLoadingStatus(true);
    final loadedData =
        await UserWebService().getRequestStatusData(reqId, context);
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
    GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
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
      context,
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
                        'Request Sent Please Wait..',
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
            '2',
            response['data']['id'].toString(),
            context,
            getData: false,
            notificationId: notificationId,
            notRespond: true,
          );

          showSnackBar(
            context: context,
            title: 'Company not responded send request again',
            labelText: 'Ok',
            seconds: 10,
            onPress: () {},
          );

          Navigator.of(context).pushNamedAndRemoveUntil(
            UsersHomeScreen.routeName,
            (route) => false,
          );
        }
        isAlive = false;
      });
    }
  }

  bool? checker;

  checkAppUpdateValue(BuildContext context) async {
    final newVersion = NewVersionPlus(
      // iOSAppStoreCountry: 'us',
      iOSId: 'com.iOS.towrevoapp',
      androidId: 'com.towrevoapp.towrevo',
      // iOSId: 'com.google.Vespa',
      // androidId: 'com.user.towr',
    );

    final version = await newVersion.getVersionStatus();
    if (MyApp.updateChecker == false) {
      if (version != null) {
        checker = version.canUpdate;
        // print('Update Check: $checker');

        if (checker == true) {
          newVersion.showAlertIfNecessary(
            context: context,
            launchModeVersion: LaunchModeVersion.normal,
          );
          await utilities.setSharedPrefBoolValue('update', checker!);
          checker = await utilities.getSharedPreferenceBoolValue('update');
          MyApp.updateChecker = true;
        }
        notifyListeners();
      }
    }
  }

  // bool simpleBehavior = true;
  // String? release;
  // appUpdateChecker(BuildContext context) async {
  //   final newVersion = NewVersionPlus(
  //     iOSId: 'com.google.Vespa',
  //     androidId: 'com.towrevoapp.towrevo',
  //   );

  //   final version = await newVersion.getVersionStatus();
  //   if (version != null) {
  //     // debugPrint(version.releaseNotes);
  //     debugPrint(version.appStoreLink);
  //     debugPrint(version.localVersion);
  //     debugPrint(version.storeVersion);
  //     // debugPrint(status.releaseNotes);
  //     debugPrint(version.canUpdate.toString());
  //     release = "Fix bugs and improvements";
  //     // setState(() {});
  //     notifyListeners();
  //   }
  //   if (version!.canUpdate == true) {
  //     newVersion.showAlertIfNecessary(
  //       context: context,
  //       launchModeVersion: LaunchModeVersion.normal,
  //     );
  //   }
  // }

  // basicStatusCheck(NewVersionPlus newVersion, BuildContext context) async {
  //   final version = await newVersion.getVersionStatus();
  //   if (version != null) {
  //     release = "Fix bugs and improvements";
  //     // setState(() {});
  //     notifyListeners();
  //   }
  //   newVersion.showAlertIfNecessary(
  //     context: context,
  //     launchModeVersion: LaunchModeVersion.normal,
  //   );
  // }

  // advancedStatusCheck(NewVersionPlus newVersion, BuildContext context) async {
  //   final status = await newVersion.getVersionStatus();
  //   if (status != null) {
  //     debugPrint(status.releaseNotes);
  //     debugPrint(status.appStoreLink);
  //     debugPrint(status.localVersion);
  //     debugPrint(status.storeVersion);
  //     // debugPrint(status.releaseNotes);
  //     debugPrint(status.canUpdate.toString());
  //     newVersion.showUpdateDialog(
  //       updateButtonText: 'UPDATE',
  //       dismissButtonText: 'LATER',
  //       context: context,
  //       versionStatus: status,
  //       dialogTitle: 'Custom Title',
  //       dialogText: 'Custom Text',
  //     );
  //   }
  // }
}
