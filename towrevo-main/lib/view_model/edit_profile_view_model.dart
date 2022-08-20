import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/utilities/utilities.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/web_services/edit_profile_web_service.dart';

class EditProfileViewModel with ChangeNotifier {
  Map body = {};
  Utilities utilities = Utilities();
  EditProfileWebService editProfileWebService = EditProfileWebService();

  bool isLoading = false;
  changeLoadingStatus(bool loadingStatus) {
    isLoading = loadingStatus;
    notifyListeners();
  }

  String imagePath = '';
  String extension = '';
  String image = '';

  Future<void> pickImage() async {
    final imageObject =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageObject != null) {
      imagePath = imageObject.path;
      extension = imageObject.path.split('.').last;
      image = base64Encode(await File(imageObject.path).readAsBytes());
      notifyListeners();
    }
  }

  initFields() {
    selectedState = null;
    selectedCity = null;
    timeRadioValue = null;
    body = {};
    extension = '';
    image = '';
    imagePath = '';
    notifyListeners();
  }

  Future<void> getEditData(
    BuildContext context,
    TextEditingController descriptionController,
  ) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);

    body = {};
    final loadedData = await editProfileWebService.getEditFields(context);

    if (loadedData != null) {
      body = loadedData;
      selectedState = body['state'];
      selectedCity = body['city'];
      if (loadedData['type'] == '2') {
        final serviceProvider =
            Provider.of<ServicesAndDaysViewModel>(context, listen: false);
        final registerCompanyViewModel =
            Provider.of<RegisterCompanyViewModel>(context, listen: false);
        final getLocation =
            Provider.of<GetLocationViewModel>(context, listen: false);
        await serviceProvider.getServices();

        registerCompanyViewModel.updateDescription(
          loadedData['company_info']['description'].toString(),
        );
        if (loadedData['company_info']['description']
            .toString()
            .contains('Other')) {
          descriptionController.text = loadedData['company_info']['description']
              .toString()
              .split('Other')
              .last;
        }

        getLocation.myCurrentLocation.placeLocation = LatLng(
          double.parse(loadedData['company_info']['latitude']),
          double.parse(loadedData['company_info']['longitude']),
        );

        await getLocation.getLocationFromCoordinates(
          getLocation.myCurrentLocation.placeLocation,
        );
        getLocation.myCurrentLocation.placeAddress = getLocation.getAddress;
        await setTimerFieldsAfterGetRequestScucceed(
          loadedData['company_info']['from'],
          loadedData['company_info']['to'],
        );
        serviceProvider
            .setServicesAndDaysSelectedWhileCompamyEditOperationPerform(
          loadedData['services'] as List,
          loadedData['days'] as List,
        );
      }
    } else {
      body = {};
    }
    changeLoadingStatus(false);
  }

  Map<String, String> timerValues = {
    'fromUtilize': '',
    'toUtilize': '',
    'from': '',
    'to': '',
  };

  int? timeRadioValue;
  changeTimeRadio(int val) {
    timeRadioValue = val;
    timerValues = {
      'from': '',
      'to': '',
      'fromUtilize': '',
      'toUtilize': '',
    };
    body['from'] = '';
    body['to'] = '';
    notifyListeners();
  }

  Future<void> setTimer(BuildContext context) async {
    final time = await utilities.setTimer(context);

    if (time != null) {
      timerValues = time;
      notifyListeners();
    }
  }

  Future<void> setTimerFieldsAfterGetRequestScucceed(
      String? from, String? to) async {
    if (from == null || to == null) {
      timerValues['fromUtilize'] = '';
      timerValues['toUtilize'] = '';
      timerValues['from'] = '';
      timerValues['to'] = '';
      timeRadioValue = 0;
    } else {
      timerValues['fromUtilize'] = from;
      timerValues['toUtilize'] = to;
      timerValues['from'] = utilities.timeConverter(from.toUpperCase());
      timerValues['to'] = utilities.timeConverter(to.toUpperCase());
      timeRadioValue = 1;
    }
  }

  Future<void> changePassword(
    String password,
    String confirmPassword,
    BuildContext context,
  ) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);
    final loadedData = await editProfileWebService.changePassword(
      password,
      confirmPassword,
      context,
    );
    changeLoadingStatus(false);
    if (loadedData != null) {
      Navigator.of(context).pop();
    }
  }

  Future<void> editProfileFields(
    Map<String, String> body,
    BuildContext context,
  ) async {
    if (!(await utilities.isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);
    final loadedData =
        await editProfileWebService.editProfileFields(body, context);
    if (loadedData != null) {
      Provider.of<UserHomeScreenViewModel>(context, listen: false)
          .setDrawerInfo(
        name: body['first_name'].toString() +
            ' ' +
            (body['last_name'] ?? '').toString(),
        image: loadedData['data']['user']['image'] ?? '',
      );
      final Map companyInfo = loadedData['data']['user']['company_info'] ?? {};
      if (companyInfo.isNotEmpty) {
        utilities.setSharedPrefValue(
          'longitude',
          companyInfo['longitude'].toString(),
        );
        utilities.setSharedPrefValue(
          'latitude',
          companyInfo['latitude'].toString(),
        );
      }
    }
    changeLoadingStatus(false);
  }

  String? selectedState;
  String? selectedCity;

  changeState(String newValue) {
    selectedState = newValue.toString();
    body['state'] = newValue.toString();
    selectedCity = null;

    notifyListeners();
  }

  changeCity(String newValue) {
    selectedCity = newValue.toString();
    body['city'] = newValue.toString();
    notifyListeners();
  }
}
