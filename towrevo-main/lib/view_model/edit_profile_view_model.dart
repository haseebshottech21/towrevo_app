import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/utitlites/utilities.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/web_services/edit_profile_web_service.dart';

class EditProfileViewModel with ChangeNotifier {
  Map body = {};

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
    if (image != null) {
      imagePath = imageObject!.path;
      extension = imageObject.path.split('.').last;
      image = base64Encode(await File(imageObject.path).readAsBytes());
      notifyListeners();
    }
  }

  initFields() {
    selectedState = null;
    selectedCity = null;
    body = {};
    extension = '';
    image = '';
    imagePath = '';
    notifyListeners();
  }

  Future<void> getEditData(BuildContext context) async {
    if (!(await Utilities().isInternetAvailable())) {
      return;
    }
    changeLoadingStatus(true);

    body = {};
    final loadedData = await EditProfileWebService().getEditFields();

    if (loadedData != null) {
      body = loadedData;
      selectedState = body['state'];
      selectedCity = body['city'];
      if (loadedData['type'] == '2') {
        final serviceProvider =
            Provider.of<ServicesAndDaysViewModel>(context, listen: false);
        await serviceProvider.getServices();

        final getLocation =
            Provider.of<GetLocationViewModel>(context, listen: false);
        getLocation.myCurrentLocation.placeLocation = LatLng(
          double.parse(loadedData['company_info']['latitude']),
          double.parse(loadedData['company_info']['longitude']),
        );
        await getLocation.getLocationFromCoordinates(getLocation.myCurrentLocation.placeLocation);
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

  Future<void> setTimer(BuildContext context) async {
    final time = await Utilities().setTimer(context);

    // print(time);
    if (time != null) {
      timerValues = time;
      notifyListeners();
    }
  }

  Future<void> setTimerFieldsAfterGetRequestScucceed(
      String from, String to) async {
    // print(from.toUpperCase());
    // print(to.toUpperCase());
    timerValues['fromUtilize'] = from;
    timerValues['toUtilize'] = to;
    timerValues['from'] = Utilities().timeConverter(from.toUpperCase());
    timerValues['to'] = Utilities().timeConverter(to.toUpperCase());

    // notifyListeners();
  }

  Future<void> changePassword(
      String password, String confirmPassword, BuildContext context) async {
    changeLoadingStatus(true);
    final loadedData = await EditProfileWebService().changePassword(
      password,
      confirmPassword,
    );
    changeLoadingStatus(false);
    if (loadedData != null) {
      Navigator.of(context).pop();
    }
  }

  Future<void> editProfileFields(
      Map<String, String> body, BuildContext context) async {
    changeLoadingStatus(true);
    final loadedData = await EditProfileWebService().editProfileFields(body);
    if (loadedData != null) {
      Provider.of<UserHomeScreenViewModel>(context, listen: false)
          .setDrawerInfo(
              name: body['first_name'].toString() +
                  ' ' +
                  (body['last_name'] ?? '').toString(),
              image: loadedData['data']['user']['image'] ?? '');
    }
    changeLoadingStatus(false);
  }

  String? selectedState;
  String? selectedCity;

  changeState(String newValue) {
    selectedState = newValue.toString();
    body['state'] = newValue.toString();
    selectedCity = null;
    // print(us_city_state[selectedState]);
    notifyListeners();
  }

  changeCity(String newValue) {
    selectedCity = newValue.toString();
    body['city'] = newValue.toString();
    notifyListeners();
  }
}
