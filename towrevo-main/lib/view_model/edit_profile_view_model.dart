import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/models/service_request_model.dart';
import 'package:towrevo/view_model/get_location_view_model.dart';
import 'package:towrevo/view_model/services_and_day_view_model.dart';
import 'package:towrevo/web_services/edit_profile_web_service.dart';

class EditProfileViewModel with ChangeNotifier {
  Map body = {};

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

  Future<void> getEditData(BuildContext context) async {
    body = {};
    final loadedData = await EditProfileWebService().getEditFields();

    if (loadedData != null) {
      body = loadedData;
      // if (loadedData['type'] == 1) {
      //   final serviceProvider =
      //       Provider.of<ServicesAndDaysViewModel>(context, listen: false);
      //   serviceProvider.getServices();

      //   final provider =
      //       Provider.of<GetLocationViewModel>(context, listen: false);
      //   provider.getLocationFromCoordinates(
      //     LatLng(
      //       double.parse(loadedData['latitude']),
      //       double.parse(loadedData['longitude']),
      //     ),
      //   );
      // }

      notifyListeners();
    } else {
      body = {};
    }
  }

  Future<void> changePassword(
      String password, String confirmPassword, BuildContext context) async {
    final loadedData = await EditProfileWebService().changePassword(
      password,
      confirmPassword,
    );
    if (loadedData != null) {
      Navigator.of(context).pop();
    }
  }

  Future<void> editProfileFields(Map<String, String> body) async {
    final loadedData = await EditProfileWebService().editProfileFields(body);
  }
}
